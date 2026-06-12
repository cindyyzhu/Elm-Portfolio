module WinterHolidayCodeFest.Gift exposing (..)

-- 1. type your word in between the ""s
word = "gift"

-- 2. draw your word using Shapes
myShapes t = 
  [
      square 40
    |> filled red
    ,
       rect 5 40
    |> filled blue
    ,
      rect 5 40
    |> filled blue
    |> rotate (degrees 90)
    ,
      rect 10 44
    |> filled red
    |> rotate (degrees 90)
    |> move (0, 15)
    ,
      roundedRect 12 15 6
    |> filled blue
    |> rotate (degrees 90)
    |> move (0, 20)
    ,
      oval 12 22
    |> filled blue
    |> rotate (degrees 90)
    |> move (10, 23)
    ,
     oval 12 22
    |> filled blue
    |> rotate (degrees 90)
    |> move (-11, 23)
    ,
      rect 6 24
    |> filled blue
    |> rotate (degrees 15)
    |> move (5, 8)
    ,
       rect 6 24
    |> filled blue
    |> rotate (degrees 160)
    |> move (-6, 8)
  ]

pair = (myShapes, word)

