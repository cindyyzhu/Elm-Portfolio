module ChildrensBedroom exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import Cat
import PiggyBank

import SpeechBubbles exposing (narrationBubble, speechBubbleLeft, speechBubbleRight, shantellSansFont) -- Your shapes go here!
type Actor = Robot | Mittens


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
  [ (Robot,"You find that Addy’s childhood piggy bank has been broken into. ")
  , (Robot, "All the coins are spilling out but most of her money is gone. ")
  , (Robot, "Maybe looking at another location will be of help.")   
  , (Mittens, "Meow, I think Addy") 
  , (Mittens, "said something about going") 
  , (Mittens, "to the garage…") 
  ] 
  
-- Your shapes go here!
myShapes model =
  [
    bedroom model
  ]
  
bedroom model = group [
  background, window, painting, name |> scale 0.9 |> move (25,-6)
    , bedFrame, panda
    ,
    Cat.myShapes model
    |> group 
    |> scale (0.25)
    |> move (-25,-8)
    ,
    PiggyBank.myShapes model
    |> group
    |> scale (0.2)
    |> move (15,-15)
    ,
    narrationBubble black (shantellSansFont) script 50 Robot (0.75*model.time)
      |> scale 1
      |> move (0,-40) 
    ,
    speechBubbleLeft(solid 0.5) black (shantellSansFont) script 25 Mittens (0.8*model.time)
      |> scale 0.8
      |> move (-3,8) 
 ]
name = group [
  curve (-4.5, 17.1) [Pull (-7.0, 25.5) (-9.4, 34.0), Pull (-13.8, 25.4) (-18.2, 16.8), Pull (-15.4, 16.9) (-12.5, 16.9), Pull (-11.8, 19.3) (-11.1, 21.8), Pull (-10.0, 19.4) (-8.9, 16.9), Pull (-6.6, 17.1) (-4.3, 17.2)]  
  |> outlined (solid 1.5) yellow
  ,
  curve (5.5, 26.1) [Pull (2.0, 21.8) (-1.3, 17.5), Pull (-2.0, 26.0) (-2.7, 34.4), Pull (1.4, 30.1) (5.7, 25.8)]
  |> outlined (solid 1.5) red
  , 
  curve (10.0, 31.2) [Pull (12.8, 27.3) (15.6, 23.3), Pull (11.1, 19.9) (6.7, 16.6), Pull (8.3, 24.0) (9.9, 31.4)]
  |> outlined (solid 1.5) blue
  , 
  curve (22.6, 23.6) [Pull (25.5, 27.7) (28.4, 31.8), Pull (25.0, 29.0) (21.5, 26.2), Pull (18.3, 28.7) (15.1, 31.1), Pull (17.5, 27.1) (19.9, 23.0), Pull (20.1, 17.3) (20.3, 11.7), Pull (21.5, 17.6) (22.7, 23.6)]
  |> outlined (solid 1.5) green
  ]

painting = group [
  rect 50 30
  |> filled white 
  |> addOutline (solid 3) brown
  |> move (30, 15)
  ] 
  
window = group [
  rect 30 40
  |> filled (rgb 193 225 255)
  |> addOutline (solid 2) white 
  |> move (-45, 15)
  ,
  rect 2 40
  |> filled white 
  |> move (-45, 15)
  ,
  rect 30 1
  |> filled white 
  |> move (-45, 5)
  ,
  rect 30 1
  |> filled white 
  |> move (-45, 15)
  ,
  rect 30 1
  |> filled white 
  |> move (-45, 25)
  
  ]
 
background = group [
  -- ground
  rect 150 30
  |> filled (rgb 151 131 129)
  |> move (0,-40)
  ,
  --wall
  rect 150 75
  |> filled (rgb 235 218 217)
  |> move (0,10)
  ]
 
