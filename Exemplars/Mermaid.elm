-- Your shapes go here!
module Mermaid exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import Array exposing (..)

animationPieces pieces default t =
  case pieces of
    (duration, shape) :: rest ->
      if t <= duration then shape t
      else animationPieces rest default (t - duration)
    [] -> default t


q0 = (40,0)
q1 = (0,40)
q2 = (-40,0)
q3 = (0,-40)

xCoord (x,y) = x
yCoord (x,y) = y

add (x,y) (u,v) = (x+u,y+v)
sub (x,y) (u,v) = (x-u,y-v)
scaleP s (x,y) = (s*x,s*y)

myShapes model =
    [
      completeMermaid model
      |> move (0, 10*sin model.time*0.5)
    ]
   
   
completeMermaid model = group [
  tail model
      |> scale 0.5
      |> move (-68, -13)
        
     , mermaid
     |> scale 0.75
     |> move (-50, 15)
  ]

tail model = group [
  animationPieces
        (mkAnimationPieceVS addCurve subCurve scaleCurve
           flippers
          
        )
        ( \ t -> MyCurve (0,0) [] )
        ( 3 + 3 * cos model.time)
        |> drawCurve
        |> filled (rgb 244 96 180)
        
 ]
    
mermaid = group [
  -- hair
  curve (-47.81,14.838) [Pull (-46.96,12.488) (-45.71,14.538),Pull (-51.21,27.682) (-45.11,31.025),Pull (-44.96,33.223) (-42.41,35.822),Pull (-35.72,47.018) (-19.63,46.014),Pull (0.5573,44.523) (0.7494,21.433),Pull (1.9491,19.983) (1.3489,19.934),Pull (3.3487,18.437) (1.9484,13.339),Pull (2.6978,11.639) (3.4473,13.339),Pull (5.1985,7.8915) (0.1498,8.2435),Pull (-0.800,5.3950) (1.6487,4.3466),Pull (5.0978,3.7456) (3.7470,6.7447),Pull (8.6459,5.5480) (6.7447,-1.648),Pull (4.1976,-6.996) (-0.749,-6.744),Pull (-0.147,-13.79) (-5.545,-16.03),Pull (-8.843,-18.03) (-12.14,-17.23),Pull (-20.68,-8.992) (-29.22,-0.749),Pull (-34.62,-2.450) (-40.01,1.0491),Pull (-43.36,4.6463) (-43.91,8.2435),Pull (-47.81,7.5920) (-49.91,12.140),Pull (-49.91,14.439) (-47.81,14.838)]
    |> filled (rgb 69 38 14)
    
    -- face
    , curve (-37.62,21.133) [Pull (-37.36,17.335) (-39.71,15.138),Pull (-37.27,6.5915) (-27.42,6.4449),Pull (-23.23,5.6449) (-19.03,6.4449),Pull (-9.789,7.0920) (-7.344,13.939),Pull (-6.894,14.388) (-6.444,14.838),Pull (-3.895,14.287) (-4.346,17.536),Pull (-5.545,19.236) (-6.744,17.536),Pull (-8.392,21.583) (-12.44,23.831),Pull (-15.88,25.679) (-17.53,29.526),Pull (-22.13,25.578) (-30.12,25.030),Pull (-31.17,21.081) (-37.62,21.133)]
    |> filled (rgb 205 156 109)
    
    -- body
    , curve (-19.33,6.4449) [Pull (-19.63,5.9953) (-18.73,5.5456),Pull (-16.28,5.1459) (-15.43,4.9461),Pull (-14.23,4.5484) (-12.44,-1.049),Pull (-12.24,-2.548) (-11.84,-4.046),Pull (-9.592,-8.243) (-7.344,-12.44),Pull (-6.744,-12.44) (-6.145,-12.44),Pull (-5.545,-11.99) (-4.946,-11.54),Pull (-4.046,-11.79) (-4.346,-11.84),Pull (-2.747,-11.99) (-3.147,-12.74),Pull (-2.097,-13.33) (-2.847,-13.93),Pull (-2.398,-14.08) (-1.948,-14.23),Pull (-2.047,-16.08) (-4.346,-15.73),Pull (-6.296,-15.63) (-5.845,-18.13),Pull (-7.344,-19.53) (-7.644,-18.13),Pull (-7.943,-17.68) (-8.243,-17.23),Pull (-9.092,-17.38) (-9.742,-15.13),Pull (-12.04,-13.98) (-13.33,-10.64),Pull (-14.23,-8.393) (-15.13,-6.145),Pull (-14.83,-9.142) (-14.53,-12.14),Pull (-22.93,-11.99) (-31.32,-11.84),Pull (-31.47,-9.892) (-31.62,-7.943),Pull (-31.32,-6.594) (-31.02,-5.245),Pull (-31.77,-6.295) (-32.52,-7.344),Pull (-33.62,-13.04) (-36.72,-15.13),Pull (-37.12,-16.38) (-39.11,-17.83),Pull (-40.01,-18.78) (-40.91,-18.13),Pull (-40.21,-17.23) (-40.91,-16.33),Pull (-41.91,-15.13) (-44.51,-15.13),Pull (-45.46,-14.63) (-44.21,-13.93),Pull (-44.56,-12.63) (-43.31,-12.74),Pull (-43.71,-12.29) (-42.71,-11.84),Pull (-42.46,-10.84) (-41.21,-11.84),Pull (-40.91,-11.99) (-40.61,-12.14),Pull (-40.16,-12.29) (-39.71,-12.44),Pull (-39.56,-12.29) (-39.41,-12.14),Pull (-36.57,-8.693) (-34.92,-3.447),Pull (-34.17,0.5995) (-32.22,4.6463),Pull (-31.22,5.3960) (-28.62,5.5456),Pull (-27.12,5.8454) (-27.42,6.1451),Pull (-27.57,6.4449) (-27.72,6.7447),Pull (-23.83,7.1943) (-19.33,6.4449)]
    |> filled (rgb 205 156 109)
    
    -- waistband
    , curve (-14.83,-7.344) [Pull (-15.68,-8.993) (-18.13,-9.442),Pull (-21.63,-9.842) (-22.93,-10.64),Pull (-24.93,-9.992) (-27.72,-9.742),Pull (-31.12,-9.443) (-31.92,-7.344),Pull (-34.37,-7.293) (-34.02,-9.442),Pull (-33.47,-10.64) (-33.12,-10.64),Pull (-33.32,-12.69) (-30.72,-12.14),Pull (-29.97,-13.99) (-28.02,-13.03),Pull (-26.02,-14.93) (-23.23,-13.03),Pull (-20.83,-14.83) (-18.43,-13.03),Pull (-17.48,-14.59) (-15.73,-12.14),Pull (-13.53,-13.19) (-13.33,-10.04),Pull (-11.98,-8.193) (-14.83,-7.344)]
    |> filled (rgb 250 203 9)
    
    -- chest shirt
    , curve (-31.62,1.0491) [Pull (-32.22,-2.098) (-31.02,-5.245),Pull (-23.93,-7.445) (-15.43,-5.245),Pull (-15.28,-2.398) (-15.13,0.4496),Pull (-16.33,2.7491) (-17.53,1.6487),Pull (-19.03,3.6484) (-20.53,2.2482),Pull (-22.03,3.5981) (-23.53,2.5480),Pull (-25.33,3.6482) (-27.12,1.9484),Pull (-28.32,3.1985) (-29.52,1.6487),Pull (-30.57,2.0489) (-31.62,1.0491)]
    |> filled (rgb 250 203 9)
    
    -- mouth
    , curve (-25.92,9.7423) [Pull (-23.93,8.1423) (-21.13,9.7423)]
    |> outlined (solid 1) red
    
    -- star hair ornament
    , curve (-14.23,35.222) [Pull (-14.08,33.873) (-13.93,32.524),Pull (-14.53,31.325) (-15.13,30.126),Pull (-13.63,29.826) (-12.14,29.526),Pull (-11.09,28.327) (-10.04,27.128),Pull (-9.442,28.477) (-8.843,29.826),Pull (-7.494,30.426) (-6.145,31.025),Pull (-7.194,32.074) (-8.243,33.124),Pull (-8.543,34.622) (-8.843,36.121),Pull (-10.04,35.522) (-11.24,34.922),Pull (-12.74,35.072) (-14.23,35.222)]
    |> filled pink
    
    -- circle hair ornament (closest to star)
    , circle 1.5
    |> filled white
    |> move (-7.5, 28)
    
     -- circle hair ornament (2nd closest to star)
    , circle 1
    |> filled white
    |> move (-5.5, 26)
    
     -- circle hair ornament (3rd closest to star)
    , circle 0.75
    |> filled white
    |> move (-5, 24)
    
     -- circle hair ornament (4th closest to star)
    , circle 0.5
    |> filled white
    |> move (-5, 22.5)
    
    -- earring
    , circle 0.75
    |> filled pink
    |> move (-7.25, 14.5)
    
      -- right eye white
    , oval 4.5 3.8
    |> filled white
    |> move (-14, 16.7)
    
    -- left eye white
    , oval 4.5 3.8
    |> filled white
    |> move (-33, 16.7) 
    
    -- right eye black
    , oval 2.4 3.3
    |> filled black
    |> move (-14, 17.2)
    |> clip (oval 4.5 3.8
            |> filled white
            |> move (-14, 16.7))
    
    -- left eye black
    , oval 2.4 3.3
    |> filled black
    |> move (-33, 17.2)
    |> clip (oval 4.5 3.8
            |> filled white
            |> move (-33, 16.7))
 ]

