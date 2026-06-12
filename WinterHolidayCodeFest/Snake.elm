module Snake exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "snake"

-- 2. draw your word using Shapes
myShapes t =

  [ tongue
    |>move (10+10*sin (t*2),3+3*sin (t*2))
  ,
  
  
  roundedRect 10 20 5
    |> filled (hsl (degrees 116) 0.872 0.397)
    |> scale 1
    |> scaleX 1.25
    |> scaleY 3.25
    |> rotate (degrees -80)
    |> move (10,0),
    
      circle 10
    |> filled (hsl (degrees 117) 0.68 0.348)
    |> scaleX 1.3
    |> scaleY -1
    |> move (-22,-4)
    |> rotate (degrees 6),
  
    circle 10
    |> filled black
    |> rotate (degrees 15)
    |> scaleX 1
    |> scaleY -1
    |> scale 0.25
    |> move (-22,-1),
    
     circle 10
    |> filled black
    |> rotate (degrees 15)
    |> scaleX 1
    |> scaleY -1
    |> scale 0.25
    |> move (-22,-9)]
    
   
tongue=group
 [  rect 10 20
    |> filled red
    |> rotate (degrees 100)
    |> scale 0.5
    |> move (-38.4,-9),
    
    triangle 10
    |> filled (hsl (degrees 0) 0.308 0.998)
    |> rotate (degrees 128)
    |> scale 0.4
  |> move (-42,-9.5)
 
  ]

pair = (myShapes, word)

