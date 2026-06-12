module WinterHolidayCodeFest.Division exposing (..)

-- 1. type your word in between the ""s
word = "Division"

-- 2. draw your word using Shapes
myShapes t = 
  [
    rect 1 24
    |> filled black
    |> rotate (degrees 90)
    ,text "x"
    |> filled black
    |> move(-3, 2)
    ,text "y"
    |> filled black
    |> move(-3, -7)
  ]

pair = (myShapes, word)

