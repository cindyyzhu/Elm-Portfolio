module WinterHolidayCodeFest.Addition exposing (..)-- 1. type your word in between the ""s
word = "Addition"

-- 2. draw your word using Shapes
myShapes t = 
  [
    rect 6 24
    |> filled black
    ,rect 6 24
    |> filled black
    |> rotate (degrees 90)
  ]
