module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)


type FoodItem
    = Pizza
    | IceCream
    | Carrot
    | Apple
    | Cupcake
    | Watermelon


allFoods =
    [ Pizza, IceCream, Carrot, Apple, Cupcake, Watermelon ]


foodLabel food =
    case food of
        Pizza      -> "Pizza"
        IceCream   -> "Ice Cream"
        Carrot     -> "Carrot"
        Apple      -> "Apple"
        Cupcake    -> "Cupcake"
        Watermelon -> "Watermelon"


foodShape food =
    case food of
        Pizza ->
            group
                [ pizza
                |> scale 0.18
                ]

        IceCream ->
            group
                [   icecream
                |> scale 0.12
                |> move (0, -8)
                ]

        Carrot ->
            group
                [ 
                carrot
                |> scale 0.1
                |> move (0, -1)
                ]

        Apple ->
            group
                [ apple
                |> scale 0.3
                |> move (11, 0)
                ]

        Cupcake ->
            group
                [ cupcake
                |> scale 0.3
                |> move (15, 3)]

        Watermelon ->
            group
                [ 
                watermelon
                ]


type alias Model =
    { time         : Float
    , scrollOffset : Float
    , fedFoods     : List FoodItem
    , happiness    : Float
    , feedEffect   : Float
    , lastFed      : Maybe FoodItem
    }


type Msg
    = Tick Float GetKeyState
    | FeedFood FoodItem
    | ScrollLeft
    | ScrollRight


update msg model =
    case msg of
        Tick t _ ->
            { model
                | time       = t
                , happiness  = clamp 0 100 (model.happiness - (t - model.time) * 1.2)
                , feedEffect = max 0 (model.feedEffect - (t - model.time) * 1.5)
            }

        FeedFood food ->
            { model
                | fedFoods   = food :: model.fedFoods
                , happiness  = clamp 0 100 (model.happiness + 20)
                , feedEffect = 1
                , lastFed    = Just food
            }

        ScrollLeft ->
            { model | scrollOffset = clamp 0 (toFloat (List.length allFoods - 1) * 52) (model.scrollOffset - 52) }

        ScrollRight ->
            { model | scrollOffset = clamp 0 (toFloat (List.length allFoods - 1) * 52) (model.scrollOffset + 52) }

init =
    { time         = 0
    , scrollOffset = 0
    , fedFoods     = []
    , happiness    = 60
    , feedEffect   = 0
    , lastFed      = Nothing
    }


main =
    gameApp Tick
        { model  = init
        , view   = view
        , update = update
        , title  = "Feed the Unicorn"
        }


view model =
    collage 192 128 (myShapes model)


visibleFoods scrollOffset =
    List.filterMap
        (\( i, food ) ->
            let
                sx = toFloat i * 52 - scrollOffset - 30
            in
            if sx > -50 && sx < 80 then Just ( i, food, sx )
            else Nothing
        )
        (List.indexedMap Tuple.pair allFoods)




