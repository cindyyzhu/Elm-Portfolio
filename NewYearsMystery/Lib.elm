module Lib exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import TalkingBookTwo

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
  [ (Robot,"Hey! How are you today? A bit tired I assume,") 
  , (Robot, "New Year’s am I right? Oh, have I seen Addy?")
  , (Robot, "I did, she was here a while ago browsing")
  , (Robot, "for a book in this corner. Oh? You think it might")
  , (Robot, "have been a dangerous book, let’s have a look.")
  , (Robot, "This book that has been loaned out recently is…")
  , (Robot, "Exploring the Deep Sea… oh you are right, this")
  , (Robot, "does look dangerous, maybe it was just for a")
  , (Robot, "casual read. Addy did seem pretty serious about")
  , (Robot, "it and she ran out of the place with it too.")
  , (Robot, "I hope she is being safe…")
  ] 
  
myShapes model =
  [

  library model
 ]

library model = group 
 [
   rect 200 200
  |>filled (hsl (degrees 185) 0.515 0.794)
  ,
  lib 
  |>scaleX 1.3
  |>move(23,0)
  ,
    clock model.time
  |>scale 0.2
  |>move(0,35)
  , TalkingBookTwo.book
  |> scale 0.4
  |> move (-5, 0)
   ,  speechBubbleLeft (solid 0.5) black (shantellSansFont) script 50 Robot (0.9*model.time)
      |> scale 0.8
      |> move (40, 20) 
  
 ]
 
lib = group
 [
   layout
  ,
  allbooks

 ]
 
clock t = group

  [ circle 50 |> filled white
      |> addOutline (solid 1) black
  , List.range 1 12
      |> List.map
          ( \ h -> String.fromInt h
                    |> text
                    |> centered
                    |> filled black
                    |> move (0,40)
                    |> rotate ( -pi * 2 / 12 * toFloat h )
          )
      |> group
  , polygon [(2,-1),(-2,-1),(0,38)]
      |> outlined (solid 1) black 
      |> rotate (-0.6*t)

  , polygon [(2,-1),(-2,-1),(0,25)]
      |> outlined (solid 1) black 
      |> rotate (-0.01*t)

  ]
 
allbooks = group
  [ leftBooks
  , leftBooks |> scaleX -1 
     |> move (-36,0)
  ]

leftBooks =
  [ 
   -- shelf (0,3)
    clrs1
      |> row
  ,
   -- shelf (0,2)
    clrs2
      |> row
      |> scaleY 1.2
      |> move (0,-20)
  ,
   -- shelf (0,1)
    clrs3
      |> row
      |> move (0,-29)
  ,
   -- shelf (0,0)
    clrs4 |> List.take 10
      |> row
      |> scale 1.2
      |> move (17.5,-44)
  ,
   -- shelf (1,3)
    clrs5
      |> row
      |> scaleX 1.25
      |> move (43,0)
  ,
   -- shelf (1,2)
    clrs6
      |> row
      |> scale 1.25
      |> move (43,-20)
  ,
   -- shelf (1,1)
    clrs7
      |> row
      |> scaleX 1.1
      |> move (30,-29)
  ,
   -- shelf (1,0)
    (clrs8 ++ clrs7) |> List.take 14
      |> row
      |> scale 1.2
      |> move (38.5,-44)
  ]
    |> group


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


row clrs =
  clrs
      |> List.indexedMap 
         ( \ idx (r,g,b) ->
               rect 1.5 (7 + 1.5 * sin (99*toFloat idx))
                 |> filled (rgb r g b)
                 |> move (-86 + 1.5 * toFloat idx
                         ,12.5 + 0.75 * sin (99*toFloat idx))
         )
      |> group


      