panda = group [ 
  curve (54.6, -7.9) [Pull (58.3, -5.8) (62.2, -8.1), Pull (63.8, -10.0) (65.3, -12.0), Pull (67.2, -19.8) (58.6, -20.8), Pull (50.9, -20.5) (51.6, -12.3), Pull (53.1, -10.1) (54.6, -7.8)] 
  |> filled white
  |> addOutline (solid 0.5) black
  ,  
  curve (54.8, -7.9) [Pull (52.1, -6.0) (50.4, -8.3), Pull (48.7, -10.7) (51.7, -12.4), Pull (52.9, -9.7) (55.0, -7.8)]
  |> filled black
  ,
  curve (54.8, -7.9) [Pull (52.1, -6.0) (50.4, -8.3), Pull (48.7, -10.7) (51.7, -12.4), Pull (52.9, -9.7) (55.0, -7.8)]
  |> filled black
  |> scaleX -1 
  |> move (117,0)
  , 
  curve (63.3, -19.7) [Pull (67.0, -27.0) (67.0, -34.3), Pull (62.1, -33.5) (62.0, -38.3), Pull (58.9, -38.3) (55.7, -38.4), Pull (55.0, -33.6) (50.2, -34.4), Pull (50.0, -27.8) (53.6, -19.9), Pull (58.7, -23.0) (63.4, -19.6)]
  |> filled white
  |> addOutline (solid 1) black
  , 
  curve (53.2, -19.9) [Pull (44.9, -28.1) (45.5, -33.8), Pull (47.9, -35.2) (50.1, -33.3), Pull (50.2, -26.6) (53.6, -20.2)]  
  |> filled black
  ,
  curve (53.2, -19.9) [Pull (44.9, -28.1) (45.5, -33.8), Pull (47.9, -35.2) (50.1, -33.3), Pull (50.2, -26.6) (53.6, -20.2)]  
  |> filled black
  |> scaleX -1
  |> move (117,0)
  ,
  curve (53.0, -34.2) [Pull (43.8, -33.9) (42.3, -35.9), Pull (38.2, -38.2) (41.9, -43.2), Pull (43.9, -44.5) (45.9, -43.7), Pull (49.6, -42.9) (55.5, -37.7), Pull (55.5, -35.4) (52.8, -34.0)]
  |> filled black --left leg
  |> move (2,1)
  ,
  curve (53.0, -34.2) [Pull (43.8, -33.9) (42.3, -35.9), Pull (38.2, -38.2) (41.9, -43.2), Pull (43.9, -44.5) (45.9, -43.7), Pull (49.6, -42.9) (55.5, -37.7), Pull (55.5, -35.4) (52.8, -34.0)]
  |> filled black  --right leg
  |> scaleX -1
  |> move (115,1)
  ,
  curve (59.6, -15.1) [Pull (58.5, -15.1) (57.4, -15.5), Pull (58.6, -17.8) (59.6, -15.3)]
  |> filled (rgb 249 181 180)
  |> addOutline (solid 0.5) black
  ,
  circle 1
  |> filled black
  |> move (55,-13)
  ,
  circle 1
  |> filled black
  |> move (62,-13)
  
  ]
  
 
bedFrame = group [
  curve (-52.9, -21.6) [Pull (-52.8, -27.6) (-52.8, -33.7), Pull (-50.8, -34.1) (-48.8, -34.6), Pull (-48.7, -31.4) (-48.7, -28.2), Pull (-39.8, -30.8) (-31.0, -33.3), Pull (-31.1, -36.7) (-31.2, -40.0), Pull (-30.1, -40.6) (-29.0, -41.1), Pull (-28.3, -40.8) (-27.7, -40.4), Pull (-27.7, -37.1) (-27.6, -33.9), Pull (9.5, -31.2) (46.8, -28.6), Pull (48.9, -25.8) (51.0, -23.0), Pull (11.4, -25.9) (-28.2, -28.7), Pull (-40.6, -25.3) (-53.1, -21.8)]
  |> filled (rgb 145 105 93)
  ,
  curve (-52.6, -23.0) [Pull (-53.2, -17.0) (-49.6, -16.8), Pull (-7.6, -14.3) (34.2, -11.9), Pull (43.1, -13.3) (51.9, -14.7), Pull (51.9, -17.2) (54.2, -19.8), Pull (51.9, -21.3) (50.8, -23.2), Pull (11.0, -26.3) (-28.6, -29.3), Pull (-40.5, -26.0) (-52.3, -22.7)]  
  |> filled blue -- mattress 
  ,
  curve (59.7, 0.0) [Pull (46.9, 2.6) (34.2, 5.2), Pull (34.2, -3.4) (34.3, -12.1), Pull (36.4, -12.5) (38.5, -12.8), Pull (38.5, -6.2) (38.6, 0.3), Pull (39.9, -0.0) (41.2, -0.3), Pull (41.2, -6.8) (41.1, -13.2), Pull (42.8, -13.5) (44.5, -13.9), Pull (44.5, -7.5) (44.4, -1.1), Pull (46.2, -1.6) (48.0, -2.1), Pull (48.2, -8.1) (48.3, -14.1), Pull (49.9, -14.4) (51.4, -14.8), Pull (51.6, -13.5) (51.7, -12.1), Pull (48.8, -9.0) (51.9, -7.2), Pull (51.8, -4.9) (51.8, -2.6), Pull (53.6, -3.1) (55.4, -3.5), Pull (55.5, -5.6) (55.7, -7.8), Pull (57.7, -6.6) (59.7, -7.2), Pull (59.7, -3.6) (59.7, -0.1)]
  |> filled (rgb 145 105 93)
  ]
