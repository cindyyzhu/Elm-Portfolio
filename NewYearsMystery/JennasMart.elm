module JennasMart exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import Apple
import Jenna

import SpeechBubbles exposing (narrationBubble, speechBubbleLeft, speechBubbleRight, shantellSansFont) -- Your shapes go here!
type Actor = Jenna

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
  
  

script = [ (Jenna,"Hello! How may I help you on this fine winter morning. ")
        ,  (Jenna, "Did Addy come here?")
         , (Jenna, "Oh yes, she did!")
         , (Jenna, "Quite a surprising purchase from her today. ") 
         , (Jenna, "What did she buy?")
         , (Jenna, "A blowtorch!")
         , (Jenna, "Right from the corner over there. ")
         , (Jenna, "She said it was for something she was making")
         , (Jenna, "for her resolution. ")
         , (Jenna, "That sounds rather dangerous, you are right. ")
         , (Jenna, "My gosh, I shouldn’t have sold it to her. ")
         , (Jenna, "In any case, good luck finding out what she is making!")
    ]
-- Your shapes go here!
myShapes model =
  [
    jennasmart model
  
   ]
   
   
jennasmart model = group [
   strLayout 
   |> scaleX 1.5
    |> scaleY 1.2
   |> move (0, 0)
    
   , window
   , rooftop
   , backwall
   , bigFridge
  , moreMilk
  |> move (-76, 10)
  , moreMilk1
  |> scaleX 0.9
  |> scaleY 1.2
  |> move (-75, 15)
  , roundSnacksStack
    |> scale 0.7
    |> move (-10, 10)
     
  
  , stackOfEggs
     |> move (-85, 10)
  
  
   ,
  [table , apples] |> group |> move (70, -20)
   , 
  [table , apples] |> group |>move (65, -40)
   ,
   [table,
   bananas] |> group |> move (-63, -45)
   , screen
   ,
   speechBubbleLeft (solid 0.5) black (shantellSansFont) script 50 Jenna (0.9*model.time)
    --  |> scale 1.1
      |> move (-100,30)
      |> move (140, 7)
     , Jenna.jenna
   |> scale 0.4
    |> move (-9,-3) 
   , pointOfSale
  ]
--store layout from the wall to the floor like an outline
strLayout = group [
 
 curve (-70.7, -51.9) [Pull (-44.7, -42.8) (-30.4, -36.0), Pull (22.3, -35.4) (75.1, -34.8), Pull (78.0, -42.9) (80.8, -51.0), Pull (4.5, -51.5) (-71.7, -52.0), Pull (-72.2, 0.9) (-72.6, 54.0), Pull (4.8, 53.9) (82.4, 53.7), Pull (80.9, 10.2) (79.5, -33.1)]
 |> filled grey
 |> addOutline (solid 0.5) blue
  ]
  
--groups of white squares close to the ceiling.
rooftop = group [

  List.map ( \ idx -> roof 
                      |> move (30-15 * toFloat idx , 0) )
           (List.range -10 10)
  |> group
  ]
-- the skyblue backwall
backwall = group [
   rect 200 65
   |> filled (hsl (degrees 210) 0.588 0.883)
   |> move (0, -5)
   
   ]  
--one square that makes up the group of squares
roof = group [
    square 15 |> outlined (solid 1) white
  
 ] |> move (-90, 50)
 
window = group [
  rect 200 25
    |> filled (hsl (degrees 0) 0.055 0.596)
    |> move (0, 30)
   -- , windowbar   
          
  ]
