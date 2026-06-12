module WinterHolidayCodeFest.Snowman exposing (..)

-- 1. type your word in between the ""s
word = "Snowman"

-- 2. draw your word using Shapes
myShapes model = 
  [
       square 80
       |> filled black    
       , circle 18
    |> filled (hsl (degrees 181) 0.842 0.964)
    |> move (0,-13),
      circle 14
    |> filled hsl (degrees 181) 0.842 0.959)
    |> move (0,19),
         circle 3
    |> filled black
    |> move (-7,23),
      circle 3
    |> filled black
    |> move (7,23),
      polygon [(0,0),(0,-10),(30,0)]
    |> filled orange
    |> move (0,19),
      circle 3
    |> filled black
    |> move (0,-5),
      circle 3
    |> filled black
    |> move (0,-15)
   

  ]