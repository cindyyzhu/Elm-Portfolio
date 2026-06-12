module Dog exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

fractionalModBy m x = x - m * toFloat (floor (x / m))

repeatDistance speed start end t =
  start + fractionalModBy (end - start) (speed * t)
  
  -- Your shapes go here!
myShapes model =
  [
    dog model
 
  ]

dog model = group
  [
    roundedRect 4 10 2 -- front right leg
    |> filled (hsl (degrees 39) 0.94 0.85)
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> move (5,-15)
    ,
    roundedRect 4 10 2 -- back right leg 
    |> filled (hsl (degrees 39) 0.94 0.85)
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> move (20,-15)
    ,
    dogBody model
    |> addOutline (solid 1) (hsl (degrees 31) 0.86 0.1)    
    ,
    dogHead
    |> move (3,0)
    
  ]

dogBody model = group
  [
    roundedRect 35 22 15 -- body
    |> filled (hsl (degrees 39) 0.94 0.85)
    |> rotate (degrees 5)
    |> move (13,-5)
    ,
    roundedRect 4 10 2 -- front leg
    |> filled (hsl (degrees 39) 0.94 0.85)
    |> move (10,-17)
    ,
    roundedRect 4 12 2 -- back leg
    |> filled (hsl (degrees 39) 0.94 0.85)
    |> move (25,-15)
    ,
    curve (0,0) [Pull (5,0) (10,0+abs(5*sin(20*model.time)))] -- tail
    |> filled (hsl (degrees 39) 0.94 0.85)
    |> rotate (degrees 45)
    |> move (26,-4)
  ]

dogHead = group
  [
    roundedRect 30 28 14 -- face
    |> filled (hsl (degrees 39) 0.94 0.85)
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> move (0,-1)
    ,
    circle 4 -- left eye
    |> filled white
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> move (-6,-3)
    ,
    circle 3 -- left eye
    |> filled (hsl (degrees 31) 0.86 0.1)
    |> move (-6,-3)
    ,
    circle 0.5
    |> filled white 
    |> move (-7,-2)
    ,
    roundedRect 5 2 1 -- left brow
    |> filled (hsl (degrees 31) 0.86 0.1)
    |> move (-6,3)
    ,
    circle 4 -- right eye
    |> filled white
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> move (6,-3)
    ,
    circle 3 -- right eye
    |> filled (hsl (degrees 31) 0.86 0.1)
    |> move (6,-3)
    ,
    circle 0.5
    |> filled white 
    |> move (5,-2)
    ,
    roundedRect 5 2 1 -- right brow
    |> filled (hsl (degrees 31) 0.86 0.1)
    |> move (6,3)
    ,
    oval 5 12 -- left ear
    |> filled (hsl (degrees 31) 0.86 0.3)
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> rotate (degrees -10)
    |> move (-14,1)
    ,
    oval 5 12 -- left ear
    |> filled (hsl (degrees 31) 0.86 0.3)
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> rotate (degrees 10)
    |> move (14,1)   
    ,
    circle 3 -- mouth
    |> filled (hsl (degrees 31) 0.86 0.3)
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> move (0,-8.5)
    ,
    oval 2 5 -- tongue
    |> filled (hsl (degrees 346) 0.94 0.62)
    |> addOutline (solid 0.3) (hsl (degrees 31) 0.86 0.1)
    |> move (0,-8)
    ,
    oval 4 6 -- mouth
    |> filled (hsl (degrees 31) 0.86 0.3)
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> rotate (degrees -30)
    |> move (-2.2,-8)
    ,
    oval 4 6 -- mouth
    |> filled (hsl (degrees 31) 0.86 0.3)
    |> addOutline (solid 0.5) (hsl (degrees 31) 0.86 0.1)
    |> rotate (degrees 30)
    |> move (2.2,-8)
    ,
    triangle 1.6 -- nose
    |> filled (hsl (degrees 31) 0.86 0.1)
    |> rotate (degrees 30)
    |> scaleX 1.8
    |> move (0,-5.8)
  ]