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

import SpeechBubbles exposing (narrationBubble, shantellSansFont) -- Your shapes go here!
type Actor = Robot

script = 
  [ (Robot,"The garage looks normal at first glance")
  , (Robot,"but you quickly notice that a metal sheet")
  , (Robot,"that you use for backyard work has")
  , (Robot,"disappeared.")
  ]
  
myShapes model =
  [
    
      garage model
      
    
  ]
  
garage model = group [
  background, door, 
    window
    |> move (-5,0)
    , storage , 
    paintCan
    |> scale (0.6)
    |> move (-55, 23)
    , 
    paintbrush,
    paintbrush
    |> move (13,-11)
    |> scale (1.1)
    , snowShovel
    , 
    car
    |> scale (0.8)
    |> move (40,-7)
    , 
    narrationBubble black (shantellSansFont) script 50 Robot model.time
      |> scale 1.3
      |> move (0,-40) 
 ]
  
car = group [
  roundedRect 18 10 2
  |> filled (rgb 64 64 62)
  |> move (-58, -53)
  , 
  roundedRect 18 10 2
  |> filled (rgb 64 64 62)
  |> move (11, -53)
  , 
  curve (-54.2, 1.3) [Pull (-57.0, -3.5) (-60.4, -9.0), Pull (-63.0, -13.0) (-67.4, -16.3), Pull (-76.6, -23.4) (-72.7, -33.7), Pull (-77.7, -36.7) (-74.1, -46.2), Pull (-75.1, -51.3) (-70.8, -51.0), Pull (-28.6, -51.3) (13.4, -51.5), Pull (24.7, -52.4) (28.3, -50.1), Pull (28.1, -48.3) (27.9, -46.4), Pull (32.8, -37.5) (26.7, -34.3), Pull (30.7, -22.5) (23.3, -17.9), Pull (18.7, -13.7) (13.2, -8.2), Pull (12.0, -3.3) (7.7, 1.2), Pull (-22.3, 4.3) (-54.1, 1.1)]
  |> filled (rgb 192 55 57)
  ,
  curve (5.8, -19.7) [Pull (-23.7, -19.7) (-53.4, -19.6), Pull (-63.1, -20.8) (-63.3, -26.1), Pull (-63.2, -31.5) (-58.7, -31.2), Pull (-23.3, -30.6) (10.8, -31.3), Pull (16.1, -31.7) (16.9, -28.2), Pull (19.9, -20.8) (5.6, -19.6)]
  |> filled (rgb 175 160 139)
  |> move (0,-1)
  ,
  roundedRect 22 5 2
  |> filled (rgb 175 160 139)
  |> move (8, -38)
  ,
  roundedRect 22 5 2
  |> filled (rgb 175 160 139)
  |> move (-55, -38)
  ,
  roundedRect 24 9 2
  |> filled (rgb 64 64 62)
  |> move (-24, -43)
  ,
  roundedRect 20 6 2
  |> filled white 
  |> move (-24, -43)
  ,
  roundedRect 75 4 2
  |> filled (rgb 64 64 62) 
  |> move (-23, -17)
  ,
  curve (-50.5, -1.2) [Pull (-23.2, -0.6) (4.4, -1.3), Pull (7.3, -5.9) (10.2, -10.4), Pull (4.2, -11.9) (-22.8, -11.4), Pull (-50.9, -11.6) (-55.9, -10.4), Pull (-53.4, -5.9) (-50.8, -1.3)]
  |> filled white
  |> move (0,-1)
  ,
  curve (16.3, -11.1) [Pull (23.2, -9.7) (21.1, -16.0)]
  |> filled white
  |> addOutline (solid 1) (rgb 192 55 57)
  |> move (-0.5,0)
  ,
  curve (16.3, -11.1) [Pull (23.2, -9.7) (21.1, -16.0)]
  |> filled white
  |> scaleX -1
  |> addOutline (solid 1) (rgb 192 55 57)
  |> move (-44.5,1)
  ,
  curve (27.0, -26.0) [Pull (26.0, -20.5) (20.4, -17.2), Pull (24.6, -21.5) (24.8, -26.9), Pull (26.0, -27.0) (27.2, -25.8)]
  |> filled white 
  |> move (-0.5,0)

  
  
  
  
  ]

snowShovel = group [
  rect 12 11
  |> filled (rgb 122 157 173)
  |> move (17,20)
  ,
  roundedRect 12 5 2
  |> filled (rgb 122 157 173)
  |> move (17,14)
  ,
  rect 2.25 45
  |> filled (rgb 64 64 62)
  |> move (17,-7)
  ]
  
