module Bridge exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import GraphicSVG exposing (..)
-- 1. type your word in between the ""s
word = "bridge"

-- 2. draw your word using Shapes
myShapes t = 
  [  circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (-10,0)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (-20,0)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (-30,0)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (10,0) 
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (20,0)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (30,0) 
    ,   rect 100 11.5
    |> filled black
    |> move (0,-5)
    , roundedRect 100 6 0
    |> filled black
    |> move (0,-7)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (-10,-10)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (10,-10) 
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (-20,-10)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (20,-10)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (-30,-10)
    , circle 10
    |> outlined (solid 1) red
    |> scaleX 2
    |> move (30,-10)
    ,  rect 100 7
    |> filled grey
    |> move (0,-14)
    , rect 100 5
    |> filled white
    |> move (0,-19)
    , polygon [(-50,-16),(-50,-26),(0,-16)]
    |> outlined (solid 1) red
    , polygon [(50,-16),(50,-26),(0,-16)]
    |> outlined (solid 1) red
    ,   oval 28 14
    |> filled blue
    |> move (0,-50)
     ,   oval 28 14
    |> filled blue
    |> move (50,-50)
     ,   oval 28 14
    |> filled blue
    |> move (50,-50)
     ,   oval 28 14
    |> filled blue
    |> move (40,-50)
     ,   oval 28 14
    |> filled blue
    |> move (30,-50)
     ,   oval 28 14
    |> filled blue
    |> move (20,-50)
     ,   oval 28 14
    |> filled blue
    |> move (10,-50)
    , oval 28 14
    |> filled blue
    |> move (0,-50)
     ,   oval 28 14
    |> filled blue
    |> move (-50,-50)
     ,   oval 28 14
    |> filled blue
    |> move (-50,-50)
     ,   oval 28 14
    |> filled blue
    |> move (-40,-50)
     ,   oval 28 14
    |> filled blue
    |> move (-30,-50)
     ,   oval 28 14
    |> filled blue
    |> move (-20,-50)
     ,   oval 28 14
    |> filled blue
    |> move (-10,-50)
    , waves t |> move (10*cos t,0)
    ]
waves t = group [
    curve (-20,-30) [Pull (10,-20) (20,-60)]
    |> filled blue
    ,   curve (-50,-30) [Pull (-20,-20) (-10,-60)]
    |> filled blue
    ,   curve (10,-30) [Pull (40,-20) (50,-60)]
    |> filled blue
    ]

pair = (myShapes, word)


