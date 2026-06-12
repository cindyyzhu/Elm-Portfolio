module WinterHolidayCodeFest.Trefoil exposing (..)

-- 1. type your word in between the ""s
word ="trefoil"

-- 2. draw your word using Shapes5
myShapes t = 
  [
    circle 10
    |> filled (hsl (degrees 64) 0.957 0.576)
    |> scale 2
    ,
      circle 10
    |> filled black
    |> scale 0.35
    ,
          circle 10
    |> outlined (dotted 10.5) black
      
  ]

pair = (myShapes, word)

