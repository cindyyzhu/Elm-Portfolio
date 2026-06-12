module Lipstick exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "lipstick"

-- 2. draw your word using Shapes
myShapes t = 
  [
       rect 7 13
    |> filled black
    |> scale 2
    |> move (0, -25),
    
    rect 6 8
    |> filled grey
    |> scale 2
    |> move (0, -4),
    
    rect 5 8
    |> filled red
    |> scale 2
    |> move (0, 12),
    
      triangle 4
    |> filled red
    |> scale 2
    |> rotate (degrees -60)
    |> move (1, 20),
    
      rect 2 16
    |> filled white
    |> scale 2
    |> move (-7, 20)
  ]

pair = (myShapes, word)

