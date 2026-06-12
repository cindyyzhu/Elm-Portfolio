module WinterHolidayCodeFest.Squirrel exposing (..)

word = "Squirrel"

-- 2. draw your word using Shapes
myShapes t = 
  [
     squirrel |> move (0,-13)
  ]
pair = (word, myShapes)

acorn = group
  [
   [roundedRect 17 18 7 -- acorn
    |> filled brown
    |> move (0,-6)
    ,
    oval 2 5
    |> filled brown
    |> move (0,-14)
   ] |> group |> addOutline (solid 1) black
  ,
   [roundedRect 19 9 6 -- stem
    |> filled darkBrown
    ,
    roundedRect 1 6 1
    |> filled darkBrown
    |> move (0,5)
   ] |> group |> addOutline (solid 1) black
  ,
  curve (0,-2) [Pull (0,-6) (-4,-8)]
  |> outlined (solid 0.5) white
  |> move (7,-5)
  ]


squirrel = group
  [
   [oval 15 28 -- tail
    |> filled (hsl (degrees 30) 0.876 0.662)
    |> rotate (degrees -30)
    |> move (11,2)
    ,
    oval 20 15
    |> filled (hsl (degrees 30) 0.876 0.4)
    |> move (17,18)
    ,
    oval 20 13
    |> filled (hsl (degrees 30) 0.876 0.662)
    |> move (15,16.5)
   ]|> group |> addOutline (solid 1) black
  ,
  curve (1,3) [Pull (6,5) (3,0)] -- tail detail
  |> outlined (solid 0.5) black
  |> move (18,14)
  ,
   [oval 12 15 -- left leg
    |> filled (hsl (degrees 30) 0.876 0.55)
    |> rotate (degrees 15)
    |> move (-10,-6)
    ,
    oval 10 3
    |> filled (hsl (degrees 30) 0.876 0.55)
    |> move (-11,-14)
   ] |> group |> addOutline (solid 1) black
  ,
  [oval 12 15 -- right leg
    |> filled (hsl (degrees 30) 0.876 0.6)
    |> rotate (degrees -15)
    |> move (10,-6)
    ,
    oval 10 3
    |> filled (hsl (degrees 30) 0.876 0.6)
    |> move (11,-14)
   ] |> group |> addOutline (solid 1) black
  ,
  roundedRect 28 27 13 -- body
  |> filled (hsl (degrees 30) 0.876 0.662)
  |> addOutline (solid 0.5) black
  ,
  roundedRect 22 22 10 -- belly
  |> filled (hsl (degrees 30) 0.876 0.87)
  |> move (0,1)
  ,
  [ -- head
    oval 9 16 -- left ear
    |> filled (hsl (degrees 30) 0.876 0.662)
    |> rotate (degrees 30)
    |> move (-10,12)
    |> addOutline (solid 0.5) black
    ,
    oval 5 12
    |> filled (hsl (degrees 30) 0.876 0.4)
    |> rotate (degrees 30)
    |> move (-10,12)
    ,
    oval 9 16 -- right ear
    |> filled (hsl (degrees 30) 0.876 0.662)
    |> rotate (degrees -30)
    |> move (10,12)
    |> addOutline (solid 0.5) black
    ,
    oval 5 12
    |> filled (hsl (degrees 30) 0.876 0.4)
    |> rotate (degrees -30)
    |> move (10,12)
    , -- head
    [circle 15
    |> filled (hsl (degrees 30) 0.876 0.662)
    ,
    roundedRect 33 20 15 
    |> filled (hsl (degrees 30) 0.876 0.662)
    |> move (0,-6)] |> group |> addOutline (solid 1) black
    ,
    circle 15 -- head detail
    |> filled (hsl (degrees 30) 0.876 0.4)
    |> subtract (oval 17 25 |> ghost |> move (-7,-4))
    |> subtract (oval 17 25 |> ghost |> move (7,-4))
    ,
    roundedRect 16 16 7 -- mouth detail
    |> filled (hsl (degrees 30) 0.876 0.8)
    |> move (0,-10)
    |> clip (roundedRect 33 20 15 |> ghost |> move (0,-6))
    ,
    oval 7 9 -- left eye
    |> filled black
    |> move (-6,2)
    ,
    circle 1 
    |> filled white
    |> move (-7.5,4)
    ,
    oval 7 9 -- right eye
    |> filled black
    |> move (6,2)
    ,
    circle 1 
    |> filled white
    |> move (4.5,4)
    ,
    oval 4 2.5 -- nose
    |> filled (hsl (degrees 30) 0.876 0.2)
    |> move (0,-4)
    , -- mouth
    rect 1 4
    |> filled (hsl (degrees 30) 0.876 0.2)
    |> move (0,-7)
    ,
    curve (0,0) [Pull (3,-3) (5,1)]
    |> outlined (solid 1) (hsl (degrees 30) 0.876 0.2)
    |> move (0,-8)
    ,
    curve (0,0) [Pull (-3,-3) (-5,1)]
    |> outlined (solid 1) (hsl (degrees 30) 0.876 0.2)
    |> move (0,-8)
  ] |> group |> move (0,25)
  ,
  acorn |> scale 0.8
  |> rotate (degrees 20)
  |> move (-1,7)
  ,
  roundedRect 10 6 3 -- left arm
  |> filled (hsl (degrees 30) 0.876 0.662)
  |> addOutline (solid 0.5) black
  |> rotate (degrees 30)
  |> move (-12,5)
  ,
  roundedRect 6 7 3 -- left hand
  |> filled (hsl (degrees 30) 0.876 0.6)
  |> addOutline (solid 0.5) black
  |> rotate (degrees 30)
  |> move (-8,7)
  ,
  roundedRect 10 6 3 -- right arm
  |> filled (hsl (degrees 30) 0.876 0.662)
  |> addOutline (solid 0.5) black
  |> rotate (degrees -30)
  |> move (12,5)
  ,
  roundedRect 6 7 3 -- right hand
  |> filled (hsl (degrees 30) 0.876 0.6)
  |> addOutline (solid 0.5) black
  |> rotate (degrees -30)
  |> move (8,7)
  ]
