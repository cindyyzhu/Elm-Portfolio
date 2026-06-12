module WinterHolidayCodeFest.Down exposing (..)

-- 1. type your word in between the ""s
word = "Down"

-- 2. draw your word using Shapes
myShapes t = 
 
   [
       rect 6 57
    |> filled black
    |> scale 1
    |> move (0,15) 
    |> move (0,-35 + 16 * (1.5998 + sin t))
      , triangle 10
    |> filled black
    |> scale 1
    |> rotate (degrees 150)
    |> move (0,-10)
    |> move (0,-35 + 16 * (1.5998 + sin t))
  ]
