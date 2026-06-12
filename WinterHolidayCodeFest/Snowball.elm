module WinterHolidayCodeFest.Snowball exposing (..)

-- 1. type your word in between the ""s
word = "Snowball"

-- 2. draw your word using Shapes
myShapes t = 
  [
      rect 100 100
    |> filled (hsl (degrees 244) 0.996 0.533),  
      circle 10
    |> filled white
    |> move (tan t*30,0),
      text "__"
    |> filled white
    |> move (tan t*30-30,5),
      text "___"
    |> filled white
    |> move (tan t*30-30,-3),
      text "____"
    |> filled white
    |> move (tan t*30-40,1),
      wedge 12 0.5
    |> filled white
    |> move (-51,40)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-53,50)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-54,30)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-51,10)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-53,20)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-54,0)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-51,-20)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-53,-10)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-54,-30)
    |> rotate (degrees 90),
          wedge 12 0.5
    |> filled white
    |> move (-51,-50)
    |> rotate (degrees 90),
      wedge 12 0.5
    |> filled white
    |> move (-53,-40)
    |> rotate (degrees 90),
      circle 1
    |> filled white
    |> move (0,tan -t*30),
        circle 1
    |> filled white
    |> move (40,tan -t*30-10),
      circle 1
    |> filled white
    |> move (-20,tan -t*30-30),
          circle 1
    |> filled white
    |> move (50,tan -t*30-50),
          circle 1
    |> filled white
    |> move (10,tan -t*30),
          circle 1
    |> filled white
    |> move (15,tan -t*30-30),
          circle 1
    |> filled white
    |> move (0,tan -t*30+70),
          circle 1
    |> filled white
    |> move (20,tan -t*30+75),
          circle 1
    |> filled white
    |> move (45,tan -t*30+50)

  ]

pair = (myShapes, word)

