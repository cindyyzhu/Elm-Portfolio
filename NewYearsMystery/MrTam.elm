module MrTam exposing (..)

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
    mrtam
    
  ]

mrtam = group [
  face, sweater, 
    shoes |> move (0,1.5),
    shoes |> scaleX -1 |> move (-8.5,2), 
    pants, 
    scarf |> move (-4,15)
  ]
sweater = group [
  curve (-8.0, 35.9) [Pull (-7.2, 32.5) (-3.9, 32.2), Pull (-1.0, 32.8) (0.9, 35.4), Pull (0.2, 34.4) (-0.1, 32.5), Pull (3.9, 31.1) (5.7, 29.1), Pull (8.3, 21.5) (6.2, -1.8), Pull (-5.8, -3.8) (-15.0, -2.3), Pull (-17.4, 22.0) (-14.4, 28.1), Pull (-12.9, 30.5) (-7.6, 32.9), Pull (-9.1, 34.4) (-8.0, 36.2)]
  |> filled (rgb 252 198 78) 
  |> addOutline(solid 0.5) black
  ,
  curve (-14.4, 28.7) [Pull (-16.6, 21.6) (-16.2, 6.8), Pull (-17.0, 4.8) (-17.2, 2.1), Pull (-17.8, -1.9) (-22.2, -0.8), Pull (-29.2, 3.5) (-21.4, 12.1), Pull (-17.9, 26.5) (-14.4, 28.8)]
  |> filled (rgb 252 198 78) 
  |> addOutline(solid 0.5) black
  ,
  curve (-14.4, 28.7) [Pull (-16.6, 21.6) (-16.2, 6.8), Pull (-17.0, 4.8) (-17.2, 2.1), Pull (-17.8, -1.9) (-22.2, -0.8), Pull (-29.2, 3.5) (-21.4, 12.1), Pull (-17.9, 26.5) (-14.4, 28.8)]
  |> filled (rgb 252 198 78) 
  |> addOutline(solid 0.5) black
  |> scaleX -1
  |> move (-9,0)
  , 
  roundedRect 9 2 1  --cane handle
  |> filled (rgb 50 38 131)
  |> addOutline(solid 0.5) black
  |> move (-21,2)
  ,
  roundedRect 1.5 60 1 --cane
  |> filled (rgb 50 38 131)
  |> addOutline(solid 0.5) black
  |> move (-21,-27)
  ,
  curve (-18.8, 5.1) [Pull (-17.1, 3.7) (-17.3, 2.4), Pull (-18.3, 2.7) (-18.6, 3.4), Pull (-19.3, 3.4) (-20.0, 3.4), Pull (-20.1, 2.2) (-20.2, 0.9), Pull (-20.3, -0.4) (-22.4, 0.0), Pull (-26.2, 4.0) (-22.0, 6.0), Pull (-20.2, 5.4) (-18.5, 4.8)]
  |> filled (rgb 231 231 231)  -- hand
  |> addOutline(solid 0.5) black
 , curve (-18.8, 5.1) [Pull (-17.1, 3.7) (-17.3, 2.4), Pull (-18.3, 2.7) (-18.6, 3.4), Pull (-19.3, 3.4) (-20.0, 3.4), Pull (-20.1, 2.2) (-20.2, 0.9), Pull (-20.3, -0.4) (-22.4, 0.0), Pull (-26.2, 4.0) (-22.0, 6.0), Pull (-20.2, 5.4) (-18.5, 4.8)]
  |> filled (rgb 231 231 231)   -- hand 2
  |> addOutline(solid 0.5) black
  |> scaleX -1
  |> move (-8,-1)
 ,  
  curve (-14.4, -2.5) [Pull (-3.1, -3.8) (5.7, -1.6), Pull (5.9, -2.6) (6.0, -3.6), Pull (-3.7, -6.3) (-14.5, -4.5), Pull (-14.5, -3.4) (-14.4, -2.3)]
  |> filled (rgb 231 231 231) 
  |> addOutline(solid 0.5) black
  ]
pants = group [
  curve (5.8, -3.5) [Pull (-3.4, -6.2) (-14.4, -4.4), Pull (-15.5, -22.2) (-15.0, -33.3), Pull (-15.4, -43.2) (-14.2, -49.9), Pull (-11.8, -52.2) (-4.9, -50.4), Pull (-3.5, -38.9) (-6.0, -30.0), Pull (-5.1, -26.7) (-4.3, -23.4), Pull (-3.6, -26.3) (-2.8, -29.2), Pull (-5.1, -39.1) (-3.2, -50.2), Pull (3.7, -53.1) (5.7, -50.2), Pull (7.7, -37.3) (5.9, -26.9), Pull (7.5, -15.3) (5.9, -3.6)]
  |> filled (rgb 50 38 131)
  |> addOutline(solid 0.5) black
  ]
shoes = group [
  curve (-17.0, -55.8) [Pull (-12.4, -54.2) (-7.7, -52.6), Pull (-7.5, -57.0) (-13.7, -58.8), Pull (-17.7, -59.0) (-17.2, -56.0)]
  |> filled (rgb 231 231 231) 
  |> addOutline(solid 0.5) black
  , 
  curve (-13.7, -50.8) [Pull (-15.3, -53.3) (-16.9, -55.7), Pull (-14.9, -56.4) (-12.3, -56.6), Pull (-8.3, -56.1) (-7.6, -52.5), Pull (-11.8, -53.0) (-13.8, -51.6)]
  |> filled (rgb 42 37 91)
  |> addOutline(solid 0.5) black
  ]

