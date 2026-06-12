module WinterHolidayCodeFest.Boots exposing (..)

-- 1. type your word in between the ""s
word = "Boots"

-- 2. draw your word using Shapes
myShapes t = 
  [
   rect 18 38
    |> filled (hsl (degrees 25) 0.472 0.416)
    |> move (-15,0),
      rect 18 38
    |> filled (hsl (degrees 25) 0.472 0.416)
    |> move (15,0),
       roundedRect 28 12 6
    |> filled (hsl (degrees 25) 0.472 0.416)
    |> move (-20,-18),
      roundedRect 28 12 6
    |> filled (hsl (degrees 25) 0.472 0.416)
    |> move (20,-18)
  ]
