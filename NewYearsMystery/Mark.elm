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
    tshirt,
    pant,
    hair,
    leftshoe,
    rightshoe,
    rightarm,
    heads,
   leftarm,
   smile,
   leye
   |> move (-10, 133)
   |> scale 0.17
   |> addOutline (solid 2.4) black,
   reye
   |> move (18, 130)
   |> scale 0.17
   |> addOutline (solid 2.4) black,
   nose,
   rbrow,
   lbrow
  ]
tshirt = group [
  
 curve (-7.7, 2.5) [Pull (-8.3, -6.7) (-9.0, -15.9), Pull (-1.2, -18.1) (6.4, -14.3), Pull (4.8, -14.4) (8.8, 1.8), Pull (9.0, -2.8) (14.6, 3.3), Pull (12.0, 10.8) (5.5, 10.7), Pull (0.0, 3.1) (-2.6, 10.3), Pull (-4.9, 9.5) (-7.3, 8.8), Pull (-9.4, 6.0) (-11.5, 3.1), Pull (-10.2, 1.6) (-7.9, -0.7)]
  |> filled (rgb 6 78 60)
  |> addOutline (solid 0.5) black
  ]
  
pant = group [
  
  curve (12.9, -47.1) [Pull (10.5, -40.1) (8.1, -33.2), Pull (5.0, -24.2) (-0.1, -20.4), Pull (2.0, -20.8) (3.7, -21.7), Pull (0.8, -19.0) (-3.5, -19.2), Pull (-2.4, -20.5) (-0.3, -20.4), Pull (-0.2, -26.6) (-0.0, -32.9), Pull (1.2, -39.7) (1.2, -48.5), Pull (-3.3, -46.8) (-7.9, -45.1), Pull (-3.2, -46.1) (0.4, -47.9), Pull (1.9, -49.0) (0.8, -52.8), Pull (-4.2, -49.5) (-9.9, -48.6), Pull (-8.8, -46.7) (-7.8, -44.8), Pull (-6.9, -39.9) (-6.6, -34.5), Pull (-7.8, -27.7) (-8.6, -15.8), Pull (-1.6, -18.9) (7.9, -13.0), Pull (12.2, -26.3) (14.4, -30.2), Pull (16.9, -33.0) (17.2, -35.3), Pull (21.1, -40.7) (22.9, -47.8), Pull (24.0, -50.7) (22.8, -53.6), Pull (17.5, -46.6) (11.3, -52.1), Pull (11.7, -50.0) (12.1, -47.8), Pull (17.1, -46.5) (22.7, -48.0)]
    |> filled (rgb 49 152 205)
    |> addOutline (solid 0.5) black
    ]
    
hair = group [

    curve (10.1, 27.9) [Pull (9.5, 28.3) (8.8, 27.8), Pull (8.9, 31.2) (0.4, 31.5), Pull (-1.4, 31.8) (-2.9, 33.0), Pull (-2.7, 32.1) (-2.5, 31.2), Pull (-3.6, 32.0) (-3.8, 33.1), Pull (-4.6, 31.6) (-4.1, 29.5), Pull (-4.7, 30.6) (-5.2, 31.7), Pull (-5.6, 28.6) (-4.3, 26.3), Pull (-3.1, 27.6) (-4.4, 28.9), Pull (-0.8, 24.2) (7.0, 27.3), Pull (7.8, 25.3) (7.7, 23.3), Pull (8.3, 23.1) (8.5, 23.4), Pull (8.8, 22.2) (7.7, 20.1), Pull (8.2, 21.5) (9.5, 22.0), Pull (11.4, 26.7) (8.5, 27.9), Pull (9.3, 28.4) (9.1, 29.0)]
    |> filled (rgb 230 208 142)
    |> addOutline (solid 0.2) black
    ]
    
     

leftshoe = group [
        curve (1.1, -36.4) [Pull (-6.9, -40.8) (-15.3, -37.5), Pull (-8.4, -40.2) (-1.6, -37.7), Pull (-2.4, -36.8) (-3.3, -36.0), Pull (-12.7, -28.8) (-15.4, -37.5), Pull (-15.3, -38.4) (-15.3, -39.3), Pull (-6.9, -41.3) (1.3, -38.2), Pull (1.1, -37.3) (1.0, -36.4), Pull (-2.6, -34.5) (-7.1, -33.4)]
    |> filled (rgb 84 61 39)
    |> addOutline (solid 0.3) black
    |> move (0, -14.6)
    ]
rightshoe = group [
    curve (10.3, -38.0) [Pull (17.3, -40.9) (23.0, -37.5), Pull (16.0, -29.2) (10.5, -38.0), Pull (10.5, -38.8) (10.6, -39.6), Pull (16.6, -41.1) (23.2, -39.3), Pull (23.2, -38.5) (23.1, -37.6)]
    |> filled (rgb 84 61 39)
    |> addOutline (solid 0.3) black
    |> move (0, -14.6)
    ]
rightarm = group [
    curve (9.1, -8.4) [Pull (10.4, -7.6) (10.9, -6.5), Pull (11.9, -4.2) (13.2, -3.1), Pull (11.5, -1.7) (9.8, -0.4), Pull (13.2, 0.7) (14.4, 4.3), Pull (20.9, -3.3) (19.1, -5.8), Pull (17.1, -8.9) (10.7, -12.4), Pull (10.6, -11.4) (10.2, -11.2), Pull (10.6, -10.2) (9.6, -9.2), Pull (9.7, -8.5) (8.5, -7.5), Pull (6.5, -7.5) (4.5, -9.6), Pull (3.5, -10.7) (4.0, -11.6), Pull (6.1, -10.9) (7.6, -9.3), Pull (5.6, -10.5) (4.0, -12.8), Pull (3.7, -13.4) (5.4, -12.9), Pull (7.1, -12.4) (8.5, -11.5), Pull (6.9, -12.4) (5.3, -13.7), Pull (6.1, -14.1) (6.8, -13.7), Pull (8.0, -13.1) (9.1, -12.6), Pull (7.7, -13.2) (6.7, -14.2), Pull (8.6, -14.5) (10.7, -12.6)]
    |> filled (rgb 232 209 186)
    |> addOutline (solid 0.2) black
    ]