layout = group
 [
  rect2
 |>move(119,0)
 ,
 curve (-68.5, 51.2) [Pull (-87.2, 48.7) (-87.5, 32.1), Pull (-87.5, -12.8) (-87.6, -57.9), Pull (-20.7, -57.7) (51.1, -57.4), Pull (51.1, -11.2) (51.0, 34.9), Pull (51.3, 50.3) (32.5, 50.0)]
 |>outlined (solid 2) black
 ,
 curve (-89.4, -34.1) [Pull (-65.3, -35.1) (-4.3, -34.3), Pull (22.5, -34.3) (53.4, -34.2)]
 |>outlined (solid 2) (hsl (degrees 27) 0.907 0.182)
 ,
 curve (-86.4, -36.3) [Pull (-17.9, -36.1) (50.3, -35.9)]
 |>outlined (solid 2) (hsl (degrees 27) 0.521 0.442)
 ,
 curve (-68.6, -37.9) [Pull (-68.7, -47.0) (-68.5, -57.9)]
 |>outlined (solid 2) (hsl (degrees 27) 0.521 0.442)
 |>move (0,1)
 ,
 curve (-37.9, -37.6) [Pull (-38.2, -47.0) (-38.0, -57.9)]
  |>outlined (solid 2) (hsl (degrees 27) 0.521 0.442)
  |>move (0,1)
  ,
  curve (3.5, -38.4) [Pull (3.1, -48.8) (3.4, -57.7)]
   |>outlined (solid 2) (hsl (degrees 27) 0.521 0.442)
   |>move (0,2)
   ,
   curve (32.5, -37.4) [Pull (32.1, -46.8) (32.4, -57.7)]
    |>outlined (solid 2) (hsl (degrees 27) 0.521 0.442)
    |>move (0,1)
    ,
 curve (-86.4, -36.3) [Pull (-17.9, -36.1) (50.3, -35.9)]
 |>outlined (solid 2) (hsl (degrees 27) 0.521 0.442)
 |>move (0,-20)
 ,
 insideRect
 ,
 insideRect
 |>move(72,0)
 ,
 rect2
 ,
 rect3
 |>move(70,0)
 ,
 rect3
 |>move(48,0)
 ,
 rect 3 18.4
 |>filled (hsl (degrees 27) 0.907 0.182)
 |>move(-18,-46)
 ,
 curve (-39.3, 8.0) [Pull (-60.1, 8.1) (-86.8, 8.1), Pull (-86.7, -0.9) (-86.5, -10.0), Pull (-62.8, -9.8) (-39.2, -9.7), Pull (-39.3, -15.3) (-39.3, -20.9), Pull (-62.7, -20.9) (-86.0, -20.9), Pull (-76.4, -21.0) (-66.7, -21.0), Pull (-66.7, -27.0) (-66.6, -33.0), Pull (-76.6, -32.9) (-86.6, -32.8), Pull (-86.8, -4.3) (-87.0, 24.1), Pull (-63.6, 23.9) (-39.7, 24.1), Pull (-39.1, -15.2) (-39.3, -32.8), Pull (-54.1, -32.9) (-66.5, -33.0), Pull (-66.4, -4.4) (-66.4, 24.0)]
 |>outlined (solid 2)  (hsl (degrees 27) 0.907 0.182)
 ,
  curve (-39.3, 8.0) [Pull (-60.1, 8.1) (-86.8, 8.1), Pull (-86.7, -0.9) (-86.5, -10.0), Pull (-62.8, -9.8) (-39.2, -9.7), Pull (-39.3, -15.3) (-39.3, -20.9), Pull (-62.7, -20.9) (-86.0, -20.9), Pull (-76.4, -21.0) (-66.7, -21.0), Pull (-66.7, -27.0) (-66.6, -33.0), Pull (-76.6, -32.9) (-86.6, -32.8), Pull (-86.8, -4.3) (-87.0, 24.1), Pull (-63.6, 23.9) (-39.7, 24.1), Pull (-39.1, -15.2) (-39.3, -32.8), Pull (-54.1, -32.9) (-66.5, -33.0), Pull (-66.4, -4.4) (-66.4, 24.0)]
 |>outlined (solid 2)  (hsl (degrees 27) 0.907 0.182)
 |>move(36,0)
 |>mirrorX
 ,
 curve (-37.5, -31.4) [Pull (-38.0, 7.8) (-38.5, 26.1), Pull (-39.6, 47.6) (-20.5, 50.5), Pull (-1.7, 52.1) (2.6, 26.9), Pull (2.5, -3.4) (2.3, -33.5)]
 |>outlined (solid 2) black
 ,
 curve (-37.5, -26.8) [Pull (-37.7, -28.2) (-37.3, -33.3)]
 |>outlined (solid 2) black
 ,
 computer
 ,
 curve (-32.1, 37.7) [Pull (-33.8, 18.2) (-13.8, 20.9), Pull (-2.1, 24.6) (-4.0, 37.1)]
 |>outlined (solid 0.5) black
 ]
