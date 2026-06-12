module PredatorPrey exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import Random


--import Bluejay
--import Robin
--import Worm

horizScale = 8
vertScale = 20

drawInitial maxAnimals dimensionless = 
  round (dimensionless * maxAnimals)
    |> String.fromInt
    |> text
    |> alignRight
    |> size 3
    |> filled black
    |> move (-85, dimensionless * vertScale - 2)
  
myShapes model =
  let 
    (x0,y0,z0) = model.start
    
    drawPoints currentTime =
       case List.drop (currentTime * 10 |> round ) model.observations of
            [] -> group []
            (t,(worms,robins,bluejays)) :: rest ->
              let 
                xWorm = currentTime * horizScale - 66
                yWorm = vertScale * worms
                diffWR = abs (worms - robins) * vertScale
                yRobin = vertScale * robins
                diffWB = abs (worms - bluejays) * vertScale
                yBluejay = vertScale * bluejays
              in
                [ circle 1 |> filled pink
                    |> move (xWorm , yWorm )
                -- x * (1 - x)
                , polygon [ (xWorm, yWorm )
                          , (xWorm + yWorm, 0)
                          , (xWorm + yWorm + (1-worms) * vertScale, (1-worms) * vertScale)
                          , (xWorm + (1-worms) * vertScale, 1 * vertScale)
                          ]
                            |> filled pink
                            |> makeTransparent 0.75
                            |> ( if worms > 1 then 
                                   addOutline (solid 0.5) black
                                 else
                                   identity
                               )
                -- x * y
                , polygon [ (xWorm - 0.5 * diffWR, yWorm - 0.5 * diffWR)
                          , (xWorm + yWorm - 0.5 * diffWR, 0 - 0.5 * diffWR)
                          , (xWorm + yWorm - 0.5 * diffWR - yRobin, 0 - 0.5 * diffWR - yRobin)
                          , (xWorm - 0.5 * diffWR - yRobin, yWorm - 0.5 * diffWR - yRobin)
                          ]
                            |> filled red
                            |> makeTransparent 0.75
                -- x * z
                , polygon [ (xWorm - 0.5 * diffWB, yWorm - 0.5 * diffWB)
                          , (xWorm + yWorm - 0.5 * diffWB, 0 - 0.5 * diffWB)
                          , (xWorm + yWorm - 0.5 * diffWB - yBluejay, 0 - 0.5 * diffWB - yBluejay)
                          , (xWorm - 0.5 * diffWB - yBluejay, yWorm - 0.5 * diffWB - yBluejay)
                          ]
                            |> filled blue
                            |> makeTransparent 0.75
                , circle 1 |> filled red
                    |> move ( currentTime * horizScale - 66, vertScale * robins )
                , circle 1 |> filled blue
                    |> move ( currentTime * horizScale - 66, vertScale * bluejays )
                ]
                  |> group

  in
   [ --model.dragState |> Debug.toString |> text |> size 5
     --   |> filled black
     --   |> move (-95,58)
     --, 
     -- timeline rectangle 
     roundedRect 196 5 2 |> filled yellow
       |> move (0,60)
       |> notifyMouseDownAt HoldTime
       |> notifyMouseMoveAt HoldTime
       |> notifyLeave ReleaseTime
       |> notifyMouseUp ReleaseTime
       
    -- zero line
    , line (-96,0) (96,0)
        |> outlined (solid 0.1) black
    -- max worms
    , line (-66,1 * vertScale) (96, 1*vertScale)
        |> outlined (solid 0.1) black
    -- worms
    , model.observations 
        |> List.map ( \ (t,(x,y,z)) -> (horizScale * t,vertScale * x) )
        |> openPolygon 
        |> outlined (solid 0.25) pink
        |> move (-66,0)
    , circle 2 |> filled (rgba 255 255 255 0.25)
        |> addOutline (solid 0.5) pink
        |> move (-66,vertScale * x0)
        |> notifyMouseDownAt (GrabInitialPoint X)
    , drawInitial 100 x0 
    , worm
        |> scale 0.1
        |> move (-76,vertScale * x0)
    ,
      model.observations 
        |> List.map ( \ (t,(x,y,z)) -> (horizScale * t,vertScale * y) )
        |> openPolygon 
        |> outlined (solid 0.25) red
        |> move (-66,0)
    , circle 2 |> filled (rgba 255 255 255 0.25)
        |> addOutline (solid 0.5) red
        |> move (-66,vertScale * y0)
        |> notifyMouseDownAt (GrabInitialPoint Y)
    , drawInitial 100 y0
    , robin 
        |> scale 0.1
        |> move (-76,vertScale * y0)
    ,
      model.observations 
        |> List.map ( \ (t,(x,y,z)) -> (horizScale * t,vertScale * z) )
        |> openPolygon 
        |> outlined (solid 0.25) blue
        |> move (-66,0)
    , circle 2 |> filled (rgba 255 255 255 0.25)
        |> addOutline (solid 0.5) blue
        |> move (-66,vertScale * z0)
        |> notifyMouseDownAt (GrabInitialPoint Z)
    , drawInitial 100 z0
    , bluejay 
        |> scale 0.1
        |> move (-76+2,vertScale * z0)
    , case model.dragState of
        Waiting _ -> group []
        Pausing _ -> group []
        Dragging _ _ -> 
          rect 194 126 
            |> filled (rgba 0 0 0 0)
            |> notifyMouseMoveAt MovePoint
            |> notifyLeave StopDrag
            |> notifyMouseUp StopDrag
    , rect 192 64 |> filled (rgb 25 128 50) 
                  |> move (0,-32)
    , drawRandomAnimals model.onField
    , case model.dragState of 
        Waiting startTime -> drawPoints (model.time - startTime)
        Pausing pauseTime -> drawPoints pauseTime
        _ ->
          group []

    ]

