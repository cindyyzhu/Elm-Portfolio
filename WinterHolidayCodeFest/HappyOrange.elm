module WinterHolidayCodeFest.HappyOrange exposing (..)


-- 1. type your word in between the ""s
word = "Orangee"

-- 2. draw your word using Shapes
myShapes t = 
  [
       circle 10
    |> filled orange
    |> scaleY 2
    |> scaleX 2
    ,    polygon [(0,0),(0,-10),(30,0)]
    |> filled green
    |> scaleY 2
    |> scaleX 2
    |> scale 0.5
    |> move (0,23)
    ,square 10
    |> filled (hsl (degrees 0) 0.626 0.28)
    |> scaleX -0.5
    |> move (0,20)
    ,  circle 2
    |> filled black
    |> move (15,0)
    ,circle 2
    |> filled black
    |> move (5,0)
    , circle 2
    |> filled red
    |> move (10,-7)
    ]

pair = (myShapes, word)