myShapes model =
    let
        sky     = rect 192 128 |> filled (rgb 210 240 255)
        sunGlow = circle 22    |> filled (rgba 255 240 150 0.35) |> move ( 75, 50 )
        theSun  = circle 14    |> filled (rgb 255 230 80)  |> move ( 75, 50 )

        mkCloud cx cy =
            group
                [ circle 9 |> filled white |> move (  0,  0 )
                , circle 7 |> filled white |> move ( 11, -2 )
                , circle 8 |> filled white |> move ( -9, -2 )
                , circle 5 |> filled white |> move (  5, -6 )
                ]
                |> move ( cx + sin (model.time * 0.08) * 3, cy )
                |> makeTransparent 0.88

        clouds = [ mkCloud -65 48, mkCloud 28 52, mkCloud 78 44, mkCloud -20 27 ]

        -- green grass ground
        ground = rect 192 100 |> filled (rgb 145 210 130) |> move ( 0, -60 )

        -- row of pink flowers next to the unicorn on both sides
        mkFlower x =
            group
                [ circle 2   |> filled (rgb 255 220 50)
                , circle 1.5 |> filled (rgb 255 120 170) |> move (  0,  2.5 )
                , circle 1.5 |> filled (rgb 255 120 170) |> move (  0, -2.5 )
                , circle 1.5 |> filled (rgb 255 120 170) |> move (  2.5, 0 )
                , circle 1.5 |> filled (rgb 255 120 170) |> move ( -2.5, 0 )
                ]
                |> move ( x, -20 )

        flowers = List.map mkFlower [ -88, -70, -50, -35, 15, 35, 58, 78 ]

        beltY = -44

        stripeOffset = modBy 14 (round (model.time * 28)) |> toFloat

        beltStripes =
            List.map
                (\i ->
                    rect 2.5 23
                        |> filled (rgba 0 0 0 0.1)
                        |> move ( toFloat i * 14 - 75 + stripeOffset, beltY )
                )
                (List.range 0 13)

        belt =
            group
                ([ roundedRect 162 30 8 |> filled (rgb 70 50 30)  |> move ( 0, beltY )
                 , roundedRect 158 25 6 |> filled (rgb 105 78 48) |> move ( 0, beltY )
                 ]
                    ++ beltStripes
                    ++ [ circle 12 |> filled (rgb 50 35 15) |> move ( -80, beltY )
                       , circle 8  |> filled (rgb 75 55 30) |> move ( -80, beltY )
                       , circle 12 |> filled (rgb 50 35 15) |> move (  80, beltY )
                       , circle 8  |> filled (rgb 75 55 30) |> move (  80, beltY )
                       , rect 160 4 |> filled (rgb 90 65 40) |> move ( 0, beltY + 14 )
                       ]
                )

        beltFoods =
            List.map
                (\( _, food, sx ) ->
                    group
                        [ circle 12|> filled (rgba 255 255 255 0.2)
                        , foodShape food |> scale 0.58
                        , text (foodLabel food)
                            |> size 4
                            |> centered
                            |> filled black
                            |> move ( 0, -19 )
                        ]
                        |> move ( sx-22, beltY )
                        |> notifyTap (FeedFood food)
                )
                (visibleFoods model.scrollOffset)

        canLeft  = model.scrollOffset > 0
        canRight = model.scrollOffset < toFloat (List.length allFoods - 1) * 52

        mkArrow lbl x active msg =
            group
                [  text lbl
                    |> size 8
                    |> centered
                    |> filled (if active then white else rgba 255 255 255 0.3)
                    |> move ( 0, -3 )
                ]
                |> move ( x, beltY )
                |> notifyTap msg

        leftArrow  = mkArrow "<<" -80 canLeft  ScrollLeft
        rightArrow = mkArrow ">>"  80 canRight ScrollRight

        bounce = sin (model.time * 1.6) * 1.8

        wiggle =
            if model.feedEffect > 0.4
            then sin (model.time * 15) * 3 * model.feedEffect
            else 0

        hearts =
            if model.feedEffect > 0 then
                group
                    [ heart |> move ( -100, 60 + (1 - model.feedEffect) * 18 ) |> makeTransparent model.feedEffect
                    |> scale 0.2
                    , heart  |> move ( -50, -40 + (1 - model.feedEffect) * 14 ) |> makeTransparent model.feedEffect
                                        |> scale 0.2

                    , heart|> move ( 50, 0 + (1 - model.feedEffect) * 22 ) |> makeTransparent model.feedEffect
                                       |> scale 0.2

                   ]
            else group []

        unicornGroup =
            group [ unicorn, hearts ]
                |> move ( 52 + wiggle, -2 + bounce )

        title =
            text "Feed the Unicorn!"
                |> size 8
                |> bold
                |> filled (rgb 110 40 130)
                |> move ( -90, 52 )

        instr =
            text "Click on the food to feed the unicorn! And click on the arrows to select different foods!"
                |> size 4
                |> filled (rgba 90 40 110 0.75)
                |> move ( -90, 43 )

        fedCount =
            text ("Food count: " ++ String.fromInt (List.length model.fedFoods))
                |> size 5.5
                |> filled (rgb 100 40 120)
                |> move ( 50, 52 )

        hpW    = 58
        hpFill = hpW * model.happiness / 100
        hpCol  =
            if model.happiness > 60 then rgb 70 210 110
            else if model.happiness > 30 then rgb 245 185 30
            else rgb 225 55 55

        hapBar =
            group
                [ rect hpW 6 |> filled (rgba 0 0 0 0.2)
                , rect (max 0 hpFill) 6
                    |> filled hpCol
                    |> move ( (hpFill - hpW) / 2, 0 )
                , rect hpW 6 |> outlined (solid 0.7) (rgba 0 0 0 0.35)
                , text "HP"
                    |> size 4
                    |> filled (rgb 220 50 100)
                    |> move ( -39, -1 )
                ]
                |> move ( -50, 33 )

        yumPopup =
            if model.feedEffect > 0 then
                text "Yum!"
                    |> size 9
                    |> bold
                    |> centered
                    |> filled (rgb 255 80 190)
                    |> move ( 52, 28 + (1 - model.feedEffect) * 8 )
                    |> makeTransparent model.feedEffect
            else group []

        hungryWarning =
            if model.happiness < 25 then
                group
                    [ roundedRect 56 13 4 |> filled (rgba 255 255 255 0.9)
                    , text "I'm hungry!"
                        |> size 5
                        |> centered
                        |> filled (rgb 200 40 40)
                        |> move ( 0, -2 )
                    ]
                    |> move ( 52, 22 )
                    |> makeTransparent (abs (sin (model.time * 2.5)))
            else group []

        lastFedBadge =
            case ( model.feedEffect > 0, model.lastFed ) of
                ( True, Just food ) ->
                    group
                        [ roundedRect 38 9 3 |> filled (rgba 255 255 255 0.8)
                        , text (foodLabel food)
                            |> size 4.2
                            |> centered
                            |> filled (rgb 120 40 140)
                            |> move ( 0, -1.5 )
                        ]
                        |> move ( 25, 10 )
                        |> makeTransparent model.feedEffect
                _ -> group []

    in
    [ sky, sunGlow, theSun ]
    ++ clouds
    ++ [ ground ]
    ++ flowers
    ++ [ belt ]
    ++ beltFoods
    ++ [ leftArrow
       , rightArrow
       , unicornGroup
       , title
       , instr
       , fedCount
       , hapBar
       , yumPopup
       , hungryWarning
       , lastFedBadge
       ]
