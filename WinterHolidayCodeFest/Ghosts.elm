module WinterHolidayCodeFest.Ghosts exposing (..)

-- 1. type your word in between the ""s
word = "Ghosts"

-- 2. draw your word using Shapes
myShapes t = 
  [
    ghost
       |> scale 0.75
       |> move (-18, 10 / sin t)
     |> makeTransparent 0.5
  , ghost
       |> scale 0.75
       |> scaleX -1
       |> move (18, -10 / sin t)
     |> makeTransparent 0.5
  ]    

ghost : Shape msg
ghost = [
      wedge 30 (1/2) 
        |> filled red |> rotate (degrees 90) 
      , rect 60 30 
        |> filled red |> move (0,-15)
      , oval 10 15 
        |> filled white 
        |> addOutline (solid 1) black
        |> move (-10,10)
      , oval 10 15 
        |> filled white 
        |> addOutline (solid 1) black
        |> move (10,10)
      , circle 2 |> filled black |> move (-10, 8) 
      , circle 2 |> filled black |> move (10, 8)
      , curve (0,0) [Pull (5,-20) (15,0)]
        |> filled red |> move (-30,-30)
      , curve (0,0) [Pull (5,-20) (15,0)]
        |> filled red |> move (-15,-30)
      , curve (0,0) [Pull (5,-20) (15,0)]
        |> filled red |> move (0,-30)
      , curve (0,0) [Pull (5,-20) (15,0)]
        |> filled red |> move (15,-30)          
  ]
      |> group

pair = (myShapes, word)

