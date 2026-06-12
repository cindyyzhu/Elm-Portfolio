module Kitchen exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import Apple

import SpeechBubbles exposing (speechBubbleRight, speechBubbleLeft, narrationBubble, shantellSansFont) -- Your shapes go here!
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
  [ (Robot,"It is around 9 am, breakfast has just been finished in the house and you are in the kitchen tidying up.")
  , (Robot,"It will be New Year’s in 2 days!")
  , (Robot,"You can’t help but feel excited about the upcoming year but also feel tired.")
  , (Robot,"You think to yourself,")
  , (Robot,"“Holidays are meant for breaks, when will I get one…”")
  , (Robot,"Your daydreams are suddenly broken when you hear a lot of running behind you,")
  , (Robot,"you turn to look back and you see Addy")
  , (Robot,"running down and out of the kitchen door.")
  , (Robot,"“Not this again, Addy!!”, you shout after her.")
  , (Robot,"You hurry to the door before it gets slammed,")
  , (Robot,"just in time to hear her say,")
  , (Robot,"“I am going to do something HUGE for my New Years Resolution!”")
  , (Robot,"“That must be dangerous”, you say,")
  , (Robot,"“I need to find out what she is up to.”")
  ] 
  
-- Your shapes go here!
myShapes model =
  [
      kitchenYay model
  ]

kitchenYay model = group [
  kitchen |> scale 1.2
    
    , narrationBubble black (shantellSansFont) script 110 Robot (0.7*model.time)
      |> scale 0.7
      |> move (-10,-50)  
  ]

mainClr = orange
secondClr = yellow
-- add any shapes you need to position with the curve, including other curves
kitchen = group
  [ Apple.apple
      |> scale 0.1
      |> move (34,-1)
  -- leftDrawers
  , roundedRect 32 80 1.8 |> filled mainClr
     |> addOutline (solid 0.5) black
     |> move (-34,-10)
  , drawer |> move (0,50)
  , drawer |> move (0,40)
  , drawer |> move (0,30)
  , rect 28 2 |> filled mainClr
      |> addOutline (solid 0.5) black
      |> move (-34,-3)
  , drawer |> move (0,10)
  , drawer
  , rect 28 16  |> filled secondClr
     |> addOutline (solid 0.5) black
     |> move (-34,-40)
  , circle 2 |> filled mainClr
     |> addOutline (solid 0.5) black
     |> move (-34,-40)
  -- counter
  , roundedRect 104 4 1.8 |> filled white
     |> addOutline (solid 0.5) black
     |> move (0,-8)
  
  -- rightDrawers
  , roundedRect 32 44 1.8 |> filled mainClr
     |> addOutline (solid 0.5) black
     |> move (34,-28)
  , drawer |> move (68,10)
  , drawer |> move (68,0)
  , rect 28 16  |> filled secondClr
     |> addOutline (solid 0.5) black
     |> move (34,-40)
  , circle 2 |> filled mainClr
     |> addOutline (solid 0.5) black
     |> move (34,-40)
  -- stove
  , roundedRect 35 6 1.8 |> filled white
     |> addOutline (solid 1) black
     |> move (0,-13)
  , circle 2 |> filled charcoal
     |> move (-12,-13)
  , circle 2 |> filled charcoal
     |> move (-4,-13)
  , circle 2 |> filled charcoal
     |> move (4,-13)
  , circle 2 |> filled charcoal
     |> move (12,-13)
  , roundedRect 35 34 1.8 |> filled white
     |> addOutline (solid 1) black
     |> move (0,-33)
  , roundedRect 25 25 1 |> filled blue
     |> addOutline (solid 1) black
     |> move (0,-33)
  --
  , teapot
      |> move (-2,-2)
  -- counter
  , roundedRect 104 4 1.8 |> filled white
     |> addOutline (solid 0.5) black
     |> move (0,-8)
  
  -- bottom
  , rect 95 3 |> filled brown
     |> move (0,-52)
     |> addOutline (solid 0.5) black
  
  -- shelf
  , pot2 
  , pot2 
      |> scale 0.8
      |> move (25,6)
  , pot2 
      |> scale 0.7
      |> move (10,10)
  , rect 60 5 |> filled mainClr
     |> addOutline (solid 0.5) black
     |> move (15,30)
  ]

