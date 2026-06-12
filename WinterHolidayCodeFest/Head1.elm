module Head1 exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "hair"

-- 2. draw your word using Shapes
myShapes t = 
  [
  hair
  |> move (sin t*20,0)
  ]
  
        
hair = 

  [
  roundedRect 10 20 5
  |> filled black
  |> scale 0.5
  |> move (25,18)
  
  ,circle 10
  |> filled lightBrown
  |> scale 3
 
  ,roundedRect 10 20 5
  |> filled black
  |> scale 0.5
  |> move (-10,10)
  
  ,roundedRect 10 20 5
  |> filled black
  |> scale 0.5
  |> move (20,8)
  
  ,roundedRect 10 20 5
  |> filled black
  |> scale 0.5
  |> move (13,26)
  
  ,roundedRect 10 20 5
  |> filled black
  |> scale 0.5
  |> move (5,29)
  
  ,roundedRect 10 20 5
  |> filled black
  |> scale 0.5
  |> move (20,23)
  
  ,roundedRect 10 20 5
  |> filled black
  |> scale 0.5
  |> move (-5,29)
  
  ,roundedRect 10 20 5
  |> filled black
  |> scale 0.5
  |> move (-15,26)
  
  ,curve (0,0) [Pull (10,0) (20,-10)]
  |> filled red
  |> scale 1
  |> scaleX 1
  |> scaleY 1
  |> rotate (degrees 210)
  |> move (17,-16)
  
  ,wedge 10 0.75
  |> filled darkOrange
  |> scale 0.4
  |> rotate (degrees 90)
  |> move(7,-7)
 
 ,roundedRect 10 30 50
  |> filled darkOrange
  |> scale 0.4
  |> rotate (degrees 180)
  |> move (7,-1)
  
  ,triangle 10
  |> filled black
  |> scale 0.5
  |> rotate (degrees 205)
  |> move (0,40)
  
  ,text "hair"
  |> filled black
  |> scale 1
  |> rotate (degrees 375)
  |> move (7,40)
  ]
  |> group

pair = (myShapes, word)

