module WinterHolidayCodeFest.Home exposing (..)

-- 1. type your word in between the ""s
word = "Home"

-- 2. draw your word using Shapes
myShapes t = 
  [
       square 46
    |> filled yellow
    |> move (0,-20),
      rect 14 24
    |> filled gray
    |> move (15,25),
      triangle 32
    |> filled red
    |> rotate (degrees -30)
    |> move (0,18)
  ]