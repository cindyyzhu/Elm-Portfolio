-- Your shapes go here!
import PartyMermaid
import SpeechBubbles exposing (speechBubbleRight, speechBubbleLeft, shantellSansFont) -- Your shapes go here!
type Actor = Robot

script = 
  [ (Robot,"Good morning. Yes, I am covering for my mother today.")
  , (Robot, "What brings you to our convenience store? ")
  , (Robot, "You are trying to find what your daughter is up to.")
  , (Robot, "Someone sounding like her did enter the store")
  , (Robot, "some time ago and she left with two buckets.")
  , (Robot, "She did look really busy and in a hurry.")
  , (Robot, "I’m afraid that is all I can tell you. ")


  ] 
  
  
myShapes model =
  [
    
   conveniencestore model
   
  
   
  ]
  
conveniencestore model = group [
  strLayout 
   |> scaleX 1.5
    |> scaleY 1.2
   |> move (0, 0)
    
   , window
   , rooftop
   , backwall
   , bigFridge
  
   , smallFridge
   
   
   , theFloor, leftShelf, roundSnacksStack
   , pointOfSale
   , stackOfEggs
   , milkRow
   , PartyMermaid.mermaidYay model
   |> move (-15, 0)
   ,
   speechBubbleRight (solid 0.5) black (shantellSansFont) script 45 Robot (0.8*model.time)
      |> scale 0.9
      |> move (-10,16) 
 ]
strLayout = group [
 
 curve (-70.7, -51.9) [Pull (-44.7, -42.8) (-30.4, -36.0), Pull (22.3, -35.4) (75.1, -34.8), Pull (78.0, -42.9) (80.8, -51.0), Pull (4.5, -51.5) (-71.7, -52.0), Pull (-72.2, 0.9) (-72.6, 54.0), Pull (4.8, 53.9) (82.4, 53.7), Pull (80.9, 10.2) (79.5, -33.1)]
 |> filled darkGrey
 |> addOutline (solid 0.5) black
 
 
 ]


rooftop = group [

  List.map ( \ idx -> roof 
                      |> move (30-15 * toFloat idx , 0) )
           (List.range -10 10)
  |> group
  ]
backwall = group [
   rect 200 65
   |> filled lightOrange
   |> move (0, -15)
   
   ]  
roof = group [
    square 15 |> outlined (solid 1) white
   , rect 20 1 |> filled white
   |> rotate (degrees 45)
   
   , rect 20 1 |> filled white
   |> rotate (degrees -45)
 ] |> move (-90, 50)
 
window = group [
  rect 200 25
    |> filled (hsl (degrees 0) 0.055 0.596)
    |> move (0, 30)
    , windowbar   
          
  ]
  
windowbar = 
  List.map ( \ idx -> square 15 |> filled (hsl (degrees 186) 0.75 0.855) 
                      |> move (30-20 * toFloat idx , 0) )
           (List.range -12 12)
 |> group |> move (-89, 30)

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
   {-   [
   square 3
   |> filled red,
   square 3
   |> filled darkGreen
   ]|> group |> move (80, 11)
   , -}
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
   ]
   
smallFridge = group [
 
   rect 35 59
    |> filled (hsl (degrees 27) 0.544 0.544)    
    |> move (0, -18)
    |> makeTransparent 0.8
    ,
    rect 30 55
    |> filled lightGrey
    |> move (0, -20)
    ,
    rect 4 2
    |> filled (hsl (degrees 27) 0.544 0.544)    
    |> move (15.5, 11.5)
    |> makeTransparent 0.8
    ,
    rect 4 2
    |> filled (hsl (degrees 27) 0.544 0.544)    
    |> move (10, 11.5)
    |> makeTransparent 0.8
    ,
    rect 4 2
    |> filled (hsl (degrees 27) 0.544 0.544)    
    |> move (-15.5, 11.5)
    |> makeTransparent 0.8
    ,
    rect 4 2
    |> filled (hsl (degrees 27) 0.544 0.544)    
    |> move (-10, 11.5)
    |> makeTransparent 0.8
    
    ,
    rect 30 2
    |> filled grey
    |> move (0, -5)
    |> addOutline (solid 0.5) darkGrey
    ,
    rect 30 2
    |> filled grey
    |> move (0, -20)
    |> addOutline (solid 0.5) darkGrey
    
    ,
    rect 30 2
    |> filled grey
    |> move (0, -35)
    |> addOutline (solid 0.5) darkGrey
    ,
    
     rect 2 58
    |> filled grey
    |> move (-14, -19)
    |> addOutline (solid 0.5) darkGrey
    ,
     rect 2 58
    |> filled grey
    |> move (15, -19)
    |> addOutline (solid 0.5) darkGrey
    , moreMilk
    , moreMilk1
    ]
    
    
pointOfSale = group [
        
       roundedRect 45 30 6
     |> filled red
     |> move (-80, -47.5)
     ,
         roundedRect 45 5 0
     |> filled grey
     |> move (-80, -60)
   
     ,
     rect 40 5
      |> filled darkBrown
     |> rotate (degrees -1)
     |> move (-77, -35)
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
   |> filled black
   |> move (-77, -14),
   square 4
   |> filled black
   |> move (-77, -20)
   ,
   roundedRect 6 10 1 --payment machine head
   |> filled charcoal
   |> move (-62, -23)
   ,
   rect 2 10 -- payment machine holder
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
      
   ]
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
theFloor = group [
  floorTile
 
  
 ]
floorTile = group [
 curve (25.1, -56.8) [Pull (24.0, -60.0) (22.9, -63.2), Pull (-3.3, -63.4) (-29.5, -63.6), Pull (-20.5, -60.4) (-11.4, -57.2), Pull (0.6, -56.2) (25.5, -56.0)]
  |> filled darkBrown
  |> addOutline (solid 1.0) darkGrey
  |> scaleX 8
  |> move (67.5, 3)
 ,
    curve (25.1, -56.8) [Pull (24.0, -60.0) (22.9, -63.2), Pull (-3.3, -63.4) (-29.5, -63.6), Pull (-20.5, -60.4) (-11.4, -57.2), Pull (0.6, -56.2) (25.5, -56.0)]
  |> filled  darkBrown
 |> addOutline (solid 1.0) darkGrey
   |> scaleX 8
  |> move (80, 9.5)
     
 ]
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
 

 
  
  
  
     
  
 
