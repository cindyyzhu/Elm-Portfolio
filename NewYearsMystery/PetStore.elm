module PetStore exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import MrTam
import SpeechBubbles exposing (speechBubbleRight, speechBubbleLeft, shantellSansFont) -- Your shapes go here!
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
  [ (Robot,"Hello there. Here to buy food for your cat?")
  , (Robot, "Addy? Yes, she was here today.")
  , (Robot, "She asked me if we had some long")
  , (Robot, "string and we did! Are you guys building")
  , (Robot, "something? Just her? Very strange. I wish")
  , (Robot, "I could help you with your search but I")
  , (Robot, "am rather busy today. Please let me know")
  , (Robot, "when you find out about her plans, it ")
  , (Robot, "sounds very peculiar.")
  ] 
  
myShapes model =
  [
    petstore model
  ]

petstore model = [
  curve (-67.7, -32.1) [Pull (3.5, -32.6) (74.8, -33.0), Pull (75.6, 8.5) (76.4, 50.1), Pull (4.1, 50.2) (-68.1, 50.3), Pull (-67.1, -12.8) (-67.6, -31.8)]
  |> filled (rgb 237 241 242),
  
  curve (-67.9, 50.3) [Pull (-81.9, 53.8) (-96.0, 57.4), Pull (-95.6, 3.5) (-95.2, -50.3), Pull (-81.3, -41.4) (-67.4, -32.4), Pull (-67.6, 9.0) (-67.9, 50.5)]
  |> filled lightBlue,
  
  curve (76.1, 48.8) [Pull (75.3, 8.1) (74.4, -32.5), Pull (85.2, -40.7) (96.0, -49.0), Pull (93.9, 11.1) (96.7, 57.0), Pull (86.3, 53.3) (76.0, 49.6)]
  |> filled lightBlue,
  
  curve (-68.2, 49.6) [Pull (4.1, 49.8) (76.5, 50.0), Pull (86.9, 53.2) (97.3, 56.4), Pull (1.0, 57.0) (-95.1, 57.6), Pull (-81.9, 53.7) (-68.6, 49.8)]
  |> filled blue,
  
  curve (97.1, -49.9) [Pull (86.6, -41.6) (76.2, -33.3), Pull (4.3, -32.7) (-67.5, -32.1), Pull (-81.9, -41.7) (-96.4, -51.3), Pull (-95.7, -57.6) (-95.1, -63.9), Pull (0.8, -64.0) (96.7, -64.2), Pull (96.5, -56.9) (96.3, -49.6)]
  |> filled (rgb 255 187 125),
  
  curve (-95.6, -55.1) [Pull (9.3, -55.7) (96.7, -56.3)]
  |> filled (rgb 252 167 108),
  
  curve (94.2, -46.5) [Pull (0.0, -46.4) (-87.4, -45.3)]
  |> filled (rgb 252 167 108),
  
  curve (62.1, -48.6) [Pull (62.3, -30.7) (62.5, -12.7), Pull (15.3, -13.4) (-54.0, -12.6), Pull (-53.8, -30.9) (-53.5, -49.1), Pull (9.6, -50.5) (61.8, -49.2)]
  |> filled (rgb 213 85 71),
  
  curve (-59.6, -12.0) [Pull (-57.3, -9.2) (-55.1, -6.3), Pull (11.8, -6.3) (62.5, -5.5), Pull (65.3, -8.5) (68.0, -11.4), Pull (10.7, -13.2) (-57.6, -12.2)]
  |> filled (rgb 242 146 100),
  
  curve (-54.2, -6.6) [Pull (16.7, -6.8) (61.5, -4.6), Pull (61.2, -2.7) (60.4, -0.8), Pull (17.8, -1.2) (-46.8, -0.1), Pull (-50.4, -2.8) (-54.0, -6.5)]
  |> filled (rgb 255 190 124),
  
  curve (-64.5, 17.8) [Pull (-64.6, 23.1) (-64.7, 23.1), Pull (-40.4, 22.8) (-23.4, 22.9), Pull (-23.4, 20.2) (-23.3, 17.6), Pull (-44.4, 17.3) (-64.4, 17.6)]
  |> filled blue,
  
  curve (29.7, 28.8) [Pull (29.6, 34.1) (29.5, 34.1), Pull (53.7, 33.8) (70.7, 33.9), Pull (70.8, 31.3) (70.8, 28.6), Pull (49.8, 28.3) (29.8, 28.6)]
  |> filled blue
  
  , MrTam.mrtam
  |> scale 0.9
  |> move (-30, 0)
  
  ,  
    speechBubbleLeft (solid 0.5) black (shantellSansFont) script 50 Robot (0.8*model.time)
      |> scale 0.9
      |> move (26,45) 
  
  ]
  |> group
