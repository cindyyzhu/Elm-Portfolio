module WinterHolidayCodeFest.Light exposing (..)

-- 1. type your word in between the ""s
word = "Light"

-- 2. draw your word using Shapes
myShapes t = 
  [
    circle 14
    |> filled (hsl (degrees 56) 0.988 0.618)
    |> move (0, 15),
      roundedRect 10 12 4
    |> filled (hsl (degrees 56) 0.027 0.872)
    |> move (0,-8),
    roundedRect 12 20 4
    |> filled (hsl (degrees 56) 0.988 0.618)
    |> move (0, 2.5),
    polygon [(5,-11.5),(-5,-11.5),(0,-17)]
    |> filled (hsl (degrees 56) 0.027 0.872),
    rect 10 6
    |> filled white
    |> move (0, -18),
    roundedRect 2 22 1
    |> outlined (solid 1) white
    |> move (2, 4),
    roundedRect 2 22 1
    |> outlined (solid 1) white
    |> move (-2, 4),
    roundedRect 12 3 3
    |> outlined (solid 1) white
    |> move (0, 14)
  ]
