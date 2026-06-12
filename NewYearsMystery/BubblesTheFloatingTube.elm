-- Your shapes go here!
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
  [
      floatee
      |> move (0, 15)  
   ]

floatee = group [
    curve (-7.6, -30.1) [Pull (-58.3, -31.6) (-55.2, -7.8), Pull (-51.2, 9.6) (-6.3, 8.2), Pull (39.6, 10.3) (40.3, -9.6), Pull (40.9, -32.1) (-7.6, -30.2)]      
      |> filled orange
      , 
      
      curve (-41.0, -1.2) [Pull (-7.2, 6.7) (26.5, -1.3), Pull (-5.8, -9.8) (-40.9, -1.2)]      
      |> filled white 
      
      , eyes , mouth , arms , legs
  ]
  
eyes = group [     
      circle 7
      |> filled white
      |> move (-25,-15)
      , 
      circle 7
      |> filled white
      |> move (10,-15)
      , 
      circle 5
      |> filled black
      |> move (-25,-15)
      , 
      circle 5
      |> filled black
      |> move (10,-15)
      ,
      circle 1.5 
      |> filled white
      |> move(-22,-13)
      ,
      circle 1.5 
      |> filled white
      |> move(13,-13)
     ]
     
mouth = group [
    wedge 7 0.5   
      |> filled black
      |> rotate (degrees -90)
      |> move (-7.5,-19)
  ]
  
arms = group [
    curve (-11.6, 8.1) [Pull (-16.9, 11.7) (-22.2, 9.1), Pull (-18.6, 12.6) (-19.6, 16.1), Pull (-20.3, 19.7) (-18.7, 23.0), Pull (-13.1, 25.7) (-16.3, 30.2), Pull (-20.6, 33.1) (-23.0, 27.7), Pull (-23.9, 25.2) (-23.0, 23.9), Pull (-27.8, 19.3) (-29.7, 12.4), Pull (-30.4, 8.7) (-30.0, 6.1), Pull (-30.4, 3.7) (-29.3, 2.8), Pull (-21.5, -3.8) (-10.3, -3.4), Pull (-11.0, 2.2) (-11.8, 8.0)]    
    |> filled orange
    |> scale 1.2
    |> move (-35,-10)
    
    , 
    curve (-11.6, 8.1) [Pull (-16.9, 11.7) (-22.2, 9.1), Pull (-18.6, 12.6) (-19.6, 16.1), Pull (-20.3, 19.7) (-18.7, 23.0), Pull (-13.1, 25.7) (-16.3, 30.2), Pull (-20.6, 33.1) (-23.0, 27.7), Pull (-23.9, 25.2) (-23.0, 23.9), Pull (-27.8, 19.3) (-29.7, 12.4), Pull (-30.4, 8.7) (-30.0, 6.1), Pull (-30.4, 3.7) (-29.3, 2.8), Pull (-21.5, -3.8) (-10.3, -3.4), Pull (-11.0, 2.2) (-11.8, 8.0)]    
    |> filled orange
    |> scale 1.2
    |> scaleX -1
    |> move (22,-11)
    ]
    
legs = group [
    curve (-2.7, -15.3) [Pull (-5.7, -20.8) (-5.0, -27.6), Pull (-8.1, -35.2) (-8.6, -39.0), Pull (-11.2, -40.0) (-13.2, -42.0), Pull (-14.9, -46.6) (-7.8, -43.2), Pull (-4.9, -41.8) (-5.5, -39.9), Pull (-4.9, -37.1) (-1.9, -36.1), Pull (1.1, -34.3) (-0.4, -28.5), Pull (3.5, -25.4) (4.3, -18.9), Pull (0.6, -17.2) (-3.0, -15.6)]
    |> filled orange
    |> scale 1.5
    |> move (-25,0)
    , 
    curve (-2.7, -15.3) [Pull (-5.7, -20.8) (-5.0, -27.6), Pull (-8.1, -35.2) (-8.6, -39.0), Pull (-11.2, -40.0) (-13.2, -42.0), Pull (-14.9, -46.6) (-7.8, -43.2), Pull (-4.9, -41.8) (-5.5, -39.9), Pull (-4.9, -37.1) (-1.9, -36.1), Pull (1.1, -34.3) (-0.4, -28.5), Pull (3.5, -25.4) (4.3, -18.9), Pull (0.6, -17.2) (-3.0, -15.6)]
    |> filled orange
    |> scale 1.5
    |> scaleX -1
    |> move (10,0)
    
    ]