-- this is called bilinear interpolation 
-- it follows the line between two points, tracing out a polygon
mkAnimationPiece listOfPoints =
  case listOfPoints of
    p0 :: p1 :: rest -> (1, \ t -> add p0 
                              (scaleP
                                 t 
                                 (sub p1 p0)
                              )
                        ) :: ( mkAnimationPiece (p1 :: rest) )
    _ -> []
    
mkAnimationPieceVS addVS subVS scaleVS listOfVectors =
  case listOfVectors of
    p0 :: p1 :: rest -> (1, \ t -> addVS p0 
                              (scaleVS 
                                 t 
                                 (subVS p1 p0)
                              )
                        ) :: ( mkAnimationPieceVS addVS subVS scaleVS (p1 :: rest) )
    _ -> []
    
type MyCurve = MyCurve (Float,Float) (List GraphicSVG.Pull)

drawCurve (MyCurve p0 pulls) = curve p0 pulls

addPull (Pull p0 p1) (Pull p2 p3) = Pull (add p0 p2) (add p1 p3)
subPull (Pull p0 p1) (Pull p2 p3) = Pull (sub p0 p2) (sub p1 p3)
scalePull s (Pull p2 p3) = Pull (scaleP s p2) (scaleP s p3)

addCurve (MyCurve p0 pulls0) (MyCurve p1 pulls1) =
  MyCurve (add p0 p1) (List.map2 addPull pulls0 pulls1)
