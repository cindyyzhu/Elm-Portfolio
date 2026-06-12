module WinterHolidayCodeFest.FlickeringCandle exposing (..)


-- 1. type your word in between the "candle"s
word = "candle"

-- 2. draw your word using Shapes
myShapes t = 
  [
  -- By WisePistachio
    rect 133 100 -- Gray Wall Background
    |> filled gray
    |> scaleX 0.75
    |> rotate (degrees 0)
  , rect 100 16 -- Table
    |> filled (hsl (degrees 356) 0.962 0.258)
    |> move (0,-42)
  , roundedRect 0.5 60 5 -- Lines on table
    |> filled white
    |> makeTransparent 0.625
    |> rotate (degrees 90)
    |> scaleX 0.75
    |> move (-30, -40)
  , roundedRect 0.5 60 5 -- Lines on table
    |> filled white
    |> makeTransparent 0.625
    |> rotate (degrees 90)
    |> scaleX 0.75
    |> move (-20, -47)
  , roundedRect 0.5 85 5 -- Lines on table
    |> filled white
    |> makeTransparent 0.625
    |> rotate (degrees 90)
    |> scaleX 0.75
    |> move (-7, -43.5)
  , roundedRect 0.5 60 5 -- Lines on table
    |> filled white
    |> makeTransparent 0.625
    |> rotate (degrees 90)
    |> scaleX 0.75
    |> move (20, -37)
  , roundedRect 0.5 35 5 -- Lines on table
    |> filled white
    |> makeTransparent 0.625
    |> rotate (degrees 90)
    |> scaleX 0.75
    |> move (-30, -36)
  , roundedRect 0.5 60 5 -- Lines on table
    |> filled white
    |> makeTransparent 0.625
    |> rotate (degrees 90)
    |> scaleX 0.75
    |> move (30, -47)
  , roundedRect 0.5 80 5 -- Lines on table
    |> filled white
    |> makeTransparent 0.625
    |> rotate (degrees 90)
    |> scaleX 0.75
    |> move (28, -40)
  ,  roundedRect 12 50 4 -- Candlestick
    |> filled (hsl (degrees 61) 0.817 0.838)
    |> move (0,-13)
  ,   oval 8.3 12 -- Candle Rim
    |> outlined (solid 0.35) (hsl (degrees 57) 0.626 0.754)
    |> scaleX 0.75
    |> rotate (degrees 90)
    |> move (0, 8.7)
  ,   rect 1 5 -- Candlewick
    |> filled (hsl (degrees 356) 0.962 0.258)
    |> move (0,12)
  ,   oval 6 12 -- Flame
    |> filled orange
    |> makeTransparent (0.85 + 0.4 * sin(10.8 *t))
    |> move (0, 18)
  , polygon [(0,0),(0,-12),(50,0)] -- Flame
    |> filled orange
    |> makeTransparent (0.85 + 0.7 * sin(11*t))
    |> rotate (degrees 90)
    |> scaleY 0.25
    |> scaleX 0.2
    |> move (0, 15)
  ,   polygon [(0,0),(0,-10),(50,0)] -- Flame
    |> filled orange
    |> makeTransparent (0.85 + 0.7 * sin(11 *t))
    |> rotate (degrees 90)
    |> scaleY 0.25
    |> scaleX -0.25
    |> move(0, 15)
  ]

pair = (myShapes, word)

