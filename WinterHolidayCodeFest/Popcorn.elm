module WinterHolidayCodeFest.Popcorn exposing (..)


-- 1. type your word in between the ""s
word = "popcorn"

-- 2. draw your word using Shapes
myShapes t = 
  [ 
   square 100
    |> filled black
  ,
  rect 36 48
    |> filled red
    |> move (-3,-10)
 ,
   rect 7 49
    |> filled white
    |> move (-5,-10)
 ,
  rect 10 49
    |> filled white
    |> move (-18,-10)
 ,
   rect 9 49
    |> filled white
    |> move (11,-10)
 ,
   circle 7
    |> filled (hsl (degrees 57) 0.817 0.684)
    |> move (0,26)
 ,
   circle 7
    |> filled (hsl (degrees 57) 0.725 0.891)
    |> move (10,21)
 ,
  circle 7
    |> filled (rgb 249 242 206)
    |> move (-3,18)
 ,
  circle 7
    |> filled (rgb 249 242 170)
    |> move (-16,18)
 ,
   circle 7
    |> filled white
    |> move (-11,18)
 ,
   circle 7
  |> filled (hsl (degrees 57) 0.759 0.759)
    |> move (7,18)
 ,
   circle 4
    |> filled (hsl (degrees 57) 0.759 0.759)
    |> move (8,18)
  ,
    circle 5
     |> filled (hsl (degrees 42) 0.552 0.931)
    |> move (15,17)
  ,
    circle 5
    |> filled (hsl (degrees 58) 0.984 0.707)
    |> move (13,28)
    |> rotate (degrees 5)
 ,
   circle 6
    |> filled white
    |> move (-17,25)
 ,
   circle 6
    |> filled (hsl (degrees 58) 0.909 0.615)
    |> move (-10, if t < 10 then
                   15 * t
                else
                  -15+ 12 * t
            )
 
  ]