--------------------------------------------------------------------------------
-----------------------------------------------------------------ASSETS--------------------------------------------------
unicorn = group [curve (-53.35,-4.046) [Pull (-51.55,-2.737) (-49.76,-1.948),Pull (-51.70,0.3823) (-53.35,-4.046)]
  |> filled (rgb 30 131 189) -- Blue part of tail filler
  ,
  curve (-40.16,-10.64) [Pull (-42.71,-6.295) (-45.26,-1.948),Pull (-48.11,-0.599) (-50.96,0.7494),Pull (-56.50,-3.147) (-62.05,-7.044),Pull (-60.25,-11.39) (-58.45,-15.73),Pull (-63.25,-27.12) (-68.04,-38.51),Pull (-63.27,-41.63) (-58.45,-38.51),Pull (-51.51,-35.11) (-51.25,-27.42),Pull (-50.46,-20.23) (-53.35,-13.03),Pull (-53.61,-7.033) (-52.15,-2.548),Pull (-51.80,-2.048) (-49.76,-1.948),Pull (-46.46,-5.096) (-43.16,-8.243),Pull (-41.81,-9.292) (-40.16,-10.64)]
  |> filled (rgb 30 131 189) -- Blue part of tail
  ,
  curve (-42.86,-5.545) [Pull (-43.58,-0.408) (-48.86,2.8477),Pull (-55.00,3.8969) (-61.15,4.9461),Pull (-65.22,-4.124) (-63.25,-18.43),Pull (-63.85,-21.88) (-64.44,-25.33),Pull (-65.01,-28.39) (-68.34,-31.02),Pull (-73.29,-34.26) (-78.23,-30.42),Pull (-76.60,-36.77) (-68.04,-38.51),Pull (-56.29,-36.07) (-55.45,-23.23),Pull (-57.35,-13.07) (-55.45,-5.245),Pull (-51.69,0.3030) (-46.16,-2.548),Pull (-44.66,-6.594) (-43.16,-10.64),Pull (-43.01,-7.793) (-42.86,-5.545)]
  |> filled (rgb 30 189 125) -- Green part of tail
  ,
  curve (-43.76,-4.646) [Pull (-44.00,-0.599) (-46.16,3.4473),Pull (-51.55,5.6955) (-56.95,7.9437),Pull (-62.35,4.9461) (-67.74,1.9484),Pull (-68.94,-4.196) (-70.14,-10.34),Pull (-68.94,-14.38) (-67.74,-18.43),Pull (-66.54,-20.53) (-65.34,-22.63),Pull (-66.99,-24.43) (-68.64,-26.22),Pull (-66.39,-25.77) (-64.14,-25.33),Pull (-61.60,-21.97) (-62.05,-16.93),Pull (-63.58,-9.621) (-62.95,-4.346),Pull (-61.67,0.6007) (-57.55,2.5480),Pull (-47.05,5.5903) (-43.76,-4.646)]
  |> filled (rgb 237 235 81) -- Yellow part of tail
  ,
  curve (-41.36,-3.147) [Pull (-41.96,-1.648) (-42.56,-0.149),Pull (-44.83,8.3157) (-54.25,10.941),Pull (-62.19,12.632) (-68.64,7.6440),Pull (-76.58,-0.048) (-72.24,-12.14),Pull (-67.92,-16.76) (-69.24,-22.63),Pull (-73.33,-28.19) (-76.74,-19.63),Pull (-79.05,-25.46) (-74.04,-29.52),Pull (-70.00,-32.86) (-66.24,-28.92),Pull (-61.64,-23.11) (-65.04,-14.53),Pull (-69.32,1.8536) (-59.95,5.2459),Pull (-50.92,9.2583) (-44.06,-1.049),Pull (-42.71,-4.196) (-41.36,-7.344),Pull (-41.36,-5.245) (-41.36,-3.147)]
  |> filled (rgb 237 81 180) -- Pink part of tail
  ,
  curve (0.8992,-21.73) [Pull (1.4781,-26.65) (3.8969,-30.42),Pull (6.2273,-37.17) (2.9976,-43.91),Pull (1.5590,-46.31) (-0.599,-48.71),Pull (-2.248,-49.91) (-3.896,-51.11),Pull (-4.196,-47.21) (-4.496,-43.31),Pull (-1.757,-39.56) (-2.697,-35.82),Pull (-3.476,-32.67) (-6.295,-29.52),Pull (-2.847,-25.62) (0.5995,-21.73),Pull (0.5995,-21.73) (0.8992,-21.73)]
  |> filled white -- Leg 1
  |> addOutline (solid 1) black
  ,
  curve (-8.393,-28.62) [Pull (-11.94,-40.01) (-8.093,-51.40),Pull (-8.543,-53.65) (-8.992,-55.90),Pull (-12.29,-53.95) (-15.58,-52.00),Pull (-18.48,-42.41) (-19.18,-32.82),Pull (-15.43,-29.52) (-11.69,-26.22),Pull (-10.19,-27.57) (-8.393,-28.62)]
  |> filled white -- Leg 2
  |> addOutline (solid 1) black
  ,
  curve (-27.87,-31.32) [Pull (-28.26,-33.72) (-29.97,-36.12),Pull (-32.02,-40.92) (-29.07,-47.21),Pull (-29.67,-49.16) (-30.27,-51.11),Pull (-33.42,-48.86) (-36.57,-46.61),Pull (-38.23,-41.36) (-38.96,-36.12),Pull (-34.97,-33.23) (-34.77,-29.82),Pull (-29.67,-26.97) (-24.58,-24.13),Pull (-26.37,-27.87) (-28.17,-31.62)]
  |> filled white -- Leg 3
  |> addOutline (solid 1) black
  ,
  curve (-15.88,33.423) [Pull (-25.07,39.056) (-22.78,52.009),Pull (-12.68,48.844) (-10.79,39.718),Pull (-5.545,44.515) (-0.299,49.311),Pull (2.0983,47.812) (4.4964,46.313),Pull (7.1943,48.861) (9.8922,51.409),Pull (12.740,52.989) (15.587,53.208),Pull (16.408,48.562) (14.388,43.915),Pull (14.538,40.018) (14.688,36.121),Pull (16.838,30.276) (14.988,24.430),Pull (18.977,18.585) (16.487,12.740),Pull (10.513,6.5216) (0.2997,8.5433),Pull (6.2995,-11.48) (0.8992,-22.63),Pull (-2.937,-27.11) (-8.093,-29.52),Pull (-18.89,-34.31) (-31.77,-30.42),Pull (-33.41,-29.80) (-34.17,-28.62),Pull (-36.18,-33.57) (-42.26,-38.51),Pull (-44.64,-42.95) (-41.66,-51.11),Pull (-41.21,-53.35) (-40.76,-55.60),Pull (-42.71,-55.60) (-44.66,-55.60),Pull (-46.61,-53.65) (-48.56,-51.70),Pull (-50.73,-44.21) (-51.25,-36.72),Pull (-47.91,-30.19) (-49.16,-23.23),Pull (-52.24,-12.89) (-49.76,-8.843),Pull (-43.89,3.1037) (-26.37,-0.749),Pull (-21.88,8.2435) (-17.38,17.236),Pull (-19.53,26.660) (-15.88,33.423)]
  |> filled white
  |> addOutline (solid 1) black -- Body
  ,
  curve (0,8.5433) [Pull (-7.614,9.6405) (-13.78,15.737)]
  |> outlined (solid 1) black -- Chin line
  ,
  curve (-6.894,-22.63) [Pull (-7.644,-25.92) (-8.393,-29.22)]
  |> outlined (solid 1) black -- Leg line
  ,
  curve (-4.496,-42.71) [Pull (-5.915,-44.02) (-6.295,-46.01),Pull (-6.386,-50.66) (-3.597,-52.30),Pull (-1.378,-51.24) (-1.199,-49.01),Pull (-3.467,-46.26) (-4.496,-42.71)]
  |> filled (rgb 35 173 204) -- Hoof 1
  |> addOutline (solid 1) black
  ,
  curve (-8.093,-52.90) [Pull (-6.184,-54.85) (-6.594,-56.80),Pull (-10.34,-58.80) (-14.08,-56.80),Pull (-15.01,-55.63) (-15.58,-52.90),Pull (-11.99,-54.24) (-8.093,-52.90)]
  |> filled (rgb 35 173 204) -- Hoof 2
  |> addOutline (solid 1) black
  ,
  curve (-28.47,-47.51) [Pull (-27.07,-49.46) (-26.67,-51.40),Pull (-30.87,-52.97) (-35.07,-51.11),Pull (-35.99,-49.31) (-36.27,-47.51),Pull (-32.37,-48.94) (-28.47,-47.51)]
  |> filled (rgb 35 173 204) -- Hoof 3
  |> addOutline (solid 1) black
  ,
  curve (-41.66,-52.00) [Pull (-39.65,-53.80) (-40.16,-55.60),Pull (-44.06,-57.49) (-47.96,-55.30),Pull (-48.83,-53.65) (-48.86,-52.00),Pull (-45.41,-53.68) (-41.66,-52.00)]
  |> filled (rgb 35 173 204) -- Hoof 4
  |> addOutline (solid 1) black
  ,
  curve (-19.78,47.512) [Pull (-20.45,36.807) (-12.88,35.822),Pull (-10.78,44.007) (-19.78,47.512)]
  |> filled (rgb 222 93 170) -- Left Ear
  ,
  curve (5.6955,15.437) [Pull (5.6955,15.437) (5.6955,15.437),Pull (5.7049,13.948) (7.1943,13.339),Pull (7.9649,14.568) (5.6955,15.437)]
  |> filled black -- Left Nostril
  ,
  curve (14.388,16.936) [Pull (13.568,16.097) (13.789,14.538),Pull (15.888,15.617) (14.388,16.936)]
  |> filled black -- Right Nostril
  ,
  curve (-9.892,24.430) [Pull (-7.494,23.081) (-5.096,21.733),Pull (-3.297,22.032) (-1.498,22.332),Pull (-1.199,22.032) (-0.899,21.733),Pull (0.4105,24.060) (-0.599,27.428),Pull (-0.717,30.326) (-4.796,31.625),Pull (-6.744,31.815) (-8.693,30.725),Pull (-8.632,31.175) (-9.292,31.625),Pull (-9.812,31.375) (-9.292,30.126),Pull (-9.872,30.076) (-9.892,29.227),Pull (-10.93,30.706) (-11.09,31.625),Pull (-11.29,30.586) (-10.49,28.627),Pull (-10.75,28.178) (-10.49,27.128),Pull (-11.47,27.728) (-11.69,27.728),Pull (-11.66,26.658) (-10.79,26.229),Pull (-10.83,25.180) (-9.892,24.430)]
  |> filled black -- Left Eye bg
  ,
  curve (-9.592,23.831) [Pull (-10.29,30.208) (-4.796,30.426),Pull (-4.196,25.180) (-3.597,19.934),Pull (-8.254,20.272) (-9.592,23.831)]
  |> filled white -- Left Eye bg white
  ,
  curve (-4.796,30.426) [Pull (-6.675,29.657) (-7.194,27.728),Pull (-7.044,25.330) (-6.894,22.932),Pull (-4.796,22.182) (-2.697,21.433),Pull (-2.847,25.330) (-2.997,29.227),Pull (-3.896,29.826) (-4.796,30.426)]
  |> filled black -- Left Eye bg filler
  ,
  curve (-6.594,29.227) [Pull (-8.614,26.849) (-7.194,22.032),Pull (-5.226,19.263) (-2.697,19.934),Pull (-1.118,20.383) (-0.899,22.032),Pull (-0.049,24.131) (-0.599,26.229),Pull (-0.799,25.629) (-1.798,25.030),Pull (-2.327,23.111) (-3.896,22.632),Pull (-6.125,23.511) (-6.594,25.629),Pull (-7.684,27.238) (-6.594,29.227)]
  |> filled (rgb 128 133 191) -- Left Eye Coloured Part
  ,
  curve (-2.697,25.629) [Pull (-3.428,25.180) (-2.398,24.730),Pull (-1.717,25.480) (-2.697,25.629)]
  |> filled white -- Left Eye bottom pupil
  ,
  curve (-5.096,28.627) [Pull (-6.436,28.268) (-5.096,27.428),Pull (-3.265,28.468) (-5.096,28.627)]
  |> filled white -- Left Eye top pupil
  ,
  curve (-7.793,19.934) [Pull (-7.644,19.334) (-7.494,18.735),Pull (-6.295,19.035) (-5.096,19.334),Pull (-3.027,18.745) (-2.398,16.637),Pull (-5.664,12.246) (-10.49,16.936),Pull (-11.21,19.195) (-7.793,19.934)]
  |> filled (rgb 222 93 170) -- Left cheek
  ,
  curve (-14.38,47.812) [Pull (-8.564,52.230) (-0.899,52.608),Pull (1.7985,52.719) (4.4964,51.709),Pull (7.9932,47.812) (12.889,43.915),Pull (17.866,41.675) (20.683,43.915),Pull (22.722,44.444) (23.081,46.613),Pull (23.843,39.917) (18.285,37.021),Pull (11.690,34.709) (5.0960,40.318),Pull (0.8992,43.615) (-3.297,46.913),Pull (-7.943,45.864) (-12.59,44.814),Pull (-13.63,46.463) (-14.38,47.812)]
  |> filled (rgb 30 189 125) 
  |> addOutline (solid 0.5) black -- Green top hair
  ,
  curve (2.0983,40.618) [Pull (3.4473,43.466) (4.7962,46.313),Pull (0.7494,48.353) (-3.297,48.112),Pull (-8.293,47.753) (-12.29,45.714),Pull (-11.69,44.365) (-11.09,43.016),Pull (-4.496,41.967) (2.0983,40.618)]
  |> filled (rgb 237 235 81) -- Yellow top hair
  ,
  curve (0.2997,44.215) [Pull (5.9449,52.959) (12.590,60.702),Pull (10.113,49.970) (4.7962,39.718),Pull (3.4473,39.569) (2.0983,39.419),Pull (1.0491,41.817) (0.2997,44.215)]
  |> filled white
  |> addOutline (solid 0.5) black -- Horn
  ,
  curve (3.2974,49.011) [Pull (3.6861,45.453) (6.5948,43.615)]
  |> outlined (solid 0.5) black -- Horn line 1
  ,
  curve (5.9953,52.908) [Pull (6.0543,49.900) (8.3934,47.812)]
  |> outlined (solid 0.5) black -- Horn line 2 
  ,
  curve (8.6932,56.805) [Pull (8.9325,53.967) (10.491,52.608)]
  |> outlined (solid 0.5) black -- Horn line 3
  ,
  curve (-42.56,-0.749) [Pull (-42.95,5.4171) (-48.26,7.9437),Pull (-54.10,12.642) (-59.35,11.540),Pull (-67.15,10.793) (-71.64,4.0468),Pull (-76.95,-3.706) (-70.74,-13.93),Pull (-67.66,-21.03) (-70.74,-24.73),Pull (-75.27,-23.99) (-77.03,-19.33),Pull (-78.63,-24.91) (-74.34,-29.52),Pull (-67.21,-33.04) (-65.04,-26.52),Pull (-64.07,-25.92) (-64.74,-25.33)]
  |> outlined (solid 0.5) black -- Tail outline 1
  ,
  curve (-68.34,-30.12) [Pull (-73.77,-34.41) (-78.83,-29.22),Pull (-78.19,-34.90) (-73.14,-37.62),Pull (-70.55,-38.59) (-68.64,-38.51),Pull (-64.18,-37.98) (-61.45,-35.52)]
  |> outlined (solid 0.5) black -- Tail outline 2
  ,
  curve (-68.34,-38.51) [Pull (-66.54,-40.54) (-61.75,-40.01),Pull (-54.37,-38.89) (-52.15,-31.32),Pull (-49.62,-23.05) (-52.45,-15.73),Pull (-54.13,-9.042) (-52.45,-4.346),Pull (-51.81,-2.907) (-50.06,-2.548),Pull (-48.56,-2.637) (-47.06,-4.046)]
  |> outlined (solid 0.5) black -- Tail outline 2
  ,
  curve (-11.99,43.016) [Pull (-9.193,44.925) (-3.597,44.515),Pull (4.1395,42.927) (4.7962,37.620),Pull (6.1268,33.493) (3.2974,30.725),Pull (3.6096,35.902) (-2.398,39.119),Pull (-5.595,41.118) (-10.19,40.918),Pull (-10.64,41.967) (-11.09,43.016),Pull (-11.24,43.316) (-11.99,43.016)]
  |> filled (rgb 237 81 180)
  |> addOutline (solid 0.5) black -- Pink hair bang
  ,
  curve (11.990,24.131) [Pull (10.791,24.580) (9.5925,25.030),Pull (8.4318,30.317) (11.391,32.524),Pull (12.440,33.514) (14.088,34.023),Pull (14.259,33.423) (13.189,32.824),Pull (14.238,32.814) (15.288,31.925),Pull (16.647,31.614) (17.086,32.824),Pull (17.637,31.374) (16.187,31.325),Pull (16.936,30.895) (17.686,31.625),Pull (17.596,29.905) (16.187,30.426),Pull (15.437,30.316) (14.688,30.725),Pull (14.388,28.028) (14.088,25.330),Pull (12.889,24.880) (11.990,24.131)]
  |> filled black -- Right eye bg
  ,
  curve (12.590,31.625) [Pull (13.489,31.785) (14.388,31.025),Pull (15.959,27.288) (13.489,23.831),Pull (12.780,22.691) (11.391,22.632),Pull (9.7318,22.350) (9.5925,26.829),Pull (9.4718,25.719) (11.391,25.330),Pull (12.390,25.699) (12.590,26.829),Pull (13.189,26.978) (13.789,27.128),Pull (14.189,29.797) (12.590,31.625)]
  |> filled (rgb 128 133 191) -- Right eye Coloured Part
  ,
  curve (10.791,30.126) [Pull (9.4814,28.327) (11.091,27.728),Pull (14.031,29.017) (10.791,30.126)]
  |> filled white -- Right eye top pupil
  ,
  curve (13.189,26.829) [Pull (12.349,27.128) (13.189,27.428),Pull (14.239,26.328) (13.189,26.829)]
  |> filled white -- Right eye bottom pupil
  ,
  curve (5.3957,13.039) [Pull (10.641,9.2292) (15.887,14.538)]
  |> outlined (solid 0.5) black
  ,
  curve (-22.78,39.718) [Pull (-25.46,34.213) (-26.37,27.428),Pull (-27.34,24.189) (-31.47,24.430),Pull (-35.63,25.248) (-35.67,29.826),Pull (-39.07,21.511) (-31.47,18.435),Pull (-30.12,17.945) (-29.37,18.735),Pull (-30.41,15.316) (-35.37,15.737),Pull (-38.67,17.395) (-40.16,20.533),Pull (-40.24,6.6911) (-29.67,2.2482),Pull (-27.38,1.9280) (-25.77,2.8477),Pull (-21.90,6.9437) (-23.98,13.039),Pull (-25.40,18.645) (-25.18,24.730),Pull (-23.85,30.606) (-20.68,36.121),Pull (-21.69,37.800) (-22.78,39.718)]
  |> filled (rgb 237 81 180)
  |> addOutline (solid 0.5) black -- Pink mane
  ,
  curve (-22.18,11.241) [Pull (-17.98,10.491) (-13.78,9.7423),Pull (-10.15,2.5480) (-13.48,-4.646),Pull (-15.03,-11.40) (-25.18,-12.44),Pull (-29.81,-11.99) (-32.37,-9.142),Pull (-25.85,-9.965) (-23.38,-3.147),Pull (-22.44,-1.498) (-22.78,0.1498),Pull (-26.22,-2.269) (-29.67,-1.648),Pull (-25.99,0.0494) (-24.28,3.1475),Pull (-23.23,7.1943) (-22.18,11.241)]
  |> filled (rgb 19 72 176) 
  |> addOutline (solid 0.5) black -- Darker Blue mane
  ,
  curve (-19.18,34.622) [Pull (-17.98,33.403) (-16.78,33.423),Pull (-21.69,25.613) (-13.48,9.4426),Pull (-12.71,4.3861) (-15.58,0.4496),Pull (-15.56,4.6463) (-17.38,8.8430),Pull (-16.68,4.4964) (-19.18,0.1498),Pull (-19.48,4.6463) (-21.58,9.1428),Pull (-20.64,3.0463) (-26.97,0.1498),Pull (-21.66,5.2459) (-23.38,10.341),Pull (-24.31,14.538) (-24.88,18.735),Pull (-23.83,26.679) (-19.18,34.622)]
  |> filled (rgb 30 131 189) -- Lighter Blue mane
  ,
  curve (-20.38,35.822) [Pull (-27.44,27.690) (-23.98,13.639),Pull (-25.01,27.451) (-18.88,34.622),Pull (-19.85,35.092) (-20.38,35.822)]
  |> filled (rgb 237 235 81)
  |> addOutline (solid 0.5) black -- Yellow mane
  ,
  curve (-9.892,24.430) [Pull (-8.543,22.401) (-7.194,21.733)]
  |> outlined (solid 0.4) black -- Left Eye coverer 1
  ,
  curve (-10.19,25.629) [Pull (-10.34,24.880) (-9.892,24.131)]
  |> outlined (solid 0.4) black -- Left Eye coverer 2
  ] |> scale 0.5
  |> move (-45,5)
  
  
