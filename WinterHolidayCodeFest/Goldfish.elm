module WinterHolidayCodeFest.Goldfish exposing (..)


-- 1. type your word in between the ""s
word = "goldfish"

-- 2. draw your word using Shapes
myShapes t = 
 [  
       rect 100 100
    |> filled blue
    |> makeTransparent 1,
  goldfish
  |> move (0,0 + 7 *sin t)
  ]
goldfish : Shape msg
goldfish = 
    [
       wedge 18 0.97
    |> filled orange
    |> move (-5,0),
      triangle 20
    |> filled orange
    |> rotate (degrees 60)
    |> move (18,0),
      circle 2.5
    |> filled black
    |> move (-12,8),
      circle 0.9
    |> filled white
    |> move (-12,8),
      triangle 5
    |> filled orange
    |> move (-4,-1)
    ]
    |> group

pair = (myShapes, word)

