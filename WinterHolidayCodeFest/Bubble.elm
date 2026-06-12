module Bubble exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import GraphicSVG exposing (..)
-- 1. type your word in between the ""s
word = "bubble"

-- 2. draw your word using Shapes
myShapes t =

  [
     bubble 
     |> scale 1.5
     |> move (1* -2* sin t, (3* -4* sin t ))
     |> rotate(degrees (1* sin t))
  ] 

bubble = group
    [
    circle 10
    |> outlined (dotdash 0.75) (hsl (degrees 212) 0.783 0.951)
    ,
     circle 10
    |> outlined (solid 0.25) gray
    |> makeTransparent 0.625
    ,  
   circle 10
    |> filled (hsl (degrees 224) 0.989 0.45)
    |> makeTransparent 0.375
    ,
      circle 10
    |> filled white
    |> makeTransparent 0.875
    ,
    oval 10 18
    |> filled gray
    |> makeTransparent 0.5
    |> scale -0.5
    |> rotate (degrees -270)
    |> move (0,-6)
    ,
      circle 10
    |> filled blue
    |> makeTransparent 0.125
    |> scale -0.75
    ,
      oval 10 13
    |> filled white
    |> scale -0.5
    |> rotate (degrees -295)
    |> move (5,4)
    ,
    oval 10 13
    |> outlined (solid 0.5) gray
    |> rotate (degrees -295)
    |> makeTransparent 0.875
    |> scale -0.5
    |> move (5,4)
    ]

pair = (myShapes, word)


