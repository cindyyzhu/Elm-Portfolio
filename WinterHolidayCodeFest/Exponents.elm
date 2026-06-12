module WinterHolidayCodeFest.Exponents exposing (..)

-- 1. type your word in between the ""s
word = "Exponents"

-- 2. draw your word using Shapes
myShapes t = 
  [
    text "x"
    |> filled black
    |> move(-1, -1)
    |> scale 3
    ,text "y"
    |> filled black
    |> move(10, 10)
    |> scale 1.25
  ]

pair = (myShapes, word)

