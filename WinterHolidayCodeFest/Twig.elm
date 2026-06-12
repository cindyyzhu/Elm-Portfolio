module WinterHolidayCodeFest.Twig exposing (..)

-- 1. type your word in between the ""s
word = "twig"

-- 2. draw your word using Shapes
myShapes t = 
  [  roundedRect 10 20 5
    |> filled (hsl (degrees 0) 0.822 0.28)
    |> scaleX 0.4
    |> scaleY 2.25
    |> rotate (degrees -65)
     
  ]