subCurve (MyCurve p0 pulls0) (MyCurve p1 pulls1) =
  MyCurve (sub p0 p1) (List.map2 subPull pulls0 pulls1)
scaleCurve s (MyCurve p1 pulls1) =
  MyCurve (scaleP s p1) (List.map (scalePull s) pulls1)

flippers =
  [MyCurve (-9.442,40.018) [Pull (-21.99,9.1911) (1.6487,-17.23),Pull (-8.408,-45.32) (21.133,-55.60),Pull (23.533,-42.26) (19.934,-27.12),Pull (34.173,-30.88) (48.412,-19.03),Pull (35.425,2.1604) (13.039,-7.644),Pull (3.6903,3.6880) (11.540,38.220),Pull (-0.000,43.619) (-9.442,40.018)]
  , MyCurve (-9.442,40.018) [Pull (-23.39,27.841) (-5.545,-18.73),Pull (-13.04,-43.01) (1.6487,-58.90),Pull (17.394,-47.61) (13.339,-29.52),Pull (23.927,-38.87) (44.515,-28.62),Pull (35.328,-8.883) (10.941,-13.33),Pull (-1.358,-7.259) (10.941,38.220),Pull (0.4496,42.569) (-9.442,40.018)]
  , MyCurve (-9.742,39.718) [Pull (-22.89,22.091) (-8.243,-17.53),Pull (-25.68,-39.72) (-17.53,-53.50),Pull (-3.444,-57.11) (3.4473,-37.32),Pull (8.4892,-50.56) (24.131,-50.81),Pull (26.437,-31.02) (9.1428,-17.23),Pull (14.942,11.091) (9.7423,39.419),Pull (-1.949,41.919) (-9.742,39.718)]
  , MyCurve (-9.742,39.419) [Pull (-23.79,21.641) (-9.442,-16.93),Pull (-26.63,-21.32) (-30.42,-40.31),Pull (-19.33,-45.92) (-8.243,-33.72),Pull (-3.300,-46.31) (10.042,-48.71),Pull (15.144,-35.02) (5.2459,-19.33),Pull (16.493,21.742) (10.341,38.220),Pull (-1.900,43.669) (-9.742,39.419)]
  , MyCurve (-12.44,38.519) [Pull (-14.74,16.740) (-11.24,-15.43),Pull (-31.38,-23.57) (-33.12,-37.92),Pull (-21.13,-43.87) (-10.94,-34.02),Pull (-7.098,-47.66) (6.1451,-49.31),Pull (11.296,-35.17) (4.0468,-19.63),Pull (18.194,15.992) (10.941,38.819),Pull (-0.599,42.569) (-12.44,38.519)] 
  , MyCurve (-10.34,39.119) [Pull (-10.69,13.089) (-13.03,-13.33),Pull (-33.08,-22.88) (-35.52,-35.82),Pull (-22.18,-41.82) (-13.63,-32.82),Pull (-10.49,-45.61) (1.0491,-50.21),Pull (10.599,-41.62) (0.7494,-18.43),Pull (17.545,4.1423) (10.941,37.920),Pull (-0.299,43.119) (-10.34,39.119)]
  , MyCurve (-11.84,38.819) [Pull (-6.639,22.239) (-14.23,-12.14),Pull (-31.12,-18.93) (-38.22,-34.32),Pull (-25.37,-40.12) (-15.73,-32.52),Pull (-14.14,-43.71) (-1.948,-50.51),Pull (6.7512,-37.12) (-1.348,-18.73),Pull (16.696,0.6922) (10.341,38.519),Pull (-0.599,42.119) (-11.84,38.819)]
  , MyCurve (10.941,38.519) [Pull (19.744,14.292) (2.5480,-19.33),Pull (8.9480,-37.67) (2.5480,-52.60),Pull (-12.89,-49.56) (-14.53,-31.92),Pull (-22.63,-40.67) (-35.52,-34.62),Pull (-38.33,-21.98) (-13.33,-13.33),Pull (-5.390,1.5903) (-11.84,37.920),Pull (-6.199,42.970) (10.941,38.519)]
  , MyCurve (10.941,38.819) [Pull (12.996,-3.907) (-2.548,-20.23),Pull (3.5039,-46.87) (-7.644,-54.70),Pull (-22.98,-49.01) (-18.13,-26.52),Pull (-32.17,-30.53) (-43.61,-20.53),Pull (-34.57,-6.788) (-20.53,-10.04),Pull (-6.487,-5.111) (-12.44,38.220),Pull (-2.649,42.420) (10.941,38.819)]
  ]

  

