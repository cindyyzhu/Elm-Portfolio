module WinterHolidayCodeFest.Turtle exposing (..)

-- 1. type your word in between the "turtle"s
word = "turtle"

-- 2. draw your word using Shapes
myShapes t = 
  [
  water
  ,
  sand
  |> move (-45,-40)
  ,
     
  head
  |> move (0,-25)
  |> rotate (2.1)
  ,
  larm
  |> move (-6,20)
  |> rotate (-0.5)
  ,
    larm
  |> move (-8,-21)
  ,
      larm
  |> move (-11,-20)
  |> rotate (1.8)
  ,
   larm
  |> move (-10,20)
  |> rotate (1)
    ,
    triangle 10
    |> filled (hsl (degrees 104) 0.754 0.544)
    |> rotate (degrees 100)
    |> scaleY 1
    |> move (-20,-13)

  ,
  shell
  ,
  line
  ,
  lined
  ,
  hexagon
  |> move (-8,-10)
  ,
  hexagon
  |> move (3,-5)
    ,
    hexagon
  |> move (-10,0)
      ,
    hexagon
  |> move (-1,7)
      ,
    hexagon
  |> move (10,6)
  ,
  cie
  |> move (23,19)
  ,
    cie
  |> move (27,11)
  ,
   
  
    oval 8 13
    |> filled (rgb 155 155 155)
    |> scaleY 1
    |> move (-42.5,36)
  ,
      oval 8 13
    |> filled gray
    |> scaleY 1
    |> move (-35,35)
   ,
  egg
  |> move (-40,30)
    

  ]

water = group
  [
      rect 200 200
    |> filled (rgb 47 202 255)
    
  ]
  
sand = group
  [
    oval 100 130
    |> filled (hsl (degrees 40) 0.662 0.685)
    |> move (20,20)
    |> rotate (degrees 30)
    ]
  
  
shell = group
  [
    oval 40 50
    |> filled (hsl (degrees 123) 0.551 0.428)
    |> rotate (2)
  ]
  
line = group
   [    oval 40 50
    |> outlined (solid 1) (hsl (degrees 123) 0.582 0.231)
    |> rotate (2)
    ]
    
    
lined = group
   [    oval 30 40
    |> outlined (solid 1) (hsl (degrees 123) 0.582 0.231)
    |> rotate (2)
    ]

head = group
  [
    roundedRect 20 25 10
    |> filled (hsl (degrees 104) 0.754 0.544)
    ]
    
larm = group
  [
  roundedRect 10 20 5
    |> filled (hsl (degrees 104) 0.754 0.544)
    ]
    
hexagon = group
  [
    ngon 6 5
    |> filled (hsl (degrees 110) 0.686 0.225)
    |> rotate (degrees 100)
    |> scaleY 1
    ]
    
cie = group
  [  circle 2
    |> filled black
    |> rotate (degrees 100)
    |> scaleY 1
    ]
    
    
egg = group
  [
    oval 8 13
    |> filled white
    |> scaleY 1
    ]

  