module Snail exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- 1. type your word in between the ""s
word = "snails"

-- 2. draw your word using Shapes
myShapes t = 
  [
  rect 15 9 -- body
  |> filled (rgb 250 200 150)
  |> scale 1.4
  |> move ( 10 , -5) 
  ,
    roundedRect 10 20 5 -- neck
    |> filled (rgb 250 200 150)
     |> scale 1.4
    |> rotate (degrees (-15 + 15 * sin (4 * t )))
    |> move ( 22 ,2.2 )
    ,
    rect 3 16 -- left eye stock
    |> filled ( rgb 250 200 150)
    |> move ( 19 , 17)
    ,
     rect 3 13 -- right eye stock
    |> filled ( rgb 250 200 150)
    |> move ( 26 , 17)
    ,
    roundedRect 11 20 3
    |> filled lightPurple
    |> rotate (degrees 90)
    |> move (7,-6.5)
    
    ,
    circle 20 -- shell
    |> filled (radialGradient [ stop (rgb 200 150 200) 15,
    stop lightPurple 20
                         ])
    |> move (-4,8.5)
    ,
        circle 20 
    |> outlined (solid 1) purple
    |> rotate (degrees -15)
    |> move (-4,8.5)
    ,
      circle 15
    |> outlined (solid 1) purple
    |> rotate (degrees -15)
     |> move (-4,8.5)
    ,
      circle 10
    |> outlined (solid 1) purple
    |> rotate (degrees -15)
     |> move (-4,8.5)
    ,
      circle 5
    |> outlined (solid 1) purple
    |> rotate (degrees -15)
     |> move (-4,8.5)
     ,
     eyes
      |> move (19.3,25)
      ,
       eyes
      |> move (25.3,25) 
      ,
       roundedRect 10 20 5 -- neck
    |> filled (rgb 250 200 150)
    |> rotate (degrees (-15 + 15 * sin (4 * t ))) 
   |> move ( -6 , -10 ),
      orangesnail
      |> scale 0.7
      |> move ( -20, -12)
      ,
     
       roundedRect 10 20 5 -- neck
    |> filled (rgb 250 200 150)
 |> scale 0.65
    |> rotate (degrees (15 + 15 * sin (4 * t )))
   |> move (10 ,-13 )
     ,
      
      pinksnail
      |> scaleX -1
     |> scale 0.5
      |> move ( 20 ,-13)
   
     
  ]

eyes =  [
  circle 4 
  |> filled black
  ,
  circle 1 
  |> filled white
  |> move (-1 , 1)
 ]
 |> group
orangesnail : GraphicSVG.Shape msg
orangesnail = group[
  rect 15 9 -- body
  |> filled (rgb 250 200 150)
  |> scale 1.4
  |> move ( 10 , -5) 
  ,
    
    rect 3 13 -- left eye stock
    |> filled ( rgb 250 200 150)
    |> move ( 19 , 17)
    ,
     rect 3 13 -- right eye stock
    |> filled ( rgb 250 200 150)
    |> move ( 26 , 17)
    ,
    roundedRect 11 20 3
    |> filled lightOrange
    |> rotate (degrees 90)
    |> move (7,-6.5)
    
    ,
    circle 20 -- shell
    |> filled (radialGradient [ stop (rgb 250 200 100) 15,
    stop lightOrange 20
                         ])
    |> move (-4,8.5)
    ,
        circle 20 
    |> outlined (solid 1) orange
    |> rotate (degrees -15)
    |> move (-4,8.5)
    ,
      circle 15
    |> outlined (solid 1) orange
    |> rotate (degrees -15)
     |> move (-4,8.5)
    ,
      circle 10
    |> outlined (solid 1) orange
    |> rotate (degrees -15)
     |> move (-4,8.5)
    ,
      circle 5
    |> outlined (solid 1) orange
    |> rotate (degrees -15)
     |> move (-4,8.5)
     ,
     eyes
      |> move (19.3,25)
      ,
       eyes
      |> move (25.3,25)
      ]
pinksnail = group[
  rect 15 9 -- body
  |> filled (rgb 250 200 150)
  |> scale 1.4
  |> move ( 10 , -5) 
  ,
    
    rect 3 20 -- left eye stock
    |> filled ( rgb 250 200 150)
    |> move ( 19 , 15)
    ,
     rect 3 13 -- right eye stock
    |> filled ( rgb 250 200 150)
    |> move ( 26 , 15)
    ,
    roundedRect 11 20 3
    |> filled (rgb 250 150 150)
    |> rotate (degrees 90)
    |> move (7,-6.5)
    
    ,
    circle 20 -- shell
    |> filled (radialGradient [ stop (rgb 250 200 200) 15,
    stop (rgb 250 150 150) 20
                         ])
    |> move (-4,8.5)
    ,
        circle 20 
    |> outlined (solid 1) (rgb 250 100 100)
    |> rotate (degrees -15)
    |> move (-4,8.5)
    ,
      circle 15
    |> outlined (solid 1) (rgb 250 100 100)
    |> rotate (degrees -15)
     |> move (-4,8.5)
    ,
      circle 10
    |> outlined (solid 1) (rgb 250 100 100)
    |> rotate (degrees -15)
     |> move (-4,8.5)
    ,
      circle 5
    |> outlined (solid 1) (rgb 250 100 100)
    |> rotate (degrees -15)
     |> move (-4,8.5)
     ,
     eyes
     |> scaleY -1
      |> move (19.3,25)
      ,
       eyes
       |> scaleY -1
      |> move (25.3,25)
      ]
{- /\____/\
  | * ^ * |
  \_______/ -}

pair = (myShapes, word)

