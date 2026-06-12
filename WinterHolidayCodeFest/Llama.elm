module WinterHolidayCodeFest.Llama exposing (..)

--type your word in between the ""s
word = "llama"

-- 2. draw your word using Shapes
myShapes t = 
  [
  
   square 300
   |> filled (hsl (degrees 184) 0.5 0.5)
   ,rect 300 25
   |> filled green
   |> move (0,-45)
    ,circle 10
    |> filled yellow
    |> move (-20,30)
  
  
   ,oval 30 15
    |> filled gray
    |> move (7,-30)
    ,oval 4 21
    |> filled gray
    |> move (-7,-40)
    ,oval 4 21
    |> filled gray
    |> move (-2,-40)
    ,oval 4 21
    |> filled gray
    |> move (18,-40)
    ,oval 4 21
    |> filled gray
    |> move (13,-40)
    ,oval 6 30
    |> filled gray
    |> move (19,-20)
    ,oval 12 8
    |> filled gray
    |> move (23,-8)
    
    ,triangle 10
    |> filled gray
    |> rotate (degrees 90)
    |> scaleX 0.25
    |> scaleY 0.5
    |> move (23,-5)
    
    ,triangle 10
    |> filled gray
    |> rotate (degrees 90)
    |> scaleX 0.25
    |> scaleY 0.5
    |> move (20,-5)
    
    ,circle 1
    |> filled black
    |> move (23,-8)
    
    
    
    
   
    
  ]
