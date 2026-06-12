module MrSamosa exposing (..)

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
   
   samosa
  ]
samosa = group [
  samosaLeg
    ,
   samosaLeg
   |> mirrorX
   ,
   hand
   |> mirrorX,
   samosaBody
  , 
  hand
 ]
samosaBody = group [
 
 curve (12.5, 57.9) [Pull (0.3, 54.8) (-2.3, 50.3), Pull (-5.4, 46.6) (-9.6, 44.1), Pull (-17.0, 37.5) (-22.9, 29.8), Pull (-24.5, 26.0) (-26.2, 22.2), Pull (-28.9, 19.9) (-25.9, 24.7), Pull (-30.3, 23.4) (-40.7, 14.1), Pull (-37.6, 17.1) (-34.4, 20.2), Pull (-47.3, 17.4) (-45.4, 8.5), Pull (-33.8, 1.1) (-41.7, 9.0), Pull (-37.2, 3.7) (-31.2, 1.5), Pull (-35.2, 5.3) (-35.5, 6.5), Pull (-28.4, -1.3) (-15.9, -7.2), Pull (-9.2, -9.8) (-3.2, -10.8), Pull (9.5, -11.8) (19.9, -11.2), Pull (27.7, -7.9) (35.5, -4.6), Pull (43.8, -0.8) (52.9, 0.0), Pull (56.9, 4.2) (52.9, 8.4), Pull (49.6, 8.3) (46.6, 8.3), Pull (44.2, 11.3) (41.7, 12.8), Pull (40.0, 16.3) (35.2, 17.8), Pull (36.0, 20.4) (31.5, 23.0), Pull (31.3, 27.8) (24.5, 32.2), Pull (26.1, 34.3) (22.6, 37.3), Pull (22.8, 39.4) (20.7, 41.6), Pull (20.9, 44.1) (18.3, 46.6), Pull (18.1, 48.0) (17.9, 49.4), Pull (18.8, 53.0) (18.6, 56.2), Pull (16.0, 58.5) (12.3, 57.4)]
 |> filled (hsl (degrees 42) 0.877 0.644)
 |> addOutline (solid 1) black
 ,
 
 curve (26.4, 31.3) [Pull (30.4, 27.1) (31.0, 22.1), Pull (37.1, 20.4) (36.0, 16.1), Pull (36.1, 17.1) (30.0, 15.1), Pull (23.2, 21.5) (20.5, 30.1), Pull (25.3, 30.6) (26.3, 31.7), Pull (23.5, 35.8) (20.6, 39.9), Pull (21.6, 37.8) (23.3, 34.7), Pull (19.9, 35.5) (16.4, 36.4), Pull (14.7, 40.1) (12.9, 43.7), Pull (18.6, 41.2) (20.5, 39.9), Pull (20.5, 46.4) (11.0, 48.2), Pull (14.7, 45.6) (18.1, 46.1), Pull (18.8, 49.9) (12.0, 52.5), Pull (17.2, 49.6) (18.7, 51.4), Pull (17.0, 60.5) (11.8, 56.7), Pull (10.8, 53.1) (11.0, 49.9), Pull (12.1, 42.7) (15.4, 37.8), Pull (18.0, 33.8) (20.0, 29.0), Pull (20.9, 27.5) (21.8, 26.0), Pull (22.7, 23.9) (23.6, 21.8), Pull (27.3, 18.3) (28.7, 14.8), Pull (31.6, 10.8) (36.5, 7.5), Pull (38.7, 5.9) (41.0, 4.3), Pull (44.8, 0.1) (50.9, 3.8), Pull (43.0, 1.0) (52.3, 0.2), Pull (59.5, 5.6) (50.7, 8.7), Pull (45.4, 8.2) (41.2, 5.0), Pull (38.9, 6.3) (36.6, 7.6), Pull (41.9, 10.6) (44.8, 10.5), Pull (46.2, 9.4) (47.5, 8.4), Pull (39.7, 16.4) (32.0, 10.7), Pull (35.4, 13.3) (40.7, 14.1), Pull (38.2, 15.5) (35.8, 16.9)]
 |> outlined (solid 0.5) black
 |>addOutline (solid 0.5) black
 ,
 
 curve (37.2, 8.0) [Pull (39.3, 7.0) (41.4, 6.1), Pull (43.6, 6.1) (46.1, 8.1), Pull (48.7, 8.8) (45.7, 8.3), Pull (42.0, 10.8) (38.0, 8.0)]
 |> filled (hsl (degrees 42) 0.877 0.644)
 ,
 curve (21.3, 30.8) [Pull (29.5, 32.1) (31.2, 21.7), Pull (35.9, 22.1) (35.2, 17.2), Pull (32.8, 15.5) (28.8, 16.0), Pull (28.0, 17.3) (27.3, 19.3), Pull (26.1, 20.2) (25.0, 21.1), Pull (24.7, 23.2) (24.3, 25.4), Pull (22.8, 26.5) (21.3, 27.7), Pull (21.3, 29.2) (21.3, 30.8)]
 |> filled (hsl (degrees 42) 0.877 0.644)
 ,
  
 curve (14.9, 42.5) [Pull (15.8, 39.9) (17.4, 37.4), Pull (19.0, 34.9) (22.0, 35.8), Pull (19.2, 41.7) (15.2, 42.2)]
 |> filled (hsl (degrees 42) 0.877 0.644)
 , 
 
 curve (9.7, 54.5) [Pull (-10.4, 42.2) (-11.2, 33.6), Pull (-19.1, 27.0) (-17.5, 28.8), Pull (-25.7, 21.2) (-28.8, 19.2), Pull (-34.8, 16.5) (-40.9, 13.9), Pull (-43.8, 12.3) (-38.1, 8.9), Pull (-30.2, 6.4) (-22.3, 5.1), Pull (-14.0, 0.0) (-5.7, -3.1), Pull (5.2, -5.5) (14.0, -3.3), Pull (21.5, 0.4) (29.0, 4.3), Pull (31.8, 3.6) (34.5, 2.9), Pull (26.1, 13.2) (20.2, 24.2), Pull (19.8, 25.1) (19.3, 25.9), Pull (13.6, 34.1) (10.9, 43.1), Pull (10.6, 44.0) (10.3, 44.9), Pull (10.2, 49.8) (10.1, 54.7)]
 |> filled ( hsl (degrees 42) 0.95 0.644)
 
 ,
 samosaEyes
 |> move (-7, 25),
 samosaEyes
  |> mirrorX
  |> move (7, 25)
 , samosaLips
 ]
 