paintbrush = group [
   curve (-51.4, 50.2) [Pull (-51.4, 47.3) (-51.5, 44.4), Pull (-54.2, 44.4) (-55.6, 45.0), Pull (-55.6, 47.6) (-55.5, 50.2), Pull (-53.3, 50.2) (-51.0, 50.2)]
  |> filled (rgb 192 55 57)
  |> move (7.5,3)
   ,
  curve (-44.6, 39.5) [Pull (-49.9, 39.7) (-52.0, 39.3), Pull (-57.9, 37.6) (-58.2, 40.0), Pull (-57.8, 42.7) (-53.0, 41.5), Pull (-49.5, 40.5) (-44.5, 41.1), Pull (-44.5, 40.3) (-44.5, 39.4)]
  |> filled (rgb 64 64 62)
  |> move (-3,10)
  , 
  curve (-51.8, 44.4) [Pull (-51.7, 47.3) (-51.7, 50.2), Pull (-49.0, 50.3) (-46.3, 50.4), Pull (-46.5, 47.4) (-46.7, 44.4), Pull (-49.3, 44.4) (-51.9, 44.3)]  
  |> filled (rgb 175 160 139)
  |> move (7.5,3)
  
  ]
  
paintCan = group [
  curve (-47.0, 51.7) [Pull (-33.1, 44.4) (-19.2, 51.8), Pull (-33.0, 57.8) (-46.8, 51.7)]
  |> filled (rgb 175 160 139)
  |> move (0,-0.85)
  , 
  curve (-19.8, 50.7) [Pull (-32.3, 45.8) (-47.3, 50.8), Pull (-47.2, 38.1) (-47.1, 25.4), Pull (-43.2, 21.2) (-33.0, 21.4), Pull (-22.0, 21.6) (-18.7, 26.3), Pull (-18.9, 38.6) (-19.1, 51.0)]
  |> filled (rgb 192 55 57)
  , 
  curve (-47.0, 50.2) [Pull (-32.8, 28.5) (-19.2, 50.4)]
  |> outlined (solid 1) (rgb 64 64 62)
  
  ]
  
storage = group [
  rect 60 6
  |> filled (rgb 64 64 62)
  |> move (54, 45)
  , 
  rect 55 40
  |> filled (rgb 64 64 62)
  |> move (54, 23)
  ,
  rect 45 3
  |> filled (rgb 64 64 62)
  |> move (54, 2)
  , 
  rect 22.75 9
  |> filled (rgb 131 102 88)
  |> move (42.5, 37)
  , 
  rect 22.75 9
  |> filled (rgb 131 102 88)
  |> move (65.5, 37)
  ,
  rect 22.75 26
  |> filled (rgb 181 158 142)
  |> move (42.5, 19.25)
  ,
  rect 22.75 26
  |> filled (rgb 181 158 142)
  |> move (65.5, 19.25)
  ,
  roundedRect 13 1.75 1
  |> filled (rgb 64 64 62)
  |> move (42.5, 39.5)
  ,
  roundedRect 13 1.75 1
  |> filled (rgb 64 64 62)
  |> move (65.5, 39.5)
  ,
  roundedRect 2 8 0.75
  |> filled (rgb 64 64 62)
  |> move (52, 26)
  , 
  roundedRect 2 8 0.75
  |> filled (rgb 64 64 62)
  |> move (56, 26)
  
  ]
  
window = group [
  rect 32 25
  |> filled white
  |> addOutline (solid 2.5) (rgb 64 64 62)
  |> move (-10, 14)
  ,
  rect 2 26
  |> filled (rgb 64 64 62)
  |> move (-10, 14)
  ,
  rect 30 2
  |> filled (rgb 64 64 62)
  |> move (-10, 14)
   
  ]
  
door = group [
   rect 50 74
  |> filled (rgb 64 64 62)
  |> move (-65, -7.5)  
  , 
  rect 43 70
  |> filled (rgb 75 111 124)
  |> move (-65, -9.5)
  , 
  rect 13 23
  |> filled (rgb 122 157 173)
  |> move (-74, 7)
  ,  
  rect 13 23
  |> filled (rgb 122 157 173)
  |> move (-55, 7) 
  , 
  rect 13 30
  |> filled (rgb 122 157 173)
  |> move (-74, -25)
  ,
  rect 13 30
  |> filled (rgb 122 157 173)
  |> move (-55, -25)
  ,
  circle 3
  |> filled (rgb 64 64 62)
  |> move (-50, -8)
  ]
  
background = group [
  List.range 0 11
  |> List.map
    ( \ idx ->
         [  
          rect 15 125
             |> filled (rgb 234 234 234)
             |> move (-90,0)
         ,
         rect 3 125
           |> filled (rgb 234 234 234)
           |> addOutline (solid 0.3) white
           |> move (-83.5,0)
         
         ]
         |> group
         |> move (15.75*toFloat idx,0)
         
   )
   |> group 
   
   ]
   
  


  

