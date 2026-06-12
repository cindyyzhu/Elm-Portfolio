module WinterHolidayCodeFest.Ostrich exposing (..)

-- 1. type your word in between the ""s
word = "ostrich"

-- 2. draw your word using Shapes
myShapes t = 
  [ 
     bodyNeck
     ,
     theHead
  ]
theHead = group
 [ 
 circle 10
    |> filled (hsl (degrees 0) 0.765 0.887)
    |> move (-2,2)

     ,
     circle 5
    |> filled white
    |> move (-3,4)
      ,
      circle 2
    |> filled black
    |> move (-4,6)
    ,
      triangle 4
    |> filled (hsl (degrees 50) 0.933 0.67)
    |> scaleX 2
    |> rotate (degrees -180)
    |> move (-13,2)
    ]
bodyNeck = group [
 rect 7 20
   |> filled (hsl (degrees 0) 0.765 0.887)
   |> move (1,-15)
   ]
 
    
    
    
    