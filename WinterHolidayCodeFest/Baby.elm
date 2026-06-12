module WinterHolidayCodeFest.Baby exposing (..)
import GraphicSVG exposing (..)
pair = (myShapes, word)
-- 1. type your word in between the ""s
word = "baby"

-- 2. draw your word using Shapes
myShapes t =
  [
     animation
     |> move (-17,40)
     |> rotate (degrees -130)
     |> makeTransparent (-2 * cos t) 
     
   , baby
     |> makeTransparent 1
  ]
   
animation = group
      [
         circle 5 
    |> filled (rgb 50 0 0)
    |> move (18,-20)
    |> makeTransparent 1
       
       ]
       
baby = group
  [
    circle 10
      |> filled black
      |> move (-20,20)
   ,circle 9
    |> filled (hsl (degrees 59) 0.89 0.832)
    |> move (-20,20)
   ,circle 1
    |> filled black
    |> move (-25,20)
   ,circle 1
    |> filled black
    |> move (-20,25)
   ,curve (0,0) [Pull (15,10) (20,-10)]
    |> filled black
    |> rotate (degrees -115)
    |> scale 0.5
    |> move (-14,22)
   ,roundedRect 10 20 2
    |> filled black
    |> rotate (degrees -135)
    |> scale 1.75
    |> move (-1,1)
   ,roundedRect 9 19 2
        |> filled white
        |> rotate (degrees -135)
        |> scale 1.7
        |> move (-1,1)
   ,rect 1 10
    |> filled black
    |> rotate (degrees 110)
    |> scale 1.75
   ,rect 1 10
    |> filled black
    |> rotate (degrees 110)
    |> scale 1.75
    |> move (-9,9)
   ,rect 1 8.2
    |> filled black
    |> rotate (degrees 110)
    |> scale 1.75
    |> move (7.5,-10)
    ,rect 0.3 3
    |> filled black
    |> rotate (degrees 230)
    |> scale 1.75
    |> move (-28,29)
    
    ]

pair = (myShapes, word)

