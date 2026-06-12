module Bee exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import GraphicSVG exposing (..)
-- 1. type your word in between the ""s
word = "Bee"

-- 2. draw your word using Shapes
myShapes t = 
  [
     bee |> scale 1.5
  ]


bee = group [
  oval 15 20 -- right wing
  |> filled lightGray
  |> rotate (degrees 170)
  |> move (10,0)
  |> subtract (triangle 5 |> ghost |> scaleX -3 |> move (18,0) |> rotate (degrees -15))
  ,
  oval 15 20 -- left wing
  |> filled lightGray
  |> rotate (degrees -170)
  |> move (-10,0)
  |> subtract (triangle 5 |> ghost |> scaleX 3 |> move (-18,0) |> rotate (degrees 15))
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> filled black
  |> scale 0.5
  |> rotate (degrees 90)
  |> move (0,10)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> filled black
  |> scale 0.5
  |> rotate (degrees 90)
  |> scaleX -1
  |> move (0,10)
  ,
  stripes
  |> clip (beeBody)
  ]

beeBody = group [
  roundedRect 14 25 8
  |> filled orange
  ]

stripes = group [
  rect 30 5
  |> filled yellow
  ,
  rect 30 5
  |> filled black
  |> move (0,5)
  ,
  rect 30 5
  |> filled black
  |> move (0,-5)
  ,
  rect 30 5
  |> filled yellow
  |> move (0,10)
  ,
  rect 30 5
  |> filled yellow
  |> move (0,-10)
  ]

pair = (myShapes, word)