displayFactor = 20

drawRandomAnimals (xs,ys,zs) = 
      ( List.map ( \ pos ->  worm 
                                |> scale 0.1
                                |> move pos
                 ) xs 
      ) ++ (
       List.map ( \ pos ->  robin 
                                |> scale 0.1
                                |> move pos
                 ) ys 
      ) ++ (
       List.map ( \ pos ->  bluejay 
                                |> scale 0.1
                                |> move pos
                 ) zs 
      ) |> group    

adjustAnimals (xs,ys,zs) (x,y,z) seed = 
  let
    adjustOne nowList shouldBeNum oneSeed =
      let 
        moreNeeded = shouldBeNum - List.length nowList
      in
        if moreNeeded == 0 then
          (nowList, oneSeed)
        else if moreNeeded < 0 then
          (List.drop (-moreNeeded) nowList, oneSeed)
        else
          let 
            pairGenerator = Random.pair 
                              (Random.float -100 100)
                              (Random.float -61 -5)
            (extra, newSeed) = Random.step
                                (Random.list (moreNeeded) pairGenerator)
                                oneSeed
          in
            (nowList ++ extra, newSeed)
            
    (newXs, seed1) = adjustOne xs x seed
    (newYs, seed2) = adjustOne ys y seed1
    (newZs, seed3) = adjustOne zs z seed2
  in
    ((newXs, newYs, newZs), seed3)    

type Msg = Tick Float GetKeyState
         | GrabInitialPoint Species (Float,Float)
         | MovePoint (Float,Float)
         | StopDrag
         | HoldTime (Float,Float)
         | ReleaseTime
         

type Species = X | Y | Z

type alias Time = Float
type alias YValues = Float
type alias XValues = Float
type alias ZValues = Float

type DragState = Waiting Float -- startTime
               | Dragging Species Float
               | Pausing Float -- time to pause
               
type alias Model = { time : Float
                   , observations : List (Time,(XValues,YValues,ZValues)) 
                   , start : (Float,Float,Float)
                   , dragState : DragState
                   , onField : (List (Float,Float), List (Float,Float), List (Float,Float))
                   , seed : Random.Seed
                   }

s = 0.22
p = 0.27
a = 0.76
b = 0.12
alpha = 0.33
beta = 0.39

dxdt t x y z = x * (1-x) - a * x * y - b * x * z
dydt t x y z = s * x * y * (x - y) - alpha * y * z
dzdt t x y z = p * x * z * (x - z) - beta * y * z
  
timeStep = 0.1

animationScale = 1

makeSteps : Float -> List (Float, (Float,Float,Float)) -> List (Float, (Float,Float,Float))
makeSteps n data = 
  if n > 0 then
    case data of
      (tn,(xn,yn,zn)) :: olderValues ->
        (tn + timeStep, ( xn + timeStep * dxdt tn xn yn zn
                        , yn + timeStep * dydt tn xn yn zn
                        , zn + timeStep * dzdt tn xn yn zn
                        )
        ) :: data  
          |> makeSteps (n-1)
      [] -> []
  else
    data

