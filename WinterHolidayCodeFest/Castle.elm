module Castle exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "Castle"

-- 2. draw your word using Shapes
myShapes t = 
  [
        rect 27 41
    |> filled gray,
      rect 22 35
    |> filled gray
    |> move (-30,-3),
        rect 22 35
    |> filled gray
    |> move (30,-3),
       rect 25 7
    |> filled gray
    |> move (-15,3),
      rect 25 7
    |> filled gray
    |> move (15,3),
      triangle 17
    |> filled red
    |> rotate (degrees -150)
    |> move (0,29),
      triangle 13
    |> filled yellow
    |> rotate (degrees -150)
    |> move (30,21),
    triangle 13
    |> filled yellow
    |> rotate (degrees -150)
    |> move (-30,21)
  ]

pair = (myShapes, word)