pizza = group [
   -- Crust (outermost ring)
    circle 110
      |> filled (rgb 210 150 80)

  , -- Sauce layer
    circle 100
      |> filled (rgb 200 60 40)

  , -- Cheese layer
    circle 90
      |> filled (rgb 245 210 100)

  , -- Pepperoni 1 (top center)
    circle 14
      |> filled (rgb 180 40 30)
      |> move (0, 55)

  , -- Pepperoni highlight 1
    circle 5
      |> filled (rgb 220 80 60)
      |> move (-4, 59)

  , -- Pepperoni 2 (left)
    circle 14
      |> filled (rgb 180 40 30)
      |> move (-48, 20)

  , -- Pepperoni highlight 2
    circle 5
      |> filled (rgb 220 80 60)
      |> move (-52, 24)

  , -- Pepperoni 3 (right)
    circle 14
      |> filled (rgb 180 40 30)
      |> move (48, 20)

  , -- Pepperoni highlight 3
    circle 5
      |> filled (rgb 220 80 60)
      |> move (44, 24)

  , -- Pepperoni 4 (bottom left)
    circle 14
      |> filled (rgb 180 40 30)
      |> move (-30, -50)

  , -- Pepperoni highlight 4
    circle 5
      |> filled (rgb 220 80 60)
      |> move (-34, -46)

  , -- Pepperoni 5 (bottom right)
    circle 14
      |> filled (rgb 180 40 30)
      |> move (30, -50)

  , -- Pepperoni highlight 5
    circle 5
      |> filled (rgb 220 80 60)
      |> move (26, -46)

  , -- Pepperoni 6 (center)
    circle 14
      |> filled (rgb 180 40 30)
      |> move (0, 0)

  , -- Pepperoni highlight 6
    circle 5
      |> filled (rgb 220 80 60)
      |> move (-4, 4)

  , -- Slice lines (cut marks)
    rect 2 200
      |> filled (rgb 160 100 50)
      |> makeTransparent 0.5

  , rect 2 200
      |> filled (rgb 160 100 50)
      |> makeTransparent 0.5
      |> rotate (degrees 60)

  , rect 2 200
      |> filled (rgb 160 100 50)
      |> makeTransparent 0.5
      |> rotate (degrees 120)

 ]
 
