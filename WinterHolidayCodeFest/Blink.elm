module WinterHolidayCodeFest.Blink exposing (..)

-- 1. type your word in between the ""s
word = "blink"

-- 2. draw your word using Shapes
myShapes t = 
  [
      happy
      , blink
      |> move (0,-4.5 + 5 * sin t)

  ]
happy : Shape msg
happy = 
    [
    circle 27
    |> filled yellow
    ,  wedge 7 0.5
    |> filled white
    |> rotate (degrees 90)
    |> move (-12,5)
        ,  wedge 7 0.5
    |> filled white
    |> rotate (degrees 90)
    |> move (12,5)
    ,  curve (-15,-10) [Pull (0,-30) (15,-10)]
    |> filled (hsl (degrees 324) 0.85 0.708)
    ,  oval 4 7
    |> filled black
    |> move (-12,8.5)
        ,  oval 4 7
    |> filled black
    |> move (12,8.5)
    ]
    |> group
blink : Shape msg
blink = 
  [
    wedge 8 0.5
    |> filled yellow
    |> rotate (degrees 90)
    |> move (-12,14)
          ,  wedge 8 0.5
    |> filled yellow
    |> rotate (degrees 90)
    |> move (12,14)
    ]
    |> group


 