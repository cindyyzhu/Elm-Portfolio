module Ball exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import GraphicSVG exposing (..)
-- 1. type your word in between the ""s
word = "ball"

-- 2. draw your word using Shapes
myShapes t = 
  [
     
      circle 1 
    |> filled red
    |> scale 13
    |> move (0,-12) 
    |> move (0,-35 + 16 * (1.6 + cos t))
   
   
  ]

pair = (myShapes, word)


