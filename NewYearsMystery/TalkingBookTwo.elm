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
  
myShapes model =
  [ book
  ]
  
book =
  [
    front
    ,back
  , spine
      ,lips
      ,pages
      ,pages2
      , eyes
      ,eyes2
      
  ]
     |> group
     
spine = 
  curve (0.2, 10.3) [Pull (4.7, 5.6) (13.4, 9.0), Pull (16.0, -18.3) (18.6, -45.6), Pull (11.1, -51.9) (2.9, -45.6), Pull (1.5, -17.9) (0.0, 9.7)]
    |> filled (rgb 0 49 133)
  

front = 
  curve (49.3, 19.9) [Pull (50.6, -5.1) (51.9, -30.1), Pull (33.6, -38.6) (15.3, -47.1), Pull (13.5, -19.6) (11.6, 7.9), Pull (30.6, 13.9) (49.5, 19.9)]
    |> filled (rgb 0 60 163)
back =
   curve (-30.8, 21.3) [Pull (-10.5, 13.1) (1, 9), Pull (2.5, -12.8) (3, -46.6), Pull (-13.4, -37.0) (-28.1, -28.4)]
    |> filled (rgb 0 60 163)
    
lips = 
     curve (6.2, -13.0) [Pull (9.3, -20.6) (11.8, -12.2), Pull (8.9, -15.3) (6.2, -12.8)]
      |> outlined (solid 1) black
pages =
      curve (-27.3, 21.6) [Pull (-29.5, 21.4) (-25.5, 25.7), Pull (7.0, 26.2) (9.2, 14.2), Pull (15.9, -0.4) (-27.5, 21.1)]
      |> filled (rgb 0 109 163)
pages2 =     
      curve (9.2, 9.2) [Pull (6.9, 25.3) (44.5, 25.1), Pull (46.9, 22.6) (49.3, 20.1), Pull (29.4, 14.1) (9.5, 8.2)]
      |> filled (rgb 0 109 163)
      
eyes = group [
    circle 10
      |> filled 
          black
        |> scale 0.25
        |> move (4,-8)
        
     ,
     
     circle 4
     |> filled white
     |> scale 0.25
     |> move(5,-8)
  ]
      
      
eyes2 = group [
    circle 10
      |> filled 
          black
        |> scale 0.25
        |> move (12,-7.5)
     , 
     circle 4
     |> filled white
     |> scale 0.25
     |> move(13,-7.5)
  ]
          
    