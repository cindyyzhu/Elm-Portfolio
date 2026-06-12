module WinterHolidayCodeFest.Fairytale exposing (..)

-- 1. type your word in between the ""s
word = "book"

-- 2. draw your word using Shapes
myShapes t = 
  [
  rect 10 20
    |> filled (hsl (degrees 346) 0.773 0.286)
    |> scaleY 1.25
    |> scaleX 1.75
    |> scale 3.25,
    
      text "Rapunzel"
    |> filled (hsl (degrees 346) 1 1)
    |> scale 1
    |> move (-22,20),
    
    rect 10 20
    |> filled gray
    |> scale 1.25
    |> scaleY 1.75
    |> scaleX 3.75
    |> move (0,-14)
  ]

pair = (myShapes, word)

