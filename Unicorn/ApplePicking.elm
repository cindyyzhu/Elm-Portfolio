module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

myShapes model =
    [background
       |> scale 0.5
       |> move (0, -20)]
       
       ++
    (List.indexedMap (\i c ->
        if c.collected then
            group [
            ]
        else
          apple
          |> move (c.x, c.y)
          |> scale 0.1
          |> notifyTap (Collect i)
            --circle 8
            --    |> filled (hsl (toFloat i * 0.3 + model.time * 0.1) 0.9 0.6)
            --    |> move (c.x, c.y)
            --    |> notifyTap (Collect i)
    ) model.circles)
    ++
    -- Score display
    [ --text ("Collected: " ++ String.fromInt model.score)
      --  |> filled black
      --  |> scale 0.5
       -- |> move (-85, 55) ,
       
   
       
     text (String.fromInt model.score)
        |> filled yellow
        |> scale 1.2
        |> move (60, 50)
    -- Spawn indicator (pulses)
    ---, circle 4
       --- |> filled (rgba 1 1 1 (0.3 + 0.2 * sin (model.time * 3)))
       --- |> move (80, -55)
    ]

background = group [
    -- Background
      rect 680 500 |> filled (rgb 112 226 255)
    , rect 680 300 |> filled (rgb 112 217 255) |> makeTransparent 0.4 |> move (0, 100)

    , rect 680 100 
    |> filled (rgb 50 199 0)
    |> move (0, -60)
    
    -- Ground
    , rect 680 80 |> filled (rgb 74 122 48) |> move (0, -210)
    , rect 680 60 |> filled (rgb 61 102 38) |> move (0, -220)

    -- Ground tufts
    , oval 110 20 |> filled (rgb 90 144 64) |> makeTransparent 0.6 |> move (-280, -195)
    , oval 130 18 |> filled (rgb 90 144 64) |> makeTransparent 0.55 |> move (-150, -197)
    , oval 140 20 |> filled (rgb 90 144 64) |> makeTransparent 0.58 |> move (0, -194)
    , oval 128 18 |> filled (rgb 90 144 64) |> makeTransparent 0.55 |> move (150, -196)
    , oval 120 20 |> filled (rgb 90 144 64) |> makeTransparent 0.6 |> move (280, -193)

    -- Tree helper: each apple tree = trunk + branch stubs + layered round canopy blobs

    -- TREE 1 (x = -285)
    , rect 12 120 |> filled (rgb 107 66 38) |> move (-285, -30)
    , rect 5 40 |> filled (rgb 107 66 38) |> rotate (degrees 40) |> move (-300, 0)
    , rect 5 40 |> filled (rgb 107 66 38) |> rotate (degrees -40) |> move (-270, 2)
    , circle 38 |> filled (rgb 46 125 50) |> move (-285, 55)
    , circle 28 |> filled (rgb 51 138 56) |> move (-308, 42)
    , circle 28 |> filled (rgb 46 125 50) |> move (-262, 40)
    , circle 30 |> filled (rgb 58 145 64) |> move (-285, 82)
    , circle 22 |> filled (rgb 67 163 74) |> move (-303, 70)
    , circle 22 |> filled (rgb 61 152 68) |> move (-267, 68)
    , circle 20 |> filled (rgb 74 174 80) |> makeTransparent 0.8 |> move (-285, 100)

    -- TREE 2 (x = -190)
    , rect 12 120 |> filled (rgb 94 59 30) |> move (-190, -33)
    , rect 5 38 |> filled (rgb 94 59 30) |> rotate (degrees 38) |> move (-205, -3)
    , rect 5 38 |> filled (rgb 94 59 30) |> rotate (degrees -38) |> move (-175, -1)
    , circle 36 |> filled (rgb 39 100 41) |> move (-190, 50)
    , circle 26 |> filled (rgb 46 112 48) |> move (-212, 38)
    , circle 26 |> filled (rgb 41 105 43) |> move (-168, 36)
    , circle 28 |> filled (rgb 52 130 56) |> move (-190, 76)
    , circle 20 |> filled (rgb 61 148 65) |> move (-207, 65)
    , circle 20 |> filled (rgb 56 140 60) |> move (-173, 63)
    , circle 18 |> filled (rgb 70 160 75) |> makeTransparent 0.8 |> move (-190, 95)

    -- TREE 3 (x = -95)
    , rect 13 90 |> filled (rgb 107 66 38) |> move (-95, -27)
    , rect 5 42 |> filled (rgb 107 66 38) |> rotate (degrees 42) |> move (-111, 2)
    , rect 5 42 |> filled (rgb 107 66 38) |> rotate (degrees -42) |> move (-79, 4)
    , circle 40 |> filled (rgb 46 125 50) |> move (-95, 58)
    , circle 30 |> filled (rgb 51 138 56) |> move (-118, 45)
    , circle 30 |> filled (rgb 46 125 50) |> move (-72, 43)
    , circle 32 |> filled (rgb 58 145 64) |> move (-95, 86)
    , circle 24 |> filled (rgb 67 163 74) |> move (-114, 74)
    , circle 24 |> filled (rgb 61 152 68) |> move (-76, 72)
    , circle 22 |> filled (rgb 74 174 80) |> makeTransparent 0.8 |> move (-95, 106)

    -- TREE 4 (x = 0, center)
    , rect 13 100 |> filled (rgb 94 59 30) |> move (0, -29)
    , rect 5 40 |> filled (rgb 94 59 30) |> rotate (degrees 40) |> move (-15, 1)
    , rect 5 40 |> filled (rgb 94 59 30) |> rotate (degrees -40) |> move (15, 3)
    , circle 38 |> filled (rgb 39 100 41) |> move (0, 54)
    , circle 28 |> filled (rgb 46 112 48) |> move (-22, 41)
    , circle 28 |> filled (rgb 41 105 43) |> move (22, 39)
    , circle 30 |> filled (rgb 52 130 56) |> move (0, 80)
    , circle 22 |> filled (rgb 61 148 65) |> move (-18, 69)
    , circle 22 |> filled (rgb 56 140 60) |> move (18, 67)
    , circle 20 |> filled (rgb 70 160 75) |> makeTransparent 0.8 |> move (0, 100)

    -- TREE 5 (x = 95)
    , rect 13 100 |> filled (rgb 107 66 38) |> move (95, -27)
    , rect 5 42 |> filled (rgb 107 66 38) |> rotate (degrees 42) |> move (79, 2)
    , rect 5 42 |> filled (rgb 107 66 38) |> rotate (degrees -42) |> move (111, 4)
    , circle 40 |> filled (rgb 46 125 50) |> move (95, 58)
    , circle 30 |> filled (rgb 51 138 56) |> move (72, 45)
    , circle 30 |> filled (rgb 46 125 50) |> move (118, 43)
    , circle 32 |> filled (rgb 58 145 64) |> move (95, 86)
    , circle 24 |> filled (rgb 67 163 74) |> move (76, 74)
    , circle 24 |> filled (rgb 61 152 68) |> move (114, 72)
    , circle 22 |> filled (rgb 74 174 80) |> makeTransparent 0.8 |> move (95, 106)

    -- TREE 6 (x = 190)
    , rect 12 100 |> filled (rgb 94 59 30) |> move (190, -33)
    , rect 5 38 |> filled (rgb 94 59 30) |> rotate (degrees 38) |> move (175, -3)
    , rect 5 38 |> filled (rgb 94 59 30) |> rotate (degrees -38) |> move (205, -1)
    , circle 36 |> filled (rgb 39 100 41) |> move (190, 50)
    , circle 26 |> filled (rgb 46 112 48) |> move (168, 38)
    , circle 26 |> filled (rgb 41 105 43) |> move (212, 36)
    , circle 28 |> filled (rgb 52 130 56) |> move (190, 76)
    , circle 20 |> filled (rgb 61 148 65) |> move (173, 65)
    , circle 20 |> filled (rgb 56 140 60) |> move (207, 63)
    , circle 18 |> filled (rgb 70 160 75) |> makeTransparent 0.8 |> move (190, 95)

    -- TREE 7 (x = 285)
    , rect 12 85 |> filled (rgb 107 66 38) |> move (285, -30)
    , rect 5 40 |> filled (rgb 107 66 38) |> rotate (degrees 40) |> move (270, 0)
    , rect 5 40 |> filled (rgb 107 66 38) |> rotate (degrees -40) |> move (300, 2)
    , circle 38 |> filled (rgb 46 125 50) |> move (285, 55)
    , circle 28 |> filled (rgb 51 138 56) |> move (262, 42)
    , circle 28 |> filled (rgb 46 125 50) |> move (308, 40)
    , circle 30 |> filled (rgb 58 145 64) |> move (285, 82)
    , circle 22 |> filled (rgb 67 163 74) |> move (267, 70)
    , circle 22 |> filled (rgb 61 152 68) |> move (303, 68)
    , circle 20 |> filled (rgb 74 174 80) |> makeTransparent 0.8 |> move (285, 100)

    -- Light dapple highlights
    , oval 24 16 |> filled (rgb 110 201 110) |> makeTransparent 0.25 |> move (-285, 100)
    , oval 22 14 |> filled (rgb 110 201 110) |> makeTransparent 0.22 |> move (-190, 94)
    , oval 26 16 |> filled (rgb 110 201 110) |> makeTransparent 0.25 |> move (-95, 105)
    , oval 22 14 |> filled (rgb 110 201 110) |> makeTransparent 0.22 |> move (0, 99)
    , oval 26 16 |> filled (rgb 110 201 110) |> makeTransparent 0.25 |> move (95, 105)
    , oval 22 14 |> filled (rgb 110 201 110) |> makeTransparent 0.22 |> move (190, 94)
    , oval 24 16 |> filled (rgb 110 201 110) |> makeTransparent 0.25 |> move (285, 100)
    
    

  ]
