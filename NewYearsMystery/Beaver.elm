module Beaver exposing (..)

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
  beaver
  ]

beaver = group [
  mainBody
  ,
  tail,
  torso,
  feet,
  head
  , toes
  |> move (-36, -37)
  , toes
    |> mirrorX
  |> move (4, -37)
  , ears
    |> move (-35, 35)
  , ears
   |> mirrorX
  |> rotate (degrees 4) 
    |> move (0, 35) 

 
  , beaverEye
      |> move (-23, 26)
  , beaverEye
    |> mirrorX
     |> move (-11, 24)
   , beaverPupil
   |> move (-8, 23)
   , beaverPupil
   |> mirrorX
   |> move (-22, 24)
   , beavernose
   |> move (-17, 12)
  , beaverTooth
   |> rotate (degrees 35)
  |> move (-16, 2)
   , beaverhands
   |> move (-8, -8)
  , beaverhands
   |> mirrorX
   |> move (-28, -8)
   , beaverfingers
   |> move (-31, -11.5)
   , beaverfingers
  |> mirrorX
  |> move (-5, -11.5)
 ]
  
mainBody = group [
 curve (-8.1, 36.8) [Pull (5.2, 29.5) (1.6, 13.0), Pull (20.4, -0.9) (9.8, -27.3), Pull (13.7, -34.9) (12.6, -44.1), Pull (-12.9, -44.8) (-31.0, -44.3), Pull (-51.4, -47.4) (-40.3, -29.0), Pull (-51.9, -11.7) (-43.9, 1.4), Pull (-71.7, 26.0) (-52.6, 42.5), Pull (-30.1, 50.7) (-22.4, 38.0), Pull (-16.5, 37.5) (-10.7, 37.1)]
 |> filled darkBrown
 ]
 
feet =  
 curve (-15.4, -43.1) [Pull (-17.1, -26.3) (-3.1, -24.7), Pull (12.1, -24.5) (12.3, -44.0), Pull (0.1, -44.8) (-43.4, -44.1), Pull (-45.7, -27.0) (-28.8, -23.7), Pull (-24.0, -25.1) (-21.6, -25.8), Pull (-19.4, -27.5) (-17.3, -29.1), Pull (-14.8, -35.0) (-15.3, -43.2)]
 |> filled (rgb 77 38 0)
 |> addOutline (solid 2) black
  
torso = group [
 curve (8.4, -30.9) [Pull (-13.8, -44.0) (-40.8, -30.4), Pull (-55.6, -8.0) (-34.0, 10.6), Pull (-14.8, -11.2) (1.9, 12.8), Pull (22.4, -5.6) (9.4, -30.3)]
 |> filled (rgb 107 68 35)
 |> addOutline (solid 2) black
 ]
 
tail = curve (-22.3, 36.4) [Pull (-13.9, 4.9) (-31.4, -2.1), Pull (-53.0, -3.4) (-61.1, 31.0), Pull (-52.2, 45.5) (-42.9, 44.6), Pull (-27.6, 45.6) (-22.5, 37.3)]
 |> filled darkBrown
 |> addOutline (solid 2) black

beaverEye =
    circle 6
      |> filled white
      |> addOutline (solid 2) black
          
beaverPupil =
 circle 1.5
      |> filled black
beavernose = 
    triangle 5
      |> filled black
      |> addOutline (solid 0) (rgb 107 68 35)
      |> rotate (30)
beaverTooth =
    triangle 5
      |> filled white
      |> addOutline (solid 0.5) black
head = group [
 curve (-15.4, 36.7) [Pull (-2.4, 36.2) (2.4, 20.7), Pull (1.7, 4.0) (-16.3, 0.2), Pull (-33.1, 3.7) (-35.0, 18.4), Pull (-32.9, 36.3) (-15.3, 37.6)]
 |> filled (rgb 107 68 35)
 |> scale 1.2
 |> move (2, -1)
 |> addOutline (solid 2) black
 ]
beaverhands =
    circle 7
      |> filled (rgb 77 38 0)
      |> addOutline (solid 2) black
 
beaverfingers = group [
   circle 2
      |> filled (rgb 26 4 0)
      |> addOutline (solid 0.5) black
      , circle 2
      |> filled (rgb 26 4 0)
      |> addOutline (solid 0.5) black
      |> move (3, 0)
      , circle 2
      |> filled (rgb 26 4 0)
      |> addOutline (solid 0.5) black
      |> move (6, 0)
      ]
ears = group [
    wedge 7 0.5
      |> filled (rgb 77 38 0)
      |> addOutline (solid 1) (rgb 26 4 0)
      |> rotate (degrees 145)
      
        ]

  
toes = group [
    oval 9 13
      |> filled 
          (rgb 26 4 0)
          , oval 9 13
      |> filled 
          (rgb 26 4 0)
          |> move (6, 0)
          ,oval 9 13
      |> filled 
          (rgb 26 4 0)
           |> move (12, 0) ]
           |> addOutline (solid 2) black
