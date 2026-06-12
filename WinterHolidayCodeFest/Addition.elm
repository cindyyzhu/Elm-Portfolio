module Addition exposing (..)-- 1. type your word in between the ""s
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import GraphicSVG exposing (..)

word = "Addition"

-- 2. draw your word using Shapes
myShapes t = 
  [
    rect 6 24
    |> filled black
    ,rect 6 24
    |> filled black
    |> rotate (degrees 90)
  ]

pair = (myShapes, word)