icecream = group [
  -- Cone body
    polygon [ (0, -130), (-120, 100), (120, 100) ]
      |> filled (rgb 200 144 58)
      |> scale 0.6
      |> move (0, -5)

  , -- Cone shadow side
    polygon [ (0, -130), (-118, 98), (0, 98) ]
      |> filled (rgb 168 112 48)
      |> scale 0.6
      |> move (0, -5)

  , -- Waffle lines vertical
    line (-60, 90) (-14, -125) |> outlined (solid 1) (rgba 160 112 40 0.5)
    |> scale 0.6
  , line (-20, 87) (-4, -128)  |> outlined (solid 1) (rgba 160 112 40 0.45)
      |> scale 0.6

  , line (20, 87)  (4, -128)   |> outlined (solid 1) (rgba 160 112 40 0.45)
      |> scale 0.6

  , line (60, 90)  (14, -125)  |> outlined (solid 1) (rgba 160 112 40 0.5)
      |> scale 0.6


  , -- Waffle lines horizontal
    line (-118, 70)  (118, 70)  |> outlined (solid 1) (rgba 160 112 40 0.4)
        |> scale 0.6

  , line (-106, 50)  (106, 50)  |> outlined (solid 1) (rgba 160 112 40 0.35)
      |> scale 0.6

  , line ( -90, 25)  ( 90, 25)  |> outlined (solid 1) (rgba 160 112 40 0.3)
      |> scale 0.6

  , line ( -70,  0)  ( 70,  0)  |> outlined (solid 1) (rgba 160 112 40 0.25)
      |> scale 0.6


  , -- strawberry pink
    circle 90
      |> filled (rgb 244 184 200)
      |> move (0, 110)
      |> scale 0.95

  , -- Scoop highlight
    oval 56 28
      |> filled (rgb 248 207 218)
      |> makeTransparent 0.7
      |> move (-20, 125)

  , -- Sprinkles
    oval 6 3 |> filled (rgb 232 96 74)  |> move (-30, 120)
  , circle 5  |> filled (rgb 232 96 74)  |> move (10,  105)
  , circle 5  |> filled (rgb 232 96 74)  |> move (35,  125)
  , circle 4  |> filled (rgb 232 96 74)  |> move (-10, 140)
  , circle 5  |> filled (rgb 232 96 74)  |> move (20,  145)

  , -- Cherry stem
    rect 5 30
      |> filled (rgb 139 94 60)
      |> rotate (degrees 15)
      |> move (-50, 170)

  , -- Cherry
    circle 16
      |> filled (rgb 240 80 48)
      |> move (-40, 150)

  , -- Leaf
    oval 16 10
      |> filled (rgb 90 158 56)
      |> rotate (degrees 38)
      |> move (-40, 168)
  
 ]


