module SamosaEmporium exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import MrSamosa

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
  [ (Robot,"Hi, what can I get you! Addy? Oh I remember!")
  , (Robot, "Addy was here earlier. She ordered some Samosas.")
  , (Robot, "Hmm. Plans? Well, she looked really busy,")
  , (Robot, "and came in with a bunch of things-")
  , (Robot, "a wagon with buckets and a blowtorch too. She")
  , (Robot, "did say that she was excited about the New Year’s")
  , (Robot, "and had big plans for her resolution this time.")
  , (Robot, "I’m sorry, but that is all I remember.")
  
  ] 

myShapes model =
  [
    samosaEmporium model
  ]
samosaEmporium model = group
 [
 side
    |> scale 2
    |> move (55, 0)

    , side 
    |> move (100, 0)
    |> scale 2
    
    , side 
    |> move (55, 30)
    |> scale 2
    
    , side 
    |> move (100, 30)
    |> scale 2
    
   ,   rect 300 40
  |> filled orange
  |> move (0, -30)
  , text "Samosa Emporium"
  |> filled white
  |> move (-45, -33)
  , roundedRect 195 5 5
  |> filled gray
  |> move (0, -10)
  
  --computer
   , rect 20 13
   |> filled black
   |> move (-25, 3)
   , rect 7 2
   |> filled black
   |> move (-25, -4)
   , rect 18 2
   |> filled black
   |> move (-25, -6.5)
   
   ,  roundedRect 6 12 1 --payment machine head
   |> filled charcoal
   |> move (-30, 4)
   ,
   rect 2 10 -- payment machine holder
   |> filled charcoal
   |> move (-30, -2.5)
   ,
   rect 5 3 -- payment machine screen
   |> filled white
   |> move (-30, 6)
   
     --computer on Right
   , rect 20 13
   |> filled black
   |> move (45, 3)
   , rect 7 2
   |> filled black
   |> move (45, -4)
   , rect 18 2
   |> filled black
   |> move (45, -6.5)
   
   ,  roundedRect 6 12 1 --payment machine head
   |> filled charcoal
   |> move (40, 4)
   ,
   rect 2 10 -- payment machine holder
   |> filled charcoal
   |> move (40, -2.5)
   ,
   rect 5 3 -- payment machine screen
   |> filled white
   |> move (40, 6)
   
  , rect 300 40
  |> filled orange
  |> move (0, 50) 
  
  , rect 180 24
  |> filled darkGray
  |> move (0, 48)
  
  , rect 40 20
  |> filled white
  |> move (-22, 48)
  
 
  
  , rect 40 20
  |> filled white
  |> move (-66, 48)
  
   , text "Menu!"
  |> filled black
  |> rotate (degrees 20)
  |> move (-80, 40)
  
  , rect 40 20
  |> filled white
  |> move (22, 48)
  
  , text "Menu!"
  |> filled black
  |> rotate (degrees 20)
  |> move (-35, 40)
  
  , rect 40 20
  |> filled white
  |> move (66, 48)
  
  , text "Menu!"
  |> filled black
  |> rotate (degrees 20)
  |> move (8, 40)
  , text "Menu!"
  |> filled black
  |> rotate (degrees 20)
  |> move (53, 40)
  
  , MrSamosa.samosa
  |> scale 0.35
  |> move (-60, 10)
   ,  speechBubbleLeft (solid 0.5) black (shantellSansFont) script 50 Robot (0.8*model.time)
      |> scale 0.8
      |> move (-10,28) 
  

 ]

side = 
  ( blocks
    ++ (blocks |> List.map (shiftBy (-18,-4)))
    ++ (blocks |> List.map (shiftBy (-28,-8)))
    ++ (blocks |> List.map (shiftBy (-32,-11.5)))
    ++ (blocks |> List.map (shiftBy (-35,-15.5)))
    ++ (blocks |> List.map (shiftBy (-37,-19)))
    ++ (blocks |> List.map (shiftBy (-34,-22.5)))
    ++ (blocks |> List.map (shiftBy (-36,-25.5)))
    ++ (blocks |> List.map (shiftBy (-38,-29.5)))
    ++ (blocks |> List.map (shiftBy (-35,-32)))
    ++ (blocks |> List.map (shiftBy (-37,-35)))
  )
    |> List.indexedMap
         ( \ idx (x,y,w) -> 
              polygon [ (x,y), (x+w,y), (x+w,y-4), (x,y-4)]
                     |> filled (hsl (degrees 40) 0.25 (0.1 * (7+sin (4.5*toFloat idx))))
                     |> addOutline (solid 0.5) charcoal
         )
    |> group
    |> scaleX 1.1

shiftBy (dx,dy) (x,y,w) = (x+dx,y+dy,w)

blocks = List.range 1 10 
       |> List.map 
            ( \ x -> (-10 - 8 * toFloat x,25,10+sin (4.5*toFloat x)) )