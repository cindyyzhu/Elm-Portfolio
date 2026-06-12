module WinterHolidayCodeFest.Juice exposing (..)

-- 1. type your word in between the ""s
word = "juice"

-- 2. draw your word using Shapes
myShapes t = 
  [
       rect 35 55
    |> filled (hsl (degrees 201) 0.857 0.612)
     ,     text "Nestea"
    |> italic
    |> bold
    |> filled (hsl (degrees 61) 0.98 0.993)
    |> move (-20.5,16)
    |> scale 0.7
 
    ,      rect 10 35
    |> filled (hsl (degrees 61) 0.967 0.688)
    |> rotate (degrees 90)
    |> move (0,23)
    
    ,  rect 25 35
    |> filled blue
    |> rotate (degrees 90)
    |> move (0,-15)
    
    ,  text "Lemon"
    |> bold
    |> filled yellow
    |> move (-20,-25)
    |> scale 0.5  
   ,
    lemon
    |> scale 1
    |> move (0, -5)
  ]
    
lemon =
  [
   wedge 10 0.5
    |> filled yellow
    |> move (5,-2)
    |> scale 1
    |> rotate (degrees 105)
    ,
     wedge 8 0.5
    |> filled white
    |> move (5,-2)
    |> rotate (degrees 105)
    |> scale 1
    |> scaleY 1
    ,
      triangle 11
    |> filled yellow
    |> scale 0.5
    |> scaleY 0.7
    |> scaleX 1
    |> rotate (degrees 217)
    |> move (6,8.5)
    ,
      triangle 11
    |> filled yellow
    |> scale 0.5
    |> scaleY 0.7
    |> scaleX 1
    |> rotate (degrees 360)
    |> move (-6,5.5)
    ,
          triangle 11
    |> filled yellow
    |> scale 0.5
    |> scaleY 1.1
    |> scaleX 1.1
    |> rotate (degrees 280)
    |> move (0,11)
  ]
    |> group

pair = (myShapes, word)

