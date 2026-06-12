module WinterHolidayCodeFest.Orange exposing (..)

-- 1. type your word in between the ""s
word = "orange"

-- 2. draw your word using Shapes
myShapes t = 
  [ circle 25
    |> filled orange
    |> rotate (degrees 30)
    
    , curve (30,0) [Pull (20,0) (30,-10)]
    |> filled green
    |> rotate (degrees 30)    
  ]
