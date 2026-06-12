module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

stops t = 
  List.range 0 10 
    |> List.map ( 
        \ idx -> stop (hsl (t + degrees 36 * toFloat idx) 1 0.5) 
        (5 * toFloat idx)
        )
 
myShapes model =
  [ 
  --rainbow model, 
  movingStarfish model
  --|> scale (0.7+0.2*sin(1.5*model.time))
  --|> rotate (5*sin( 1*model.time))
  
  ]

-- combines starfish and the animated rainbow gradient
movingStarfish model = group [
  starfish 
  , rainbow model
  |> clip (pearls)
 ]

-- animated rainbow gradient
rainbow model = group [
  circle 50
    |> filled 
          (
            radialGradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
       
    )
    |> move (-5, -0.5)
 ]
 
-- original starfish outline
starfish  = group [curve (5.0659,13.340) [Pull (15.197,14.522) (25.329,15.704),Pull (29.223,14.591) (27.356,10.638),Pull (18.575,4.7282) (9.7941,-1.182),Pull (8.9053,-2.679) (9.4564,-4.897),Pull (13.678,-13.50) (17.899,-22.12),Pull (18.846,-26.61) (12.833,-25.49),Pull (6.0791,-18.91) (-0.675,-12.32),Pull (-4.390,-9.104) (-8.105,-13.00),Pull (-13.50,-19.25) (-18.91,-25.49),Pull (-24.31,-26.55) (-23.64,-21.44),Pull (-20.77,-13.17) (-17.89,-4.897),Pull (-17.07,-3.039) (-19.92,-1.182),Pull (-28.36,3.2084) (-36.81,7.5989),Pull (-39.71,11.780) (-34.78,13.002),Pull (-24.99,12.664) (-15.19,12.327),Pull (-12.48,11.549) (-12.49,14.691),Pull (-9.794,24.654) (-7.092,34.617),Pull (-4.390,37.786) (-1.688,34.955),Pull (0.1688,24.992) (2.0263,15.029),Pull (3.1661,13.184) (5.0659,13.340)] 
  |> filled (hsla (degrees 13) 0.84 0.50 1)
  |> addOutline (solid 6) (hsla (degrees 14) 0.95 0.30 1)
  ,
  curve (0,19.757) [Pull (-1.519,11.482) (-3.039,3.2084),Pull (-14.86,3.7150) (-26.68,4.2216),Pull (-15.53,0.8443) (-4.390,-2.532),Pull (-9.456,-14.01) (-14.52,-25.49),Pull (-6.585,-15.19) (1.3509,-4.897),Pull (9.2875,-14.69) (17.224,-24.48),Pull (12.158,-14.01) (7.0923,-3.546),Pull (17.562,1.6886) (28.031,6.9234),Pull (16.886,4.8970) (5.7414,2.8707),Pull (2.7018,11.313) (0,19.757)]
  |> filled (hsla (degrees 12.5) 0.50 0.47 1)
  |> move (-5,5)
  |> scale 0.8
  ]
 
-- pearls on starfish 
pearls = group [
  circle 1
  |> filled white
  ,
  circle 1
  |> filled white
  |> move (4,-7)
  ,
  circle 0.5
  |> filled white
  |> move (8,-13)
  ,
  circle 0.5
  |> filled white
  |> move (-9,0)
  ,
  circle 1
  |> filled white
  |> move (-11.5,-7)
  ,
  circle 1
  |> filled white
  |> move (-15,-13)
  ,
  circle 1
  |> filled white
  |> move (5,6)
  ,
  circle 1
  |> filled white
  |> move (12,8)
  ,
  circle 1
  |> filled white
  |> move (18,10)
  ,
  circle 0.5
  |> filled white
  |> move (-5,12)
  ,
  circle 1
  |> filled white
  |> move (-5,18)
  ,
  circle 1
  |> filled white
  |> move (-5,23)
  ,
  circle 0.5
  |> filled white
  |> move (-14,5)
  ,
  circle 1
  |> filled white
  |> move (-20.5,6.5)
  ,
  circle 1
  |> filled white
  |> move (-26,8)
 ]
type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

init = { time = 0 }

update msg model =
  case msg of
    Tick t _ -> { model | time = t }

view model = collage 192 128 (myShapes model)

main = gameApp Tick { model = init, view = view, update = update, title = "Starfish" }