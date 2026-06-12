module WinterHolidayCodeFest.Rainbow exposing (..)

-- 1. type your word in between the ""s
word = "rainbow"

-- 2. draw your word using Shapes
myShapes t = 
  [
       wedge 45 0.5
    |> filled red
    |> rotate (degrees 90)
    |> move (0,-15)
   ,   wedge 45 0.5
    |> filled orange
    |> rotate (degrees 90)
    |> move (0,-16.75)
    |> scale (0.9)
   ,   wedge 45 0.5
    |> filled yellow
    |> rotate (degrees 90)
    |> move (0,-19)
    |> scale 0.8
  ,   wedge 45 0.5
    |> filled green
    |> rotate (degrees 90)
    |> move (0,-21.75)
    |> scale 0.7
  ,    wedge 45 0.5
    |> filled blue
    |> rotate (degrees 90)
    |> move (0,-25.5)
    |> scale 0.6
  ,    wedge 45 0.5
    |> filled purple
    |> rotate (degrees 90)
    |> move (0,-30.5)
    |> scale 0.5
  ,  wedge 45 0.5
    |> filled white
    |> rotate (degrees 90)
    |> move (0,-38.5)
    |> scale 0.4
  ]

