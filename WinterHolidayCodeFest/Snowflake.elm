module Snowflake exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "snowflake"

-- 2. draw your word using Shapes
myShapes t = 
  [
     snowflake |> scale 1.5
  ]
  
snowflake = group
  [
  rect 1 60
  |> filled (rgb 83 222 255)
  ,
  rect 1 60
  |> filled (rgb 83 222 255)
  |> rotate (degrees 90)
  ,
  rect 1 48
  |> filled (rgb 83 222 255)
  |> rotate (degrees 135)
  ,
  rect 1 48
  |> filled (rgb 83 222 255)
  |> rotate (degrees 225)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> outlined (solid 1) (rgb 83 222 255)
  |> rotate (degrees 225)
  |> move (-2,-2)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> outlined (solid 1) (rgb 83 222 255)
  |> rotate (degrees 460)
  |> move (-8,-23)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> outlined (solid 1) (rgb 83 222 255)
  |> rotate (degrees 551)
  |> move (24.5,-9)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> outlined (solid 1) (rgb 83 222 255)
  |> rotate (degrees 313.5)
  |> move (1.5,-1.5)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> outlined (solid 1) (rgb 83 222 255)
  |> rotate (degrees 130)
  |> move (-1.5,1.5)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> outlined (solid 1) (rgb 83 222 255)
  |> rotate (degrees 13)
  |> move (-23.5,7)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> outlined (solid 1) (rgb 83 222 255)
  |> rotate (degrees 281.5)
  |> move (7.3,23)
  ,
  curve (0,0) [Pull (10,0) (20,-10)]
  |> outlined (solid 1) (rgb 83 222 255)
  |> rotate (degrees 760)
  |> move (2,2)
  ]

pair = (myShapes, word)