computer = group 
 [
 curve (-16.5, -31.2) [Pull (-16.7, -28.3) (-16.9, -25.4), Pull (-19.2, -25.3) (-21.4, -25.1), Pull (-21.8, -28.0) (-22.1, -30.9), Pull (-31.6, -32.3) (-32.3, -28.5), Pull (-33.0, -18.5) (-28.7, -19.2), Pull (-23.3, -19.2) (-11.2, -19.4), Pull (-6.5, -18.7) (-7.9, -29.1), Pull (-9.0, -31.9) (-16.5, -31.0), Pull (-16.7, -31.1) (-17.0, -31.2)]
 |>filled (hsl (degrees 185) 0.469 0.915)
 |>addOutline (solid 1) black
 ,
 curve (-21.3, -25.6) [Pull (-21.8, -29.3) (-22.4, -33.1), Pull (-19.4, -33.0) (-16.5, -32.9), Pull (-16.3, -25.7) (-16.9, -25.9), Pull (-19.2, -25.8) (-21.7, -25.4)]
 |>filled (hsl (degrees 185) 0.002 0.574)
 |>addOutline (solid 1) black
 ,
 curve (-11.5, -22.8) [Pull (-19.2, -23.4) (-27.3, -22.5)]
 |>outlined (solid 0.5) black
 ,
 curve (-32.9, 0.5) [Pull (-17.5, 0.4) (-2.1, 0.3)]
 |>outlined (dashed 1) black
 ,
 light
 ,
 light
 |>mirrorX
 |>move (-35,0)
 
 
 ]
