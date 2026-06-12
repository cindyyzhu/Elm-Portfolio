module Shovel exposing (..)

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
sub =  curve (-76.3, 40.5) [Pull (-71.9, 32.9) (-63.0, 39.3), Pull (-58.5, 43.4) (-62.4, 51.6), Pull (-67.5, 47.0) (-76.1, 40.4)]
 |>filled blank -- inside the handle
myShapes model =
  [
    shovel-- often helpful to start with a circle centered at (0,0) to position you image before tracing
 ]
shovel = group
 [
 curve (-63.3, 33.0) [Pull (-46.1, 13.3) (-38.4, 3.0), Pull (-53.4, -7.9) (-23.9, -29.8), Pull (-10.1, -24.5) (-3.5, -13.3), Pull (-19.8, 18.6) (-33.4, 7.3), Pull (-46.8, 21.5) (-58.7, 36.3)]
  |>filled (hsl (degrees 33) 0.918 0.77)
 |>addOutline (solid 1) black
  ,
 curve (-22.5, -28.8) [Pull (-45.2, -7.3) (-34.8, -0.8), Pull (-27.9, -5.7) (-30.5, 3.8), Pull (-20.9, 10.1) (-5.4, -14.5), Pull (-10.5, -24.5) (-21.5, -28.4)]
 |>filled red
 |>addOutline (solid 1) black
 ,
 handle
 |>move (0,-1.5)
 |>subtract sub  |>addOutline (solid 2) black
 ]

handle = group
 [
 curve (-83.2, 39.3) [Pull (-73.3, 48.6) (-61.5, 58.0), Pull (-49.0, 47.9) (-61.5, 35.0), Pull (-75.6, 26.6) (-83.0, 40.1)]
 |>filled red
 |>addOutline (solid 1) black
 ]


