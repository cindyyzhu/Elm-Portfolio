module WinterHolidayCodeFest.Sunset exposing (..)

-- 1. type your word in between the ""s
word = "Sunset"

-- 2. draw your word using Shapes
myShapes t = 
  [
    sun
      |> move (0,8)
      |> rotate (degrees -(tap t)),
   
    terrain
     |> move (0,-50),
    arrow
     |> move (-43,42)
  ]

tap t =
  let
    angle = 0 + 150 * sin (4*t)
  in
    if angle < 0 then
      0
    else
      angle + 5
        
terrain : Shape msg
terrain = 
  [
  wedge 60 0.5
    |> filled green
    |> rotate (degrees 90)
    |> makeTransparent 1
  ]
   |> group
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
arrow : Shape msg
arrow =
  [
   rect 5 15
    |> filled black
    |> rotate (degrees 0),
   triangle 7
    |> filled black
    |> rotate (degrees -90)
    |> move (0,-11)
  ]
    |> group
    
plotGraph : (Float -> Float) -> Float -> Shape a
plotGraph f time =
  group
    [ openPolygon (List.map (\ t -> (-96+(toFloat t)/2.5 - 200 * toFloat (floor (time / 10)),f (toFloat t / 50))) <| List.range (500 * floor (time / 10)) (500 * ceiling (time / 10))) |> outlined (solid 1) (rgb 0 0 200)
    , group [
              circle 3 |> filled red
            , text ("(" ++ String.fromFloat time ++ ", " ++ String.fromFloat (toFloat (round <| (f time) * 100) / 100)  ++ ")")
                |> size 6
                |> filled black
                |> move (5, 5)
            ]

        |> move (-96+20* time - 200 * toFloat (floor (time / 10)),f (time))
    ]