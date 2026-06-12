module WinterHolidayCodeFest.Eye exposing (..)

-- 1. type your word in between the ""s
word = "eye"

-- 2. draw your word using Shapes
myShapes t = 
  [
  square 90
   |> filled (rgb 240 184 160)
   , eyelashes
   , eye
   , eyebrow
   , iris t |> move (10 * sin t, 0) 
  ]

eye = group [  
   oval 70 40
   |> filled black
   |> move (0,-10)
  , oval 65 32
   |> filled white
   |> move (0,-10)
  ]

iris t = group [
   circle 16
   |> filled (rgb 107 63 27)
   |> move (0,-10)
 , circle 7
   |> filled black
   |> move (0,-10)
   
  ]
  

eyebrow = group [
    curve (0,0) [Pull (10,1) (20,-12)]
    |> outlined (solid 2) black
    |> rotate (degrees 25)
    |> scale 3
    |> move (-35,20)
  ]
eyelashes = group [
    curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (19, -9)
    
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (14, -7)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (9, -5)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (4, -4)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (-1, -3)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (-6, -2.5)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (-11, -3)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (-16, -4)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (-21, -5)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (-26, -6.5)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (-31, -9)
  , curve (12,-6) [Pull (10,0) (20,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees -220)
    |> scaleX (-1)
    |> move (-35, -12)
  , curve (20,-20) [Pull (15,0) (10,-10)]
    |> outlined (solid 1) black
    |> rotate (degrees 170)
    |> move (-15, -15)
  ]

pair = (myShapes, word)

