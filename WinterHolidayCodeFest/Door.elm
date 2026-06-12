module Door exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "Door"

-- 2. draw your word using Shapes
myShapes t =


 [
     rect 20 60
    |> filled (hsl (degrees 30) 0.853 0.32)
     ,circle 2
    |> filled black
    |> move (3,1)
     ,  rect 3 26
    |> filled black
    |> move (-25,1)
       ,rect 3 25
    |> filled black
    |> rotate (degrees -35)
    |> move (-32,-20)
    ,  rect 3 25
    |> filled black
    |> move (-27,-7)
    |> rotate (degrees 35)
   , circle 8
    |> outlined (solid 2.5) black
    |> move (-24,21)
     ,rect 3 25
    |> filled black
    |> rotate (degrees 90)
    |> move (-13.5,-0)
      ,rect 3 23
    |> filled black
    |> move (17,29)
    |> rotate (degrees 130)  
  ]

pair = (myShapes, word)

