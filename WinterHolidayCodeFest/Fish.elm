module WinterHolidayCodeFest.Fish exposing (..)

-- 1. type your word in between the ""s
word = "fish"

-- 2. draw your word using Shapes
myShapes t = 
  [ square 156
    |> filled blue
    , circle 10
    |> filled black
    |> rotate (degrees 90)
    |> move (-48,15)
    |> scale 0.5
    ,   triangle 6
    |> filled orange
    
    |> rotate (degrees 180)
    |> scaleY 2
    |> scale 2
    |> move (30,0)
    , oval 20 40
    |> filled yellow
    
    |> rotate (degrees 90)
    |> scaleX 1.5
    ,   circle 10
    |> filled black
    |> rotate (degrees 90)
    |> scale 0.5
    |> move (-20,8)
     ,  circle 10
    |> filled white
    |> rotate (degrees 90)
    |> scale 0.25
    |> move (-21,8)
    ,  triangle 6
    |> filled orange
    |> scaleX 2
    |> rotate (degrees 180)
    
  ]
