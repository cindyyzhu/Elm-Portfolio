module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

fractionalModBy m x = x - m * toFloat (floor (x / m))

repeatDistance speed start end t =
  start + fractionalModBy (end - start) (speed * t)
  
  -- Your shapes go here!

myShapes model =
  [
    ravine model
  ]


ravine model =
  [
   rect 192 128 |> filled grey |> makeTransparent 1
 
    -- often helpful to start with a circle centered at (0,0) to position you image before tracing
  , trailBed
  , stairBed
  , makeBarrier 1 0 farRailPoints
  , makeBarrier 1 0 nearRailPoints
  , makeBarrier 1 0.3 rightRailPoints
  , makeBarrier 1 0.3 leftRailPoints
  , nearRailTop
  ]
    |> group

nearRailTop =
  curve (-27.1, -63.3) [Pull (-21.3, -63.4) (-15.5, -63.5), Pull (-16.5, -38.0) (-17.5, -12.4), Pull (-19.8, -8.4) (-22.1, -4.4), Pull (-23.0, -4.7) (-23.8, -5.1), Pull (-22.3, -9.0) (-20.8, -12.9), Pull (-24.0, -38.2) (-27.2, -63.4)]
    |> filled white

makeBarrier mult add points =
  let
    top clr = 
      openPolygon points
        |> outlined (solid 2) clr
    botPoints displacement pts = 
      case pts of 
        (x1,y1) :: rest -> 
          (x1,y1+displacement) 
            ::
            ( botPoints (displacement-0.85*add*bHeight) rest )
        [] ->
            [] 
    bot clr = botPoints (-bHeight*mult) points
       |> openPolygon
       |> outlined (solid 2) clr
  in
    [ top darkBrown 
        |> move (0,-1)
    , bot darkBrown 
    , drawBallisters mult add points
        |> group
    , top white
    ]
      |> group

stairBed = 
  curve (-49.7, -9.0) [Pull (-48.6, -10.5) (-47.5, -11.9), Pull (-44.7, -11.9) (-41.9, -11.8), Pull (-40.2, -16.2) (-38.4, -20.5), Pull (-30.8, -19.9) (-23.3, -19.2), Pull (-20.9, -25.0) (-18.5, -30.7), Pull (-18.9, -47.1) (-19.4, -63.5), Pull (13.3, -63.5) (46.1, -63.4), Pull (30.6, -44.0) (15.0, -24.6), Pull (11.0, -18.0) (6.9, -11.4), Pull (-5.1, -13.7) (-17.3, -16.0), Pull (-18.5, -11.8) (-19.7, -7.6), Pull (-24.6, -8.6) (-29.5, -9.6), Pull (-30.5, -7.3) (-31.4, -5.0), Pull (-40.5, -6.9) (-49.6, -8.9)]
     |> filled lightGrey

farRailPoints =   
  [ (-93.0, 0.5) 
  , (-67.1, 3.9)
  , (-17.3, 12.0)
  , (32.3, 27.5) 
  , (56.7, 34.7)
  , (94.3, 48.5)
  ]

nearRailPoints = 
  [ (-30.3, -1.6), (-18.4, 1.3), (31.6, 16.2)]

rightRailPoints =
  [ (-30.3, -1.6), (-19.7, 3.1), (-17.1, -2.9), (7.2, 4.2), (15.0, -6.6)] -- , (95.6, 6.3)]

leftRailPoints =
  [ (-47.5, -4.4), (-41.9, -1.2), (-38.6, -8.1), (-23.3, -4.2), (-19.2, -12.9), (-19.7, -55.8)]

trailBed = 
  polygon ( (farRailPoints 
               |> List.map ( \ (x,y) -> (x,y-8-bHeight) )
            ) ++
            (farRailPoints 
               |> List.map ( \ (x,y) -> (x,y-bHeight) )
               |> List.reverse
            )
          )
     |> filled lightGrey

bHeight = 8
drawBallisters mult add points =
  case points of 
    (x1,y1) :: (x2,y2) :: rest ->
      let
        dist = sqrt ((x1-x2)^2 + (y1-y2)^2)
        (dx,dy) = ((x2-x1)/dist,(y2-y1)/dist)
      in
        ( line (x1,y1) (x1,y1-mult*bHeight) |> outlined (solid 1) darkBrown )
        ::
        ( List.range 1 (floor (0.5*dist/mult - 1)) 
            |> List.map 
                 ( \ i -> let 
                            s = mult * (0.4+ 2 * toFloat i)
                          in
                            line 
                              (x1 + s * dx, y1 + s * dy) 
                              (x1 + s * dx, y1 + s * dy - mult * bHeight) 
                              |> outlined (solid 0.5) darkBrown
                 )
        )
        ++ ( drawBallisters (mult+add) add ((x2,y2)::rest) )
    [(xLast,yLast)] ->
        [ line (xLast,yLast) (xLast,yLast-mult*bHeight) |> outlined (solid 1) darkBrown ] 
    [] ->
        [] 
