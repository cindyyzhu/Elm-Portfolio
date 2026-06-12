module Bookstore exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import TalkingBook
import SpeechBubbles exposing (speechBubbleLeft, shantellSansFont) -- Your shapes go here!
type Actor = Robot

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


script = 
  [ (Robot,"Good morning there! How can I help you?")
  ,(Robot,"Last minute New Year’s shopping for a loved one")
  ,(Robot,"maybe?")
  ,(Robot,"Addy’s up to something?")
  ,(Robot,"A new year’s resolution?")
  ,(Robot,"At the library looking at ocean exploration?")
  ,(Robot,"She was here a few minutes ago, and")
  ,(Robot,"I have a receipt of what she bought too!")
  ,(Robot,"Here it is:")
  ,(Robot,"“How to Preserve Vegetables for Long Journeys”...")
  ,(Robot,"well well well what is Addy up to this time.")
  ] 
  
myShapes model =
  [
    bookstore model
  ]

bookstore model = group [
  rect 500 500
  |> filled (rgb 184 247 255)
  
 , stack (clrs1 ++ clrs2) 0  25
      |> move (-30,0)
  ,
    stack (clrs2 ++ clrs7) 20 28
      |> move (-17,0)
  ,
    stack (clrs4 ++ clrs5) 30 26
      |> move (-6,0)
  ,
    stack (clrs7 ++ clrs6) 40 22
      |> move (5,0)
  ,
    stack (clrs5 ++ clrs1) 50 24
      |> move (18,0)
  ,
    stack (clrs8 ++ clrs7) 50 20
      |> move (29,0)
  , plank
  , TalkingBook.book
  |> scale 0.5
  |> move (-60, 0)
   ,  speechBubbleLeft (solid 0.5) black (shantellSansFont) script 50 Robot (0.9*model.time)
      |> scale 0.7
      |> move (3,28) 
 ]

clrs1 = [ (250, 128, 114)
    , (255, 99, 71)
    , (135, 206, 235)
    , (0, 255, 255)
    , (0, 128, 128)
    , (128, 128, 0)
    , (211, 211, 211)
    , (64, 64, 64)
    , (255, 20, 147)
    , (0, 0, 128)
    , (230, 230, 250)
    , (128, 0, 128)
    , (50, 205, 50) ]

clrs2 = clrs1
  |> List.map (\ (r,g,b) -> (g,b,r) )
    
clrs3 = [(255, 127, 80)
        , (220, 20, 60)
        , (255, 140, 0)
        , (0, 255, 127)
        , (46, 139, 87)
        , (0, 206, 209)
        , (70, 130, 180)
        , (30, 144, 255)
        , (123, 104, 238)
        , (221, 160, 221)
        , (160, 82, 45)
        , (244, 164, 96)
        , (210, 105, 30)]

clrs4 = clrs3
  |> List.map (\ (r,g,b) -> (b,g,r) )

clrs5 = clrs3
  |> List.map (\ (r,g,b) -> (100+0.5*g,b,r) )

clrs6 = clrs3
  |> List.map (\ (r,g,b) -> (g,r,b) )

clrs7 = clrs3
  |> List.map (\ (r,g,b) -> (0.5*(r+g),g,b) )

clrs8 = clrs1
  |> List.map (\ (r,g,b) -> (100+0.5*g,b,r) )

clrs9 = clrs1
  |> List.map (\ (r,g,b) -> (g,r,b) )

clrs10 = clrs1
  |> List.map (\ (r,g,b) -> (0.5*(r+g),g,b) )


stack clrs offset toTake =
  clrs
      |> List.indexedMap 
         ( \ idx (r,g,b) ->
               rect (7 + 1.5 * sin (99*toFloat idx + offset)) 1.5 
                 |> filled (rgb (50+0.5*r) (50+0.5*g) (50+0.5*b))
                 |> move (
                          12.5 + 0.75 * sin (89*toFloat idx + offset)
                         , -20 + 1.5 * toFloat idx
                         )
         )
      |> List.take toTake
      |> group

plank =
  [ curve (-32.9, 12.5) [Pull (-63.8, 12.6) (-94.7, 12.8), Pull (-94.7, 6.4) (-94.7, 0.0), Pull (-63.7, 0.0) (-32.7, 0.0), Pull (-32.7, 6.3) (-32.7, 12.5)]
      |> filled black
  , curve (-77.2, 0.0) [Pull (-81.0, 0.0) (-84.8, 6.6), Pull (-84.8, -15.5) (-84.8, -31.1), Pull (-80.8, -31.1) (-76.7, -31.1), Pull (-76.9, -15.5) (-77.0, -0.0)]
      |> filled black
  , curve (-55.1, 0.2) [Pull (-55.2, -15.5) (-55.3, -31.4), Pull (-51.3, -31.4) (-47.3, -31.4), Pull (-47.3, -15.5) (-47.3, 0.2)]
      |> filled black
  ] 
    |> group
    |> scaleY 0.4
    |> scaleX 1.5
    |> move (105,-26)
    
 