module Tree exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "Tree"

-- 2. draw your word using Shapes
myShapes t = 
  [
   rect 10 45
    |> filled (hsl (degrees 0) 0.706 0.215)
    |> move (0,-10)
    ,circle 17 
    |> filled green
    |> move (0,15)
   ,circle 165
    |> filled (hsl (degrees 181) 0.945 0.585)
    |> move (20,20)
    |> makeTransparent 0.375
    ,circle 10
     |> filled black
     |> move (50,42)
 
 ]

pair = (myShapes, word)

