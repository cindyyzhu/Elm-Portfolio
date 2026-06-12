module WinterHolidayCodeFest.Anger exposing (..)

-- 1. type your word in between the ""s
word = "anger"

-- 2. draw your word using Shapes
myShapes t = 
  [  circle 40
    |> filled red
      , polygon [(-10,-20),(-20,-15),(0,0)]
    |> filled gray
    ,  steam t |> move (0,3*cos t)
    , polygon [(10,-20),(20,-15),(0,0)]
    |> filled gray
      , curve (-30,10) [Pull (-30,-10) (-5,5)]
    |> filled gray
     , curve (30,10) [Pull (30,-10) (5,5)]
    |> filled grey
    , curve (-20,-30) [Pull (0,-10) (20,-30)]
    |> outlined (solid 1.25) grey] 
steam t = group
    [
     circle 5
    |> filled gray
    |> move (-10,-20)
     ,  circle 5
    |> filled gray
    |> move (-15,-20)
     ,  circle 5
    |> filled gray
    |> move (-10,-15)
    ,       circle 5
    |> filled gray
    |> move (-20,-15)
     , circle 5
    |> filled gray
    |> move (10,-20)
     ,  circle 5
    |> filled gray
    |> move (15,-20)
     ,  circle 5
    |> filled gray
    |> move (10,-15)
    ,       circle 5
    |> filled gray
    |> move (20,-15)
    ]
    
