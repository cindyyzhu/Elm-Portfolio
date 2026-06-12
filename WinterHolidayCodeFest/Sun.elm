module WinterHolidayCodeFest.Sun exposing (..)
-- 1. type your word in between the ""s
word = "Sun"

-- 2. draw your word using Shapes
myShapes t = 
  [
    sun
      |> move (0,0)
      |> rotate (degrees -(tap t))
  ]
 
 
tap t =
  let
    angle = 18.5 + 18.5 * sin (4*t)
  in
    if angle < 0 then
      0
    else
      angle
      
sun : Shape msg
sun =
  [
   circle 15.5
     |> filled (hsl (degrees 30) 1 0.535),
   oval 30 30
     |> filled (rgb 255 255 92),     
   rect 4 18
     |> filled (rgb 255 255 92)
     |> rotate (degrees 90)
     |> move (26,0),   
   rect 4 18
     |> filled (rgb 255 255 92)
     |> rotate (degrees 180)
     |> move (0,26),   
   rect 4 18
     |> filled (rgb 255 255 92)
     |> rotate (degrees 90)
     |> move (-26,0),   
   rect 4 18
     |> filled (rgb 255 255 92)
     |> rotate (degrees 180)
     |> move (0,-26),  
   rect 4 18
     |> filled (rgb 255 255 92)
     |> rotate (degrees 45)
     |> move (19,-19),  
   rect 4 18
     |> filled (rgb 255 255 92)
     |> rotate (degrees 45)
     |> move (-19,19), 
   rect 4 18
     |> filled (rgb 255 255 92)
     |> rotate (degrees -45)
     |> move (-19,-19),
   rect 4 18
     |> filled (rgb 255 255 92)
     |> rotate (degrees -45)
     |> move (19,19),
   rect 4 18
     |> filled (hsl (degrees 30) 1 0.535)
     |> rotate (degrees 22.5)
     |> move (-10,24),
   rect 4 18
     |> filled (hsl (degrees 30) 1 0.535)
     |> rotate (degrees 22.5)
     |> move (10,-24),
   rect 4 18
     |> filled (hsl (degrees 30) 1 0.535)
     |> rotate (degrees -22.5)
     |> move (10,24),
   rect 4 18
     |> filled (hsl (degrees 30) 1 0.535)
     |> rotate (degrees -22.5)
     |> move (-10,-24),
   rect 4 18
     |> filled (hsl (degrees 30) 1 0.535)
     |> rotate (degrees 112.5)
     |> move (25,11),
   rect 4 18
     |> filled (hsl (degrees 30) 1 0.535)
     |> rotate (degrees 112.5)
     |> move (-25,-11),
   rect 4 18
     |> filled (hsl (degrees 30) 1 0.535)
     |> rotate (degrees -112.5)
     |> move (-25,11),
   rect 4 18
     |> filled (hsl (degrees 30) 1 0.535)
     |> rotate (degrees -112.5)
     |> move (25,-11)
   ]
    |> group