bluejay = group [

    curve (-18.14,43.621) [Pull (-23.07,46.225) (-21.97,49.990),Pull (-13.05,47.994) (-4.139,48.398),Pull (8.8424,46.131) (11.144,35.024),Pull (10.902,26.587) (3.8208,18.149),Pull (5.4007,3.7408) (-4.139,-10.50),Pull (-23.29,-26.05) (-52.85,-30.24),Pull (-58.58,-46.48) (-65.91,-62.72),Pull (-67.66,-65.58) (-69.41,-62.72),Pull (-65.38,-44.89) (-57.63,-27.06),Pull (-59.86,-28.06) (-62.08,-26.74),Pull (-62.80,-22.88) (-54.44,-19.74),Pull (-57.52,-9.795) (-47.76,9.8706),Pull (-38.83,23.806) (-25.47,27.383),Pull (-23.82,39.825) (-18.14,43.621)]
  |> filled blue
  -- |> makeTransparent 0.1
  ,
  shingles
  ,
  curve (3.5024,38.527) [Pull (-3.543,47.128) (-10.18,37.890),Pull (-10.34,32.318) (-10.50,26.746),Pull (-8.437,24.358) (-6.368,21.970),Pull (-15.86,22.051) (-15.60,5.4129),Pull (-18.82,-6.674) (-28.65,-15.60),Pull (-39.44,-22.49) (-50.30,-24.83),Pull (-51.58,-27.70) (-52.85,-30.56),Pull (-30.12,-25.40) (-8.915,-15.60),Pull (5.8727,-5.185) (3.8208,17.830),Pull (8.1457,22.766) (9.8706,27.701),Pull (6.3681,33.114) (3.5024,38.527)]
  |> filled white
   -- |> makeTransparent 0.5
  ,
  shingles2
  ,
  curve (6.0497,30.248) [Pull (7.9601,29.452) (9.8706,28.656),Pull (8.4249,23.402) (4.1393,18.149),Pull (4.6879,1.5904) (-7.323,-14.32),Pull (-28.20,-25.08) (-53.17,-30.56),Pull (-52.98,-27.70) (-50.62,-24.83),Pull (-35.23,-20.00) (-23.56,-11.46),Pull (-25.94,-15.44) (-29.93,-19.42),Pull (-12.23,-15.94) (-4.776,-1.592),Pull (0.7927,9.3930) (-0.318,20.378),Pull (1.9512,21.608) (3.8208,24.199),Pull (5.5361,27.542) (6.0497,30.248)]
  |> filled lightGray
  ,
  curve (-20.69,40.437) [Pull (-20.66,43.092) (-16.87,42.666),Pull (-11.37,41.960) (-8.915,37.253),Pull (-7.982,35.438) (-6.049,35.343),Pull (-8.278,35.226) (-10.50,34.069),Pull (-9.444,27.154) (-3.820,24.199),Pull (-1.432,21.068) (0.9552,20.378),Pull (0.4776,19.741) (0,19.104),Pull (-5.851,21.285) (-11.46,26.746),Pull (-14.93,30.821) (-15.92,36.616),Pull (-19.72,38.748) (-20.37,40.119)]
  |> filled black
  ,
  curve (6.3681,35.343) [Pull (16.907,34.876) (22.606,29.930),Pull (14.998,29.254) (10.189,28.338),Pull (7.1641,30.430) (4.1393,31.522),Pull (5.2537,33.592) (6.3681,35.661)]
  |> filled darkGray
  ,
  curve (3.5024,38.845) [Pull (3.4464,36.772) (1.9104,36.298),Pull (1.7440,32.490) (4.4577,31.522),Pull (6.4225,32.691) (10.507,35.980),Pull (8.1433,36.394) (4.1393,38.208)]
  |> filled black
  ,
  eye
  |> move (-3.5,37.5)
  |> scale 0.9
 
 
 
 
  ]

 
eye = group [  circle 6
  |> filled black
  ,
  circle 5
  |> filled white
  ,
  circle 4
  |> filled black
  ,
  circle 1
  |> filled white
  |> move (-1,1)] 
 
