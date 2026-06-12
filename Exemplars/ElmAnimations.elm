-- Your shapes go here!
-- You can use model.time to animate things :)

module ElmAnimations exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

myShapes model =
  [
   rect 500 500 
     |> filled 
        (
          gradient
            [
            
            --light blue
             stop (rgb 134 229 247) -33
           --blue
           ,stop (rgb 0 167 200) 30
        
            ]
            |> rotateGradient (degrees -90)
        )
        
  ,flower blue 
  |> makeTransparent (1*abs(sin(model.time)))
  |> move (100*sin (2*model.time), 60*cos(1*model.time))
  
  , flower pink
  |> mirrorX
  |> move (100*sin (2*model.time), cos(1*model.time))
  |> rotate (degrees 30*model.time)

  ]

flower pedal = group [
--petals
  circle 15
  |> filled pedal
  
  , circle 15
  |> filled pedal
  |> move (15, 11)
  
  , circle 15
  |> filled pedal
  |> move (10, 31)
  
  , circle 15
  |> filled pedal
  |> move (-15, 11)
  
  , circle 15
  |> filled pedal
  |> move (-10, 31)
  
  --centre (pistil)
  , circle 15
  |> filled yellow
  |> move (0, 17)
  
  ,--mouth
  wedge 3 0.5
  |> filled black
  |> rotate (degrees 270)
  |> move (-3, 10)
  
  --left eye
  ,oval 2 4
  |> filled black
  |> move (-8, 18)
  
  --right eye
  ,oval 2 4
  |> filled black
  |> move (0, 18)
  
 ]
 
  


type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

