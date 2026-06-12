module Pencil exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)


-- 1. type your word in between the ""s
word = "pencil"

-- 2. draw your word using Shapes
myShapes t = 
  [
  rect 8 55
    |> filled yellow,
      triangle 5.5
    |> filled (rgb 232 208 130)
    |> rotate (degrees 90)
    |> move (0,29.9),
      rect 5 9
    |> filled gray
    |> rotate (degrees 90)
    |> move (0,-29),
      rect 5 9
    |> filled (hsl (degrees 346) 0.893 0.815)
    |> rotate (degrees -90)
    |> move (0,-34),
      triangle 1.5
    |> filled black
    |> rotate (degrees -270)
    |> move (0,34),
      rect 54 1
    |> filled black
    |> rotate (degrees -270),
      rect 54 1
    |> filled black
    |> rotate (degrees -270)
    |> move (4,0),
      rect 54 1
    |> filled black
    |> rotate (degrees -270)
    |> move (-4,0),
      rect 9 1
    |> filled black
    |> move (0,-27),
      rect 9 1
    |> filled black
    |> move (0,27),
      text "hi"
    |> filled black
    |> move (-5,36)
  ]

pair = (myShapes, word)