shingles2 = group [  curve (-41.07,2.5472) [Pull (-39.64,0.3120) (-38.20,0.6368),Pull (-37.57,-0.023) (-36.93,0.9552),Pull (-35.18,0.1952) (-33.43,0.9552),Pull (-31.68,0.8328) (-29.93,1.9104),Pull (-28.01,0.5504) (-26.10,1.9104),Pull (-24.19,1.1696) (-22.28,2.2288)]
  |> outlined (solid 1) black
  ,
  curve (-45.85,-0.955) [Pull (-43.94,-2.551) (-42.02,-2.547),Pull (-39.32,-3.209) (-36.61,-1.592),Pull (-35.34,-2.214) (-34.06,-0.636),Pull (-32.95,-2.313) (-31.84,-1.910),Pull (-30.24,-0.770) (-28.65,-1.910),Pull (-26.42,-1.089) (-24.19,-2.228)]
  |> outlined (solid 2) white
  ,
  curve (-48.39,-6.686) [Pull (-47.28,-8.601) (-46.16,-8.597),Pull (-44.89,-7.877) (-43.62,-8.597),Pull (-42.66,-10.33) (-41.71,-10.18),Pull (-40.11,-9.855) (-38.52,-7.641),Pull (-36.45,-8.700) (-34.38,-8.278)]
  |> outlined (solid 0.5) black
  ,
  curve (-49.35,-11.14) [Pull (-48.71,-12.58) (-48.07,-12.73),Pull (-47.60,-12.89) (-45.53,-13.05),Pull (-44.18,-13.67) (-42.34,-12.09),Pull (-40.59,-12.91) (-38.84,-12.09)]
  |> outlined (solid 0.5) black
  ,
  curve (-50.62,-14.00) [Pull (-49.99,-14.94) (-49.35,-14.64),Pull (-48.07,-16.24) (-46.80,-15.92),Pull (-45.05,-17.25) (-43.30,-16.23)]
  |> outlined (solid 0.5) black
  ,
  curve (-54.44,-18.14) [Pull (-53.01,-19.08) (-51.58,-18.46),Pull (-51.10,-21.22) (-50.62,-19.42),Pull (-49.83,-20.16) (-49.03,-20.05)]
  |> outlined (solid 0.5) black
  ,
  curve (-26.74,-6.686) [Pull (-40.43,-16.70) (-54.12,-23.88)]
  |> outlined (solid 0.4) black
  ,
  curve (-28.01,-8.597) [Pull (-38.52,-17.47) (-49.03,-24.19)]
  |> outlined (solid 0.5) black]
 
 
shingles = group [  curve (-56.67,-28.97) [Pull (-54.60,-30.01) (-52.53,-28.33)]
  |> outlined (solid 0.5) black
  ,
  curve (-58.90,-32.47) [Pull (-56.51,-33.41) (-54.12,-31.84)]
  |> outlined (solid 0.5) black
  ,
  curve (-60.81,-36.93) [Pull (-57.94,-37.35) (-56.03,-35.34)]
  |> outlined (solid 0.5) black
  ,
  curve (-61.13,-41.39) [Pull (-59.06,-41.89) (-56.99,-40.75)]
  |> outlined (solid 0.5) black
  ,
  curve (-62.72,-44.57) [Pull (-60.81,-46.05) (-58.90,-44.57)]
  |> outlined (solid 0.5) black
  ,
  curve (-64,-48.71) [Pull (-62.24,-49.61) (-60.49,-48.71)]
  |> outlined (solid 0.5) black
  ,
  curve (-65.27,-51.58) [Pull (-63.52,-53.26) (-61.77,-52.21)]
  |> outlined (solid 0.5) black
  ,
  curve (-66.22,-56.67) [Pull (-64.95,-58.17) (-63.68,-56.67)]
  |> outlined (solid 0.5) black
  ,
  curve (-66.86,-59.86) [Pull (-65.91,-60.46) (-64.95,-59.22)]
  |> outlined (solid 0.5) black
 ] 


