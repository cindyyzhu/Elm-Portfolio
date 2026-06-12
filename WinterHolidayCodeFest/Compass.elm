module WinterHolidayCodeFest.Compass exposing (..)

-- 1. type your word in between the ""s
word = "compass"

-- 2. draw your word using Shapes
myShapes t = 
  [  square 22
    |> filled black
    |> rotate (degrees 225)
    |> scaleY 2
    |> scaleX 0.5
    ,square 22
    |> filled black
    |> rotate (degrees -135)
    |> scaleX 2
    |> scaleY 0.5
  ,circle 13
    |> outlined (solid 1) black
    |> rotate (degrees -135)
    |> scale 2
    ,  text "N"
    |> filled black
    |> move (-4,36)
    ,  text "E"
    |> filled black
    |> move (32,-4)
    ,  text "W"
    |> filled black
    |> move (-43,-4)
    ,  text "S"
    |> filled black
    |> move (-4,-42) 
    ,  circle 50
    |> outlined (solid 2) black
    ,  triangle 10
    |> filled black
    |> scaleY 0.5
    |> rotate (degrees -140)
    |> move (-10,-9)
        ,  triangle 10
    |> filled black
    |> scaleY 0.5
    |> rotate (degrees 40)
    |> move (10,9)
        ,  triangle 10
    |> filled black
    |> scaleY 0.5
    |> rotate (degrees -40)
    |> move (9,-9)
    ,  triangle 10
    |> filled black
    |> scaleY 0.5
    |> rotate (degrees 140)
    |> move (-9,9)
    ,  triangle 10
    |> filled (red)
    |> rotate (degrees -150)
    |> scaleX 0.5
    |> scaleY 1
    |> move (0,5)
   ,  triangle 10
    |> filled (blue)
    |> rotate (degrees 150)
    |> scaleX 0.5
    |> scaleY 1
    |> move (0,-5)
      ,circle 2
    |> filled (hsl (degrees 140) 0.379 0.25)
   
 ]

pair = (myShapes, word)

