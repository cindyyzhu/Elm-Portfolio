module WinterHolidayCodeFest.Candle exposing (..)

-- 1. type your word in between the ""s
word = "candle"

-- 2. draw your word using Shapes
myShapes t =
  [
  candle
    |> move (-20,0)
    |> rotate (degrees(10+15 * sin (4*t))),
    
  candle
    |> move (20,0)
    |> rotate (degrees(10-15 * sin (4*t)))
  ]

candle : Shape msg
candle =
  [
    oval 24 12
    |> filled (hsl (degrees 48) 0.95 0.921)
    |> move (0, 22),
      rect 24 54
    |> filled (hsl (degrees 48) 0.95 0.921)
    |> move (0, -5),
    oval 24 12
    |> filled (hsl (degrees 48) 0.95 0.921)
    |> move (0, -32),
    oval 24 12
    |> outlined (solid 1) (hsl (degrees 37) 0.054 0.921)
    |> move (0, 22),
    rect 1 7
    |> filled (hsl (degrees 218) 0 0)
    |> move (0, 25),
      oval 4 10
    |> filled (hsl (degrees 37) 0.945 0.559)
    |> move (0,32)
  ]
    |> group