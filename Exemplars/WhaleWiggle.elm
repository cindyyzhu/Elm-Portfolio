module WhaleWiggle exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

wiggleCurve t pos pulls =
  curve (wigglePt t pos) (List.map (wiggle t) pulls)

myShapes model =
  [
    -- neck
    wiggleCurve model.time (-92.77,4.6463)
      [Pull (-88.83,-1.360) (-75.69,-2.847),Pull (-68.41,-4.125) (-62.50,-8.843),Pull (-51.86,-14.96) (-40.91,-18.73),Pull (-42.26,-16.33) (-43.61,-13.93),Pull (-55.92,-5.715) (-63.40,2.5480),Pull (-88.98,6.6870) (-92.77,4.6463)]
    |> filled (rgb 155 172 184)
    |> addOutline (solid 1) black
    
    -- neck left line
    , wiggleCurve model.time (-87.98,5.2459) [Pull (-85.49,1.5282) (-79.28,-0.749),Pull (-74.83,-1.328) (-71.49,-3.147),Pull (-71.19,-3.447) (-70.89,-3.747)]
    |> outlined (solid 1) black
    
    -- neck second left line
    , wiggleCurve model.time (-81.68,4.6463) [Pull (-78.20,0.3183) (-73.29,-0.449),Pull (-68.49,-1.556) (-63.70,-7.344)]
    |> outlined (solid 1) black
    
    -- neck third left line
    , wiggleCurve model.time (-76.59,4.3466) [Pull (-73.63,1.2884) (-68.79,-0.449),Pull (-64.12,-2.226) (-60.70,-7.644),Pull (-56.92,-11.98) (-51.70,-13.63)]
    |> outlined (solid 1) black
    
    -- neck fourth left line
    , wiggleCurve model.time (-69.09,3.1475) [Pull (-66.16,-0.540) (-62.80,-2.548),Pull (-59.35,-4.885) (-55.90,-8.543),Pull (-52.45,-11.92) (-49.01,-13.93),Pull (-46.16,-15.73) (-43.31,-17.53),Pull (-42.56,-17.98) (-41.81,-18.43)]
    |> outlined (solid 1) black
  
    -- whale body
    , wiggleCurve model.time (-92.77,4.9461) 
      [Pull (-90.97,5.9357) (-89.18,5.8454),Pull (-76.29,4.4964) (-63.40,3.1475),Pull (-60.65,-1.659) (-55.30,-4.946),Pull (-50.01,-9.223) (-45.71,-12.14),Pull (-34.23,-18.45) (-22.03,-21.13),Pull (-11,-25.45) (0,-25.13),Pull (16.671,-25.94) (44.215,-3.747),Pull (61.054,7.1117) (73.292,-0.749),Pull (83.334,-5.578) (93.377,-3.447),Pull (83.493,-1.550) (75.690,4.9461),Pull (83.806,7.4223) (85.882,14.538),Pull (86.171,16.897) (88.580,17.536),Pull (77.990,20.859) (62.800,10.341),Pull (28.403,4.4219) (4.6463,10.341),Pull (-90.07,20.833) (-92.77,4.9461)]
    |> filled (rgb 104 121 140)
    |> addOutline (solid 1) black
    
    -- whale front fin
    , curve (-47.51,-9.142) [Pull (-41.48,-14.44) (-32.82,-30.42),Pull (-23.52,-43.73) (3.4473,-47.21),Pull (5.5682,-45.66) (1.0491,-42.11),Pull (-10.82,-31.41) (-23.53,-20.83),Pull (-28.90,-13.30) (-34.32,-12.14),Pull (-36.40,-11.63) (-36.72,-9.442)]
    |> filled (rgb 104 121 140)
    |> addOutline (solid 1) black
    
    -- top fin
    , curve (4.0468,10.941) [Pull (11.082,13.151) (15.437,10.641),Pull (13.108,9.9525) (13.339,8.5433)]
    |> filled (rgb 104 121 140)
    |> addOutline (solid 1) black
    |> move (0,-2 + 1 * sin model.time)
    
    -- bottom fin
    , curve (-49.61,-16.03) [Pull (-53.72,-32.87) (-48.11,-39.11),Pull (-45.12,-41.35) (-44.21,-37.92),Pull (-43.96,-29.54) (-41.51,-18.73)]
    |> filled (rgb 104 121 140)
    |> addOutline (solid 1) black
    
    
    -- eye
    , curve (-58.30,-0.449) [Pull (-56.95,0.3207) (-55.60,-1.348),Pull (-55.36,-3.018) (-57.40,-2.248),Pull (-59.06,-2.198) (-58.30,-0.449)]
    |> filled black
    
    -- eye white
    , circle 0.5
    |> filled white
    |> move (-57, -1)
    
    -- eyebrow
    , curve (-58.90,0.7494) [Pull (-58.66,1.4990) (-57.10,1.6487)]
    |> outlined (solid 1) black
  ]

wigglePt t (x,y) = 
  if x > 0 then
    (x,y + 5 * x/80 * sin (3*pi/2/90*x) * sin t)
  else
    (x,y + 1 * sin (3*pi/2/90*x) * sin t)
    
wiggle t (Pull (x,y) (u,v)) = 
    Pull (wigglePt t (x,y)) (wigglePt t (u,v))

type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)