robin = group [

     -- foot (right)
  curve (13.489,-13.93) [Pull (13.439,-15.28) (13.189,-16.63),Pull (8.6932,-23.68) (4.1967,-30.72),Pull (7.0444,-30.77) (9.8922,-34.02),Pull (3.0491,-30.02) (-7.793,-38.22),Pull (-6.645,-35.12) (-3.297,-33.42),Pull (-5.245,-33.22) (-7.194,-35.22),Pull (-5.198,-31.12) (2.9976,-30.42),Pull (6.7447,-23.38) (10.491,-16.33),Pull (9.7423,-14.83) (8.9929,-13.33),Pull (11.990,-11.39) (14.988,-9.442),Pull (14.088,-11.54) (13.489,-13.93)]
  |> filled (rgb 97 72 39)
  |> addOutline (solid 0.25) black
  
  --foot (left)
  , 
  curve (5.3957,-16.63) [Pull (0.5510,-21.93) (-8.093,-28.62),Pull (-6.444,-28.72) (-4.796,-29.22),Pull (-3.796,-29.97) (-4.196,-30.72),Pull (-6.144,-29.32) (-9.292,-30.72),Pull (-15.88,-31.02) (-21.88,-33.72),Pull (-19.68,-31.47) (-17.08,-30.42),Pull (-18.93,-30.22) (-22.18,-31.62),Pull (-21.58,-30.27) (-19.18,-28.92),Pull (-15.43,-28.77) (-11.69,-28.62),Pull (-5.695,-23.08) (0.2997,-17.53),Pull (1.9484,-16.63) (3.5971,-15.73),Pull (4.1967,-16.33) (5.3957,-16.63)]
  |> filled (rgb 97 72 39)
  |> addOutline (solid 0.25) black
    
  -- body (red)
  , curve (-35.67,25.629) [Pull (-32.07,21.085) (-32.07,12.140),Pull (-31.27,2.5466) (-27.27,-3.447),Pull (-16.23,-16.74) (0,-17.83),Pull (13.790,-16.69) (23.381,-6.145),Pull (33.129,2.0983) (28.477,10.341),Pull (29.377,10.791) (30.276,11.241),Pull (33.324,13.937) (34.173,19.634),Pull (35.122,26.679) (36.271,31.925),Pull (27.278,28.477) (18.285,25.030),Pull (12.140,22.782) (5.9953,20.533),Pull (1.0491,23.681) (-3.896,26.829),Pull (-8.393,24.430) (-35.67,25.629)]
  |> filled (rgb 201 107 0)
  |> addOutline (solid 0.25) black
  
  -- wing/tail (grey)
  , 
  curve (-26.97,39.119) [Pull (-14.68,42.872) (-2.398,30.426),Pull (7.7946,30.378) (16.187,24.131),Pull (32.576,41.671) (43.765,49.011),Pull (46.464,50.312) (46.763,46.613),Pull (47.415,42.716) (41.667,38.220),Pull (35.621,33.574) (32.374,25.929),Pull (31.025,16.184) (29.077,14.238),Pull (28.477,13.439) (27.878,13.639),Pull (32.824,8.6932) (37.770,3.7470),Pull (17.686,8.2435) (-2.398,12.740),Pull (-7.793,15.887) (-13.18,19.035),Pull (-10.64,20.083) (-8.093,22.932),Pull (-5.193,27.278) (-9.292,31.025),Pull (-13.03,34.624) (-16.78,34.622),Pull (-22.28,34.522) (-25.18,36.421),Pull (-26.77,37.220) (-26.97,39.119)]
  |> filled (rgb 66 66 66)
  |> addOutline (solid 0.25) black
  
  -- wing outline
  , curve (14.088,22.932) [Pull (26.079,16.589) (39.269,3.4473),Pull (16.786,3.5449) (-5.695,9.4426),Pull (-12.89,11.489) (-13.48,16.337),Pull (-13.43,17.836) (-13.18,19.334)]
  |> filled (rgb 66 66 66)
  |> addOutline (solid 0.25) black
  
  -- beak (brown)
  ,
  curve (-36.27,32.824) [Pull (-43.91,31.875) (-46.76,30.126),Pull (-38.81,28.327) (-36.27,26.529),Pull (-33.72,27.278) (-31.17,28.028),Pull (-31.92,30.725) (-32.67,33.423),Pull (-34.62,33.274) (-36.27,32.824)]
  |> filled (rgb 255 191 0)
  |> addOutline (solid 0.25) black
  
  -- beak (mouth line)
  , curve (-46.76,30.126) [Pull (-41.96,30.126) (-37.17,28.927)]
  |> outlined (solid 0.5) black
  
  -- head (orange)
  ,  curve (-26.97,39.119) [Pull (-32.52,37.971) (-36.87,32.824),Pull (-37.97,30.225) (-33.87,28.627),Pull (-36.32,27.828) (-35.97,25.629),Pull (-31.72,21.035) (-32.07,10.641),Pull (-31.77,6.0948) (-30.27,2.5480),Pull (-23.92,2.8437) (-21.58,13.339),Pull (-20.38,17.087) (-13.78,19.035),Pull (-5.341,22.831) (-7.494,28.627),Pull (-10.14,33.625) (-17.38,35.222),Pull (-22.08,35.471) (-25.18,36.721),Pull (-26.67,37.170) (-26.97,39.119)]
  |> filled (rgb 46 44 44)
  |> addOutline (solid 0.25) black
  
  --eye
  , circle 2.6
  |> filled black
  |> move (-26.4, 29.5)
  
  --eye white
  , curve (-26.07,32.224) [Pull (-22.92,28.526) (-26.97,27.428),Pull (-23.98,26.727) (-23.98,29.826),Pull (-24.83,32.175) (-26.07,32.224)]
  |> filled white
  
  -- eye dot
  , circle 1
  |> filled white
  |> move (-27, 30)
  
 ]

