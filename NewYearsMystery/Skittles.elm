module Skittles exposing (..)

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
   bodyOutline 
  ]
bodyOutline = group
 [
 
 curve (-63.9, 22.5) [Pull (-66.0, 10.8) (-59.0, 6.9), Pull (-61.5, 11.0) (-59.7, 14.5), Pull (-58.4, 6.9) (-51.7, 4.0), Pull (-52.3, 5.7) (-53.0, 7.3), Pull (-50.2, 2.9) (-44.9, 2.1), Pull (-45.7, 3.3) (-46.5, 4.5), Pull (-43.2, 0.9) (-39.0, 0.3), Pull (-44.3, 5.2) (-31.5, 0.9), Pull (-41.4, -5.7) (-25.4, 2.9), Pull (-29.6, -3.0) (-19.9, 5.5), Pull (-15.2, 8.0) (-14.1, 13.6), Pull (-13.9, 12.1) (-13.8, 10.7), Pull (-9.6, 13.6) (-10.2, 21.3), Pull (-9.1, 20.7) (-8.0, 20.0), Pull (-9.1, 26.7) (-13.7, 33.3), Pull (-11.7, 33.0) (-9.6, 32.6), Pull (-13.7, 36.5) (-14.8, 41.0), Pull (-12.6, 49.7) (-17.0, 57.1), Pull (-22.3, 59.4) (-25.7, 57.4), Pull (-28.0, 57.7) (-31.4, 56.8), Pull (-30.3, 58.6) (-28.0, 59.7), Pull (-35.6, 60.2) (-42.6, 54.8), Pull (-41.2, 56.8) (-41.0, 58.8), Pull (-43.4, 58.3) (-46.5, 55.7), Pull (-51.7, 59.9) (-56.3, 60.1), Pull (-63.9, 57.1) (-64.9, 42.8), Pull (-67.7, 37.1) (-71.9, 32.6), Pull (-68.6, 32.3) (-66.5, 34.4), Pull (-73.5, 27.4) (-72.8, 18.2), Pull (-70.4, 18.7) (-70.3, 20.4), Pull (-71.5, 12.4) (-70.2, 5.6), Pull (-67.8, 7.2) (-67.8, 9.9), Pull (-67.2, 3.3) (-68.4, -3.3), Pull (-65.4, -0.5) (-64.2, 2.8), Pull (-67.4, -6.7) (-63.9, -12.1), Pull (-62.3, -10.4) (-63.0, -8.1), Pull (-60.1, -20.0) (-57.9, -30.1), Pull (-53.8, -45.6) (-58.4, -51.2), Pull (-67.1, -54.4) (-60.1, -58.3), Pull (-55.3, -58.4) (-50.5, -58.5), Pull (-45.9, -52.0) (-40.5, -45.6), Pull (-37.7, -38.5) (-38.3, -33.9), Pull (-34.3, -34.1) (-34.0, -39.1), Pull (-32.6, -38.0) (-31.1, -36.9), Pull (-26.7, -51.1) (-34.0, -55.1), Pull (-37.9, -58.6) (-33.4, -61.0), Pull (-26.0, -61.8) (-21.1, -60.9), Pull (-14.8, -44.6) (-11.6, -27.2), Pull (-12.0, -30.0) (-12.5, -32.7), Pull (7.3, -25.0) (11.5, -26.9), Pull (16.5, -34.7) (24.7, -37.0), Pull (29.4, -43.0) (28.4, -49.5), Pull (23.0, -54.9) (29.0, -56.6), Pull (33.9, -56.6) (38.8, -56.5), Pull (42.3, -56.2) (41.6, -43.3), Pull (41.8, -37.0) (42.0, -30.7), Pull (40.5, -28.1) (39.0, -25.6), Pull (40.7, -7.2) (34.0, 1.9), Pull (25.8, 15.1) (2.3, 13.4), Pull (-4.9, 13.7) (-9.9, 16.5)]
 |>filled (hsl (degrees 34) 0.922 0.371)
 |>addOutline (solid 1 ) black
 ,
 curve (37.9, -6.4) [Pull (43.9, -0.8) (45.1, 8.8), Pull (46.0, 6.4) (46.8, 3.9), Pull (49.3, 9.0) (44.6, 17.0), Pull (46.8, 15.0) (48.9, 12.9), Pull (48.2, 19.6) (43.3, 24.6), Pull (44.6, 24.3) (46.0, 23.9), Pull (43.3, 27.7) (38.2, 29.6), Pull (39.7, 29.9) (41.2, 30.1), Pull (37.9, 34.5) (29.5, 32.5), Pull (30.7, 33.2) (35.1, 35.1), Pull (23.0, 36.9) (16.3, 30.0), Pull (15.2, 29.8) (14.1, 30.8), Pull (6.3, 24.3) (7.9, 15.9), Pull (7.0, 16.8) (6.0, 17.7), Pull (5.8, 15.7) (6.3, 13.8)]
 |>filled (hsl (degrees 34) 0.922 0.371)
 |>addOutline (solid 1 ) black

 ,
 curve (15.5, -32.7) [Pull (15.1, -31.7) (12.0, -27.1), Pull (6.7, -24.3) (-4.3, -29.8), Pull (5.5, -31.0) (15.3, -32.1)]
 |>filled (hsl (degrees 34) 0.922 0.371)
 |>move(0,-1)

 , 
 curve (16.4, -32.9) [Pull (15.0, -35.6) (17.0, -40.3), Pull (12.4, -47.9) (4.4, -55.5), Pull (0.5, -55.5) (-3.3, -55.5), Pull (-12.7, -51.6) (-2.0, -48.5), Pull (-0.6, -45.1) (0.7, -41.6), Pull (-1.7, -35.8) (-4.3, -30.1)]
 |>filled (hsl (degrees 34) 0.922 0.371)
 |>addOutline (solid 1 ) black
 ,
 
 curve (-48.1, 23.8) [Pull (-49.1, 20.0) (-40.8, 19.1), Pull (-32.7, 20.2) (-30.3, 26.7), Pull (-30.7, 19.2) (-24.7, 21.2), Pull (-26.8, 18.2) (-28.6, 13.0), Pull (-34.6, 11.3) (-43.5, 19.3)]
 |>filled black
 |>addOutline (solid 1 ) black
 ,
 curve (-37.6, 19.7) [Pull (-36.3, 20.6) (-34.4, 21.1), Pull (-32.0, 20.5) (-31.3, 18.3), Pull (-31.5, 22.4) (-28.0, 20.0), Pull (-26.6, 10.8) (-34.6, 13.7), Pull (-36.9, 16.1) (-38.1, 19.1)]
  |>filled red
 |>addOutline (solid 1 ) black
 ,
 curve (-60.6, -17.5) [Pull (-56.0, -25.4) (-57.3, -14.9), Pull (-50.8, -34.3) (-51.5, -21.4), Pull (-50.0, -28.1) (-46.8, -30.9), Pull (-46.3, -28.2) (-47.0, -25.4), Pull (-42.9, -31.9) (-38.8, -33.5), Pull (-39.7, -28.3) (-35.3, -25.3), Pull (-36.0, -26.8) (-36.2, -29.4), Pull (-26.1, -19.2) (-28.0, -13.9), Pull (-28.6, -25.0) (-17.8, -5.2), Pull (-12.8, -6.4) (-12.6, 2.6), Pull (-10.5, 3.4) (-11.0, 6.3), Pull (-9.7, 3.5) (-8.0, 1.8), Pull (-6.8, 7.6) (-9.9, 11.7)]
 |>outlined (solid 1 ) black
 ,
 curve (-55.2, -5.4) [Pull (-51.7, -11.9) (-48.4, -15.7), Pull (-47.3, -13.1) (-46.2, -10.6), Pull (-45.7, -11.7) (-45.3, -12.9), Pull (-42.6, -10.3) (-40.0, -7.6)]
 |>outlined (solid 1 ) black
 ,
 curve (5.9, 14.1) [Pull (5.7, 15.9) (5.5, 17.7), Pull (7.2, 16.8) (9.0, 15.9), Pull (5.9, 25.1) (14.2, 30.4), Pull (13.3, 28.2) (12.4, 26.0), Pull (22.8, 37.9) (35.8, 35.9), Pull (33.0, 34.6) (30.3, 33.2), Pull (37.1, 34.7) (41.9, 30.3), Pull (39.9, 30.0) (37.9, 29.8), Pull (43.1, 28.2) (46.3, 24.6), Pull (44.3, 24.9) (42.2, 25.3), Pull (48.7, 20.3) (49.3, 13.4), Pull (47.1, 15.2) (44.8, 17.1), Pull (49.1, 9.9) (46.8, 3.3), Pull (46.1, 5.9) (45.4, 8.5), Pull (44.7, -0.6) (38.6, -5.8), Pull (30.1, 14.2) (5.7, 13.9)]
 |>filled (hsl (degrees 34) 0.922 0.371) --tail
 |>addOutline (solid 1 ) black
 ,
 --details
 curve (-7.8, -14.0) [Pull (-5.3, -24.2) (-9.3, -21.4), Pull (-7.7, -26.7) (-10.9, -28.9)]
 |>outlined (solid 1 ) black
 ,
 curve (15.9, -11.4) [Pull (9.8, -21.4) (12.2, -25.9)]
 |>outlined (solid 1 ) black
 ,
 curve (35.7, -10.4) [Pull (36.3, -19.1) (31.4, -22.3)]
 |>outlined (solid 1 ) black
 ,
 curve (21.5, 14.2) [Pull (27.5, 20.5) (34.7, 9.4)]
 |>outlined (solid 1 ) black
 ,
 curve (-56.4, -28.8) [Pull (-54.2, -35.6) (-50.8, -38.9)]
 |>outlined (solid 1 ) black
 ,
 curve (-59.1, -58.5) [Pull (-60.4, -51.4) (-54.7, -52.1)]
 |>outlined (solid 1 ) black
 ,
 curve (-27.3, -56.1) [Pull (-29.6, -58.7) (-28.3, -61.4)]
 |>outlined (solid 1 ) black
 ,
 curve (-31.7, -56.5) [Pull (-34.1, -58.3) (-33.7, -61.1)]
 |>outlined (solid 1 ) black
 ,
 curve (-3.2, -50.8) [Pull (-4.4, -52.3) (-3.6, -55.4)]
  |>outlined (solid 1 ) black
  ,
  curve (30.3, -51.3) [Pull (27.7, -53.7) (29.9, -56.6)]
  |>outlined (solid 1 ) black
  ,
  curve (36.1, -51.1) [Pull (33.1, -52.6) (33.8, -56.6)]
 |>outlined (solid 1 ) black
 ,
 curve (-24.0, 22.2) [Pull (-19.2, 32.3) (-31.9, 35.9), Pull (-43.7, 34.9) (-45.9, 27.6)]
 |>outlined (solid 1 ) black
 ,
 curve (-21.3, 28.2) [Pull (-17.7, 23.5) (-20.8, 19.3)]
 |>outlined (solid 1 ) black
 ,
 curve (-24.9, 15.0) [Pull (-28.5, 0.0) (-44.8, 10.3)] 
 |>outlined (solid 1 ) black
 ,
 curve (-49.5, 26.1) [Pull (-53.6, 21.4) (-49.8, 19.7)]
 |>outlined (solid 1 ) black
 ,
 curve (-21.3, 28.2) [Pull (-17.7, 23.5) (-20.8, 19.3)]
 |>outlined (solid 1 ) black
 ,
 curve (-26.1, 44.1) [Pull (-29.5, 39.2) (-27.6, 35.1)]
 |>outlined (solid 1 ) black
 ,
 curve (-25.2, 33.9) [Pull (-16.6, 35.9) (-12.6, 26.4)]
 |>outlined (solid 1 ) black
 ,
 curve (-29.1, 45.4) [Pull (-33.2, 41.8) (-30.1, 37.1)]
 |>outlined (solid 1 ) black
 ,
 curve (-37.8, 37.2) [Pull (-36.4, 43.7) (-40.8, 46.0)]
 |>outlined (solid 1 ) black
 ,
 curve (-42.9, 44.7) [Pull (-45.2, 41.3) (-40.8, 34.2)]
 |>outlined (solid 1 ) black
 ,
 curve (-23.7, -21.0) [Pull (-22.0, -27.8) (-24.5, -34.6)]
 |>outlined (solid 1 ) black
 ,
 curve (-45.0, 18.6) [Pull (-38.5, 13.6) (-35.4, 12.0), Pull (-32.0, 12.0) (-28.6, 12.0), Pull (-27.0, 13.4) (-26.6, 15.3)]
 |>outlined (solid 1 ) black
 ,
 curve (-47.7, 39.9) [Pull (-47.3, 43.1) (-43.8, 42.1)]
 |>outlined (solid 1 ) black
 ,
 curve (-27.6, 42.0) [Pull (-23.8, 42.2) (-23.4, 40.3)] 
 |>outlined (solid 1 ) black
 ,
 oval 8.5 6 --nose
 |>filled black
 |>move(-30,29.5)
 ,
 oval 2 3
 |>filled white
 |>move(-31,30)
 ,
 oval 1 2
 |>filled white
 |>move(-28,30)
 ,
 curve (-28.6, 38.3) [Pull (-22.8, 38.8) (-24.3, 33.9), Pull (-25.6, 33.5) (-27.9, 34.8)]
 |>filled (hsl (degrees 183) 0.861 0.73)
 |>addOutline (solid 1 ) black
 ,
 curve (-40.5, 34.2) [Pull (-44.3, 33.1) (-48.1, 34.4), Pull (-46.7, 39.4) (-42.9, 38.4)]
 |>filled (hsl (degrees 183) 0.861 0.73)
 |>addOutline (solid 1 ) black
 ,
 circle 2.5
 |>filled black
 |>move (-44,36)
 ,
 circle 1.9
 |>filled black
 |>move(-26.5,36)
 
 ,
 
 --eye
 curve (-59.1, 39.9) [Pull (-63.2, 35.9) (-66.1, 32.7), Pull (-62.3, 33.4) (-62.7, 33.5), Pull (-70.2, 26.0) (-66.7, 20.2), Pull (-58.7, 31.9) (-47.4, 34.3)]
 |>outlined (solid 1 ) black
 ,
 --ear
 curve (-25.2, 56.8) [Pull (-26.4, 55.8) (-27.5, 54.9), Pull (-27.2, 54.3) (-26.2, 53.9), Pull (-21.4, 56.8) (-17.3, 53.2)]
 |>outlined (solid 1 ) black
 ,
 curve (-26.7, 54.3) [Pull (-22.6, 52.1) (-22.5, 52.3), Pull (-23.7, 51.8) (-24.5, 51.6), Pull (-21.5, 50.3) (-16.0, 42.5)]
 |>outlined (solid 1 ) black
 ,
 curve (-19.8, 53.4) [Pull (-19.9, 48.8) (-20.1, 48.4)]
 |>outlined (solid 1 ) black
 ,
 curve (-18.9, 46.2) [Pull (-19.3, 46.1) (-16.8, 48.4)]
 |>outlined (solid 1 ) black
 ,
 curve (-64.6, 42.6) [Pull (-63.9, 38.2) (-58.4, 47.0), Pull (-55.2, 49.5) (-51.9, 51.1), Pull (-56.7, 51.2) (-47.4, 54.0)]
 |>outlined (solid 1 ) black
 ,
 curve (-56.4, 49.0) [Pull (-55.6, 51.0) (-54.7, 53.0), Pull (-55.8, 55.1) (-57.9, 52.7), Pull (-55.1, 55.7) (-49.8, 54.5)]
 |>outlined (solid 1 ) black
 ]