carrot = group [

   -- Main carrot body
    polygon [ (0, -160), (-45, 60), (45, 60) ]
      |> filled (rgb 235 110 30)

  , -- Carrot body shading (left side darker)
    polygon [ (0, -160), (-45, 60), (0, 60) ]
      |> filled (rgb 210 85 15)
      |> makeTransparent 0.4

  , -- Carrot highlight (right side)
    polygon [ (0, -130), (8, -80), (28, 20), (20, 60), (0, 60) ]
      |> filled (rgb 255 145 60)
      |> makeTransparent 0.5

  , -- Horizontal texture lines
    line (-8,  -120) (8,  -120) |> outlined (solid 1.5) (rgba 200 75 10 0.35)
  , line (-16, -90)  (16, -90)  |> outlined (solid 1.5) (rgba 200 75 10 0.35)
  , line (-22, -60)  (22, -60)  |> outlined (solid 1.5) (rgba 200 75 10 0.35)
  , line (-30, -28)  (30, -28)  |> outlined (solid 1.5) (rgba 200 75 10 0.35)
  , line (-36,  5)   (36,  5)   |> outlined (solid 1.5) (rgba 200 75 10 0.35)
  , line (-42,  38)  (42,  38)  |> outlined (solid 1.5) (rgba 200 75 10 0.35)

  , carrotleaves
  |> mirrorY
  |> move (0, -90)

 ]
 
