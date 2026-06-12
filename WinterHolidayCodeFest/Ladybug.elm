module Ladybug exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "Ladybug"

-- 2. draw your word using Shapes
myShapes t = 
  [
     ladybug |> scale 1.7
  ]

ladybug = group
  [
  curve (0,0) [Pull (2,0) (5,-5)]
  |> outlined (solid 0.8) black
  |> move (-7,16)
  ,
  curve (0,0) [Pull (2,0) (5,-5)]
  |> outlined (solid 0.8) black
  |> move (-7,16)
  |> mirrorX
  ,
  circle 5.5
  |> filled black
  |> move (0,8)
  ,
  oval 19 21
  |> filled red
  |> move (0,-1)
  ,
  oval 0.8 20
  |> filled black
  |> move (0,-1)
  ,
  circle 1.5
  |> filled black
  |> move (3,5)
  ,
  circle 1.5
  |> filled black
  |> move (5,-1)
  ,
  circle 1.5
  |> filled black
  |> move (3,-7)
  ,
  circle 1.5
  |> filled black
  |> move (-3,5)
  ,
  circle 1.5
  |> filled black
  |> move (-5,-1)
  ,
  circle 1.5
  |> filled black
  |> move (-3,-7)
  ]

pair = (myShapes, word)
