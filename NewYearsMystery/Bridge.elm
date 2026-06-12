-- Your shapes go here!
module Bridge exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import Beaver

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

myShapes model =
  [
    bridgeYay model
  ]
bridgeYay model = group [
  sky, pond, bridge, 
    Beaver.beaver
    |> scale 0.2
    |> move (-75,-15)
  ]

sky = group [
  rect 200 70
  |> filled (rgb 135 206 235)
  |> move (0,25)
  ]
  
pond = [
   curve (9.5925,-10.94) [Pull (60.124,-14.23) (54.857,-28.92),Pull (52.516,-39.56) (29.976,-49.01),Pull (10.808,-55.11) (-51.55,-43.01),Pull (-71.00,-35.62) (-53.65,-22.03),Pull (-37.12,-10.78) (-14.38,-11.54),Pull (-1.798,-11.24) (9.5925,-10.94)]
   |> filled blue
   |> scale 1.3
   |> move (0,5)
  ]
  |> group

bridge = 
  [ 
    arch 0
      |> move (3,-20)
  , side
     |> rotate (degrees -1) 
  , side
      |> scaleX -1
      |> rotate (degrees -1)
      |> move (-8,0)
  , arch 0.1
      |> move (-3,-20)
  --, rocks
  ]
    |> group

width = 2.5
depth = 10
r = 50

{--rocks = 
  [ ((0,0),5,3) ]
    |> List.indexedMap
         ( \ idx ((x,y),w,h) -> 
              oval w h 
               |> filled (hsl (degrees 40) 0.25 (0.1 * (7+sin (4.5*toFloat idx))))
               |> addOutline (solid 0.25) charcoal
               |> move (x,y)
         )
    |> group --}


arch fill = 
  List.range 1 30
    |> List.map
         ( \ idx -> polygon [ (-width,r)
                            , (width,r)
                            , (width*(r-depth)/r,r-depth)
                            , (-width*(r-depth)/r,r-depth)
                            ] 
                     |> filled (hsl (degrees 40) 0.25 (fill * (7+sin (4.5*toFloat idx))))
                     |> addOutline (solid 0.5) charcoal
                     |> rotate (-1.6 + 0.1 * toFloat idx)
         )
    |> group
    |> scaleX 1.1

side = 
  ( blocks
    ++ (blocks |> List.map (shiftBy (-18,-4)))
    ++ (blocks |> List.map (shiftBy (-28,-8)))
    ++ (blocks |> List.map (shiftBy (-32,-11.5)))
    ++ (blocks |> List.map (shiftBy (-35,-15.5)))
    ++ (blocks |> List.map (shiftBy (-37,-19)))
    ++ (blocks |> List.map (shiftBy (-34,-22.5)))
    ++ (blocks |> List.map (shiftBy (-36,-25.5)))
    ++ (blocks |> List.map (shiftBy (-38,-29.5)))
    ++ (blocks |> List.map (shiftBy (-35,-32)))
    ++ (blocks |> List.map (shiftBy (-37,-35)))
  )
    |> List.indexedMap
         ( \ idx (x,y,w) -> 
              polygon [ (x,y), (x+w,y), (x+w,y-4), (x,y-4)]
                     |> filled (hsl (degrees 40) 0.25 (0.1 * (7+sin (4.5*toFloat idx))))
                     |> addOutline (solid 0.5) charcoal
         )
    |> group
    |> scaleX 1.1

shiftBy (dx,dy) (x,y,w) = (x+dx,y+dy,w)

blocks = List.range 1 10 
       |> List.map 
            ( \ x -> (-10 - 8 * toFloat x,25,10+sin (4.5*toFloat x)) )
