module WinterHolidayCodeFest.Moon exposing (..)

-- 1. type your word in between the ""s
word = "Moon"

-- 2. draw your word using Shapes
myShapes t = 
  [   square 100
    |> filled black
 ,
  circle 27
    |> filled (hsl (degrees 60) 0.699 0.852)
    |> move (0,5)
    |> makeTransparent 0.5
 ,
   circle 22
    |> filled gray
    |> move (0,5)
 ,
   circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (25,40)
 ,
    circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (0,if t < 1 then
                    10 * t
                  else
                   10 - 10 * t
             )
 ,
   circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (-40,40)
 ,
 circle 1
   |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (-35,20)
 ,
   circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (-35,if t < 1 then
                    10 * t
                  else
                   10 - 10 * t
             )
 ,
   circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (-25,-40)
 ,
   circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (-10,-30)
 ,
   circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (0,-40)
 ,
    circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (30,-40)
 ,
   circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (40, if t < 1 then
                    10 * t
                  else
                   10 - 10 * t
             )
 ,
  circle 1
    |> filled (hsl (degrees 60) 0.699 0.833)
    |> move (40,20)
 ,
   circle 1
    |> filled (hsl (degrees 60) 0.8 0.822)
    |> move (30,35)
  ]