worm = group [
  body,
  eyes,
  scales
  ]

body = group [
   curve (-67.8, 12.8) [Pull (-67.8, 11.3) (-67.8, 9.8), Pull (-68.0, 0.4) (-64.6, -4.4), Pull (-58.6, -12.4) (-47.6, -12.7), Pull (-38.1, -12.6) (-29.3, -8.6), Pull (-23.4, -6.7) (-15.9, 1.0), Pull (-11.7, 6.7) (-6.6, 10.6), Pull (2.5, 17.3) (12.9, 16.3), Pull (18.7, 15.6) (25.2, 12.1), Pull (33.5, 6.8) (38.5, 2.3), Pull (47.6, -6.4) (51.3, -9.2), Pull (57.1, -13.9) (63.8, -13.2), Pull (67.5, -12.7) (70.5, -10.3), Pull (73.5, -9.1) (77.1, -10.4), Pull (82.3, -13.0) (82.3, -17.5), Pull (81.9, -22.4) (73.2, -26.7), Pull (67.4, -29.3) (57.1, -27.8), Pull (50.3, -26.8) (44.1, -23.0), Pull (40.8, -20.9) (33.0, -13.1), Pull (27.3, -7.6) (19.4, -1.7), Pull (11.6, 3.1) (4.5, -0.3), Pull (0.4, -2.5) (-4.5, -8.9), Pull (-15.1, -19.8) (-27.9, -24.1), Pull (-44.7, -29.9) (-58.6, -26.4), Pull (-71.5, -21.7) (-77.7, -11.8), Pull (-83.1, -2.9) (-82.9, 13.3), Pull (-85.6, 18.3) (-81.3, 19.1), Pull (-75.2, 24.1) (-69.7, 18.8), Pull (-65.6, 17.2) (-67.9, 12.5)]
      |> filled (rgb 255 140 120)
 , curve (-78.0, 21.1) [Pull (-80.2, 20.6) (-80.7, 19.3), Pull (-83.3, 19.5) (-83.9, 17.0), Pull (-84.4, 14.9) (-82.6, 13.7), Pull (-83.9, 8.4) (-82.0, -0.0), Pull (-80.2, -8.9) (-75.1, -15.2), Pull (-69.9, -21.5) (-61.5, -25.3), Pull (-52.2, -29.0) (-40.4, -27.3), Pull (-28.8, -25.9) (-15.9, -18.2), Pull (-7.6, -13.5) (-0.6, -4.4), Pull (-0.4, -4.1) (-0.1, -3.8), Pull (3.7, 0.6) (8.9, 1.2), Pull (15.0, 1.4) (20.2, -1.8), Pull (26.6, -6.0) (34.2, -14.1), Pull (43.7, -23.5) (49.4, -25.2), Pull (59.6, -30.0) (70.0, -27.3), Pull (80.1, -23.6) (81.3, -19.8), Pull (82.8, -16.6) (81.2, -13.6), Pull (78.1, -19.2) (72.5, -21.6), Pull (62.1, -26.3) (52.6, -21.3), Pull (44.6, -18.1) (37.9, -11.7), Pull (31.5, -6.4) (26.1, -0.9), Pull (20.4, 5.2) (11.2, 5.3), Pull (2.2, 4.9) (-3.8, -1.6), Pull (-9.7, -9.9) (-16.8, -14.0), Pull (-27.4, -20.0) (-37.3, -22.0), Pull (-53.2, -25.6) (-62.7, -19.6), Pull (-72.3, -14.7) (-74.9, -8.0), Pull (-78.2, -1.2) (-78.3, 5.1), Pull (-78.5, 10.1) (-77.7, 20.9)]
      |> filled (rgb 254 127 107)  
  ]