carrotleaves = group [
  -- Green base (where leaves meet carrot)
    oval 80 28
      |> filled (rgb 30 120 20)
      |> move (0, -148)

  , -- Green base outline
    oval 80 28
      |> outlined (solid 4) (rgb 20 80 10)
      |> move (0, -148)

  , -- Leaf 1 center (tallest)
    curve (0, -148)
      [ Pull (-15, -200) (-5, -240)
      , Pull (5, -260) (0, -270)
      , Pull (15, -255) (18, -230)
      , Pull (22, -195) (0, -148)
      ]
      |> filled (rgb 40 145 25)

  , curve (0, -148)
      [ Pull (-15, -200) (-5, -240)
      , Pull (5, -260) (0, -270)
      , Pull (15, -255) (18, -230)
      , Pull (22, -195) (0, -148)
      ]
      |> outlined (solid 4) (rgb 20 80 10)

  , -- Leaf center vein
    curve (0, -152) [ Pull (6, -210) (4, -265) ]
      |> outlined (solid 2) (rgb 20 80 10)

  , -- Leaf 2 (left)
    curve (-15, -152)
      [ Pull (-50, -195) (-52, -230)
      , Pull (-54, -258) (-45, -265)
      , Pull (-30, -258) (-22, -235)
      , Pull (-10, -205) (-15, -152)
      ]
      |> filled (rgb 38 138 22)

  , curve (-15, -152)
      [ Pull (-50, -195) (-52, -230)
      , Pull (-54, -258) (-45, -265)
      , Pull (-30, -258) (-22, -235)
      , Pull (-10, -205) (-15, -152)
      ]
      |> outlined (solid 4) (rgb 20 80 10)

  , line (-15, -155) (-45, -262)
      |> outlined (solid 2) (rgb 20 80 10)

  , -- Leaf 3 (right)
    curve (15, -152)
      [ Pull (10, -205) (22, -235)
      , Pull (30, -258) (45, -265)
      , Pull (54, -258) (52, -230)
      , Pull (50, -195) (15, -152)
      ]
      |> filled (rgb 42 150 28)

  , curve (15, -152)
      [ Pull (10, -205) (22, -235)
      , Pull (30, -258) (45, -265)
      , Pull (54, -258) (52, -230)
      , Pull (50, -195) (15, -152)
      ]
      |> outlined (solid 4) (rgb 20 80 10)

  , line (15, -155) (45, -262)
      |> outlined (solid 2) (rgb 20 80 10)

  , -- Leaf 4 (far left, shorter)
    curve (-30, -150)
      [ Pull (-72, -178) (-80, -210)
      , Pull (-85, -235) (-72, -242)
      , Pull (-55, -238) (-45, -215)
      , Pull (-35, -190) (-30, -150)
      ]
      |> filled (rgb 35 130 20)

  , curve (-30, -150)
      [ Pull (-72, -178) (-80, -210)
      , Pull (-85, -235) (-72, -242)
      , Pull (-55, -238) (-45, -215)
      , Pull (-35, -190) (-30, -150)
      ]
      |> outlined (solid 4) (rgb 20 80 10)

  , -- Leaf 5 (far right, shorter)
    curve (30, -150)
      [ Pull (35, -190) (45, -215)
      , Pull (55, -238) (72, -242)
      , Pull (85, -235) (80, -210)
      , Pull (72, -178) (30, -150)
      ]
      |> filled (rgb 45 155 30)

  , curve (30, -150)
      [ Pull (35, -190) (45, -215)
      , Pull (55, -238) (72, -242)
      , Pull (85, -235) (80, -210)
      , Pull (72, -178) (30, -150)
      ]
      |> outlined (solid 4) (rgb 20 80 10)
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
  
cupcake = group [  curve (-47.28,35.630) [Pull (-56.96,38.492) (-49.64,44.073),Pull (-32.06,50.303) (-19.92,35.292),Pull (-13.03,29.103) (-18.57,17.393),Pull (-6.926,16.018) (-12.15,3.8839),Pull (3.7124,-0.561) (-6.416,-12.32),Pull (-48.97,-20.82) (-91.52,-13.00),Pull (-99.94,6.6251) (-80.71,2.5329),Pull (-90.22,18.176) (-72.61,19.419),Pull (-75.49,27.849) (-65.85,34.279),Pull (-59.02,37.430) (-50.32,33.941),Pull (-43.29,31.588) (-41.54,37.994),Pull (-49.76,41.201) (-47.28,35.630)]
  |> filled pink
  |> addOutline (solid 1) black
  ,
  curve (-91.52,-16.04) [Pull (-92.03,-14.69) (-92.53,-13.34),Pull (-82.91,-36.81) (-73.28,-60.28),Pull (-40.82,-63.73) (-21.95,-57.58),Pull (-14.52,-34.78) (-7.092,-11.98),Pull (-48.16,-18.31) (-92.87,-14.35)]
  |> filled lightBrown
  |> addOutline (solid 1) black]
  
  
watermelon = group [
  circle 13 |> filled (rgb 60 180 60)
                , circle 11 |> filled (rgb 250 80 80)
                , circle 2  |> filled black |> move ( 3, 3 )
                , circle 2  |> filled black |> move ( -4, -2 )
                , circle 2  |> filled black |> move ( 1, -5 )
                , circle 13 |> outlined (solid 0.8) (rgb 40 140 40)

  ]
  
heart = group [triangle 40
          |> filled (hsl (degrees 315) 0.93 0.87) -- 315°, 93%, 87%
  |> rotate (degrees 30)
  |> scaleY 0.66
  
  ,circle 20
     |> filled (hsl (degrees 315) 0.93 0.87)
  |> move (17, 23.5)
  
  , circle 20
    |> filled (hsl (degrees 315) 0.93 0.87)
  |> move (-17, 23.5)]