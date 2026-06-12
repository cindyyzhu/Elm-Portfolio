module WinterHolidayCodeFest.Thermometer exposing (..)

-- 1. type your word in between the ""s
word = "Thermometer"

-- 2. draw your word using Shapes
myShapes t = 
  [
     thermometer |> scale 1.5
  ]

thermometer = group
  [
    circle 10
    |> outlined (solid 1) black
    |> move (0,-20)
    ,roundedRect 8 36 5
    |> outlined (solid 1) black
    ,rect 7 30
    |> filled (rgb 255 0 0)
    |> move (0,-10)
    ,circle 9.5
    |> filled (rgb 255 0 0)
    |> move (0,-20)
    ,rect 7.5 0.5
    |> outlined (solid 1) black
    |> move (0,5)
  ]

pair = (myShapes, word)

