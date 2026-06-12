module Mountain exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "Mountain"

-- 2. draw your word using Shapes
myShapes t = 
  [
     bee |> scale 1.5
  ]


bee = group [
    triangle 30
    |> filled (rgb 150 150 150)
    |> rotate (degrees 90)
    ,triangle 30
    |> outlined (solid 1) black
    |> rotate (degrees 90)
    ,triangle 10
    |> filled (rgb 255 255 255)
    |> rotate (degrees 90)
    |> move(0, 20)
    ,triangle 10
    |> outlined (solid 1) black
    |> rotate (degrees 90)
    |> move(0, 20)
  ]

pair = (myShapes, word)

