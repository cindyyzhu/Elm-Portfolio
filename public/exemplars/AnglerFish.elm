module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)


fractionalModBy m x = x - m * toFloat (floor (x / m))


repeatDistance speed start end t =
  start + fractionalModBy (end - start) (speed * t)

-- Your shapes go here!
myShapes model =
  [
  rect 250 200 |> filled black,
  anglerFish |> move (repeatDistance 10 -350 200 -model.time,0)
  
  -- animation idea: make it appear from the right side (decrease transparency i.e. make it from ghost to solidier)
  ]

anglerFish = group [
                    medianFins |> rotate (degrees 10) 
                               |> move (-10,50),

                    -- light
                    wedge 50 0.375 |> filled yellow |> makeTransparent 0.5 |> rotate (degrees -90) |> move (-130,15),
                    circle 8 |> filled yellow |> move (-130,5),
                    
                    illicium |> scaleY 0.5 |> move (-30,30),
                    
                    bodyShape  |> scale 0.75 
                               |> move (-20,0),
                               
                    tailandarm |> scale 0.6 
                               |> rotate (degrees 5) 
                               |> move (75,8),
                               
                    tailandarm |> addOutline (solid 2) black 
                               |> subtract (rect 10 60 |> filled white |> move (-55,5)) 
                               |> scaleX 0.5
                               |> scaleY 0.7
                               |> rotate (degrees 20)
                               |> move (50,10),
                    eyes
                              
                    
              ] |> scale 0.5

illicium = group [ curve (0,17) [Pull (14,-10) (-107,-41), Pull (-73,46) (-31,19), Pull (-21,8) (-7,10) ]
                  |> filled (rgb 0 128 128)
                  |> subtract (curve (0,0) [Pull (10,0) (20,-10)] |> filled (rgb 230 125 50) |> scaleX 2 |> scaleY -2 |> rotate (degrees 10) |> move (-35,-20))
                  |> subtract (oval 20 25 |> filled (rgb 230 125 50)|> scaleX 3.5 |> scaleY 2 |> move (-50,-10))
                  |> subtract (triangle 30 |> filled (rgb 230 125 50) |> rotate (degrees 90) |> move (-75,-30))
                 
                  ]


teeth = group [isosceles 7 40 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-55,-35),
               isosceles 7 30 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-50,-35),
               isosceles 7 20 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-45,-35),
               isosceles 7 30 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-40,-35),
               isosceles 7 40 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-35,-35),
               isosceles 7 30 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-30,-35),
               isosceles 7 20 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-25,-35),
               isosceles 7 30 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-20,-35),
               isosceles 7 40 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-15,-35),
               isosceles 7 20 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-10,-35),
               isosceles 7 40 |> filled white |> addOutline (solid 0.5) black |> rotate (degrees 20) |> move (-5,-35)
               ]

eyes = group [circle 6 |> filled (rgb 245 245 245) |> move (-10,20),
              curve (0,0) [Pull (7,-1) (8,-10)] |> filled lightCharcoal |> move (-13,25)]


bodyShape = group [
                      -- back of the mouth
                      rect 40 50 |> filled black |> rotate (degrees 10) |> move (-25,3),
                      sideAngleSide 80 (degrees 45) 100 |> filled black |> move (-62,-38),
                      
                      -- teeth
                      teeth,
                      teeth |> scaleY -1 |> rotate (degrees -30) |> move (-10,-30),
                      
                      oval 100 150 |> filled (rgb 0 128 128) |> rotate (degrees -60) 
                               |> subtract (curve (34,-40) [Pull (44,20) (-13,50), Pull (-87,36) (-62,-5),
                                                            Pull (-36,-31) (-40,-26), Pull (-37,-34) (-6,-38)] 
                                                               |> filled white |> rotate (degrees 20)|> move (-50,-10))
                      ,
                      polygon [(-40,-30),(-28,25),(18,10),(20,-7)]
                               |> filled (rgb 0 128 128)
                               |> scaleY 1.5
                               |> move (80,12)
                               |> subtract (rect 10 60 |> filled white |> move (-55,5)),

                      curve (75,0) [Pull (-4,-35) (-20,0) ]
                               |> filled (rgb 0 128 128)
                               |> scaleX 2
                               |> scaleY 2.5
                               |> move (-30,-20)
                               |> rotate (degrees 15)
                               
                 ]
                 
medianFins = group [
                    
                    curve (-20.86,-14.37) [Pull (-22,-8) (-23,-1), Pull (-23,8) (-23,18), Pull (-22,20) (-20,23), Pull (-18,16) (-15,10),
                                           Pull (-13,8) (-11,6), Pull (-8,7) (-6,8), Pull (-1,11) (3,14), Pull (6,15) (8,16),
                                           Pull (7,14) (6,12), Pull (5,7) (5,1), Pull (10,4) (16,6), Pull (19,7) (23,8),
                                           Pull (20,3) (18,-2), Pull (18,-4) (19,-6), Pull (21,-6) (24,-7), Pull (27,-5) (30,-4),
                                           Pull (33,-3) (35,-3), Pull (33,-6) (30,-10), Pull (30,-12) (30,-14), Pull (31,-15) (33,-16),
                                           Pull (39,-15) (45,-14), Pull (43,-18) (42,-21), Pull (43,-24) (44,-27), Pull (47,-26) (51,-26),
                                           Pull (53,-26) (55,-26), Pull (50,-36) (45,-46), Pull (12,-30) (-21,-14)]
                          |> filled lightBlue
                    ]
                
tailandarm = group [
               fin |> scale 0.35,  
               polygon [(-25,-20),(-20,25),(18,10),(20,-7)]
                 |> filled (rgb 0 128 128)
                 |> move (-30,5)
              ]
              
fin = group [curve (-32,-10) [Pull (-40,8) (-40,20), Pull (-43,60) (-25,0), Pull (-21,50) (-18,0), Pull (-5,40) (-10,0), Pull (5,30) (-4,0), Pull (10,20) (2,0), Pull (21,13) (-1,-10) ]
                  |> filled lightBlue
                  |> scaleX 1.5
                  |> scaleY 3
                  |> rotate (degrees -80)  
             ]

type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

init = { time = 0 }

update msg model =
  case msg of
    Tick t _ -> { model | time = t }

view model = collage 192 128 (myShapes model)

main = gameApp Tick { model = init, view = view, update = update, title = "Starfish" }