eyes = group [
   circle 3
      |> filled (rgb 225 92 77)
      |> move (-81.25,16.25)
 , circle 3
      |> filled (rgb 225 92 77)
      |> move (-69.5,15.5)
 , circle 2.3
      |> filled white
      |> move (-81.25,16.25)
 , circle 2.3
      |> filled white
      |> move (-69.5,15.5)
 , circle 1.5
      |> filled black
      |> move (-81.25,16)
 , circle 1.5
      |> filled black
      |> move (-69.5,15.25)
 , circle 0.5
      |> filled white
      |> move (-80.25,16.75)
 , circle 0.5
      |> filled white
      |> move (-68.5,16)
  ]

scales = group [
  curve (-71.3, 10.2) [Pull (-75.7, 6.3) (-80.3, 10.1)]
      |> outlined (solid 0.5) black  
 ,  curve (-66.8, 0.5) [Pull (-67.1, 1.7) (-67.2, 2.6), Pull (-74.5, 1.3) (-81.9, 0.0), Pull (-81.8, -1.9) (-81.0, -3.9), Pull (-74.0, -1.2) (-66.6, 0.4)]
      |> filled (rgb 225 92 77)
 ,  curve (-61.9, -7.6) [Pull (-62.5, -6.9) (-63.8, -5.6), Pull (-68.7, -10.5) (-75.5, -15.0), Pull (-73.9, -17.4) (-72.2, -18.5), Pull (-67.3, -12.8) (-61.7, -7.7)]
      |> filled (rgb 225 92 77)
 ,  curve (-53.8, -12.0) [Pull (-54.9, -12.1) (-56.3, -11.2), Pull (-58.7, -18.2) (-61.2, -25.4), Pull (-59.4, -26.2) (-57.6, -26.4), Pull (-55.1, -15.7) (-53.6, -12.4)]
      |> filled (rgb 225 92 77)
 ,  curve (-53.6, -12.1) [Pull (-55.0, -11.6) (-56.4, -11.0), Pull (-58.6, -18.9) (-61.4, -25.2), Pull (-59.7, -26.2) (-57.3, -26.6), Pull (-55.6, -19.2) (-53.6, -12.1)]
      |> filled (rgb 225 92 77)
 ,  curve (-46.2, -12.7) [Pull (-44.7, -12.7) (-43.2, -12.3), Pull (-42.0, -20.2) (-41.5, -27.5), Pull (-43.7, -27.9) (-45.5, -27.6), Pull (-45.8, -20.4) (-46.1, -13.1)]
      |> filled (rgb 225 92 77)
 ,  curve (-32.4, -9.8) [Pull (-29.3, -16.4) (-26.8, -23.7), Pull (-28.4, -24.7) (-30.7, -25.0), Pull (-32.3, -17.9) (-35.1, -10.8), Pull (-33.9, -10.2) (-32.3, -9.9)]
      |> filled (rgb 225 92 77)
 ,  curve (-22.0, -4.3) [Pull (-23.1, -5.2) (-24.2, -6.1), Pull (-22.0, -11.9) (-16.4, -18.6), Pull (-14.8, -17.7) (-13.9, -16.7), Pull (-20.1, -8.6) (-22.2, -4.3)]
      |> filled (rgb 225 92 77)
 ,  curve (-2.8, -7.0) [Pull (-3.4, -8.4) (-4.8, -9.0), Pull (-9.4, -5.8) (-15.9, 1.2), Pull (-14.7, 2.1) (-13.8, 3.7), Pull (-6.8, -3.9) (-2.6, -6.8)]
      |> filled (rgb 225 92 77)
 ,  curve (4.9, -0.1) [Pull (4.1, -0.3) (3.3, -1.1), Pull (-1.0, 5.6) (-5.4, 11.2), Pull (-3.8, 12.7) (-1.5, 13.4), Pull (1.3, 6.7) (5.2, -0.1)]
      |> filled (rgb 225 92 77)
 ,  curve (11.8, 16.3) [Pull (14.1, 16.3) (16.3, 15.6), Pull (14.1, 8.1) (13.2, 0.7), Pull (12.5, 1.2) (10.5, 1.2), Pull (11.6, 10.9) (11.4, 16.2)]
      |> filled (rgb 225 92 77)
 ,  curve (30.4, 8.7) [Pull (29.1, 9.3) (27.2, 10.9), Pull (24.0, 3.4) (19.8, -1.9), Pull (21.1, -2.7) (22.4, -3.5), Pull (26.5, 2.4) (30.4, 8.5)]
      |> filled (rgb 225 92 77)
 ,  curve (41.2, -0.0) [Pull (39.9, 0.8) (38.9, 1.8), Pull (36.0, -2.2) (29.1, -9.2), Pull (30.1, -10.5) (31.4, -11.5), Pull (37.1, -4.9) (41.2, -0.4)]
      |> filled (rgb 225 92 77)
 ,  curve (41.9, -21.1) [Pull (40.2, -20.0) (38.6, -18.3), Pull (44.6, -12.8) (48.4, -7.0), Pull (49.8, -8.1) (50.8, -8.6), Pull (46.4, -14.7) (41.9, -20.8)]
      |> filled (rgb 225 92 77)
 ,  curve (56.9, -12.1) [Pull (58.5, -12.6) (59.7, -12.9), Pull (58.2, -20.4) (56.6, -27.8), Pull (54.4, -27.6) (52.8, -26.8), Pull (56.0, -18.6) (56.9, -12.3)]
      |> filled (rgb 225 92 77)
 ,  curve (65.1, -13.1) [Pull (68.7, -19.7) (70.4, -27.7), Pull (72.6, -27.0) (74.8, -25.7), Pull (69.9, -17.3) (68.8, -11.5), Pull (67.0, -12.3) (65.1, -12.9)]
      |> filled (rgb 225 92 77)
  ]


