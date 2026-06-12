module Jenna exposing (..)

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
  
  
myShapes model = [
    jenna
  ]

jenna = [
  curve (16.0, 27.3) [Pull (2.5, 49.5) (-16.7, 30.4), Pull (-26.9, 15.3) (-18.7, 5.9), Pull (1.4, -4.3) (16.3, 5.1), Pull (22.0, 16.3) (15.6, 27.6)]
  |> filled (rgb 240 208 161),
   
  curve (-52.9, -3.0) [Pull (-45.4, 12.2) (-35.8, -0.8), Pull (-44.4, -3.9) (-53.0, -2.9)]
  |> filled (rgb 240 208 161),
  
  curve (34.9, -7.3) [Pull (42.6, -9.8) (49.7, -10.4), Pull (37.7, 2.7) (35.3, -6.5)]
  |> filled (rgb 240 208 161),
  
  curve (17.7, 26.6) [Pull (7.5, 31.3) (-17.4, 30.4), Pull (-0.8, 52.4) (17.1, 26.2), Pull (27.5, 62.4) (36.4, 15.0), Pull (38.9, 2.8) (48.6, 20.5), Pull (42.7, -10.3) (19.1, 18.0), Pull (21.1, 32.4) (-18.1, 31.1)]
  |> filled darkBrown,
  
  curve (-4.3, 34.2) [Pull (21.4, 29.0) (25.5, 14.9), Pull (14.6, 23.5) (-4.2, 33.6)]
  |> filled darkBrown,
  
  curve (28.8, 13.1) [Pull (17.1, 23.9) (-2.4, 30.7), Pull (-30.2, 32.2) (-17.7, 4.2), Pull (-39.8, 35.6) (-2.1, 39.3), Pull (12.5, 25.9) (29.4, 13.2)]
  |> filled darkBrown,
  
  curve (-20.9, 28.4) [Pull (17.1, 29.6) (22.7, 14.7), Pull (24.7, 26.5) (25.3, 39.7), Pull (22.6, 21.9) (-2.4, 33.3), Pull (-11.2, 30.8) (-19.9, 28.2)]
  |> filled darkBrown,
  
  curve (16.2, -17.7) [Pull (28.1, -22.3) (31.5, -15.1), Pull (25.3, -1.8) (13.5, 0.7), Pull (-2.0, 0.0) (-17.0, 1.5), Pull (-29.6, -3.5) (-35.0, -12.5), Pull (-30.1, -22.0) (-18.1, -17.5), Pull (-18.8, -25.3) (-17.4, -32.4), Pull (-0.8, -32.5) (15.6, -32.7), Pull (17.7, -25.1) (16.3, -16.7)]
  |> filled (rgb 214 87 58),
  
  curve (-17.4, -32.0) [Pull (-21.9, -59.2) (-4.2, -60.9), Pull (-2.8, -42.1) (-3.2, -33.3), Pull (2.1, -33.3) (2.5, -32.3), Pull (1.1, -45.4) (2.9, -60.3), Pull (21.5, -61.7) (16.0, -32.9), Pull (-0.7, -31.4) (-17.4, -32.1)]
  |> filled blue,
  
  curve (-27.3, -18.4) [Pull (-42.5, -33.6) (-44.8, -2.2)]
  |> outlined (solid 1) (rgb 240 208 161),
  
  curve (24.1, -19.1) [Pull (40.2, -31.1) (40.1, -8.7)]
  |> outlined (solid 1) (rgb 240 208 161),
  
  curve (24.5, -30.5) [Pull (33.8, -11.2) (42.3, -30.7)]
  |> outlined (solid 1) (rgb 156 222 230),
  
  curve (24.8, -49.7) [Pull (34.3, -52.0) (42.8, -50.3), Pull (46.3, -40.5) (44.4, -30.7), Pull (33.7, -30.5) (23.0, -30.3), Pull (22.0, -40.4) (25.3, -49.8)]
  |> filled (rgb 156 222 230),
  
  curve (-5.6, 15.2) [Pull (-10.9, 22.1) (-16.3, 15.4)]
  |> outlined (solid 1) black,
  
  curve (10.6, 15.2) [Pull (6.1, 21.4) (1.0, 15.4)]
  |> outlined (solid 1) black,
  
  curve (-8.1, 8.1) [Pull (-0.9, 2.9) (5.3, 7.9)]
  |> outlined (solid 1) black,
  
  curve (-18.8, -14.5) [Pull (-10.2, -21.9) (-12.0, -4.4), Pull (-8.8, -4.4) (-5.5, -4.3), Pull (-12.0, -4.3) (-18.8, -4.4)]
  |> outlined (solid 1) black,
  
  curve (-8.7, -12.4) [Pull (-1.2, -21.7) (1.5, -11.1), Pull (-15.9, -7.5) (1.3, -4.7)]
  |> outlined (solid 1) black,
  
  curve (13.7, -16.8) [Pull (9.7, 7.5) (9.0, -16.4), Pull (6.4, 7.4) (4.2, -16.5)]
  |> outlined (solid 1) black

  ]
  |> group