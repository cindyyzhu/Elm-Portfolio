module WinterHolidayCodeFest.Watermelon exposing (..)

-- 1. type your word in between the ""s
word = "watermelon"

-- 2. draw your word using Shapes
myShapes t = 
  [
    triangle 31
    |> filled red
    |> rotate (degrees 90)
    |> makeTransparent 1,    curve (0,0) [Pull (10,0) (20,-10)]
    |> filled green
    |> makeTransparent 1
    |> scaleX 3
    |> move (-28,20)
    |> rotate (degrees 190),    
      oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> move (7,-3)
    |> scaleY -0.25
    |> scaleX 0.5,
      oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (4,8),
      oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (-10,8),
      oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (-6,5),
      oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (-6,5),
      oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (11,-8),
        oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (-2,-8),
        oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (-18,-8),
      oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (-13,1),
      oval 9 14
    |> filled black
    |> rotate (degrees 180)
    |> scaleY -0.25
    |> scaleX 0.5
    |> move (0,21)
  ]
