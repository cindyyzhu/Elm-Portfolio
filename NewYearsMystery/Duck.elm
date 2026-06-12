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
      curve (-18.28,2.5480) [Pull (-33.72,-3.145) (-32.97,-13.03),Pull (-33.27,-23.68) (-24.58,-27.72),Pull (-7.795,-32.52) (13.189,-30.72),Pull (27.582,-28.18) (31.775,-17.83),Pull (35.526,-7.344) (29.077,3.1475),Pull (27.878,9.7444) (26.079,10.941),Pull (21.732,13.192) (19.185,9.4426),Pull (18.137,5.9946) (14.088,4.3466),Pull (7.7939,3.1468) (1.4988,3.7470),Pull (12.296,12.439) (8.0936,23.531),Pull (0.3016,37.177) (-12.29,33.423),Pull (-22.33,31.028) (-25.18,21.433),Pull (-25.78,14.388) (-22.78,7.3442),Pull (-20.38,3.8960) (-18.28,2.5480)]
  |> filled yellow
   --beak
  , curve (-25.48,21.433) [Pull (-24.73,16.786) (-19.78,12.140),Pull (-18.43,9.7421) (-21.28,7.9437),Pull (-25.18,7.4941) (-29.07,7.0444),Pull (-31.32,8.2430) (-29.37,10.641),Pull (-28.17,11.540) (-26.97,12.440),Pull (-32.82,14.087) (-34.47,19.934),Pull (-35.22,23.833) (-32.37,22.332),Pull (-30.72,21.433) (-27.87,20.533),Pull (-26.67,20.233) (-25.48,21.433)]
  |> filled orange
  
  , oval 4 7
  |> filled black
  |> rotate (degrees -20)
  |> move (-17, 22)
  
  , oval 2.5 4.5
  |> filled white
  |> rotate (degrees -20)
  |> move (-17, 22.9)
  ]
