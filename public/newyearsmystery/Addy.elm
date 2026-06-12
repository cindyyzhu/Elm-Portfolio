module Main exposing (..)

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
   addy
 
  
  ]

addy = group [

  --left shoe
    curve (-62.05,-31.92) [Pull (-61.90,-32.22) (-61.75,-32.52),Pull (-61.60,-33.72) (-61.45,-34.92),Pull (-64.74,-36.57) (-68.04,-38.22),Pull (-70.74,-38.72) (-69.24,-36.42),Pull (-67.39,-34.17) (-65.34,-32.52),Pull (-63.70,-32.22) (-62.05,-31.92)]
    |> filled red
    
    --left leg
    , curve (-61.15,-14.53) [Pull (-61.30,-23.98) (-61.45,-33.42),Pull (-63.55,-34.07) (-65.64,-33.12),Pull (-66.99,-24.13) (-68.34,-15.13),Pull (-64.74,-15.28) (-61.15,-14.53)]
    |> filled blue
    
    --right shoe
    ,   
    curve (-59.35,-32.52) [Pull (-59.35,-33.72) (-59.35,-34.92),Pull (-56.20,-36.42) (-53.05,-37.92),Pull (-49.75,-38.37) (-51.25,-36.42),Pull (-53.20,-33.67) (-55.75,-32.52),Pull (-57.55,-32.67) (-59.35,-32.52)]
    |> filled red
    
    --right leg
    , 
    curve (-59.35,-14.83) [Pull (-59.35,-23.83) (-59.35,-32.82),Pull (-57.80,-34.47) (-54.85,-33.12),Pull (-54.10,-24.28) (-53.35,-15.43),Pull (-56.50,-15.13) (-59.35,-14.83)]
    |> filled blue
    
    --right hand mitt
    , 
    curve (-49.76,-3.747) [Pull (-50.36,-8.844) (-47.96,-11.54),Pull (-44.26,-12.79) (-44.36,-9.442),Pull (-44.41,-5.795) (-45.86,-3.147),Pull (-47.81,-3.297) (-49.76,-3.747)]
    |> filled purple
    
    --left hand mitt
    , 
    curve (-70.44,-4.346) [Pull (-70.04,-8.293) (-72.24,-11.84),Pull (-76.24,-13.19) (-75.84,-8.543),Pull (-75.39,-5.995) (-73.74,-3.447),Pull (-72.24,-4.196) (-70.44,-4.346)]
    |> filled purple
    
    --right eye fold
    
    ,curve (-59.05,31.925) [Pull (-56.65,33.925) (-54.25,31.925)]
    |> outlined (solid 0.05) brown
    
    --left eye fold
    , 
    curve (-61.45,31.925) [Pull (-63.85,33.974) (-66.24,32.224)]
    |> outlined (solid 0.05) brown
    
    -- left eye brow
    , 
    curve (-61.45,33.124) [Pull (-63.00,34.373) (-65.34,34.023)]
    |> outlined (solid 0.2) brown
    
   
    
    --hair (lower half)
    , 
    curve (-53.05,28.028) [Pull (-52.00,26.679) (-50.96,25.330),Pull (-45.36,23.032) (-50.36,18.735),Pull (-47.91,16.487) (-50.06,14.238),Pull (-60.25,13.639) (-70.44,13.039),Pull (-72.54,15.437) (-71.04,17.836),Pull (-73.84,21.933) (-69.84,23.831),Pull (-70.29,26.679) (-68.94,29.526),Pull (-61.00,28.777) (-53.05,28.028)]
    |> filled darkBrown 
    
    --head
    ,
    curve (-68.34,36.721) [Pull (-69.14,28.276) (-64.74,23.831),Pull (-59.55,20.781) (-55.15,23.531),Pull (-46.55,32.224) (-55.75,40.918),Pull (-65.25,43.669) (-68.34,36.421)]
    |> filled (rgb 241 194 125)
   
    
    --hair (upper half)
    , 
    curve (-65.04,37.620) [Pull (-59.20,31.922) (-51.55,32.824),Pull (-53.10,43.621) (-65.04,40.618),Pull (-70.39,36.671) (-68.94,31.325),Pull (-65.74,34.323) (-65.04,37.620)]
    |> filled darkBrown
    
   
    
      --left eye
    , circle 2.2
    |> filled white
    |> move (-63.8, 30.5)
    
    --right eye
    , circle 2.2
    |> filled white
    |> move (-56.7, 30.5)
    
    
    
    --left eye pupil
    , circle 1.3
    |> filled black
    |> move (-63.5, 30.5)
    
    --right eye pupil
    , circle 1.3
    |> filled black
    |> move (-57, 30.5) 
    
    
    --mouth
    ,
    curve (-62.35,27.128) [Pull (-60.25,26.428) (-58.15,27.128)]
    |> outlined (solid 0.2) black
    
    --nose
    , 
    curve (-61.15,28.627) [Pull (-60.40,29.027) (-59.65,28.627)]
    |> outlined (solid 0.2) black
    
    --headband
    , 
    curve (-69.24,32.524) [Pull (-69.19,41.321) (-60.55,41.517),Pull (-51.35,41.171) (-51.55,32.224)]
    |> outlined (solid 1) red
    
    --right ear muff
    , oval 5.5 8
    |> filled green
    |> rotate (degrees -8)
    |> move (-52, 29)
    
    
    --left ear muff
    , oval 5.5 8
    |> filled green
    |> rotate (degrees 8)
    |> move (-68, 29)
   
    
  
    
      --jacket
   , curve (-53.05,19.035) [Pull (-47.41,14.194) (-45.56,-4.646),Pull (-47.81,-5.296) (-50.06,-4.946),Pull (-50.45,4.3466) (-53.65,13.639),Pull (-48.70,-1.747) (-49.76,-20.53),Pull (-59.90,-25.08) (-70.44,-20.23),Pull (-69.89,0.6526) (-66.54,13.339),Pull (-68.74,4.9468) (-70.14,-5.245),Pull (-72.84,-5.046) (-74.34,-4.046),Pull (-71.79,15.593) (-66.24,19.634),Pull (-57.30,13.134) (-53.05,19.035)]
    |> filled pink
    
    --jacket line in the middle
    , 
    curve (-60.25,18.135) [Pull (-60.65,-2.098) (-60.25,-22.33)]
    |> outlined (solid 0.3) black
    
    --jacket button (bottommost one)
    , circle 0.8
    |> filled yellow
    |> move (-62, -20)
    
    --jacket button
    , circle 0.8
    |> filled yellow
    |> move (-62, -12)
    
    --jacket button
    , circle 0.8
    |> filled yellow
    |> move (-62, -5)
    
    --jacket button
    , circle 0.8
    |> filled yellow
    |> move (-62, 2)
    
    --jacket button (topmost one)
    , circle 0.8
    |> filled yellow
    |> move (-62, 10)
    
   --scarf
    ,
    curve (-64.74,23.531) [Pull (-65.94,23.532) (-65.34,22.332),Pull (-66.54,20.983) (-65.94,19.634),Pull (-58.65,12.934) (-53.35,19.035),Pull (-52.85,20.434) (-53.95,21.433),Pull (-53.55,23.182) (-54.55,23.531),Pull (-59.35,21.081) (-64.74,23.531)]
    |> filled white
    
    --scarf line

    ,curve (-60.85,20.533) [Pull (-59.15,19.784) (-56.05,20.234)]
    |> outlined (solid 0.2) black
    
    --scarf line
    , 
    curve (-63.25,21.433) [Pull (-62.00,19.084) (-56.95,18.735)]
    |> outlined (solid 0.2) black
 ]