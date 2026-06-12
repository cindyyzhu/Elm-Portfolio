module WinterHolidayCodeFest.Fear exposing (..)

-- 1. type your word in between the "fear"s
word = "fear"

-- 2. draw your word using Shapes
myShapes t = 
  [ 
   roundedRect 12 32 6
    |> filled black
    |> move (0,0)
    |> rotate (degrees 90)
       ,rect 8 53
    |> filled red
    |> rotate (degrees 90)
    |> move (8,-5)
     ,  oval 13 20
    |> filled (hsl (degrees 279) 0.959 0.536)
    |> rotate (degrees 125)
    |> move (24,5)
    ,  oval 13 20
    |> filled (hsl (degrees 52) 0.905 0.79)
    |> rotate (degrees 125)
    |> move (15,10)
    ,  circle 1
    |> filled black
    |> rotate (degrees 125)
    |> move (15,12)
    ,  rect 1 5
    |> filled black
    |> rotate (degrees 50)
    |> move (10,10)
      ,rect 4 40
    |> filled black
    |> rotate (degrees -180)
    |> move (-17,-3)
    , circle 4
    |> filled black
    |> rotate (degrees -180)
    |> move (-17,20) 
      ,rect 4 40
    |> filled black
    |> rotate (degrees -180)
    |> move (35,-3)
    , circle 4
    |> filled black
    |> rotate (degrees -180)
    |> move (35,20)
    ,  rect 15.5 53
    |> filled black
    |> rotate (degrees -90)
    |> move (8,-15)
    |> makeTransparent 0.9
    ,  oval 2 10
    |> filled red
    |> rotate (degrees -90)
    |> move (3,-15)
    ,   oval 2 10
    |> filled red
    |> rotate (degrees -90)
    |> move (15,-15)
    ,  triangle 10
    |> filled white
    |> rotate (degrees -90)
    |> move (0,0)
    |> scale 0.1
  ]

pair = (myShapes, word)

