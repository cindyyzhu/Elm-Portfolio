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
import Robin

import SpeechBubbles exposing (speechBubbleRight, speechBubbleLeft, shantellSansFont) -- Your shapes go here!
type Actor = Robot 

script = 
  [ (Robot,"Hey there! Addy was here. You just missed her.")
  , (Robot, "She was digging for garlic for her New Year's")
  , (Robot, "surprise.")
  ] 
  
myShapes model = 
  scene model.time
  
  
  
  
scene time = 
  let 
    t = if time < 7 then time else 7
  in
    ( rect 192 128 |> filled grey  )
    ::
    ( -- far trees
      treePositions
        |> List.concatMap 
             ( \ (x,dist,width) ->
                   let 
                     shrink = 100 / (dist + 300 - t*50 + 200)
                   in
                     if shrink < 3 && shrink > 0 then
                       [ birch1
                           |> scale shrink
                           |> move (x*shrink,0)
                       ]
                     else
                       []
             )
    )
    ++
    (  [(50,250,0)] |>
         List.concatMap
             ( \ (x,dist,width) ->
                   let 
                     shrink = 100 / (dist - t*50 + 200)
                   in
                     if shrink < 3 && shrink > 0 then
                       [ Robin.robin
                          |> scale 0.15
                          |> scale shrink
                          |> move (x*shrink,-40 * shrink)                        
                       ] ++
                       ( if time > 7 then
                           [speechBubbleRight (solid 0.5) black (shantellSansFont) script 50 Robot (0.8*(time-7))
                              |> move (-10,-19)
                           ]
                         else
                           []
                       )
                     else
                       []
             )
    )
    ++
    ( -- near trees
      treePositions
        |> List.concatMap 
             ( \ (x,dist,width) ->
                   let 
                     -- perspective is calculating the position
                     -- on an imaginary window between you
                     -- and the scene
                     -- in this case the window is 100 units from your eye
                     -- the size is determined by the rays of light going
                     -- from the sides of an object through the window
                     -- to your eye
                     {-
                         window/o
                              + b
                             /| j
                         eye  | e
                             \| c
                              + t
                               \.
                               
                       |window - eye| / |object - eye|
                     -}
                     shrink = 100 / (dist - t*50 + 200)
                   in
                     if shrink < 3 && shrink > 0 then
                       [ birch1
                           |> scale shrink
                           |> move (x*shrink,0)
                       ]
                     else
                       []
             )
    )

 
treePositions =
  [(9,71,-62)
  ,(13,-4,52)
  ,(-50,-20,-33)
  ,(45,34,71)
  ,(-33,85,-46)
  ,(-22,-7,51)
  ,(-25,-4,-32)
  ,(2,-3,16)
  ,(-79,42,-95)
  ,(-91,19,24)
  ,(-39,-25,43)
  ,(65,66,40)
  ,(-32,71,-43)
  ,(-69,45,-21)
  ,(85,90,-1)
  ,(-15,62,-75)
  ,(37,14,-56)
  ,(65,-25,97)
  ,(44,30,-58)
  ,(-58,25,16)
  ]
    |> List.sortBy ( \ (_,dist,_) -> -dist )
  

birch1 = 
  [ birchOutline1
  , knot1
  , knot2
  , knot3
    |> move (23.3,33.1)
  , knot3
    |> move (25,14)
  , knot3
    |> move (25,14)
  , knot3
    |> move (26.3,-17.1)
  , knot3
    |> move (23,-24)
  , knot3
    |> move (23.1,-39.2)
  , knot4
    |> move (24.8,-32.4)
   , knot5
  ]
    |> group
    |> clip birchOutline1
    |> move (-22,0)

birchOutline1 =
  curve (21.7, 42.7) [Pull (20.0, 20.0) (21.2, 12.3), Pull (21.8, -6.8) (22.1, -18.6), Pull (21.7, -19.9) (20.9, -21.1), Pull (20.5, -24.1) (21.5, -27.1), Pull (21.8, -39.7) (22.1, -52.3), Pull (25.7, -52.3) (29.2, -52.2), Pull (28.1, -40.2) (27.0, -28.1), Pull (26.8, -24.9) (28.2, -20.6), Pull (28.6, -15.0) (28.3, -9.4), Pull (26.0, 3.1) (26.5, 21.5), Pull (26.8, 32.2) (26.4, 42.8), Pull (24.1, 42.7) (21.8, 42.6)]
    |> filled white
    
knot1 = 
  curve (26.1, 20.6) [Pull (23.6, 22.7) (21.7, 21.1), Pull (22.0, 22.7) (23.0, 23.1), Pull (24.3, 23.5) (24.3, 22.3), Pull (25.2, 21.4) (26.2, 20.6)]  
    |> filled charcoal
    
knot2 = 
  curve (-23.2, -6.8) [Pull (-11.7, -1.0) (-9.3, 3.2), Pull (-5.2, 8.9) (-0.4, 3.4), Pull (3.3, -0.9) (14.9, -6.7), Pull (6.2, -3.9) (-2.1, -0.0), Pull (-4.9, 1.7) (-7.0, -0.3), Pull (-17.5, -5.1) (-23.3, -6.8)]
    |> filled charcoal
    |> scale 0.2
    |> move (25,0)
    
knot3 = 
  curve (-2,0) [Pull (0,2) (2,0), Pull (0,1) (-2,0)]
    |> filled charcoal

knot4 = 
  [ curve (-2,-1) [Pull (0,1) (2,-0.5), Pull (0,0) (-2,-1)]
    |> filled charcoal
  , oval 1.5 1
    |> filled darkCharcoal
    |> rotate 0.1
  ]
    |> group

knot5 = 
  curve (-7.8, 9.6) [Pull (-64.3, 30.8) (0.0, 40.0), Pull (22.1, 42.4) (18.3, 19.8), Pull (13.3, -6.3) (-7.8, 9.8)]
    |> filled darkCharcoal
    |> scale 0.07
    |> move (26,3)
