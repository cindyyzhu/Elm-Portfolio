module WinterHolidayCodeFest.Zebra exposing (..)

-- 1. type your word in between the ""s
word = "zebra"

-- 2. draw your word using Shapes
myShapes t = 
  [
  zebra
    |> move (-20,0)
    |> rotate (degrees(15 - 15 * sin (4*t))),
    
  zebra
    |> move (20,0)
    |> rotate (degrees(15 - 15 * sin (4*t)))
  ]

zebra : Shape msg
zebra =  
  [
     oval 26 35
    |> outlined (solid 1) black
    |> move (0, 5),
    
      oval 25 19
    |> filled black
    |> move (0,-7),
    
      oval 3 7
    |> filled black
    |> move (5, 12),
      oval 3 7
    |> filled black
    |> move (-5, 12),
    
      circle 1
    |> filled white
    |> move (5, -12),
      circle 1
    |> filled white
    |> move (-5, -12),
    
      wedge 8 0.25
    |> filled black
    |> move (6, 20),
      wedge 8 0.25
    |> filled black
    |> mirrorX
    |> move (-6, 20),
    
      wedge 8 0.05
    |> filled black
    |> rotate (170)
    |> move (5, 6),
      wedge 8 0.05
    |> filled black
    |> mirrorX
    |> rotate (50)
    |> move (-5, 6),
       wedge 8 0.05
    |> filled black
    |> move (5, 3),
      wedge 8 0.05
    |> filled black
    |> mirrorX
    |> move (-5, 3),
    
      rect 4 9
    |> filled black
    |> move (0, 27)
  ]
    |> group
