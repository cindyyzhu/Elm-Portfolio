module WinterHolidayCodeFest.Penguin exposing (..)

-- 1. type your word in between the ""s
word = "penguin"

-- 2. draw your word using Shapes
myShapes t = 
  [
  circle 9
    |> filled black
    |> scale 1.5
    |> scaleY 2
    |> move (0,-4)
    ,
    circle 9
    |> filled black
    |> scaleX 2
    |> move (0,21)
    |> scaleY 2
    |> scale 0.75
    ,
   circle 9
    |> filled white
    |> scaleY 2
    |> move (0,-4)
    ,
    triangle 10
    |> filled orange
    |> scaleY 2
    |> rotate (degrees 270)
    |> scale 0.25
    |> move (0,25)
    ,
    circle 9
    |> filled white
    |> rotate (degrees 270)
    |> scale 0.25
    |> move (7,31)
    ,
    circle 9
    |> filled white
    |> rotate (degrees 270)
    |> scale 0.25
    |> move (-7,31)
    ,
    openPolygon [(0,0),(0,-10),(30,0)]
    |> filled black
    |> scale 0.75
    |> rotate (degrees 210)
    |> move (-8,5)
    ,
  openPolygon [(0,0),(0,-10),(30,0)]
    |> filled black
    |> scale 0.75
    |> rotate (degrees 350)
    |> move (9,12)
    ,
    circle 9
    |> filled orange
    |> scaleY 1.75
    |> scale 0.5
    |> rotate (degrees 445)
    |> move (10,-31)
    ,
    circle 9
    |> filled orange
    |> scaleY 1.75
    |> scale 0.5
    |> rotate (degrees 445)
    |> move (-12,-30)
  ]
