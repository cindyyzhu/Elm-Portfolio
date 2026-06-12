-- Your shapes go here!
module AnimationPiecesExit exposing (..)

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
scale s (x,y) = (s*x,s*y)

myShapes model =
    [
      graphPaper 10
    --, plotGraph myRepeat model.time
    , let
        -- E
        y0 = (-50, 40)
        y1 = (-90, 40)
        y2 = (-90, 0)
        y3 = (-50, 0)
        y4 = (-90, 0)
        y5 = (-90, -40)
        y6 = (-50, -40)
        -- X
        y7 = (-40,40)
        y8 = (0,-40)
        y9 = (-20,0) 
        y10 = (0,40)
        y11 = (-40,-40)
        {--- to use if you want it to start from the top right side of X
        y7 = (0,40)
        y8 = (-40,-40)
        y9 = (-20,0) 
        y10 = (-40,40)
        y11 = (0,-40) -}
        -- I
        y12 = (10, 40)
        y13 = (40, 40)
        y14 = (25, 40)
        y15 = (25, -40)
        y16 = (10, -40)
        y17 = (40, -40)
        -- T
        y18 = (50,40)
        y19 = (90,40)
        y20 = (70,40)
        y21 = (70,-40)
        
        newFun x = animationPieces
                     [
                     -- E
                     (1, \ t -> add y0 (scale t (sub y1 y0)))
                     ,(1, \ t -> add y1 (scale t (sub y2 y1)))
                     ,(1, \ t -> add y2 (scale t (sub y3 y2)))
                     ,(1, \ t -> add y3 (scale t (sub y4 y3)))
                     ,(1, \ t -> add y4 (scale t (sub y5 y4)))
                     ,(1, \ t -> add y5 (scale t (sub y6 y5)))
                     ,(1, \ t -> add y6 (scale t (sub y7 y6)))
                     
                     -- X
                     ,(1, \ t -> add y7 (scale t (sub y8 y7)))
                     ,(1, \ t -> add y8 (scale t (sub y9 y8)))
                     ,(1, \ t -> add y9 (scale t (sub y10 y9)))
                     ,(1, \ t -> add y10 (scale t (sub y11 y10)))
                     ,(1, \ t -> add y11 (scale t (sub y12 y11)))
                     
                     -- I
                     ,(1, \ t -> add y12 (scale t (sub y13 y12)))
                     ,(1, \ t -> add y13 (scale t (sub y14 y13)))
                     ,(1, \ t -> add y14 (scale t (sub y15 y14)))
                     ,(1, \ t -> add y15 (scale t (sub y16 y15)))
                     ,(1, \ t -> add y16 (scale t (sub y17 y16)))
                     ,(1, \ t -> add y17 (scale t (sub y18 y17)))
                     
                     -- T
                     ,(1, \ t -> add y18 (scale t (sub y19 y18)))
                     ,(1, \ t -> add y19 (scale t (sub y20 y19)))
                     ,(1, \ t -> add y20 (scale t (sub y21 y20)))
                     ]
                     ( \ t -> y21 )
                     x
      in
        [ 
          -- E
          openPolygon [y0, y1, y2, y3, y4, y5, y6]
          |> outlined (solid 2) red
          
          -- X
          , openPolygon [y7, y8, y9, y10, y11]
           |> outlined (solid 2) red 
           
          -- I
          , openPolygon [y12, y13, y14, y15, y16, y17]
          |> outlined (solid 2) red
          
          -- T
          , openPolygon [y18, y19, y20, y21]
          |> outlined (solid 2) red
          
          -- Pacman
          , wedge 5 0.75 |> filled yellow
            |> move (newFun model.time)
            
        ] |> group
        
    ]

