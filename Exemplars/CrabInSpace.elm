module CrabInSpace exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import Html
import Html.Attributes

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
  

galaxy = "https://images.pexels.com/photos/813269/pexels-photo-813269.jpeg?cs=srgb&dl=pexels-min-an-813269.jpg&fm=jpg"

myShapes model = [
  (html 5000 5000 <| Html.img [Html.Attributes.src galaxy] [] )
                      |> scale 0.06
                      |> move (-100,70)
  , crab model
  |> scale 0.45
  |> scale (0.7+0.2*sin(1.5*model.time))
  |> rotate (5*sin( 1*model.time))
  |> move (50*tan model.time, -10)
 ]

stops t = 
  List.range 0 10 
    |> List.map ( 
        \ idx -> stop (hsl (t + degrees 10 * toFloat idx) 1 0.5) 
        (5 * toFloat idx)
        )
        
crab model = group [
  -- right middle leg
  curve (46.613,-11.24) [Pull (60.906,-9.835) (65.798,-25.62),Pull (66.249,-28.92) (63.700,-30.42),Pull (59.302,-30.92) (58.903,-26.22),Pull (58.604,-23.53) (56.505,-20.83),Pull (51.259,-16.43) (46.014,-17.83),Pull (44.665,-18.13) (43.316,-18.43),Pull (42.566,-15.73) (41.817,-13.03),Pull (44.065,-11.99) (46.613,-11.24)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- right bottom leg
  , curve (36.421,-26.52) [Pull (39.868,-26.12) (43.316,-27.12),Pull (47.913,-28.82) (49.311,-34.32),Pull (50.010,-36.42) (51.110,-38.51),Pull (57.107,-41.52) (56.505,-34.32),Pull (55.109,-26.42) (47.512,-21.73),Pull (43.466,-19.93) (39.419,-19.93),Pull (37.470,-21.73) (35.522,-23.53),Pull (35.672,-24.88) (36.421,-26.52)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  {--- right pincer
  , curve (55.007,43.915) [Pull (44.958,29.725) (50.510,17.536),Pull (53.658,12.888) (56.206,12.440),Pull (69.348,7.4882) (74.491,17.536),Pull (80.243,33.626) (69.995,42.716),Pull (66.047,39.170) (63.700,34.023),Pull (62.653,42.619) (55.007,43.915)]
  |> filled (rgb 234 54 32)
  |> addOutline (solid 1) black -}
  
  -- right pincer left side
  , curve (63.700,33.723) [Pull (61.653,42.619) (55.606,43.915),Pull (48.359,35.923) (48.112,23.531),Pull (50.959,13.835) (56.206,12.740),Pull (59.353,11.290) (62.501,11.241),Pull (67.350,22.932) (63.700,33.723)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- right pincer right side
  , curve (63.700,34.023) [Pull (65.447,38.519) (69.995,43.016),Pull (77.642,38.623) (76.889,24.430),Pull (74.445,9.7861) (62.201,10.941),Pull (58.600,22.632) (63.700,34.023)]
   |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )

  -- right upper arm
  , curve (46.613,4.9461) [Pull (52.610,4.5943) (55.007,9.4426),Pull (55.756,10.941) (56.505,12.440),Pull (59.653,10.540) (62.800,10.641),Pull (61.854,3.5960) (54.707,-0.449),Pull (50.960,-2.049) (47.213,-1.648),Pull (45.414,1.1990) (46.613,4.9461)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- left bottom leg
  , curve (-41.81,-24.13) [Pull (-53.26,-29.17) (-52.90,-40.01),Pull (-50.51,-45.31) (-46.91,-40.01),Pull (-43.71,-31.12) (-39.71,-31.02),Pull (-37.17,-30.32) (-34.62,-29.82),Pull (-32.82,-28.02) (-31.02,-26.22),Pull (-34.77,-23.68) (-38.51,-21.13),Pull (-39.86,-22.33) (-41.81,-24.13)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- left middle leg
  , curve (-43.61,-21.13) [Pull (-46.91,-21.58) (-50.21,-22.63),Pull (-54.15,-24.32) (-55.30,-29.82),Pull (-56.50,-33.52) (-59.50,-34.02),Pull (-63.40,-33.67) (-61.90,-27.12),Pull (-59.80,-20.33) (-55.30,-17.53),Pull (-51.70,-14.93) (-48.11,-15.13),Pull (-45.71,-14.53) (-43.31,-13.93),Pull (-42.11,-16.63) (-40.91,-19.33),Pull (-42.41,-20.08) (-43.61,-21.13)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  {-- left pincer
  , curve (-72.39,42.716) [Pull (-84.94,28.977) (-75.09,15.437),Pull (-65.64,7.0885) (-56.80,13.939),Pull (-48.45,19.132) (-50.51,30.126),Pull (-52.35,37.170) (-57.40,44.215),Pull (-63.90,43.119) (-65.79,34.023),Pull (-68.44,39.920) (-72.39,42.716)]
  |> filled (rgb 234 54 32)
  |> addOutline (solid 1) black -}
  
  -- left pincer right side
  , curve (-65.49,34.023) [Pull (-63.70,42.919) (-57.10,44.215),Pull (-49.25,34.123) (-50.81,22.632),Pull (-52.05,16.036) (-57.70,13.039),Pull (-59.65,12.140) (-61.60,11.241),Pull (-68.10,19.832) (-65.49,34.023)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
    
  -- left pincer left side
  , curve (-72.69,43.016) [Pull (-81.24,32.925) (-77.78,20.234),Pull (-73.69,11.237) (-65.79,10.641),Pull (-63.55,11.241) (-61.30,11.840),Pull (-60.15,22.632) (-65.79,33.423),Pull (-68.09,38.220) (-72.69,43.016)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- left upper leg
  , curve (-49.91,-0.749) [Pull (-57.95,-1.551) (-62.80,5.8454),Pull (-64.69,8.6932) (-65.19,11.540),Pull (-61.75,12.440) (-58.30,13.339),Pull (-58.05,10.341) (-55.00,7.3442),Pull (-51.85,5.1449) (-48.71,5.5456),Pull (-47.06,4.3466) (-45.41,3.1475),Pull (-45.41,0.7494) (-45.41,-1.648),Pull (-47.66,-1.049) (-49.91,-0.749)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- left eye rect
  , curve (-25.62,31.925) [Pull (-26.48,27.128) (-24.13,22.332),Pull (-21.58,22.932) (-19.03,23.531),Pull (-22.33,27.477) (-21.43,32.824),Pull (-23.53,32.674) (-25.62,31.925)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
    -- left eye circle (red)
  , curve (-30.42,49.611) [Pull (-36.47,35.868) (-25.92,30.725),Pull (-16.68,29.822) (-15.43,39.119),Pull (-13.68,49.714) (-19.33,51.709),Pull (-27.98,53.510) (-30.42,49.611)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- left eye circle (black)
  , curve (-25.92,38.220) [Pull (-23.68,36.870) (-21.43,38.519),Pull (-19.53,41.967) (-20.83,45.414),Pull (-23.38,47.614) (-26.52,44.814),Pull (-27.92,42.117) (-25.92,38.220)]
  |> filled black
  |> addOutline (solid 1) black
  
  -- left eye circle (white)
  , circle 1
  |> filled white
  |> move (-22.5, 44)
  
  -- right eye rect
  , curve (17.536,34.622) [Pull (20.286,29.227) (16.037,23.831),Pull (18.735,23.531) (21.433,23.231),Pull (24.782,29.176) (22.332,36.721),Pull (20.084,35.522) (17.536,34.622)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- right eye circle (red)
  , curve (10.042,49.311) [Pull (7.5901,38.867) (15.138,33.423),Pull (22.133,29.272) (25.929,37.920),Pull (29.230,44.964) (24.730,52.009),Pull (21.035,56.259) (12.140,52.309),Pull (10.491,50.960) (10.042,49.611),Pull (10.042,49.461) (10.042,49.311)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- right eye circle (black)
  , curve (14.838,45.714) [Pull (14.537,41.716) (16.637,40.318),Pull (18.735,39.318) (20.833,40.918),Pull (21.983,43.765) (21.133,46.613),Pull (18.735,48.763) (16.337,47.512),Pull (15.137,46.463) (14.838,45.714)]
  |> filled black
  |> addOutline (solid 1) black
  
   -- left eye circle (white)
  , circle 1
  |> filled white
  |> move (18.7, 45.5)
  
  -- body
  , curve (-48.71,5.2459) [Pull (-54.56,-16.14) (-34.02,-30.12),Pull (2.7990,-49.17) (36.421,-26.82),Pull (51.667,-13.29) (46.313,7.6440),Pull (45.614,10.192) (43.316,12.740),Pull (41.067,15.038) (38.819,16.337),Pull (32.824,20.034) (26.829,22.332),Pull (20.683,24.431) (14.538,25.330),Pull (6.7447,26.429) (-1.049,26.529),Pull (-11.14,26.630) (-19.63,24.131),Pull (-25.48,22.732) (-31.32,20.533),Pull (-34.17,19.585) (-37.02,17.836),Pull (-38.96,16.987) (-40.91,15.138),Pull (-43.01,13.489) (-45.11,11.241),Pull (-46.61,9.5428) (-48.11,7.0444),Pull (-48.56,6.1451) (-48.71,5.2459)]
  |> filled 
          (
            gradient
              (stops (model.time*0.4))
              |> rotateGradient (degrees 90)
    )
  
  -- mouth
  , curve (-9.442,1.9484) [Pull (0.2508,-8.751) (7.3442,3.1475)]
  |> outlined (solid 2.5) black
  ]
