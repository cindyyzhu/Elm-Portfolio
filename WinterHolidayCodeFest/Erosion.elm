module Erosion exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "erosion"

-- 2. draw your word using Shapes
myShapes t = 
  [
  rock |> scale (-1 * cos t)
  ,wave |> move (310 * sin t, 0)
  ]
rock = group [ 
  openPolygon[(-19,-5),(-5,-4),(-1,1),(6,5),(7,8),(-2,15),(-10,15),(-17,11),(-23,9)]
    |> filled gray
    |> rotate (degrees -210)
    |> move (-6,10)
    |> scale 3
    ]
     
wave = group [
   openPolygon[(-20,0),(-15,5),(-10,10),(-5,15),(10,20),(17,17),(5,10),(7,0),(-20,0)]
    |> filled blue
    |> scale 5
    |> move (-150,-50)
    ]

pair = (myShapes, word)

