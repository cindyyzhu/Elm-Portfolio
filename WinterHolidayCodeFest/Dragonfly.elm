module WinterHolidayCodeFest.Dragonfly exposing (..)

-- 1. type your word in between the ""s
word = "Dragonfly"

-- 2. draw your word using Shapes
myShapes t = 
  [
     dragonfly |> scale 1.5
  ]
pair = (word, myShapes)

dragonfly = group
  [
  curve (0,0) [Pull (2,-1) (2,2)]
  |> outlined (solid 0.5) (rgb 0 86 144)
  |> move (1.3,3.8)
  ,
  curve (0,0) [Pull (2,-2) (2,3)]
  |> outlined (solid 0.5) (rgb 0 86 144)
  |> move (0.8,6.5)
  ,
  curve (0,0) [Pull (2,-1) (2,2)]
  |> outlined (solid 0.5) (rgb 0 86 144)
  |> move (1.3,3.8)
  |> mirrorX
  ,
  curve (0,0) [Pull (2,-2) (2,3)]
  |> outlined (solid 0.5) (rgb 0 86 144)
  |> move (0.8,6.5)
  |> mirrorX
  ,
  oval 3.5 4
  |> filled (rgb 0 146 224)
  |> move (0,6.5)
  ,
  circle 2.4
  |> filled (rgb 0 126 204)
  |> move (0,10)
  ,
  oval 1.5 2.5
  |> filled black
  |> move (1.8,10.5)
  ,
  oval 1.5 2.5
  |> filled black
  |> move (-1.8,10.5)
  ,
  oval 4 18
  |> filled (rgb 0 126 204)
  |> move (0,-3)
  ,
  oval 26 5.5
  |> filled grey
  |> makeTransparent (0.85)
  |> rotate (degrees 10)
  |> move (12.5,7.5)
  ,
  oval 20 4
  |> filled grey
  |> makeTransparent (0.85)
  |> rotate (degrees -15)
  |> move (9.5,1.5)
  ,
  oval 26 5.5
  |> filled grey
  |> makeTransparent (0.8)
  |> rotate (degrees 10)
  |> move (12.5,7.5)
  |> mirrorX
  ,
  oval 20 4
  |> filled grey
  |> makeTransparent (0.8)
  |> rotate (degrees -15)
  |> move (9.5,1.5)
  |> mirrorX
  ]