-- this is called bilinear interpolation 
-- it follows the line between two points, tracing out a polygon
mkAnimationPiece listOfPoints =
  case listOfPoints of
    p0 :: p1 :: rest -> (1, \ t -> add p0 
                              (scale 
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
scalePull s (Pull p2 p3) = Pull (scale s p2) (scale s p3)

addCurve (MyCurve p0 pulls0) (MyCurve p1 pulls1) =
  MyCurve (add p0 p1) (List.map2 addPull pulls0 pulls1)
subCurve (MyCurve p0 pulls0) (MyCurve p1 pulls1) =
  MyCurve (sub p0 p1) (List.map2 subPull pulls0 pulls1)
scaleCurve s (MyCurve p1 pulls1) =
  MyCurve (scale s p1) (List.map (scalePull s) pulls1)

flippers =
  [ MyCurve (-21.45,2.7042) [Pull (-25.41,-4.687) (-29.38,-12.07),Pull (-29.56,-13.34) (-29.74,-14.60),Pull (-29.92,-15.32) (-30.10,-16.04),Pull (-29.74,-17.12) (-29.38,-18.20),Pull (-28.30,-20.55) (-27.22,-22.89),Pull (-24.87,-25.6) (-22.53,-28.30),Pull (-19.29,-30.82) (-16.04,-33.35),Pull (-9.915,-36.59) (-3.785,-39.84),Pull (0.9014,-40.92) (5.5887,-42.00),Pull (7.0309,-41.64) (8.4732,-41.28),Pull (8.8338,-40.38) (9.1943,-39.48),Pull (8.6535,-38.21) (8.1126,-36.95),Pull (2.7042,-31.36) (-2.704,-25.78),Pull (-4.146,-23.61) (-5.588,-21.45),Pull (-7.030,-17.66) (-8.473,-13.88),Pull (-8.653,-11.53) (-8.833,-9.194),Pull (-7.211,-3.605) (-5.588,1.9830),Pull (-13.52,2.3436) (-21.45,2.7042)]
  , MyCurve (-21.45,2.7042) [Pull (-25.23,-4.507) (-29.02,-11.71),Pull (-29.38,-13.16) (-29.74,-14.60),Pull (-29.74,-16.22) (-29.74,-17.84),Pull (-28.30,-20.91) (-26.86,-23.97),Pull (-23.25,-28.12) (-19.65,-32.27),Pull (-13.88,-36.77) (-8.112,-41.28),Pull (-4.146,-43.44) (-0.180,-45.61),Pull (0.9014,-45.79) (1.9830,-45.97),Pull (2.7042,-45.79) (3.4253,-45.61),Pull (3.9661,-44.52) (4.5070,-43.44),Pull (4.1464,-41.82) (3.7859,-40.20),Pull (-0.901,-33.53) (-5.588,-26.86),Pull (-6.850,-24.33) (-8.112,-21.81),Pull (-8.653,-19.65) (-9.194,-17.48),Pull (-9.374,-14.24) (-9.554,-10.99),Pull (-8.653,-7.391) (-7.752,-3.785),Pull (-6.670,-0.901) (-5.588,1.9830),Pull (-13.52,2.3436) (-21.45,2.7042)]
  , MyCurve (-21.45,2.7042) [Pull (-25.05,-3.785) (-28.66,-10.27),Pull (-29.20,-12.98) (-29.74,-15.68),Pull (-29.74,-18.20) (-29.74,-20.73),Pull (-28.84,-24.51) (-27.94,-28.30),Pull (-26.32,-31.90) (-24.69,-35.51),Pull (-22.89,-37.85) (-21.09,-40.20),Pull (-18.02,-42.90) (-14.96,-45.61),Pull (-13.88,-46.33) (-12.8,-47.05),Pull (-11.89,-47.05) (-10.99,-47.05),Pull (-10.27,-45.97) (-9.554,-44.89),Pull (-9.554,-42.00) (-9.554,-39.12),Pull (-10.27,-35.15) (-10.99,-31.18),Pull (-11.89,-27.94) (-12.8,-24.69),Pull (-12.8,-20.73) (-12.8,-16.76),Pull (-12.43,-13.34) (-12.07,-9.915),Pull (-10.81,-6.670) (-9.554,-3.425),Pull (-7.932,-0.721) (-6.309,1.9830),Pull (-13.88,2.3436) (-21.45,2.7042)]
  , MyCurve (-21.45,2.7042) [Pull (-25.41,-4.507) (-29.38,-11.71),Pull (-29.74,-13.16) (-30.10,-14.60),Pull (-30.64,-16.94) (-31.18,-19.29),Pull (-31.18,-21.63) (-31.18,-23.97),Pull (-31.18,-27.04) (-31.18,-30.10),Pull (-30.82,-32.63) (-30.46,-35.15),Pull (-29.56,-38.40) (-28.66,-41.64),Pull (-27.94,-43.98) (-27.22,-46.33),Pull (-26.86,-46.87) (-26.50,-47.41),Pull (-25.6,-47.95) (-24.69,-48.49),Pull (-23.43,-48.49) (-22.17,-48.49),Pull (-21.45,-47.23) (-20.73,-45.97),Pull (-20.37,-43.98) (-20.01,-42.00),Pull (-18.92,-36.59) (-17.84,-31.18),Pull (-16.76,-27.22) (-15.68,-23.25),Pull (-14.60,-19.65) (-13.52,-16.04),Pull (-9.915,-7.030) (-6.309,1.9830),Pull (-13.88,2.1633) (-21.45,2.7042)]
  , MyCurve (-21.81,2.7042) [Pull (-25.96,-4.867) (-30.10,-12.43),Pull (-31.54,-16.40) (-32.99,-20.37),Pull (-33.89,-24.15) (-34.79,-27.94),Pull (-35.33,-32.27) (-35.87,-36.59),Pull (-35.87,-40.74) (-35.87,-44.89),Pull (-35.33,-45.79) (-34.79,-46.69),Pull (-33.89,-47.05) (-32.99,-47.41),Pull (-31.54,-46.69) (-30.10,-45.97),Pull (-28.66,-43.98) (-27.22,-42.00),Pull (-24.15,-35.15) (-21.09,-28.30),Pull (-19.65,-24.69) (-18.20,-21.09),Pull (-16.58,-18.20) (-14.96,-15.32),Pull (-13.88,-13.16) (-12.8,-10.99),Pull (-11.89,-9.014) (-10.99,-7.030),Pull (-10.27,-5.588) (-9.554,-4.146),Pull (-9.014,-2.884) (-8.473,-1.622),Pull (-7.752,-0.540) (-7.030,0.5408),Pull (-14.60,1.6225) (-21.81,2.7042)]
  , MyCurve (-22.17,2.7042) [Pull (-24.69,-1.983) (-27.22,-6.670),Pull (-28.66,-9.554) (-30.10,-12.43),Pull (-32.09,-16.40) (-34.07,-20.37),Pull (-35.87,-24.51) (-37.67,-28.66),Pull (-38.76,-31.00) (-39.84,-33.35),Pull (-40.56,-35.15) (-41.28,-36.95),Pull (-41.64,-39.12) (-42.00,-41.28),Pull (-42.00,-42.54) (-42.00,-43.80),Pull (-41.28,-44.34) (-40.56,-44.89),Pull (-39.30,-44.52) (-38.03,-44.16),Pull (-36.59,-43.08) (-35.15,-42.00),Pull (-32.99,-39.84) (-30.82,-37.67),Pull (-28.48,-34.79) (-26.14,-31.90),Pull (-24.51,-29.74) (-22.89,-27.58),Pull (-20.73,-23.97) (-18.56,-20.37),Pull (-16.04,-15.68) (-13.52,-10.99),Pull (-10.45,-5.228) (-7.391,0.5408),Pull (-14.78,1.6225) (-22.17,2.7042)]
  , MyCurve (-22.53,2.7042) [Pull (-27.22,-5.408) (-31.90,-13.52),Pull (-33.53,-15.86) (-35.15,-18.20),Pull (-37.67,-21.45) (-40.20,-24.69),Pull (-42.00,-26.86) (-43.80,-29.02),Pull (-45.61,-30.64) (-47.41,-32.27),Pull (-48.67,-33.17) (-49.93,-34.07),Pull (-50.47,-35.15) (-51.01,-36.23),Pull (-51.38,-36.95) (-51.74,-37.67),Pull (-51.74,-38.76) (-51.74,-39.84),Pull (-51.38,-40.20) (-51.01,-40.56),Pull (-49.93,-40.92) (-48.85,-41.28),Pull (-47.05,-41.10) (-45.25,-40.92),Pull (-42.36,-40.02) (-39.48,-39.12),Pull (-35.51,-36.59) (-31.54,-34.07),Pull (-27.22,-29.56) (-22.89,-25.05),Pull (-17.66,-17.30) (-12.43,-9.554),Pull (-9.735,-4.507) (-7.030,0.5408),Pull (-14.78,1.6225) (-22.53,2.7042)]
  ]
  
-- our goal is to go from blue (q0) to purple (q1) but taking into account 
-- that we will go to q2 next and that we came from q3 before

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

init = { time = 0 }

update msg model =
  case msg of
    Tick t _ -> { model | time = t }

view model = collage 192 128 (myShapes model)

main = gameApp Tick { model = init, view = view, update = update, title = "EXIT" }