heads = group [
    curve (-2.0, 11.8) [Pull (2.0, 11.2) (4.5, 13.0), Pull (6.8, 14.1) (8.1, 17.8), Pull (8.8, 17.6) (9.4, 18.0), Pull (11.9, 19.5) (10.6, 22.1), Pull (8.7, 22.2) (7.6, 20.2), Pull (8.5, 22.1) (8.7, 23.7), Pull (8.0, 23.2) (7.6, 23.3), Pull (7.5, 25.4) (7.0, 27.0), Pull (-0.6, 24.7) (-3.5, 27.8), Pull (-4.2, 26.5) (-4.5, 24.8), Pull (-5.4, 20.9) (-4.5, 17.5), Pull (-3.4, 12.3) (-1.7, 11.6), Pull (-2.0, 10.7) (-2.3, 9.7), Pull (0.4, 3.9) (5.0, 10.7), Pull (4.7, 12.0) (5.0, 13.3), Pull (6.8, 14.3) (8.0, 17.9), Pull (8.6, 20.7) (10.2, 20.9), Pull (8.6, 20.7) (8.2, 18.6), Pull (9.5, 18.9) (9.1, 20.3)]
    |> filled (rgb 232 209 186)
    |> addOutline (solid 0.2) black
    ]
    
leye = group [
      
    circle 10
      |> filled 
          white
        |> scaleX 1.25
        |> scaleY 1.25
  , circle 10
      |> filled 
          (rgb 75 43 0)
        |> scaleX 1
  , circle 10
      |> filled 
          black
        |> scaleX 0.5
        |> scaleY 0.5
        |> scale 1
  , circle 10
      |> filled 
          white
        |> scale 0.25
        |> move (3,3)  ]
reye = group [
      
    circle 10
      |> filled 
          white
        |> scaleX 1.25
        |> scaleY 1.25
  , circle 10
      |> filled 
          (rgb 75 43 0)
        |> scaleX 1
  , circle 10
      |> filled 
          black
        |> scaleX 0.5
        |> scaleY 0.5
        |> scale 1
  , circle 10
      |> filled 
          white
        |> scale 0.25
        |> move (3,3)  ]

leftarm = group [
    curve (-11.4, -11.2) [Pull (-16.3, -5.5) (-15.5, -3.2), Pull (-13.5, 0.1) (-11.1, 3.1), Pull (-10.1, 1.0) (-8.1, -0.2), Pull (-8.1, -1.0) (-8.0, -1.8), Pull (-9.3, -2.9) (-10.6, -4.1), Pull (-11.1, -3.7) (-11.6, -3.3), Pull (-10.0, -4.9) (-9.0, -6.8), Pull (-9.8, -7.0) (-9.7, -8.0), Pull (-10.9, -8.6) (-10.5, -9.8), Pull (-11.4, -10.6) (-11.3, -11.6), Pull (-11.1, -13.1) (-9.9, -13.6), Pull (-9.0, -13.9) (-8.1, -13.7), Pull (-9.4, -13.0) (-10.1, -11.9), Pull (-9.3, -13.0) (-8.1, -13.6), Pull (-7.6, -13.8) (-7.1, -13.1), Pull (-8.8, -12.3) (-9.9, -10.4), Pull (-8.7, -12.3) (-7.1, -13.2), Pull (-6.7, -13.1) (-6.7, -12.2), Pull (-7.7, -10.8) (-8.7, -9.4), Pull (-7.7, -10.8) (-6.2, -12.2), Pull (-5.7, -11.7) (-5.7, -11.1), Pull (-6.2, -9.4) (-7.3, -8.0), Pull (-8.0, -6.8) (-9.0, -6.6)]
    |> filled (rgb 232 209 186)
    |> addOutline (solid 0.2) black 
    ]
smile = group [
    curve (-3.4, 17.5) [Pull (-0.7, 16.5) (4.2, 17.5), Pull (2.4, 14.1) (1.2, 14.3), Pull (-2.0, 13.7) (-3.4, 17.7), Pull (0.1, 16.5) (4.1, 17.5), Pull (3.5, 16.6) (2.9, 15.6), Pull (2.1, 15.9) (1.3, 16.1), Pull (0.1, 16.1) (-1.1, 16.1)]
    |> filled white
    |> addOutline (solid 0.3) black
    ]
nose = group [
  
    curve (0,0) [Pull (10,0) (20,-10)]
      |> outlined (solid 2) 
          black
        |> rotate (degrees 120)
        |> scale 0.14
        |> move (0.1,18.2)
       
  ]
rbrow = group [  
    curve (0,0) [Pull (10,0) (20,-10)]
      |> outlined (solid 2.3) 
          black
        |> rotate (degrees 10)
        |> scale 0.16
        |> move (2.4,25.4)
  ]  
lbrow = group [ 
  
    curve (0,0) [Pull (10,0) (20,-10)]
      |> outlined (solid 2.3) 
          black
        |> scale 0.16
        |> rotate (degrees 30)
        |> move (-3.8,25.2)
  ]
    
 
    
   
    

    