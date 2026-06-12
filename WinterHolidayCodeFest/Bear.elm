module WinterHolidayCodeFest.Bear exposing (..)

-- 1. type your word in between the ""s
word = "bear"

-- 2. draw your word using Shapes
myShapes t = 
  [    
    square 75
    |> filled (hsl (degrees 105) 0.714 0.841)
    ,
    roundedRect 38 26 20
    |> filled (rgb 108 66 34)
    ,
    circle 10
    |> filled (rgb 108 66 34)
    |> move (10, 12)
    ,
    circle 10
    |> filled (rgb 108 66 34)
    |> move (-10, 12)
    ,
      roundedRect 43 44 20
    |> filled (rgb 108 66 34)
    |> move (2, -20)
    ,
    roundedRect 18 17 20
    |> filled (rgb 142 113 34)
    |> move (-10, -30)
    ,
     roundedRect 18 17 20
    |> filled (rgb 142 113 34)
    |> move (10, -30)
    ,
     roundedRect 7 6 20
    |> filled (rgb 147 222 73)
    |> move (6, 2)
    ,
    roundedRect 7 6 20
    |> filled (rgb 147 222 73)
    |> move (-8, 2)
    ,
      oval 12 10
    |> filled (hsl (degrees 10) 0.308 0.649)
    |> move (-1, 1)
    ,
      circle 3
    |> filled (hsl (degrees 344) 0.608 0.955)
    |> move (10, -35)
    ,
    circle 3
    |> filled (hsl (degrees 344) 0.608 0.955)
    |> move (-10, -35)
    ,
      circle 2
    |> filled (hsl (degrees 344) 0.608 0.955)
    |> move (-10, -25)
    ,
    circle 2
    |> filled (hsl (degrees 344) 0.608 0.955)
    |> move (10, -25)
    ,
     circle 2
    |> filled (hsl (degrees 344) 0.608 0.955)
    |> move (5, -28)
      
  
    
  ]