samosaEyes = group [
  circle 6
  |> filled black
  ,
  circle 5
  |> filled white
  |> move (0, -0.6),
  circle 3.7
  |> filled black
  |> move (1, 0),
  circle 1.5
  |> filled white
  |> move (2.1, 1.5)
  ]
  
samosaLips = group [
 
 curve (9.1, 9.5) [Pull (0.1, 1.7) (-9.1, 9.9)]
 |> outlined (solid 1) black
 ,
 
 cheekspot
 ,
 dimple
 ,
 dimple
 |> mirrorX
 
 ]
 
dimple = group [ 
 curve (-5.7, 11.4) [Pull (-10.4, 12.3) (-9.9, 7.6)]
 |> filled black
 
 ]
samosaLeg = group [
 curve (-13.9, -34.5) [Pull (-11.7, -37.4) (-7.2, -36.4), Pull (-7.4, -28.4) (-6.0, -19.3), Pull (-4.7, -14.4) (-2.6, -9.5), Pull (-7.0, -8.9) (-8.7, -7.9), Pull (-12.6, -19.2) (-13.8, -34.6)]
 |> filled (hsl (degrees 42) 0.877 0.644)
 |> addOutline (solid 1) black
 , shoe
 ]
shoe = group [
 
 curve (-7.6, -38.6) [Pull (-4.4, -38.8) (-4.3, -37.4), Pull (-4.8, -35.6) (-6.8, -35.3), Pull (-8.3, -33.9) (-6.4, -32.4), Pull (-5.5, -32.5) (-4.6, -32.5), Pull (-2.5, -35.4) (-0.8, -42.0), Pull (0.5, -49.4) (-4.8, -51.7), Pull (-10.5, -59.2) (-15.8, -61.8), Pull (-20.6, -63.3) (-27.6, -61.7), Pull (-32.5, -57.8) (-30.9, -51.6), Pull (-27.7, -45.1) (-24.5, -42.9), Pull (-24.0, -40.2) (-22.4, -39.8), Pull (-22.2, -37.9) (-20.5, -36.7), Pull (-19.2, -36.5) (-17.9, -36.3), Pull (-17.1, -35.1) (-16.3, -33.9), Pull (-8.9, -35.7) (-8.0, -38.0)]
 |> filled blue
 |> addOutline (solid 1) black
 ,
 
 curve (-14.4, -56.0) [Pull (-17.0, -46.6) (-27.5, -46.4), Pull (-32.4, -51.2) (-27.9, -57.1), Pull (-21.4, -59.6) (-14.5, -56.0)]
  |> filled white
  |> addOutline (solid 0.5) black
  ,
  
 curve (-1.9, -44.1) [Pull (0.1, -45.1) (-0.7, -47.6), Pull (-4.9, -52.3) (-9.0, -57.0), Pull (-14.0, -62.3) (-22.8, -62.3), Pull (-28.0, -62.4) (-31.2, -57.8), Pull (-31.4, -56.0) (-30.3, -53.9), Pull (-25.5, -58.6) (-19.9, -58.8), Pull (-13.0, -56.6) (-7.7, -51.8), Pull (-4.7, -47.9) (-1.7, -44.0)]
  |> filled white
  |> addOutline (solid 0.5) black
  ,
  

 curve (-19.8, -38.0) [Pull (-13.7, -35.2) (-9.6, -41.4)]
 |> outlined (solid 1) white,
 
 
 curve (-11.1, -43.2) [Pull (-15.5, -38.9) (-20.6, -40.3)]
 |> outlined (solid 1) white,
 
 curve (-12.7, -45.9) [Pull (-16.2, -40.4) (-22.5, -42.6)]
 |> outlined (solid 1) white,

 curve (-15.0, -49.0) [Pull (-19.3, -43.9) (-24.8, -45.2)]
 |> outlined (solid 1) white
 ]