drawer = 
  [
    rect 28 8  |> filled secondClr
     |> addOutline (solid 0.5) black
  , circle 2 |> filled mainClr
     |> addOutline (solid 0.5) black
  ] 
     |> group
     |> move (-34,-26)

pot2 = group
 [
 circle 2
 |>filled (hsl (degrees 182) 0.567 0.621)
 |>addOutline (solid 1) black
 |>move (0.3,48)
 ,
 curve (9.2, 40.3) [Pull (9.2, 40.3) (9.1, 40.3), Pull (1.1, 40.2) (-6.9, 40.2), Pull (-6.7, 35.6) (-7.2, 33.3), Pull (1.0, 33.6) (8.1, 33.2), Pull (7.8, 35.6) (8.6, 40.1)]
 |>filled gray
 |>addOutline (solid 1) black
 ,
 curve (-3.3, 39.3) [Pull (-3.4, 30.2) (-3.3, 33.6), Pull (-4.9, 33.3) (-6.5, 32.9), Pull (-6.2, 34.7) (-6.3, 39.8), Pull (-4.6, 39.6) (-2.8, 39.5)]
 |>filled (hsl (degrees 155) 0.025 0.684)
 |>move (0,0.5)
 ,
 curve (-7.2, 40.3) [Pull (0.9, 40.4) (9.0, 40.5), Pull (10.5, 40.6) (9.0, 42.6), Pull (0.6, 42.3) (-7.8, 42.1), Pull (-8.6, 40.5) (-6.6, 40.2)]
 |>filled (hsl (degrees 182) 0.567 0.621)
 |>addOutline (solid 1) black
 ,
 curve (-6.6, 42.6) [Pull (-8.2, 47.3) (0.6, 47.5), Pull (7.5, 47.9) (8.4, 42.9), Pull (0.3, 42.5) (-6.3, 42.8)]
 |>filled (hsl (degrees 182) 0.567 0.621)
 |>addOutline (solid 1) black
 ]

teapot = group 
 [
 
 curve (5.8, -1.8) [Pull (6.5, 1.1) (7.1, 4.1), Pull (6.5, 3.0) (6.6, 1.8), Pull (3.7, 3.4) (2.1, 4.5), Pull (1.2, 3.8) (0.3, 3.2), Pull (4.5, 2.6) (5.9, -1.6), Pull (5.6, -2.8) (5.4, -4.0), Pull (12.6, -4.1) (19.8, -4.1), Pull (21.2, -4.5) (20.2, -0.2), Pull (22.1, 1.1) (24.0, 2.5), Pull (23.5, 3.3) (23.0, 4.1), Pull (21.3, 3.1) (19.6, 2.1), Pull (19.5, 2.8) (19.3, 3.4), Pull (19.6, 4.3) (19.8, 5.3), Pull (13.2, 5.4) (6.6, 5.5), Pull (6.8, 4.9) (7.1, 4.3), Pull (13.1, 4.3) (19.1, 4.4), Pull (19.6, 2.0) (20.1, -0.3)]
 |>filled (hsl (degrees 155) 0.682 0.39)
 |>addOutline (solid 1) black
 ,
 curve (6.9, 5.7) [Pull (12.2, 10.7) (19.1, 5.8), Pull (12.9, 5.2) (6.7, 5.7)]
 |>filled (hsl (degrees 155) 0.682 0.39)
 |>addOutline (solid 1) black
 ,
 circle 1
 |>filled (hsl (degrees 155) 0.682 0.39)
 |>addOutline (solid 0.5) black
 |>move(13,9.4)
 ,
  curve (7.5, 3.5) [Pull (6.6, -0.9) (6.5, -1.6), Pull (13.0, -0.9) (19.6, -0.1), Pull (19.1, 1.9) (18.7, 4.0), Pull (13.1, 3.7) (7.4, 3.4)]
 |>filled (hsl (degrees 155) 0.682 0.39)
 |>scaleY 1.2
 |>move(0,-0.2)
 ,
 curve (8.7, 2.1) [Pull (8.2, -0.0) (8.4, -2.4)]
 |>outlined (solid 0.5) black 
 ]