module WinterHolidayCodeFest.Santa exposing (..)


-- 1. type your word in between the ""s
word = "santa"

-- 2. draw your word using Shapes
myShapes t = 
  [
     
   santa
   |> scale 0.7

  ]

santa = group
  [
    hair
    ,
    hair
    |> scaleX -1
    ,
    circle 24
    |> filled red
    |> move (0, -39)
    |>scaleX 1.15
    ,
    head
    ,
    beard
    |> move (0, 5)
    |> scale 1.25
    ,
    hat
    |> move (0, -1)
    ,
      roundedRect 7 58 3
    |> filled black
    |> rotate (degrees 90)
    |> move (0, -40)
    ,
      roundedRect 7 13 2
    |> outlined (solid 1) white
    |> rotate (degrees 90)
    |> move (0, -40)
    ,
      circle 0.05
    |> outlined (solid 1) white
    |> rotate (degrees -30)
    |> move (0, -40)
     ,
       hand
       
     ,
       hand
       |> scaleX -1
     
  ]

head = group
  [
    roundedRect 40 60 5
    |> filled red
    |> move (0, -40)
    ,
      circle 15
    |> filled (hsl (degrees 45) 0.756 0.819)
    |> move (0, 10)
    , 
    circle 1.3
    |> filled black
    |> rotate (degrees -30)
    |> move (5, 15)
    ,
    circle 1.3
    |> filled black
    |> rotate (degrees -30)
    |> move (-5, 15)
  ]
  
hand = group
  [
      roundedRect 9 22 4
    |> filled red
    |> rotate (degrees 130)
    |> move (22, -8)
    ,
      circle 4
    |> filled (hsl (degrees 45) 0.756 0.819)
    |> move (30, -1)
    ,
    roundedRect 9 2 5
    |> filled (hsl (degrees 45) 0.756 0.819)
    |> rotate (degrees 130)
    |> move (30, -5)
    |> scaleY -1
   
    
  ]

beard = group
  [
    
      triangle 15
    |> filled white
    |> rotate (degrees 30)
    |> move (0, -8)
    ,
      circle 5
    |> filled white
    |> rotate (degrees 30)
    |> move (-6, -5.5)
    ,
    circle 5
    |> filled white
    |> rotate (degrees 30)
    |> move (-5, -10)
    ,
    circle 5
    |> filled white
    |> rotate (degrees 30)
    |> move (-3, -14)
    ,
    circle 5
    |> filled white
    |> rotate (degrees 30)
    |> move (0, -18)
    ,
      triangle 15
    |> filled white
    |> rotate (degrees 30)
    |> move (0, -8)
    ,
      circle 5
    |> filled white
    |> rotate (degrees 30)
    |> move (6, -5.5)
    ,
    circle 5
    |> filled white
    |> rotate (degrees 30)
    |> move (5, -10)
    ,
    circle 5
    |> filled white
    |> rotate (degrees 30)
    |> move (3, -14)
    ,
    wedge 4 0.5
      |> filled red
      |> rotate (degrees -90)
      |> move(0, 0)
      ,
     curve (0,0) [Pull (10,0) (15,-10)]
      |> filled white
      |> rotate (degrees -160)
      |> move(0, 1)
      ,
     curve (0,0) [Pull (10,0) (15,-10)]
      |> filled white
      |> rotate (degrees -160)
      |> move(0, 1)
      |> scaleX -1
      ,
    wedge 1 0.5
      |> outlined (solid 1) (hsl (degrees 22) 0.736 0.716)
      |> rotate (degrees -90)
      |> move(0, 3)
  ]
  
hat = group
  [
      ngon 5 14
    |> filled red
    |> rotate (degrees -45)
    |> move (-4, 35)
    ,
    triangle 9.85
    |> filled red
    |> rotate (degrees 15)
    |> move (-15, 46)
    ,
      circle 3
    |> outlined (solid 1) black
    |> rotate (degrees -30)
    |> move (-24, 54)
  ]
  
hair = group
  [
      wedge 8 0.5
      |> filled gray
      |> rotate (degrees -160)
      |> move(-15, 5)
      ,
      wedge 10 0.5
      |> filled gray
      |> rotate (degrees -160)
      |> move(-12, 0)
      ,
      wedge 9 0.5
      |> filled gray
      |> rotate (degrees -195)
      |> move(-12, 14)
      ,
      wedge 8 0.5
      |> filled gray
      |> rotate (degrees -220)
      |> move(-8, 18)
      
  ]