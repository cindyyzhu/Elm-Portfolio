module WinterHolidayCodeFest.Volleyball exposing (..)

-- 1. type your word in between the ""s
word = "volleyball"

-- 2. draw your word using Shapes
myShapes t = 
  [   volleyball t
 |> rotate(5*(-t))]
volleyball t=group[   circle 10
    |> filled yellow
    
    ,    curve (0,0) [Pull (10,0) (20,-10)]
    |> outlined (solid 0.5) black
    |> rotate (degrees -60)
    |> move (6,11)
    |> scaleY 0.5
    
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> outlined (solid 0.5) black
    |> rotate (degrees 120)
    |> scaleY 0.5
    |> move (-6,-6)
    ,  rect 1 13
    |> filled black
    |> rotate (degrees 90)
    |> move (0,5)
    , rect 1 13
    |> filled black
    |> rotate (degrees 90)
    |> move (0,-6)
    ,    curve (0,0) [Pull (10,0) (20,-10)]
    |> outlined (solid 0.75) black
    |> rotate (degrees 25)
    |> scaleY 0.75
    |> scaleX 0.75
    |> move (-8,1)
      ,curve (0,0) [Pull (10,0) (20,-10)]
    |> outlined (solid 0.75) black
    |> scaleY 0.75
    |> scaleX 0.75
    |> rotate (degrees -150)
    |> move (8,-1)
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> outlined (solid 0.75) black
    |> rotate (degrees -70)
    |> scale 0.5
    |> scaleY 0.4
    |> scaleX 0.75
    |> move (4,9)
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> outlined (solid 0.75) black
    |> scaleY 0.5
    |> scale 0.5
    |> scaleX 0.5
    |> rotate (degrees 105)
    |> move (-5,4)
    ,    curve (0,0) [Pull (10,0) (20,-10)]
    |> outlined (solid 0.5) black
    |> scaleX 0.25
    |> scaleY 0.5
    |> rotate (degrees 165)
    |> move (-3,-9)
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> outlined (solid 0.5) black
    |> scaleX 0.25
    |> scaleY 0.5
    |> rotate (degrees -30)
    |> scale 0.75
    |> move (5,-4)
  ]

pair = (myShapes, word)

