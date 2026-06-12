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
    helmet
  
  ]
  
helmet = group
 [

  curve (-49.8, 30.9) [Pull (-37.6, 48.8) (-18.9, 53.5), Pull (-17.5, 57.9) (-13.1, 58.8), Pull (-5.3, 56.7) (-4.2, 50.6), Pull (43.4, 28.5) (11.1, -15.0), Pull (-21.0, -36.7) (-46.5, -7.3), Pull (-36.8, -2.2) (-37.3, 14.8), Pull (-39.4, 31.0) (-50.4, 30.4)]
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1 ) black --outer
 ,
 rounds
 ,
 rounds
 |>scaleY 2.5
 |>scaleX 1.5
 |>move(150,-60)
 |>scale 0.36
 |>rotate (degrees 180)
 ,
 curve (-40.2, -14.4) [Pull (-40.3, -16.0) (-40.8, -18.5), Pull (-13.9, -34.4) (8.1, -20.7), Pull (7.5, -19.9) (8.6, -17.2), Pull (-17.9, -31.8) (-40.3, -14.5)]
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1 ) black --outer
 ,
 curve (-4.2, 50.0) [Pull (-2.5, 45.1) (-3.6, 44.7), Pull (-0.7, 34.7) (-2.1, 34.2), Pull (-4.7, 34.6) (-7.4, 35.0), Pull (-11.6, 49.4) (-22.0, 51.5), Pull (-20.5, 52.2) (-19.1, 52.9), Pull (-17.5, 52.7) (-15.9, 52.5), Pull (-11.1, 59.4) (-9.4, 45.3), Pull (-5.0, 42.2) (-1.8, 44.6)]
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1 ) black --outer
 ,
 curve (-10.4, 51.9) [Pull (-13.4, 53.0) (-15.1, 53.3)]
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1 ) black --outer
 ,
 curve (12.1, -14.4) [Pull (26.6, -31.5) (25.2, -41.7), Pull (22.1, -64.2) (-10.8, -63.3), Pull (-35.2, -63.5) (-41.7, -49.2), Pull (-54.2, -9.1) (-67.8, -14.7), Pull (-59.7, -8.1) (-58.3, -9.4), Pull (-46.7, -11.1) (-35.8, -41.9), Pull (-16.5, -64.7) (9.6, -56.2), Pull (27.5, -40.7) (8.7, -19.2), Pull (10.7, -16.9) (12.7, -14.6)]
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1 ) black --outer
 ,
 curve (-39.0, -19.5) [Pull (-24.4, -44.9) (-9.3, -45.6), Pull (10.9, -39.6) (7.8, -21.6), Pull (-14.9, -32.9) (-38.8, -20.1)]
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1 ) black --outer
 ,
 curve (-67.3, -14.4) [Pull (-67.4, -35.5) (-47.1, -39.0), Pull (-49.6, -27.8) (-57.6, -18.3), Pull (-66.9, -12.1) (-65.2, -22.6)]
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1 ) black --outer
 ,
 curve (-58.5, -9.0) [Pull (-42.5, -16.5) (-36.0, -42.1), Pull (-17.1, -63.9) (9.5, -55.7), Pull (26.0, -38.8) (8.3, -21.8), Pull (9.1, -43.0) (-9.4, -46.5), Pull (-26.0, -44.9) (-41.4, -15.6), Pull (-42.4, -12.1) (-45.9, -8.6), Pull (-51.8, -11.2) (-54.3, -8.1), Pull (-56.4, -8.7) (-58.6, -9.1)]
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1 ) black --outer
 ,
 designcircle
 |>scale 0.15
 |>move(-52,-18)
 ,
  designcircle
 |>scale 0.15
 |>move(-45,-30)
 ,
   designcircle
 |>scale 0.15
 |>move(-39,-45)
 ,
 designcircle
 |>scale 0.15
 |>move(-30,-57)
 ,
  designcircle
 |>scale 0.13
 |>move(-15,-61.7)
 ,
  designcircle
 |>scale 0.08
 |>move(-3,-62)
 ,
 designcircle
 |>scale 0.06
 |>move(8,-60.1)
 ,
  designcircle
 |>scale 0.1
 |>move(18,-53.8)
  ,
 designcircle
 |>scale 0.14
 |>move(22.7,-42)
 ,
 designcircle
 |>scale 0.14
 |>move(15.4,-24)
 ] 

designcircle = group
 [
   circle 16.5 --inner
 |>filled black
 |>move (-4,12)
 ,
  circle 16
 |>filled (hsl (degrees 209) 0.607 0.828)
 |>addOutline (solid 1 ) black --inner
 |>move (-5,12)
 ,
 curve (1.8, 2.1) [Pull (10.6, 9.4) (5.1, 18.0)]
 |>outlined (solid 0.5 ) black --insideline
 ]

rounds = group
 [
  circle 23 --outer
  |>filled black --outer
 |>move (-7,12)
 ,
  circle 21.5 --outer
  |>filled (hsl (degrees 50) 1.0 0.42) --outer
   |>addOutline (solid 1 ) black --inner
 |>move (-5,12)
 
 ,
  circle 16.5 --inner
 |>filled black
 |>move (-4,12)
 ,
  circle 16
 |>filled (hsl (degrees 188) 0.895 0.805)
 |>addOutline (solid 1 ) black --inner
 |>move (-5,12)
 ,
 curve (1.8, 2.1) [Pull (10.6, 9.4) (5.1, 18.0)]
 |>outlined (solid 0.5 ) black --insideline
 ]
