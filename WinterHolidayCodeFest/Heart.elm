module WinterHolidayCodeFest.Heart exposing (..)

-- 1. type your word in between the ""s
word = "Heart"

-- 2. draw your word using Shapes
myShapes t = 
  [
    heart
  ]
  
heart = group 
  [
       triangle 40
    |> filled red
    |> rotate (degrees 30)
    |> scaleY 0.7
    ,
      circle 20
    |> filled red
    |> rotate (degrees 30)
    |> move(17,24)
    ,
      circle 20
    |> filled red
    |> rotate (degrees 30)
    |> move(-17,24)
  ]

pair = (myShapes, word)

