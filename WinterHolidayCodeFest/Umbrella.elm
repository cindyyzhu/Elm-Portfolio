module Umbrella exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
-- 1. type your word in between the ""s
word = "umbrella"

-- 2. draw your word using Shapes
myShapes t = 
  [
    square 8
    |> filled (hsl (degrees 288) 0.622 0.841)
    |> scale 15.5
    ,  roundedRect 1 13 4
    |> filled (hsl (degrees 19) 0.009 0.478)
    |> scale 2
    |> move (0,-11)
    |> scaleX 2
    ,  wedge 19 0.6
    |> filled (hsl (degrees 19) 0.009 0.478)
    |> rotate (degrees -45)
    |> move (-10,-90)
    |> scale 0.25
    ,   roundedRect 6 17 4
    |> filled (hsl (degrees 19) 0.009 0.478)
    |> scale 0.5
    |> scaleX 1
    |> rotate (degrees 28)
    |> move (-5.6,-23)
    ,  wedge 19 0.5
    |> filled (hsl (degrees 288) 0.536 0.392)
    |> rotate (degrees 90)
    |> scaleX 1.75
    |> scaleY 1.25
    |> move (0,-3)
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> filled (hsl (degrees 288) 0.608 0.229)
    |> scaleX 1
    |> scaleY 0.5
    |> rotate (degrees 80)
    |> move (-22,-2)
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> filled (hsl (degrees 288) 0.608 0.229)
    |> scaleX 1
    |> scaleY 0.5
    |> rotate (degrees 100)
    |> move (0,-2)
    ,  square 8
    |> filled (hsl (degrees 288) 0.608 0.229)
    |> rotate (degrees 80)
    |> move (-4,23)
    |> scaleY 1
    |> scaleX 0.25
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> filled (hsl (degrees 288) 0.608 0.229)
    |> scaleX 0.25
    |> rotate (degrees 2)
    |> scaleY 2
    |> move (11,18)
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> filled (hsl (degrees 288) 0.608 0.229)
    |> scaleX 1
    |> scaleY 0.5
    |> rotate (degrees 90)
    |> move (-10,-2)
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> filled (hsl (degrees 288) 0.608 0.229)
    |> scaleX 0.25
    |> rotate (degrees 2)
    |> scaleY 2
    |> move (4,18)
    ,  curve (0,0) [Pull (10,0) (20,-10)]
    |> filled (hsl (degrees 288) 0.608 0.229)
    |> scaleX 0.25
    |> rotate (degrees 2)
    |> scaleY 1
    |> move (21,10)
  ]

pair = (myShapes, word)

