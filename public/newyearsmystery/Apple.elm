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
   apple
  ]

apple = group [
   curve (-39.56,25.929) [Pull (-17.23,33.030) (-6.295,24.730),Pull (11.649,9.0941) (8.3934,-9.742),Pull (5.8498,-29.77) (-8.093,-42.41),Pull (-14.98,-49.21) (-21.88,-49.61),Pull (-29.37,-49.86) (-36.87,-48.71),Pull (-40.31,-48.26) (-43.76,-49.01),Pull (-48.11,-50.11) (-52.45,-49.01),Pull (-55.90,-47.81) (-59.35,-45.41),Pull (-71.84,-34.57) (-76.74,-20.53),Pull (-82.99,-2.497) (-75.84,13.939),Pull (-70.64,25.083) (-59.05,28.627),Pull (-54.85,29.728) (-46.46,26.829),Pull (-43.01,25.829) (-39.56,25.929)]
  |> filled red
  
  , 
  curve (-8.093,19.035) [Pull (7.2023,3.6489) (2.0983,-16.33),Pull (12.352,4.9988) (-8.093,19.035)]
  |> filled white
  
  ,curve (-44.96,45.114) [Pull (-39.71,36.572) (-38.66,26.229),Pull (-37.77,26.529) (-36.87,26.829),Pull (-35.02,36.121) (-37.77,45.414),Pull (-41.36,45.114) (-44.96,45.114)]
  |> filled darkBrown
  
  , 
  curve (-35.67,34.622) [Pull (-22.63,55.616) (-1.199,50.210),Pull (-12.23,28.216) (-35.67,34.622)]
  |> filled darkGreen
  , 
  curve (-35.67,34.922) [Pull (-22.63,43.618) (-9.592,46.313)]
  |> outlined (solid 0.25) black
 ]