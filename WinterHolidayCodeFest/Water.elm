module WinterHolidayCodeFest.Water exposing (..)

-- 1. type your word in between the ""s
word = "Water"

-- 2. draw your word using Shapes
myShapes t = 
  [
     water |> scale 2
  ]

water = group 
  [
    circle 10
    |> filled (rgb 0 200 255)
    ,circle 10
    |> outlined (solid 1) black
    ,triangle 10
    |> filled (rgb 0 200 255)
    |> move(10, 0)
    |> rotate(degrees 90)
    ,triangle 10
    |> outlined (solid 1) black
    |> move(10, 0)
    |> rotate(degrees 90)
    ,circle 9.5
    |> filled (rgb 0 200 255)
  ]