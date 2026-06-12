module WinterHolidayCodeFest.Toothbrush exposing (..)

-- 1. type your word in between the ""s
word = "toothbrush"

-- 2. draw your word using Shapes
myShapes t = 
  [
  rect 7 15
    |> outlined (solid 0.5) black 
    |> move (5,23.5)
  , rect 4 63
      |> filled blue
  , rect 4 0.25
      |> filled black
      |> move (6.5,30)
  , rect 4 0.25
      |> filled black
      |> move (6.5,29)
  , rect 4 0.25
      |> filled black
      |> move (6.5,28)
  , rect 4 0.25
      |> filled black
      |> move (6.5,27)
  , rect 4 0.25
      |> filled black
      |> move (6.5,26)
  , rect 4 0.25
      |> filled black
      |> move (6.5,25)
  , rect 4 0.25
      |> filled black
      |> move (6.5,24)
  , rect 4 0.25
      |> filled black
      |> move (6.5,23)
  , rect 4 0.25
      |> filled black
      |> move (6.5,22)
  , rect 4 0.25
      |> filled black
      |> move (6.5,21)
  , rect 4 0.25
      |> filled black
      |> move (6.5,20)
  , rect 4 0.25
      |> filled black
      |> move (6.5,19)
  , rect 4 0.25
      |> filled black
      |> move (6.5,18)
  , rect 4 0.25
      |> filled black
      |> move (6.5,17)
  , rect 4 0.25
      |> filled black
      |> move (6.5,16)
  ]
