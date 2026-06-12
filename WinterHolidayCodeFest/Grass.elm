module WinterHolidayCodeFest.Grass exposing (..)


-- 1. type your word in between the ""s
word = "grass"

-- 2. draw your word using Shapes
myShapes t = 
  [  triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees -270),
   
   triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees 90)
    |> move (9,5),
 
 triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees 90)
    |> move (-10,4),
 
 triangle 10
    |> filled green
    |> scaleX 3
    |> rotate (degrees -270)
    |> move (19,4),
  
  triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees -270)
    |> move (-17,3),
    
     triangle 10
    |> filled green
    |> scaleX 3
    |> rotate (degrees -270)
    |> move (-25,3),
    
     triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees -270)
    |> move (9,9),
   
   triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees 90)
    |> move (1,7),
 
 triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees 90)
    |> move (-12,6),
 
 triangle 10
    |> filled green
    |> scaleX 3
    |> rotate (degrees -270)
    |> move (22,8),
  
  triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees -270)
    |> move (2,5),
    
     triangle 10
    |> filled green
    |> scaleX 3
    |> rotate (degrees -270)
    |> move (-3,4),
    
    triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees 90)
    |> move (2,9),
 
 triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees 90)
    |> move (-15,6),
 
 triangle 10
    |> filled green
    |> scaleX 3
    |> rotate (degrees -270)
    |> move (20,8),
  
  triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees -270)
    |> move (0,5),
    
     triangle 10
    |> filled green
    |> scaleX 2
    |> rotate (degrees -270)
    |> move (-3,4),
   
   curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,10)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t)),
    
   curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,5)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t)),
    
    curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,0)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t)),
    
    curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,15)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t)),
    
    curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,20)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t)),
    
    curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,25)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t)),
    
    curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,30)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t)),
    
    curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,-5)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t)),
    
    curve (0,0) [Pull (10,2) (20,-10)]
    |> outlined (solid 1) (hsl (degrees 195) 0.822 0.41)
    |> move (-47,35)
    |> makeTransparent (0.75 + 0.25 * sin (10 * t))
    
    
    ]
    
 
  
  
  

    
    
     
