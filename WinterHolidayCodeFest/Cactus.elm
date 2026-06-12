module WinterHolidayCodeFest.Cactus exposing (..)
import GraphicSVG exposing (..)
pair = (myShapes, word)
-- 1. type your word in between the ""s
word = "cactus"
  
myShapes t =
   [
     plant
     |> move (11,11 * sin t )

     ,
     pot
     |> move (11,11* sin t )
 ]

    
-- 2. draw your word using Shapes

cactus = group [
  plant
  ,
  pot
  ]
  
plant= group [
    roundedRect 16 30 20
    |> filled green
    |> scaleX 1.5
    |> scaleY 2
    ,
     rect 6 1
    |> filled black
    |> rotate (degrees -145)
    |> move (-4,13)
    ,
    rect 6 1
    |> filled black
    |> rotate (degrees -70)
    |> move (-4,3)
    ,
    rect 6 1
    |> filled black
    |> rotate (degrees -70)
    |> move (-0,-8)
    ,
    rect 6 1
    |> filled black
    |> rotate (degrees -13)
    |> move (-7,-2)
    ,
      rect 6 1
    |> filled black
    |> rotate (degrees -13)
    |> move (5,19)
    ,
      rect 6 1
    |> filled black
    |> rotate (degrees -234)
    |> move (10,-18)
    ,
      rect 6 1
    |> filled black
    |> rotate (degrees -234)
    |> move (8,-30)
    ,
    rect 6 1
    |> filled black
    |> rotate (degrees -234)
    |> move (7,-3)
    ,
    rect 6 1
    |> filled black
    |> rotate (degrees 234)
    |> move (6,9)
    ]
pot= group [    
     openPolygon [(0,0),(0,-15),(30,0)]
    |> filled (hsl (degrees 24) 0.626 0.403)
    |> rotate (degrees -90)
    |> move (-12,-17)
    |> scale 0.75
    ,
      openPolygon [(0,0),(0,-15),(30,0)]
    |> filled (hsl (degrees 24) 0.626 0.403)
    |> rotate (degrees -90)
    |> move (-12,-17)
    |> scale 0.75
    |> mirrorX
    ,
      rect 20 20
    |> filled (hsl (degrees 24) 0.626 0.403)
    |> move (0,-23)
    ,
      rect 30 1
    |> filled (hsl (degrees 57) 0.347 0.628)
    |> move (0,-23)
    ]

pair = (myShapes, word)

