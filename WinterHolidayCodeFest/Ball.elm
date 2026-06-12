module WinterHolidayCodeFest.Ball exposing (..)


-- 1. type your word in between the ""s
word = "ball"

-- 2. draw your word using Shapes
myShapes t = 
  [
     
      circle 1 
    |> filled red
    |> scale 13
    |> move (0,-12) 
    |> move (0,-35 + 16 * (1.6 + cos t))
   
   
  ]

