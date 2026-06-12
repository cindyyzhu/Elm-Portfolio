module WinterHolidayCodeFest.North exposing (..)

-- 1. type your word in between the ""s
word = "North"

-- 2. draw your word using Shapes
myShapes t = 
  [
       circle 10
    |> outlined (solid 1) black
    |> scaleY 2
    |> scaleX 2
  ,   triangle 4
    |> outlined (solid 1) red
    |> rotate (degrees -150)
    |> scaleY 1.5
    |> move (0,6)
  ,   rect 8 22
    |> filled red
    |> move (0,35)

  ]
