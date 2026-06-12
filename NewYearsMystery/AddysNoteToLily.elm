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
    note
  ]
note = group [
  page, writing
 ]

writing = group [
  text "Lily!"
  |> filled black 
  |> scale (0.35)
  |> move (-27, 20.5)
  
  ,
  
  text "I am planning something"
  |> filled black 
  |> scale (0.35)
  |> move (-27, 10.5)
  
  ,
  
  text "huge for my new year’s resolution."
  |> filled black 
  |> scale (0.35)
  |> move (-27, 0.5)
  
  , 
  
  text "I need to get a lot of materials for it."
  |> filled black 
  |> scale (0.35)
  |> move (-27, -9.5)
  
  ,  
  
   text "I hope I can do it on time. Come by"
  |> filled black 
  |> scale (0.35)
  |> move (-27, -19.5)
  
  , 
  text "house on New Year’s day to look at it!"
  |> filled black 
  |> scale (0.35)
  |> move (-27, -29.5)
  
  ]


page = group [

  curve (38.0, 43.2) [Pull (38.1, -0.4) (38.1, -44.1), Pull (2.2, -44.1) (-33.5, -44.1), Pull (-33.5, -0.3) (-33.5, 43.5), Pull (-30.3, 43.5) (-27.1, 43.4), Pull (-27.1, 41.8) (-27.1, 40.2), Pull (-30.3, 34.2) (-24.9, 34.2), Pull (-19.6, 34.0) (-22.2, 40.1), Pull (-22.8, 41.6) (-23.3, 43.1), Pull (-18.0, 43.2) (-12.7, 43.3), Pull (-12.7, 41.7) (-12.8, 40.1), Pull (-16.9, 33.9) (-10.9, 34.1), Pull (-4.3, 34.3) (-9.3, 40.2), Pull (-9.3, 41.8) (-9.3, 43.3), Pull (-4.3, 43.2) (0.6, 43.2), Pull (0.7, 41.6) (0.9, 40.0), Pull (-4.4, 33.5) (3.0, 33.7), Pull (8.5, 33.9) (5.1, 39.8), Pull (5.0, 41.6) (4.9, 43.3), Pull (9.3, 43.3) (13.7, 43.3), Pull (13.8, 41.5) (13.9, 39.7), Pull (8.5, 33.9) (15.7, 33.4), Pull (23.0, 34.2) (17.5, 40.4), Pull (17.8, 41.7) (18.2, 43.1), Pull (23.2, 43.2) (28.3, 43.3), Pull (28.4, 41.5) (28.5, 39.8), Pull (23.9, 34.8) (30.3, 33.8), Pull (36.6, 34.2) (31.5, 39.8), Pull (31.9, 41.5) (32.4, 43.1), Pull (35.3, 43.1) (38.1, 43.0)]
  |> filled (rgb 253 253 150)
  |> addOutline (solid 0.5) black
  
   ,
    
  rect 55 0.5
  |> filled black
  |> move (2, 20)
  
  ,
  rect 55 0.5
  |> filled black
  |> move (2, 10) 
  ,
  
  rect 55 0.5
  |> filled black
  |> move (2, 0)
  
  , 
  
  rect 55 0.5
  |> filled black
  |> move (2, -10)
  
  , 
  
  rect 55 0.5
  |> filled black
  |> move (2, -20)
  
  , 
  
  rect 55 0.5
  |> filled black
  |> move (2, -30)
  
  
    ]
  
