module WinterHolidayCodeFest.Penguiny exposing (..)

-- 1. type your word in between the ""s
word = "Penguiny"

-- 2. draw your word using Shapes
myShapes t = 
  [
     penguin
     |> move (10, -5)
  ]

penguin = group [
 oval 8 10
  |> filled yellow
  |> addOutline (solid 0.5) black
  |> rotate (degrees 90)
  |> move (-20, -15)
  
  , oval 8 10
  |> filled yellow
  |> addOutline (solid 0.5) black
  |> rotate (degrees 90)
  |> move (-1, -15)
  
  , triangle 10
  |> filled (rgb 119 120 119)
  |> addOutline (solid 0.5) black
  |> rotate (degrees -45)
  |> move (-30, 5)
  
  , triangle 10
  |> filled (rgb 119 120 119)
  |> addOutline (solid 0.5) black
  |> rotate (degrees 100)
  |> move (10, 5)
  
  , roundedRect 40 50 20
  |> filled (rgb 119 120 119)
  |> addOutline (solid 1) black
  |> move (-10, 10)
  
  , roundedRect 30 33 20
  |> filled white
  |> move (-10, 5)
  
  , circle 3
  |> filled white
  |> addOutline (solid 0.5) black
  |> move (-18, 25)
  
  , circle 3
  |> filled white
  |> addOutline (solid 0.5) black
  |> move (-3, 25)
  
  , circle 1
  |> filled black
  |> move (-18, 25)
  
  , circle 1
  |> filled black
  |> move (-3, 25)
  
  , triangle 5
  |> filled yellow
  |> rotate (degrees 30)
  |> move (-10, 18)
  ]