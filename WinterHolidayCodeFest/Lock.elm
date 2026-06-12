module WinterHolidayCodeFest.Lock exposing (..)

-- 1. type your word in between the ""s
word = "lock"

-- 2. draw your word using Shapes
myShapes t = 

  [
      lockhead
    |> move (0,5 + 5* cos t)
    
    ,
      lockbody
      
      
  
 
  ]


lockhead : Shape userMsg
lockhead = group
    [
             roundedRect 16 21 5
    |> filled (hsl (degrees 0) 0.004 0.72)
    |> move (0,10)
    
    ,
    
      roundedRect 12 22 3
    |> filled (rgb 255 255 255)
    |> move (0,7)
    
    ,
    
      roundedRect 2 16 1
    |> filled (hsl (degrees 0) 0.004 0.72)
    |> move (-7,0)
    ]
    
lockbody = group
    
    [
    -- lock body
        circle 10
    |> filled (hsl (degrees 0) 0.004 0.488)
    
    ,
    
      circle 8
    |> filled (hsl (degrees 48) 0.988 0.465)
    
   ,
   
     circle 3
    |> filled (hsl (degrees 48) 0.05 0.01)
    |> move (0,2)
    ,
    
      ngon 3 4
    |> filled (hsl (degrees 48) 0.05 0.01)
    |> rotate (degrees -30)
    |> move (0,-1)
    ]