-- the big fridge to the left of the store
bigFridge = group [
   
  rect 70 63
    |> filled (hsl (degrees 27) 0.544 0.544)    
    |> move (60, -16)
    |> makeTransparent 0.8
    ,
   rect 65 57
   |> filled lightGrey
   |> move (60, -19)
   |> addOutline (solid 0.2) charcoal
   ,
   rect 4 59 --left fridge bar
   |> filled lightGrey
   |> move (29, -18)
   |> addOutline (solid 0.2) charcoal
   ,
   rect 4 59 --right fridge bar
   |> filled lightGrey
   |> move (91, -18)
   |> addOutline (solid 0.2) charcoal
      ,
      rect 57.5 4 --fridge top with buttons
   |> filled lightGrey
   |> move (60, 9)
   |> addOutline (solid 0.5) charcoal
   ,
   rect 57.5 2 -- fridge inner third row
   |> filled blue
   |> move (60,8)
     
   ,
    rect 57.5 5 -- fridge inner first row
   |> filled lightCharcoal
   |> move (60,4.5)
   |> makeTransparent 0.8
   ,
   rect 57.5 2 --topmost fridge divider
   |> filled lightGrey
   |> move (60, -5)
   |> addOutline (solid 0.2) charcoal
   ,
   rect 57.5 5 -- fridge inner second row
   |> filled lightCharcoal
   |> move (60,-8.8)
   |> makeTransparent 0.8
   ,
   rect 57 2 --fridge divider second row
   |> filled lightGrey
   |> move (60, -20)
   |> addOutline (solid 0.2) charcoal
   ,
    rect 57.5 5 -- fridge inner third row
   |> filled lightCharcoal
   |> move (60,-23)
   |> makeTransparent 0.8
   ,
   rect 57.5 12.5 --fridge base
   |> filled lightGrey
   |> move (60, -41)
   |> addOutline (solid 0.2) charcoal
   , 
   rect 57.5 3 -- stripe of lower fridge
   |> filled blue
   |> move (60,-37)
   ,
   rect 13 0.5 -- stripe of lower fridge1
   |> filled grey
   |> move (80,-40)
   ,
   rect 13 0.5 -- stripe of lower fridge2
   |> filled grey
   |> move (80,-41)
   ,
   rect 13 0.5 -- stripe of lower fridge3
   |> filled grey
   |> move (80,-42)
   ,
   rect 13 0.5 -- stripe of lower fridge4
   |> filled grey
   |> move (80,-43)
     
   , milkRow
   , stackOfEggs
    , roundSnacksStack
 
   
   ]|> move (-120, 10)
 
    
--the entire POS and the desk    
pointOfSale = group [
        
       roundedRect 45 30 6
     |> filled lightBrown
     |> move (-80, -47.5)
     |> addOutline (solid 0.5) black
     ,
         roundedRect 45 5 0
     |> filled grey
     |> addOutline (solid 0.5) black
     |> move (-80, -60)
   
     ,
     rect 50 5
      |> filled white
     |> rotate (degrees -1)
     |> move (-80, -35)
     |> addOutline (solid 0.5) black
     , 
          roundedRect 23 4 1
     |> filled black
     |> rotate (degrees -1)
     |> move (-79, -30.5)
     |> addOutline (solid 0.5) charcoal
     
     ,
       roundedRect 19 5.5 1
     |> filled black
     |> rotate (degrees -1)
     |> move (-77, -25.5)
     |> addOutline (solid 0.5) charcoal
   ,
   square 13
   |> filled charcoal
   |> move (-77, -14),
   square 4
   |> filled charcoal
   |> move (-77, -20)
   ,
   roundedRect 6 10 1 --payment machine head
   |> filled charcoal
   |> move (-62, -23)
   ,
   rect 2 6.5 -- payment machine holder
   |> filled charcoal
   |> move (-62, -30)
   ,
   rect 5 3 -- payment machine screen
   |> filled white
   |> move (-62, -21)
   ,
   List.map ( \ idx -> square 1.5 |> filled (hsl (degrees 186) 0.75 0.855) 
                      |> move (3-2 * toFloat idx , 1) )
           (List.range -2 0)
 |> group |> move (-67, -25)
 ,
  List.map ( \ idx -> square 1.5 |> filled (hsl (degrees 186) 0.75 0.855) 
                      |> move (3-2 * toFloat idx , 2) )
           (List.range -2 0)
 |> group |> move (-67, -28)
      
   ]|> move (85, 15)
   
-- multiply the row of eggs vertically
stackOfEggs = List.map ( \ idx -> eggsRow 
                      |> move (0, 0-3.5 * toFloat idx ) )
           (List.range -2 0) |> group
-- 6 eggs
eggsRow = List.map ( \ idx -> eggs 
                      |> move (0-3.5 * toFloat idx , 0) )
           (List.range -5 0) |> group