scarf = group [
    roundedRect 40 10 4
      |> filled red
      |> scale 0.5
      |> move (0, 15)
      , 
     roundedRect 12 4 0.5
       |> filled red
       |> rotate (degrees 50)
       |> move (-12, 10)
       ,
       roundedRect 12 4 0.5
       |> filled red 
       |> rotate (degrees 70)
       |> move (-6, 8)
       
  ]

face = group [
  curve (1.0, 44.0) [Pull (-0.8, 44.8) (-2.7, 45.6), Pull (-5.0, 44.9) (-7.3, 44.1), Pull (-11.0, 34.3) (-3.8, 32.2), Pull (3.2, 34.3) (1.2, 44.1)]
  |> filled (rgb 243 163 144)
  |> addOutline(solid 0.5) black
  ,
  curve (-8.6, 40.7) [Pull (-7.4, 38.9) (-6.2, 37.0), Pull (-5.3, 38.3) (-3.7, 37.7), Pull (-2.0, 38.1) (-1.4, 36.6), Pull (0.1, 38.8) (1.6, 41.0), Pull (2.7, 33.3) (-4.4, 32.2), Pull (-9.8, 33.2) (-8.4, 40.8)]
  |> filled (rgb 231 231 231) 
  |> addOutline(solid 0.5) black
  ,
  curve (-2.2, 37.0) [Pull (-3.1, 37.1) (-3.9, 37.3), Pull (-4.8, 37.0) (-5.7, 36.8), Pull (-4.1, 35.0) (-2.2, 37.0), Pull (-3.6, 36.1) (-5.8, 36.8)]
  |> filled (rgb 243 163 144)
  |> addOutline(solid 0.2) black
  ,
  curve (3.8, 41.9) [Pull (2.5, 41.8) (1.3, 41.7), Pull (1.3, 42.6) (1.4, 43.4), Pull (-0.4, 44.4) (-2.3, 45.5), Pull (0.7, 46.2) (3.5, 46.0), Pull (4.1, 43.5) (3.5, 42.2), Pull (3.6, 42.0) (3.7, 41.9)]
  |> filled (rgb 231 231 231) 
  |> addOutline(solid 0.5) black
  ,
  curve (-9.4, 43.0) [Pull (-11.1, 44.8) (-10.8, 46.5), Pull (-7.4, 50.1) (2.3, 50.0), Pull (4.5, 48.3) (3.5, 46.0), Pull (-3.6, 45.7) (-9.5, 43.4)]
  |> filled (rgb 231 231 231) 
  |> addOutline(solid 0.5) black
  ,
  curve (-5.3, 53.5) [Pull (0.3, 53.7) (2.8, 50.0), Pull (-8.1, 50.1) (-10.6, 46.4), Pull (-10.4, 45.6) (-10.3, 44.7), Pull (-11.3, 43.2) (-11.1, 41.1), Pull (-11.4, 42.4) (-12.7, 41.2), Pull (-12.6, 52.7) (-5.1, 53.9)]
  |> filled (rgb 50 38 131)
  |> addOutline(solid 0.5) black
  ,  
  circle 1.5
  |> filled (rgb 231 231 231) 
  |> move (-12,41)
  |> addOutline(solid 0.5) black
  ,
  curve (-9.2, 42.5) [Pull (-9.7, 42.7) (-9.6, 43.5), Pull (-8.8, 43.8) (-8.0, 44.1), Pull (-8.3, 42.8) (-8.6, 41.5), Pull (-9.0, 42.0) (-9.3, 42.4)]
  |> filled (rgb 231 231 231) 
  |> addOutline(solid 0.5) black
  |> move (0.5,0)
  ,
  curve (-8.9, 38.4) [Pull (-11.0, 40.3) (-9.8, 42.2), Pull (-7.8, 41.6) (-8.9, 38.5)]
  |> filled (rgb 243 163 144)
  |> addOutline(solid 0.5) black
  |> move (0,0.25)
  ,
  curve (1.6, 38.1) [Pull (2.2, 39.3) (2.8, 40.4), Pull (3.5, 42.2) (1.6, 42.2), Pull (1.6, 40.1) (1.5, 38.0)]
  |> filled (rgb 243 163 144)
  |> addOutline(solid 0.5) black
  ,
  curve (-8.9, 42.2) [Pull (-7.2, 43.0) (-5.4, 42.5)]
  |> outlined (solid 1) (rgb 231 231 231)
  ,
  curve (0.9, 42.2) [Pull (-0.3, 43.1) (-2.5, 42.5)]
  |> outlined (solid 1) (rgb 231 231 231)
  , 
  curve (-7.0, 39.0) [Pull (-5.6, 39.3) (-5.4, 40.3)]
  |> filled black  -- left wrinkle
  ,
  curve (-2.5, 40.3) [Pull (-2.4, 39.5) (-1.5, 39.3)]
  |> filled black  -- right wrinkle
  ,
  curve (-4.2, 42.1) [Pull (-4.6, 40.5) (-5.1, 38.9), Pull (-6.9, 39.0) (-8.8, 39.2), Pull (-8.7, 40.2) (-8.6, 41.2), Pull (-6.7, 41.6) (-4.8, 41.9), Pull (-4.0, 41.6) (-3.2, 41.4), Pull (-3.1, 41.7) (-3.0, 42.1), Pull (-0.8, 41.7) (1.3, 41.3), Pull (1.1, 40.3) (0.9, 39.2), Pull (-0.6, 39.0) (-2.1, 38.7), Pull (-3.2, 40.4) (-3.0, 41.4)]
  |> outlined (solid 0.25) black  -- glasses
  ,
  curve (-2.2, 40.6) [Pull (-1.1, 40.6) (-0.3, 40.3)]  
  |> outlined (solid 0.5) black
  ,
  curve (-7.3, 40.3) [Pull (-6.5, 40.4) (-5.7, 40.6)]
  |> outlined (solid 0.5) black
  ]