approachesOne t = (1 - 0.5 / (1 + t)) * 10

myRepeat t = 3 * sin ( 0.3 * t )

liftOff t = 
  if t < 2 then
    0
  else if t < 7 then
    10 * (t - 2)
  else
    50
    
liftOff2 t =
  animationPieces
    [(2, \ tt -> 0)
    ,(1, \ tt -> 50 / 20 * (10 - 10 * cos (pi * tt) ) )
    ,(1, \ tt -> (45 + 5 * cos (pi * tt) ))
    ,(2, \ tt -> 40)
    ,(2, \ tt -> (30 + 10 * cos (0.5 * pi * tt) ))
    ]
    ( \ tt -> 20 )
    t

-- needs at least 3 floats to interpolate
interpolateFloats floats t = 
  let
    len = Array.length floats
    intTime = floor t
    fracTime = 0.5 * pi * (t - toFloat intTime)
    idx0 = modBy len intTime 
    idx1 = modBy len (intTime + 1) 
    idx2 = modBy len (intTime + 2) 
    idx3 = modBy len(intTime + 3) 
  in
    case (Array.get idx0 floats, Array.get idx1 floats, Array.get idx2 floats) of
      (Just p0, Just p1, Just p2) ->
        let
          p0top2 = p2 - p0
          midPoint = 0.5 * (p2 + p0)
          midTop1 = p1 - midPoint
        in
          sin fracTime
      _ ->
        0



type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