-- one egg
eggs = group [
    oval 17 27
      |> filled lightBrown
          -- (hsl (degrees 30) 0.185 0.967)
  , ngon 2 10
      |> outlined (solid 1) 
          (hsl (degrees 33) 0.416 0.421)
        |> scale 0.75
        |> rotate (degrees 70)
        |> move (7,-10)
  , rect 10 14
      |> filled 
          (hsl (degrees 29) 0.379 0.431)
        |> move (0,-10)
  , polygon [(0,0),(0,-10),(30,0)]
      |> filled 
          (hsl (degrees 27) 0.328 0.449)
        |> scale 0.5
        |> rotate (degrees -90)
        |> move (-5,-2)
  , rect 6 12
      |> filled 
          (hsl (degrees 29) 0.356 0.426)
        |> rotate (degrees -20)
        |> move (4,-9)
  , rect 23 3
      |> filled 
          (hsl (degrees 25) 0.31 0.486)
        |> move (0,-3)
      
  ] |> scale 0.15 |> move (33.5, -32)

milkRow = List.map ( \ idx -> milk 
                      |> move (0-5 * toFloat idx , 0) )
           (List.range -5 0) |> group  
milk = group   [
    
    roundedRect 15 27 2
      |> filled (rgb 163 131 108)
          
        |> move (4,-10)
  , roundedRect 5 5 0
      |> filled (rgb 89 66 54)
          
        |> move (4,8)
  , circle 9
      |> filled (rgb 163 131 108)
          
        |> scale 0.75
        |> move (4,1)
  , rect 15 6
      |> filled (rgb 89 66 54)
          
        |> move (4,-1)
  , rect 15 2
      |> filled (rgb 89 66 54)
         
        |> move (4,-8)
  , rect 15 1
      |> filled (rgb 89 66 54)
        |> move (4,-23)
  , text "M I L K"
      |> outlined (solid 1) 
          (rgb 196 163 139)
      |> scale 0.4
        |> move (-2.1,-2.3)
   ] |> scaleY 0.37 |> scaleX 0.3 |> move (60, -10) 
      |> addOutline (solid 1)(rgb 196 163 139)

leftShelf = group [
   
  rect 70 63
    |> filled (hsl (degrees 27) 0.544 0.544)    
    |> move (60, -16)
    |> makeTransparent 0.8
    ,
   rect 65 57
   |> filled lightGrey
   |> move (60, -19)
   |> addOutline (solid 0.2) charcoal
   ,
   rect 4 59 --left fridge bar
   |> filled charcoal
   |> move (29, -18)
   |> addOutline (solid 0.2) charcoal
   ,
   rect 4 59 --right fridge bar
   |> filled charcoal
   |> move (91, -18)
   |> addOutline (solid 0.2) charcoal
   ,
   rect 57.5 4 --fridge top with buttons
   |> filled charcoal
   |> move (60, 9)
   |> addOutline (solid 0.5) charcoal
     
   ,
    rect 57.5 5 -- fridge inner first row
   |> filled charcoal
   |> move (60,4.5)
   |> makeTransparent 0.8
   ,
   rect 57.5 2 --topmost fridge divider
   |> filled charcoal
   |> move (60, -5)
   |> addOutline (solid 0.2) charcoal
   ,
   rect 57.5 5 -- fridge inner second row
   |> filled charcoal
   |> move (60,-8.8)
   |> makeTransparent 0.8
   ,
   rect 57 2 --fridge divider second row
   |> filled charcoal
   |> move (60, -20)
   |> addOutline (solid 0.2) charcoal
   ,
    rect 57.5 5 -- fridge inner third row
   |> filled charcoal
   |> move (60,-23)
   |> makeTransparent 0.8
   ,
   rect 57.5 12.5 
   |> filled charcoal
   |> move (60, -41)
   |> addOutline (solid 0.2) charcoal
     
   ] |> move (-113,-1.5) |> makeTransparent (0.8) |> scaleX 1.2

creamText x = List.map ( \ idx -> text "mee" |> filled white |> scale 0.3
                      |> move (4-8.5 * toFloat idx , -1) )
           (List.range x 0)
           |> group |> move (-76,0)
           
roundSnacks =  List.map ( \ idx -> circle 3  |> filled pink
                      |> move (4-7 * toFloat idx , 0) )
           (List.range -5 0)
 |> group |> move (-74, -2) |> addOutline (solid 1) brown
 
roundSnacks2 =  List.map ( \ idx -> circle 3  |> filled pink
                      |> move (4-7 * toFloat idx , 0) )
           (List.range -4 0)
         
 |> group |> move (-70, 4.5) |> addOutline (solid 1) brown


             
roundSnacksStack = group [ 
              
              roundSnacks, roundSnacks2
              
              ] 
