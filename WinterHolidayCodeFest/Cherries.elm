module WinterHolidayCodeFest.Cherries exposing (..)

-- 1. type your word in between the ""s
word = "cherries"

-- 2. draw your word using Shapes
myShapes t = 
  [
    cherries
      |> scale 0.75
      |> move (-18, 10 * sin t)
  ]

cherries : Shape msg
cherries =
  [
    square 3
      |> filled green
      |> scaleX 8
      |> rotate (degrees 60)
      |> move (-5,0)
  , square 3
      |> filled green
      |> scaleX 8
      |> rotate (degrees 300)
      |> move (5,0)
  , circle 4
      |> filled green
      |> scaleX 2.5 
      |> move (10,9)
      |> rotate (degrees 20)
  , circle 10
      |> filled red
      |> move (-10,-15)
  , circle 10
      |> filled red
      |> move (10,-15)
 , circle 1
      |> filled black
      |> move (7,-18)
 , circle 1
      |> filled black
      |> move (14,-18)
 , curve (0,0) [Pull (10,0) (20,-10)]
      |> filled black
      |> move (-12,100)
      |> rotate (degrees 205)
      |> scale 0.25
 , circle 1
      |> filled black
      |> move (-7,-18)
 , circle 1
      |> filled black
      |> move (-14,-18)
 , curve (0,0) [Pull (10,0) (20,-10)]
      |> outlined (solid 1) black
      |> move (60,63)
      |> rotate (degrees 205)
      |> scale 0.25
  ]
  |> group
