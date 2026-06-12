module Frog exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)


-- 1. type your word in between the ""s
word = "frog"

-- 2. draw your word using Shapes
myShapes t = 
  [   circle 17
    |> filled green,  
    circle 4 
    |> filled black
    |> move (-7,17),
      circle 4
    |> filled black
    |> move (7,17),
        circle 6
    |> filled (hsl (degrees 341) 0.704 0.578)
    |> scaleX 2
    |> move (1,1),
      circle 7
    |> filled green
    |> scale 1.75
    |> scaleX 1.25
    |> move (0,-25),
      roundedRect 5 5 10
    |> filled green
    |> scale 1.75
    |> scaleX 1.25
    |> rotate (degrees 30)
    |> move (-10,-35),
 
      roundedRect 5 5 10
    |> filled green
    |> scale 1.75
    |> scaleX 1.25
    |> rotate (degrees 30)
    |> move (10,-35)]

pair = (myShapes, word)