cheekspot = group [
  circle 2
 |> filled (hsl (degrees 42) 0.877 0.544)
 |> addOutline (solid 0.1) white
 |> move (18, 12)
 ,
 oval 5 2
 |> filled (hsl (degrees 42) 0.877 0.544)
 |> move (18, 9)
 ,
  circle 3
 |> filled (hsl (degrees 42) 0.877 0.444)
 |> move (-18, 12)
 |> makeTransparent 0.5
 ,
   
    roundedRect 4 6 24
      |> filled 
          (hsl (degrees 42) 0.74 0.494)
          |> move (-25, 20)
          |> addOutline (solid 0.1) white
  
 
 ]
 
hand = group [

 curve (36.3, -6.8) [Pull (26.8, 10.3) (24.8, 3.8), Pull (28.5, -2.8) (31.7, -10.3), Pull (35.6, -9.6) (36.3, -7.1)]
 |> filled (hsl (degrees 42) 0.877 0.644)
 |> addOutline (solid 1) black
 ,
 
 curve (30.5, -13.0) [Pull (29.6, -16.9) (33.3, -20.1), Pull (32.7, -23.1) (31.3, -26.1), Pull (38.2, -28.0) (37.2, -20.5), Pull (39.5, -21.4) (42.6, -20.1), Pull (51.3, -26.8) (53.3, -22.1), Pull (49.1, -21.6) (44.6, -17.6), Pull (54.6, -21.8) (54.0, -15.5), Pull (48.7, -16.5) (44.1, -13.5), Pull (45.0, -14.4) (46.0, -15.4), Pull (57.4, -13.5) (51.5, -7.9), Pull (47.1, -12.3) (39.9, -8.1), Pull (33.2, -6.7) (30.2, -12.7), Pull (37.0, -12.3) (39.9, -8.5)]
 |> filled (hsl (degrees 42) 0.877 0.644)
 |> addOutline (solid 1) black
 ]