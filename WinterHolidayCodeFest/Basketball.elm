module Basketball exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import GraphicSVG exposing (..)
-- 1. type your word in between the ""s
word = "basketball"

-- 2. draw your word using Shapes
myShapes t = 
  [ circle 40
                  |> filled orange
              , curve (-37,0) [Pull (10,10) (31,-10)]
                  |> outlined (solid 1) black
                  |> move (0,-15)
              , curve (37,0) [Pull (-10,-10) (-31,10)]
                  |> outlined (solid 1) black
                  |> move (0,15)
              , curve (-40,0) [Pull (5,0) (40,-10)]
                  |> outlined (solid 1) black
                  |> move (0,4)
              , curve (-40,0) [Pull (5,0) (40,-10)]
                  |> outlined (solid 1) black
                  |> rotate 190
                  |> move (-5,0)
  ]

pair = (myShapes, word)