apple = group [
  curve (-39.56,25.929) [Pull (-17.23,33.030) (-6.295,24.730),Pull (11.649,9.0941) (8.3934,-9.742),Pull (5.8498,-29.77) (-8.093,-42.41),Pull (-14.98,-49.21) (-21.88,-49.61),Pull (-29.37,-49.86) (-36.87,-48.71),Pull (-40.31,-48.26) (-43.76,-49.01),Pull (-48.11,-50.11) (-52.45,-49.01),Pull (-55.90,-47.81) (-59.35,-45.41),Pull (-71.84,-34.57) (-76.74,-20.53),Pull (-82.99,-2.497) (-75.84,13.939),Pull (-70.64,25.083) (-59.05,28.627),Pull (-54.85,29.728) (-46.46,26.829),Pull (-43.01,25.829) (-39.56,25.929)]
  |> filled red
  
  , 
  curve (-8.093,19.035) [Pull (7.2023,3.6489) (2.0983,-16.33),Pull (12.352,4.9988) (-8.093,19.035)]
  |> filled white
  
  ,curve (-44.96,45.114) [Pull (-39.71,36.572) (-38.66,26.229),Pull (-37.77,26.529) (-36.87,26.829),Pull (-35.02,36.121) (-37.77,45.414),Pull (-41.36,45.114) (-44.96,45.114)]
  |> filled darkBrown
  
  , 
  curve (-35.67,34.622) [Pull (-22.63,55.616) (-1.199,50.210),Pull (-12.23,28.216) (-35.67,34.622)]
  |> filled darkGreen
  , 
  curve (-35.67,34.922) [Pull (-22.63,43.618) (-9.592,46.313)]
  |> outlined (solid 0.25) black
 ]
 