light = group
 [
 circle 2
 |>filled yellow
 |>addOutline (solid 0.5) black
 |>move(-75,30)
 ,
 curve (-75.0, 33.5) [Pull (-70.5, 33.1) (-69.6, 30.7), Pull (-75.0, 30.8) (-80.4, 31.0), Pull (-78.9, 33.0) (-75.0, 33.6), Pull (-74.8, 44.1) (-74.5, 54.6), Pull (-76.6, 54.6) (-78.7, 54.6), Pull (-63.5, 54.5) (-48.3, 54.4)]
 |>outlined (solid 0.5) black
 ,
 curve (-55.8, 54.1) [Pull (-55.7, 51.9) (-55.7, 49.8), Pull (-60.2, 49.9) (-61.1, 45.2), Pull (-51.3, 45.1) (-40.4, 45.0), Pull (-40.6, 51.8) (-47.1, 51.4), Pull (-50.8, 50.0) (-51.2, 44.9), Pull (-50.9, 49.2) (-56.0, 49.9)]
 |>filled (hsl (degrees 185) 0.002 0.574)
 |>addOutline (solid 1) black
 ,
 curve (-46.3, 56.8) [Pull (-46.3, 54.0) (-46.3, 51.3)]
 |>outlined (solid 0.5) black
 ,
 curve (-62.9, 25.1) [Pull (-58.3, 25.0) (-53.8, 24.9), Pull (-53.8, 25.8) (-53.8, 26.6), Pull (-58.1, 26.5) (-62.9, 26.3), Pull (-62.9, 25.6) (-62.9, 24.8)]
 |>filled gray
 |>addOutline (solid 0.5) black
 ,
 curve (-58.2, 26.5) [Pull (-57.5, 30.9) (-54.6, 30.2), Pull (-54.5, 26.7) (-58.1, 27.6), Pull (-58.9, 30.2) (-61.6, 31.0), Pull (-61.3, 27.6) (-58.0, 27.5), Pull (-58.1, 29.2) (-58.2, 30.9), Pull (-60.6, 35.4) (-63.6, 34.0), Pull (-62.0, 31.7) (-59.4, 32.4), Pull (-58.8, 31.6) (-58.1, 30.8), Pull (-57.1, 31.6) (-56.1, 32.4), Pull (-54.4, 32.2) (-53.1, 33.4), Pull (-53.8, 33.8) (-54.4, 34.1), Pull (-53.6, 35.3) (-53.8, 36.5), Pull (-55.8, 36.1) (-55.6, 34.9), Pull (-56.5, 33.6) (-58.2, 33.3), Pull (-55.5, 33.0) (-54.2, 34.1), Pull (-56.0, 33.2) (-58.3, 33.2), Pull (-58.0, 37.0) (-54.5, 36.2), Pull (-58.7, 36.2) (-58.0, 31.5), Pull (-59.1, 34.1) (-59.1, 34.3), Pull (-58.7, 37.9) (-61.3, 38.1), Pull (-62.6, 34.7) (-59.4, 34.2), Pull (-58.8, 32.6) (-58.1, 30.9)]
 |>filled green
 |>addOutline (solid 0.5) black
 ,
 curve (-79.3, 31.3) [Pull (-75.8, 34.6) (-70.4, 31.0), Pull (-75.0, 31.1) (-79.5, 31.1)]
 |>filled (hsl (degrees 185) 0.002 0.574)

 

 ]
rect3 = group
 [ rect 19 18.7
 |>filled (hsl (degrees 27) 0.457 0.574)
 |>move (-77,-46)
 ,
 circle 2
 |>filled black
 |>move(-72,-43)
 ]
rect2 = group
 [
 rect 19 18.7
 |>filled (hsl (degrees 27) 0.457 0.574)
 |>move (-77,-46)
 ,
 circle 2
 |>filled black
 |>move(-72,-43)
 ,
 circle 2
 |>filled black
 |>move(-81,-43) 
 
 ]
insideRect = group 
 [
 rect 28 18
 |>outlined (solid 1 ) black
 |>move (-53,-46)
 ,
 rect 26.8 5
 |>filled (hsl (degrees 27) 0.457 0.574)
 |>move (-53.2,-43)
-- |>addOutline (solid 1) black
 ,
 rect 26.8 3.5
 |>filled (hsl (degrees 27) 0.907 0.182)
 |>move (-53.2,-39)
 ,
  rect 26.8 10
 |>filled (hsl (degrees 27) 0.521 0.442)
 |>move (-53.2,-50)
 ,
 curve (-62.5, -36.9) [Pull (-62.4, -43.4) (-62.1, -55)]
 |>outlined (solid 1 ) black
 ,
  curve (-62.5, -36.9) [Pull (-62.4, -43.4) (-62.1, -55)]
 |>outlined (solid 1 ) black
 |>move(5,0)
 ,
 curve (-62.5, -36.9) [Pull (-62.4, -43.4) (-62.1, -55)]
 |>outlined (solid 1 ) black
 |>move(10,0)
 ,
 curve (-62.5, -36.9) [Pull (-62.4, -43.4) (-62.1, -55)]
 |>outlined (solid 1 ) black
 |>move(15,0)
 ,
 curve (-62.5, -36.9) [Pull (-62.4, -43.4) (-62.1, -55)]
 |>outlined (solid 1 ) black
 |>move(20,0)
 
 
 ]
