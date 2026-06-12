module Up exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "Up"

-- 2. draw your word using Shapes
myShapes t = 
  [
       rect 20 57
    |> filled red
    |> move (0,-16),
      triangle 22
    |> filled red
    |> rotate (degrees 210)
    |> move (0,20)
  ]

pair = (myShapes, word)