type Msg
    = Tick Float GetKeyState
    | Collect Int


type alias Circle =
    { x : Float, y : Float, collected : Bool }


type alias Model =
    { time : Float
    , circles : List Circle
    , score : Int
    , nextSpawn : Float
    }


update msg model =
    case msg of
        Tick t _ ->
            let
                newModel =
                    { model | time = t }

                -- Spawn a new circle every 2 seconds
               --- spawnDue = 
                   --- t - model.nextSpawn > 2.0

                newCircles =
                   --- if spawnDue then
                   --     model.circles
                   --         ++ [ { x = 80 * sin (t * 1.3 + 1)
                   --              , y = 50 * cos (t * 0.9 + 2)
                   --              , collected = False
                   --              }
                   --            ]
                   -- else
                        model.circles

               -- newNextSpawn =
                   -- if spawnDue then t else model.nextSpawn
            in
            { newModel
                | circles = newCircles
               -- , nextSpawn = newNextSpawn
            }

        Collect i ->
            let
                updatedCircles =
                    List.indexedMap
                        (\idx c ->
                            if idx == i then { c | collected = True }
                            else c
                        )
                        model.circles
            in
            { model
                | circles = updatedCircles
                , score = model.score + 1
            }


init =
    { time = 0
    , circles =
        [ 
        -- Tree 1 (far left)
        { x = -780, y = 80,  collected = False }
        , { x = -900, y = 120, collected = False }
        
        -- Tree 2
        , { x = -600, y = 60,  collected = False }
        , { x = -20, y = 150, collected = False }
        
        -- Tree 3
        , { x = -420, y = 200, collected = False }
        , { x = -360, y =9,  collected = False }
        
        -- Tree 4
        , { x = -240, y = 130, collected = False }
        , { x = -100, y = -40, collected = False }
        
        -- Tree 5 (center)
        , { x = -60,  y = 250,  collected = False }
        , { x = 60,   y = 180, collected = False }
        
        -- Tree 6
        , { x = 180,  y = 0, collected = False }
        , { x = 300,  y = 150, collected = False }
        
        -- Tree 7
        , { x = 420,  y = 0, collected = False }
        , { x = 540,  y = 50,  collected = False }
        
        , { x = 720,  y = 210, collected = False }
        
        , { x = 850,  y = 0, collected = False }
        
       , { x = 900,  y = 150, collected = False }


        ]
    , score = 0
    , nextSpawn = 0
    }


main =
    gameApp Tick
        { model = init
        , view = view
        , update = update
        , title = "Potion Game to regenerate health"
        }


view model =
    collage 192 128 (myShapes model)