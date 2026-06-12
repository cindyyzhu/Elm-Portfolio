module WinterHolidayCodeFest.Butterfly exposing (..)

-- 1. type your word in between the ""s
word = "Butterfly"

-- 2. draw your word using Shapes
myShapes t = 
  [
     butterfly |> scale 1.3
  ]
pair = (word, myShapes)

butterfly = group 
  [
  oval 15 30
  |> filled (rgb 230 125 50)
  |> rotate (degrees 30)
  |> move (-10, 7)
  ,
  oval 15 30
  |> filled (rgb 230 125 50)
  |> rotate (degrees -30)
  |> move (10, 7)
  ,
  oval 10 20
  |> filled (rgb 230 125 50)
  |> rotate (degrees 120)
  |> move (-7, -7)
  ,
  oval 10 20
  |> filled (rgb 230 125 50)
  |> rotate (degrees -120)
  |> move (7, -7)
  ,
  roundedRect 5 25 3
  |> filled darkBrown
  ,
  rect 1 15
  |> filled darkBrown
  |> rotate (degrees 20)
  |> move (-3,15)
  ,
  rect 1 15
  |> filled darkBrown
  |> rotate (degrees -20)
  |> move (3,15)
  ,
  circle 2
  |> filled darkBrown
  |> move (-5,22)
  ,
  circle 2
  |> filled darkBrown
  |> move (5,22)
  ,
  circle 0.5
  |> filled black
  |> move (-1,10)
  ,
  circle 0.5
  |> filled black
  |> move (1,10)
  ,
  rect 5 1
  |> filled black
  |> move (0,5)
  ,
  rect 5 1
  |> filled black
  |> move (0,2.5)
  ,
  rect 5 1
  |> filled black
  ,
  rect 5 1
  |> filled black
  |> move (0,-5)
  ,
  rect 5 1
  |> filled black
  |> move (0,-2.5)
  ]