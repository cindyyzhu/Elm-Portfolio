module WinterHolidayCodeFest.Constellation exposing (..)

-- 1. type your word in between the ""s
word = "constellation"

-- 2. draw your word using Shapes
myShapes t = 
  [
     square 100
    |> filled black
  ,circle 1
    |> filled white
    |> move (-23,30)
    ,circle 1
    |> filled white
    |> move (-30,15)
    ,circle 1
    |> filled white
    |> move (-5,25)
    ,circle 1
    |> filled white
    |> move (5,0)
    ,circle 1
    |> filled white
    |> move (2,-5)
    ,circle 1
    |> filled white
    |> move (0,-10)
    ,circle 1
    |> filled white
    |> move (35,-25)
    ,circle 1
    |> filled white
    |> move (15,-42)
    ,  rect 27 0.5
    |> filled white
    |> move (-12,5)
    |> rotate (degrees -68)
    ,  rect 20 0.5
    |> filled white
    |> move (-21,23)
    |> rotate (degrees -15)
    ,  rect 15 0.5
    |> filled white
    |> move (9,33.5)
    |> rotate (degrees 65)
       ,  rect 40 0.5
    |> filled white
    |> move (-13,-8)
    |> rotate (degrees -40)
       ,  rect 35 0.5
    |> filled white
    |> move (27,-4.5)
    |> rotate (degrees -64.5)
    ,  rect 39 0.5
    |> filled white
    |> move (24,3.5)
    |> rotate (degrees -40.5)
    ,  rect 27 0.5
    |> filled white
    |> move (-2,-42)
    |> rotate (degrees 40)
   ]

pair = (myShapes, word)

