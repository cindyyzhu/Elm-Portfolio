module WinterHolidayCodeFest.Car exposing (..)

-- 1. type your word in between the ""s
word = "car"

-- 2. draw your word using Shapes
myShapes t = 
  [    
      ground 
    , sky t
    , car |> move (-90 + 10 * repeat t,0)
    , carWheel |> rotate (-10 * t) |>  move (-110 + 10 * repeat t,-20)
    , carWheel |> rotate (-10 * t) |> move (-70 + 10 * repeat t,-20) 
    , clouds t 
    , sun t 
    , moon t
    
  ]
repeat t = t
          - 18.5 * toFloat (floor(t/18.5))
  
sun t = group [
  circle 10
  |> filled yellow
  |> move (35,30)
  |> makeTransparent (2 * cos (t + 1.6))
  ]
  
moon t = group [
  circle 10
  |> filled gray
  |> move (35,30)
  |> subtract (circle 10 |> filled white |> move (40,30))
  |> makeTransparent (2 * sin t)
  ]

clouds t = group [
   oval 20 10
   |> filled white
   |> move (-35,30)
  , oval 30 10
   |> filled white
   |> move (-25,30)
 , oval 20 10
   |> filled white
   |> move (5,30)
  , oval 25 10
   |> filled white
   |> move (10,30)
   
  ]
car = group [
  rect 30 70
      |> filled red
      |> rotate (degrees -90)
      |> move (0,-5)
      |> subtract tri
      |> subtract tri2
      |> subtract window 
      |> subtract window2
    ,  headlights 
 
  ]
  
tri = group [
  triangle 10
      |> filled white
      |> rotate (55)
      |> move (15, 6)
      |> scaleX (2.5)
  ]
tri2 = group [
  triangle 10
        |> filled white
        |> rotate (300)
        |> move (-15, 6)
        |> scaleX (2.5)
  ]

ground = group [
  rect 100 30
    |> filled green 
    |> move (0, -30)
  ]
  
sky t = group [
  rect 100 60
    |> filled (rgb 0 (250-150*sin t) (250-100*sin t))  
    |> move (0, 15)
     
  ]

window = group [
    roundedRect 10 20 5
      |> filled white
      |> rotate (degrees 90) 
      |> move (-12,0)
  ]
  
window2 = group [
    roundedRect 10 20 5
      |> filled white
      |> rotate (degrees 90) 
      |> move (12,0)
  ]
   
carWheel = group [
    circle 10
        |> filled black
    , circle 8
        |> filled gray
    , rect 10 1
        |> filled black 
    , rect 1 10
        |> filled black 
  ]

headlights = group [
    roundedRect 4 7 2
    |> filled yellow
    |> move (35,-7)
    
  ]
