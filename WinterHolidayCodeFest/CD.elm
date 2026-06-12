module CD exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "CD"

-- 2. draw your word using Shapes
myShapes t = 
  [
  circle 30
    |> filled black
    |> move (0,0),
      circle 8
    |> filled white
    |> move (0,0)
  ]

pair = (myShapes, word)

