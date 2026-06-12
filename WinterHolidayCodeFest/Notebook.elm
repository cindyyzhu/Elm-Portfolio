module WinterHolidayCodeFest.Notebook exposing (..)

-- 1. type your word in between the ""s
word = "Notebook"

-- 2. draw your word using Shapes
myShapes t = 
  [
       rect 14 20
    |> filled (hsl (degrees 0) 0.896 0.53)
  ,   rect 8 3
    |> filled white
    |> move (0,5)
  , rect 8 7
    |> outlined (solid 0.25) black
    |> move( 0,-4)
  ,   rect 4 0.5
    |> filled black
    |> move (0,-5)
  ,   rect 4 0.5
    |> filled black
    |> move (0,-3)

  ]

pair = (myShapes, word)