moreMilk = List.map ( \ idx -> rect 4 7 |> filled lightBrown |> addOutline (solid 0.5) brown
                      |> move (4-5 * toFloat idx , 0) )
           (List.range -4 0)
 |> group |> move (-13.5, 0) 
 
moreMilk1 = List.map ( \ idx -> rect 6 8 |> filled white |> addOutline (solid 0.5) blue 
                      |> move (4-7 * toFloat idx , 0) )
           (List.range -3 0)
 |> group |> move (-15, -16) 
 
table = group [
      
      rect 4 25
      |> filled lightBrown
      |> move (14, -8),
       rect 4 25
      |> filled lightBrown
      |> move (-14, -8)
      ,
      rect 35 4
      |> filled charcoal
      
      ]
      
      
 --apple on the desk
apples = group [
      List.map ( \ idx -> Apple.apple |> scale 0.07
                      |> move (4-6.2 * toFloat idx , 0) )
           (List.range -5 0)
 |> group |> move (-18, 5),
  List.map ( \ idx -> Apple.apple |> scale 0.07
                      |> move (4-6.2 * toFloat idx, 0) )
           (List.range -4 0)
 |> group |> move (-14, 10)
 ,

 List.map ( \ idx -> Apple.apple |> scale 0.07
                      |> move (4-6.2 * toFloat idx, 0) )
           (List.range -3 0)
            |> group |> move (-10, 15)
            ,
 List.map ( \ idx -> Apple.apple |> scale 0.07
                      |> move (4-6.2 * toFloat idx, 0) )
           (List.range -2 0)
 |> group |> move (-6, 20)
 
  ,
  List.map ( \ idx -> Apple.apple |> scale 0.07
                      |> move (4-6.2 * toFloat idx, 0) )
           (List.range -1 0)
 |> group |> move (-2, 25)
 
 ]

bananas = group [
      List.map ( \ idx -> banana |> scale 0.07
                      |> move (4-6.2 * toFloat idx , 0) )
           (List.range -5 0)
 |> group |> move (-18, 5),
  List.map ( \ idx -> banana |> scale 0.07
                      |> move (4-6.2 * toFloat idx, 0) )
           (List.range -4 0)
 |> group |> move (-14, 10)
 ,

 List.map ( \ idx -> banana |> scale 0.07
                      |> move (4-6.2 * toFloat idx, 0) )
           (List.range -3 0)
            |> group |> move (-10, 15)
            ,
 List.map ( \ idx -> banana |> scale 0.07
                      |> move (4-6.2 * toFloat idx, 0) )
           (List.range -2 0)
 |> group |> move (-6, 20)
 
  ,
  List.map ( \ idx -> banana |> scale 0.07
                      |> move (4-6.2 * toFloat idx, 0) )
           (List.range -1 0)
 |> group |> move (-2, 25)
 
 ]
 

-- banana
banana = group [
 curve (-22.3, -61.9) [Pull (-23.8, -62.6) (-54.7, -47.5), Pull (-84.7, -10.6) (-74.1, 8.9), Pull (-63.7, 21.5) (-64.0, 36.8), Pull (-59.5, 39.2) (-55.1, 41.6), Pull (-51.3, 20.4) (-37.1, 12.8), Pull (-1.9, -11.5) (55.4, 1.3), Pull (56.3, -6.1) (61.3, -7.9), Pull (52.2, -30.9) (15.7, -37.4), Pull (-6.5, -33.0) (-35.2, -16.7), Pull (-45.0, -4.8) (-56.9, 15.2), Pull (-56.4, 22.1) (-55.9, 29.0), Pull (-55.4, 3.8) (-27.5, -27.0), Pull (-9.2, -35.4) (38.7, -41.2), Pull (37.3, -48.7) (40.5, -51.7), Pull (32.3, -62.2) (-18.8, -61.4)]
 |> filled yellow
 |> addOutline (solid 1) black
 , 
 curve (57.9, 0.0) [Pull (55.0, -2.2) (61.3, -8.9), Pull (60.1, -4.4) (58.8, 0.0)]
 |> filled brown
 ]-- |> scale 0.07
 
screen = group [ rect 30 20
             |> filled grey
             |> addOutline (solid 3) charcoal
             |> move (48, 15)
             ,
             text "S A L E"
             |> filled black
             |> scale 0.5
             |> move (39, 14)
             
             ]
 