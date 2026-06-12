module WinterHolidayCodeFest.Carrot exposing (..)

-- 1. type your word in between the ""s
word = "Carrot"

-- 2. draw your word using Shapes
myShapes t = 
  [
    triangle 10
      |> filled (hsl (degrees 39) 0.996 0.566)
      |> scaleX 3.5
      |> rotate (degrees -90)
      |> move (0,0)
   , wedge 10 0.75
    |> filled (hsl (degrees 121) 0.996 0.566)
    |> rotate (degrees -90)
    |> move (30,70)
    |> scaleY 0.25
    |> scaleX 0.25
       , wedge 10 0.75
    |> filled (hsl (degrees 121) 0.996 0.566)
    |> rotate (degrees -90)
    |> move (20,70)
    |> scaleY 0.25
    |> scaleX 0.25
       , wedge 10 0.75
    |> filled (hsl (degrees 121) 0.996 0.566)
    |> rotate (degrees -90)
    |> move (10,70)
    |> scaleY 0.25
    |> scaleX 0.25
   , wedge 10 0.75
    |> filled (hsl (degrees 121) 0.996 0.566)
    |> rotate (degrees -90)
    |> move (0,70)
    |> scaleY 0.25
    |> scaleX 0.25
       , wedge 10 0.75
    |> filled (hsl (degrees 121) 0.996 0.566)
    |> rotate (degrees -90)
    |> move (-10,70)
    |> scaleY 0.25
    |> scaleX 0.25
       , wedge 10 0.75
    |> filled (hsl (degrees 121) 0.996 0.566)
    |> rotate (degrees -90)
    |> move (-20,70)
    |> scaleY 0.25
    |> scaleX 0.25
   , wedge 10 0.75
    |> filled (hsl (degrees 121) 0.996 0.566)
    |> rotate (degrees -90)
    |> move (-30,70)
    |> scaleY 0.25
    |> scaleX 0.25
    ,   curve (0,0) [Pull (10,0) (20,-10)]
    |> filled (hsl (degrees 36) 0.978 0.458)
    |> scaleY -0.25
    |> rotate (degrees -5)
    |> scaleX 0.5
  ]

pair = (myShapes, word)

