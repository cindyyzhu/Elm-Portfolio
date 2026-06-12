-- Your shapes go here!
module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import Html
import Html.Attributes

forest = "https://cdn.wallpapersafari.com/21/28/p1l8b2.jpg"

myShapes model =
  [
  
  (html 5000 5000 <| Html.img [Html.Attributes.src forest] [] )
                      |> scale 0.13
                      |> move (-100,90)
                      
   , fox
   |> scale 0.5
   |> move (35, -20)
  ]

fox = group [
   -- tail
   curve (-0.449,-10.64) [Pull (3.7470,-7.396) (7.9437,2.8477),Pull (14.087,16.342) (24.430,16.637),Pull (32.974,16.936) (41.517,17.236),Pull (39.518,16.337) (39.119,13.639),Pull (36.922,2.1974) (32.524,-7.044),Pull (27.330,-20.08) (18.135,-25.92),Pull (14.538,-28.17) (10.941,-28.02),Pull (5.2459,-26.82) (-0.449,-25.62),Pull (-2.098,-18.58) (-0.449,-10.64)]
  |> filled (rgb 189 116 29)
  |> addOutline (solid 1) black
  
  -- tail tip
  , curve (9.4426,5.8454) [Pull (16.487,10.344) (22.332,9.4426),Pull (19.183,4.1967) (20.833,-1.049),Pull (25.929,3.2990) (31.025,3.4473),Pull (29.175,-2.098) (31.925,-7.644),Pull (37.272,3.0971) (39.419,14.838),Pull (39.718,16.737) (41.217,17.236),Pull (31.625,17.337) (22.032,16.037),Pull (15.087,15.341) (9.4426,5.8454)]
  |> filled (rgb 244 236 203)
  |> addOutline (solid 1) black
  
  -- left back leg
  , curve (-41.81,-23.23) [Pull (-48.86,-18.92) (-49.31,-28.02),Pull (-49.21,-32.67) (-45.71,-35.52),Pull (-50.56,-37.02) (-50.21,-39.71),Pull (-49.31,-42.31) (-44.21,-42.71),Pull (-41.06,-42.66) (-37.92,-41.81),Pull (-39.86,-32.52) (-41.81,-23.23)]
  |> filled (rgb 189 116 29)
  |> addOutline (solid 1) black
  
  -- right back leg
  , curve (2.5480,-23.83) [Pull (9.8948,-17.63) (10.641,-26.82),Pull (11.392,-31.17) (7.3442,-35.52),Pull (9.4426,-35.42) (11.540,-38.51),Pull (13.142,-42.01) (8.5433,-42.71),Pull (3.6969,-43.66) (-0.749,-41.21),Pull (0.8992,-32.52) (2.5480,-23.83)]
  |> filled (rgb 189 116 29)
  |> addOutline (solid 1) black
  
  -- body
   , curve (-33.12,2.8477) [Pull (-41.98,-12.87) (-42.11,-28.92),Pull (-43.08,-40.69) (-34.32,-43.61),Pull (-17.97,-46.29) (-3.747,-43.01),Pull (3.8204,-40.46) (2.5480,-25.03),Pull (1.0715,-9.651) (-6.444,2.8477),Pull (-19.93,-2.072) (-33.12,2.8477)]
  |> filled (rgb 228 144 34)
  |> addOutline (solid 1) black
  
  -- belly
  , curve (-25.92,1.0491) [Pull (-39.10,-23.54) (-30.72,-33.42),Pull (-26.82,-35.07) (-22.93,-36.72),Pull (-19.33,-37.21) (-15.73,-37.02),Pull (-11.84,-35.37) (-7.943,-33.72),Pull (0.6578,-23.39) (-12.14,0.4496),Pull (-19.03,0.7494) (-25.92,1.0491)]
  |> filled (rgb 244 236 203)
  |> addOutline (solid 1) black
  
  -- left leg
  , curve (-30.72,-25.92) [Pull (-30.87,-33.12) (-31.02,-40.31),Pull (-36.17,-42.81) (-33.72,-46.91),Pull (-28.32,-50.11) (-25.33,-45.71),Pull (-20.83,-37.52) (-23.53,-25.92),Pull (-27.12,-20.37) (-30.72,-25.92)]
  |> filled (rgb 228 144 34)
  |> addOutline (solid 1) black
  
  -- right leg
  , curve (-13.93,-24.13) [Pull (-18.48,-35.47) (-13.03,-45.41),Pull (-9.093,-50.01) (-4.346,-46.01),Pull (-2.895,-42.21) (-7.644,-40.61),Pull (-7.644,-33.27) (-7.644,-25.92),Pull (-9.541,-20.78) (-13.63,-23.83),Pull (-13.98,-24.13) (-13.93,-24.13)]
  |> filled (rgb 228 144 34)
  |> addOutline (solid 1) black
  
  -- right leg cover up
  , curve (-13.93,-24.73) [Pull (-13.33,-23.83) (-12.74,-22.93)]
  |> outlined (solid 1) black 
  
  -- head
  , curve (-55.30,17.536) [Pull (-43.73,1.5929) (-19.03,0.4496),Pull (4.6611,1.4927) (16.037,18.135),Pull (1.6115,45.134) (-19.93,46.014),Pull (-42.25,44.605) (-55.30,17.536)]
  |> filled (rgb 244 236 203)
  |> addOutline (solid 1) black
  
  -- nose
  , curve (-23.23,14.538) [Pull (-22.78,12.239) (-19.33,12.140),Pull (-16.23,12.189) (-16.33,14.838),Pull (-19.78,14.838) (-23.23,14.538)]
  |> filled black
  |> addOutline (solid 1) black
  
  -- forehead
  , curve (-55.30,17.236) [Pull (-40.57,34.767) (-22.93,14.538),Pull (-19.78,14.538) (-16.63,14.538),Pull (-0.299,33.837) (16.037,18.135),Pull (1.3816,45.254) (-20.23,46.014),Pull (-41.20,45.105) (-55.30,17.236)]
  |> filled (rgb 228 144 34)
  |> addOutline (solid 1) black
  
  -- right line for mouth
  , curve (-19.63,11.840) [Pull (-19.78,10.491) (-19.93,9.1428),Pull (-15.68,6.0421) (-14.23,10.941)]
  |> outlined (solid 1) black
  
  -- left line for mouth
  , curve (-19.93,11.840) [Pull (-19.93,10.341) (-19.93,8.8430),Pull (-23.83,5.9922) (-25.33,10.941)]
  |> outlined (solid 1) black
  
  -- outer left ear
  , curve (-46.31,31.925) [Pull (-50.45,40.688) (-48.71,49.011),Pull (-40.24,49.064) (-32.82,42.716),Pull (-40.01,39.150) (-46.31,31.925)]
  |> filled (rgb 228 144 34)
  |> addOutline (solid 1) black
  
  -- inner left ear
  , curve (-44.21,35.222) [Pull (-46.70,39.858) (-45.71,44.814),Pull (-40.65,45.026) (-36.12,40.918),Pull (-39.86,37.920) (-44.21,35.222)]
  |> filled (rgb 189 116 29)
  |> addOutline (solid 1) black
  
  -- outer right ear
  , curve (-6.444,42.716) [Pull (1.0788,48.764) (9.4426,49.011),Pull (11.303,39.868) (6.4449,31.925),Pull (0.5400,38.640) (-6.444,42.716)]
  |> filled (rgb 228 144 34)
  |> addOutline (solid 1) black
  
  -- inner right ear
  , curve (-3.447,41.217) [Pull (1.0287,45.066) (6.7447,45.114),Pull (6.7856,39.588) (4.3466,34.622),Pull (0.2997,37.770) (-3.447,41.217)]
  |> filled (rgb 189 116 29)
  |> addOutline (solid 1) black
  
  -- right eye
  , circle 3
  |> filled black
  |> move (-4, 16)
  
  -- right eye bottom speck
  , circle 0.7
  |> filled white
  |> move (-5, 14.5)
  
  -- right eye left speck
  , circle 0.45
  |> filled white
  |> move (-6, 15.6)
  
  -- left eye
  , circle 3
  |> filled black
  |> move (-35, 16)
  
  -- left eye bottom speck
  , circle 0.7
  |> filled white
  |> move (-36, 14.5)
  
  -- left eye left speck
  , circle 0.45
  |> filled white
  |> move (-37, 15.6)
 ]

type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

init = { time = 0 }

update msg model =
  case msg of
    Tick t _ -> { model | time = t }

view model = collage 192 128 (myShapes model)

main = gameApp Tick { model = init, view = view, update = update, title = "Starfish" }