update msg model = case msg of
                     Tick t _ -> 
                       case model.dragState of 
                         Waiting startTime ->
                           let
                             newTime = ( t - startTime ) * animationScale
                             (bdX,bdY,bdZ) = model.onField
                             (randomNumber,seed0) = Random.step 
                                                      (Random.int 0 100)
                                                      model.seed
                             adX = if randomNumber < List.length bdX then 
                                     List.drop 1 bdX
                                   else
                                     bdX
                             adY = if randomNumber < List.length bdY then 
                                     List.drop 1 bdY
                                   else
                                     bdY
                             adZ = if randomNumber < List.length bdZ then 
                                     List.drop 1 bdZ
                                   else
                                     bdZ
                           in
                             case List.drop (round (10*newTime)) model.observations of
                               (_,(x,y,z)) :: _ ->
                                 let
                                   (newOnField,newSeed) = adjustAnimals 
                                                            (adX, adY, adZ)
                                                            (round (displayFactor*x),round (displayFactor*y),round (displayFactor*z)) 
                                                            seed0
                                 in
                                   { model | time = t 
                                           , onField = newOnField
                                           , seed = newSeed
                                           }
                               otherwise -> 
                                   { model | time = t }
                         otherwise -> 
                             { model | time = t }
                     GrabInitialPoint species (_,vert) ->
                       case model.dragState of
                         Waiting _ ->
                           { model | dragState = Dragging species vert }
                         _ -> 
                           model
                     MovePoint (_,newVert) ->
                       case model.dragState of
                         Dragging species _ ->
                           let
                             (x0,y0,z0) = model.start
                             posVert = if newVert > 0 then newVert else 0
                             newStart = case species of
                                          X -> (posVert / vertScale,y0,z0)
                                          Y -> (x0,posVert / vertScale,z0)
                                          Z -> (x0,y0,posVert / vertScale)
                           in
                             { model | dragState = Dragging species newVert
                                     , start = newStart
                                     , observations = makeSteps 200 [(0,newStart)]
                                                         |> List.reverse
                                     }
                         _ -> 
                           model
                     StopDrag ->
                       -- take a step in the direction of the derivative
                       { model | dragState = Waiting model.time}
                     HoldTime (x,_) ->
                       let
                         clickedTime = (x + 66) / horizScale
                         stoppedTime = if clickedTime < 0 then
                                         0
                                       else
                                         clickedTime
                       in
                         { model | dragState = Pausing stoppedTime }
                     ReleaseTime ->
                         { model | dragState = Waiting model.time }

init : Model
init = { time = 0 
       , observations = makeSteps 200 [(0,(0.3,0.2,0.1))]
       , start = (0.3,0.2,0.1)
       , dragState = Waiting 0
       , onField = ([],[],[])
       , seed = Random.initialSeed 7
       }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)





