module Mug exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "mug"

-- 2. draw your word using Shapes
myShapes t = 
  [
     wedge 32 0.5
    |> filled gray
    |> rotate (degrees -90) 
    ,  wedge 20 0.5
    |> filled gray
    |> rotate (degrees -540)
    |> move (-30,20)
    ,  rect 40 65
    |> filled gray
    |> move (20,1)
    |> rotate (degrees -630)
    ,  wedge 15 0.5
    |> filled white
    |> rotate (degrees -900)
    |> move (-30,20)
  ]

pair = (myShapes, word)

