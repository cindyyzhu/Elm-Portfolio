module Clock exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "clock"

-- 2. draw your word using Shapes
myShapes t = 
  [
     base
     , smallArrow t |> rotate (-1/10 * t)
     , longArrow t |> rotate (-1.25 * t)
     , circle 3 |> filled black 
     , ticks

  ]

base = group [
      circle 35
      |> filled black
    
    , circle 30
      |> filled gray
  
  ]
  
smallArrow t = group [
      rect 3 14
      |> filled red 
      |> move (0,6)
      
    , triangle 4
      |> filled red
      |> rotate (degrees 90)
      |> move (0,14)
  
  ]

longArrow t = group [
    rect 3 19
        |> filled red 
        |> move (0,10)

      , triangle 4
        |> filled red
        |> rotate (degrees 90)
        |> move (0,19)
  ]
  
ticks = group [
    rect 2 5
      |> filled black
      |> move (0,25)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 330)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 300)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 270)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 240)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 210)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 180)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 150)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 120)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 90)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 60)
   , rect 2 5
      |> filled black
      |> move (0,25)
      |> rotate (degrees 30)
  ]

pair = (myShapes, word)

