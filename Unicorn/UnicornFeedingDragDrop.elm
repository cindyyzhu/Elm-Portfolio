module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import Html
import Html.Attributes exposing (href, rel)

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
                        |> move ( toFloat i * -14 + 75 - stripeOffset, beltY )
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
                        [ circle 12 |> filled (rgba 255 255 255 0.2)
                        , foodShape food |> scale 0.58
                        , text (foodLabel food)
                            |> size 4
                            |> centered
                            |> filled black
                            |> move ( 0, -19 )
                        ]
                        |> move ( sx - 22, beltY )
                        |> notifyMouseDownAt (\( mx, my ) -> DragStart food mx my)
                )
                (visibleFoods model.scrollOffset)
                
        dragLayer =
            case model.drag of
                Nothing -> group []
                Just d  ->
                    group
                        [ circle 14   |> filled (rgba 255 255 255 0.35)
                        , circle 14   |> outlined (dashed 1) (rgba 255 200 0 0.8)
                        , foodShape d.food |> scale 0.65
                        ]
                        |> move ( d.x, d.y )
                        |> notifyMouseMoveAt (\( mx, my ) -> DragMove mx my)
                        |> notifyMouseUpAt   (\( mx, my ) -> DragEnd  mx my)

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
            text "Drag the food on the conveyor belt to feed the unicorn! And click on the arrows to select different foods!"
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
       , dragLayer 
       ]


type FoodItem
    = Pizza
    | IceCream
    | Carrot
    | Apple
    | Cupcake
    | Watermelon
    | RainbowPretzel
    | Turnip
    | CottonCandy
    | Oats
    | Acai
    | ChocolateStrawberry
    | Candisteen
    | Hotdog
    | Burger
    | Mangosteen
    | Pineapple
    | Egg
    | Milk
    | Lemon
    | Cinnamon
    | Blueberries
    | Kiwi
    | Yogurt
    | Sugar
    | Peach


allFoods =
    [ Pizza, IceCream, Carrot, Apple, Cupcake, Watermelon, RainbowPretzel, Turnip, CottonCandy, Oats, Acai, ChocolateStrawberry, Candisteen, Hotdog, Burger, Mangosteen, Pineapple, Egg, Milk, Lemon, Cinnamon, Blueberries, Kiwi, Yogurt, Sugar, Peach ]


foodLabel food =
    case food of
        Pizza      -> "Pizza"
        IceCream   -> "Ice Cream"
        Carrot     -> "Carrot"
        Apple      -> "Apple"
        Cupcake    -> "Cupcake"
        Watermelon -> "Watermelon"
        RainbowPretzel -> "Pretzel"
        Turnip -> "Turnip"
        CottonCandy -> "Cotton Candy"
        Oats -> "Oats"
        Acai -> "Acai Berry"
        ChocolateStrawberry -> "Strawberry" 
        Candisteen -> "Candisteen"
        Hotdog -> "Hotdog"
        Burger -> "Burger"
        Mangosteen -> "Mangosteen"
        Pineapple -> "Pineapple"
        Egg -> "Egg"
        Milk -> "Milk"
        Lemon -> "Lemon"
        Cinnamon -> "Cinnamon"
        Blueberries -> "Blueberries"
        Kiwi -> "Kiwi"
        Yogurt -> "Yogurt"
        Sugar -> "Sugar"
        Peach -> "Peach"


foodShape food =
    case food of
        Pizza ->
            group
                [ pizza
                    |> scale 0.35
                    |> move (12, -5)
                ]

        IceCream ->
            group
                [ icecream
                    |> scale 0.12
                    |> move (0, -8)
                ]

        Carrot ->
            group
                [ carrott
                    |> scale 0.4
                    |> move (12, -1)
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
                    |> move (15, 3)
                ]

        Watermelon ->
            group
                [ watermelon
                ]

        RainbowPretzel ->
            group
                [ rainbowPretzel
                |> scale 0.3
                |> move (1, -1)
                ]

        Turnip ->
            group
                [ turnip
                |> scale 0.3
                |> move (11, 0)
                ]

        CottonCandy ->
            group
                [ cottoncandy
                |> scale 0.3
                |> move (10, 0)
                ]

        Oats ->
            group
                [ oats
                |> scale 0.3
                |> move (-7, 0)
                ]

        Acai ->
            group
                [ acai
                |> scale 0.25
                ]

        ChocolateStrawberry ->
            group
                [ chocolateStrawberry
                |> scale 0.4
                |> move (-1, 5)
                ]

        Candisteen ->
            group
                [ candisteen
                |> scale 0.4
                |> move (7, -1)
                ]

        Hotdog ->
            group
                [ hotdog
                |> scale 0.32
                |> move (10, -1)
                ]

        Burger ->
            group
                [ burger
                |> scale 0.26
                |> move (5, 0)
                ]

        Mangosteen ->
            group
                [ mangosteen
                |> scale 0.27
                |> move (4, 1)
            
                ]

        Pineapple ->
            group
                [ pineapple
                |> scale 0.3
                ]

        Egg ->
            group
                [ egg
                |> scale 0.3
                |> move (8, 0)
                ]

        Milk ->
            group
                [ milk
                |> scale 0.3
                |> move (10, 0)
                ]

        Lemon ->
            group
                [ lemon
                |> scale 0.25
                |> move (-3, 0)
                ]

        Cinnamon ->
            group
                [ 
                 body
                 |> scale 0.3
                 |> move (-1, 0)
                , cinnamonPowder
                |> scale 0.3
                |> move (-1, 0)
                 , spoon 
                 |> scale 0.3
                 |> move (-1, 0)
                , cinnamonPowderBottom
                |> scale 0.3
                |> move (-1, 0)
                 ,cinnamonSticks2 |>move (5,-10)
                 |> scale 0.3
                 |> move (-1, 0)
                 ,cinnamonSticks2 |> move (-12, -10)
                 |> scale 0.3
                 |> move (-1, 0)
                 ,cinnamonSticks2
                 |> scale 0.3
                 |> move (-1, 0)
                 ,logo
                 |> scale 0.3
                 |> move (-1, 0)
                ]

        Blueberries ->
            group
                [ blueberry2
                |> scale 1.5
                |> move (127, 37)
                
                ]

        Kiwi ->
            group
                [ kiwi
                |> scale 1
                |> move (-32, -6)
                ]

        Yogurt ->
            group
                [ yogurt
                |> scale 0.3
                |> move (7, 0)
                ]
                
        Sugar -> 
            group
                [
                sugar
                |> scale 0.3
                |> move (0, -2)
                ]

        Peach ->
            group
                [ peach
                |> scale 0.3
                |> move (1, -1)
                ]
        
                
        
                
            


type alias Model =
    { time         : Float
    , scrollOffset : Float
    , fedFoods     : List FoodItem
    , happiness    : Float
    , feedEffect   : Float
    , lastFed      : Maybe FoodItem
    , drag         : Maybe { food : FoodItem, x : Float, y : Float }
    }

type Msg
    = Tick Float GetKeyState
    | ScrollLeft
    | ScrollRight
    | DragStart FoodItem Float Float
    | DragMove  Float Float
    | DragEnd   Float Float


update msg model =
    case msg of
        Tick t _ ->
            { model
                | time       = t
                , happiness  = clamp 0 100 (model.happiness - (t - model.time) * 1.2)
                , feedEffect = max 0 (model.feedEffect - (t - model.time) * 1.5)
            }

        DragStart food x y ->
            { model | drag = Just { food = food, x = x, y = y } }

        DragMove x y ->
            case model.drag of
                Nothing -> model
                Just d  -> { model | drag = Just { d | x = x, y = y } }

        DragEnd x y ->
            case model.drag of
                Nothing -> model
                Just d  ->
                    -- Unicorn body sits around (7, 3) in collage coords after move (-45,5) + scale 0.5
                    -- The visible unicorn centre in collage space is roughly (7, 3); accept a generous radius
                    let
                        ux = 7
                        uy = 3
                        dist = sqrt ((x - ux)^2 + (y - uy)^2)
                    in
                    if dist < 38 then
                        { model
                            | drag        = Nothing
                            , fedFoods    = d.food :: model.fedFoods
                            , happiness   = clamp 0 100 (model.happiness + 20)
                            , feedEffect  = 1
                            , lastFed     = Just d.food
                        }
                    else
                        { model | drag = Nothing }

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
    , drag         = Nothing
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



--------------------------------------------------------------------------------
-----------------------------------------------------------------ASSETS--------------------------------------------------
peach = group [
   curve (1.5925,34.737) [Pull (-13.23,40.021) (-30.45,32.945),Pull (-46.16,27.525) (-50.76,7.4650),Pull (-53.42,-10.25) (-39.41,-28.56),Pull (-27.68,-39.32) (-10.35,-45.68),Pull (-2.864,-48.09) (3.5832,-43.49),Pull (18.029,-38.65) (28.756,-29.40),Pull (44.162,-16.00) (41.009,11.387),Pull (35.491,33.151) (14.774,36.036),Pull (7.0000,36.735) (1.5925,34.737)]
 |> filled (rgb 253 159 96),
 curve (29.333,30.558) [Pull (48.850,15.084) (38.846,-14.27),Pull (26.934,-37.14) (-0.936,-45.26),Pull (-5.237,-47.86) (-9.297,-45.98),Pull (-23.21,-41.57) (-34.09,-33.44),Pull (-16.45,-37.78) (2.8108,-28.25),Pull (18.734,-17.59) (26.738,-0.288),Pull (32.256,15.279) (29.333,30.846)]
  |> filled (rgb 270 142 80),
  curve (-8.144,-43.67) [Pull (-19.02,-26.45) (-18.95,-9.225),Pull (-19.86,9.9999) (-7.567,25.225),Pull (-4.612,27.603) (-1.657,29.981),Pull (-1.369,31.279) (-1.081,32.576),Pull (2.8439,35.338) (9.0090,36.180),Pull (11.018,35.822) (11.747,33.585),Pull (9.4297,34.501) (7.7117,34.018),Pull (1.7225,31.823) (-2.666,28.108),Pull (-7.106,25.072) (-10.30,20.756),Pull (-12.78,16.916) (-14.34,12.396),Pull (-16.54,5.2167) (-17.94,-2.882),Pull (-18.80,-13.37) (-15.35,-24.79),Pull (-12.75,-34.04) (-6.990,-42.37),Pull (-5.837,-43.24) (-4.684,-44.10),Pull (-7.082,-44.82) (-8.144,-43.67)]
  |> filled (rgb 270 142 80),
  curve (-6.846,27.531) [Pull (-22.44,27.783) (-34.95,36.036),Pull (-42.16,39.558) (-48.64,41.801),Pull (-44.51,48.955) (-35.38,52.468),Pull (-24.33,56.558) (-13.76,48.288),Pull (-8.434,43.489) (-6.702,35.171),Pull (-6.382,31.855) (-6.702,28.540)]
  |> filled (rgb 121 164 78),
  curve (-7.711,28.396) [Pull (-11.16,41.568) (-24.86,44.540),Pull (-22.49,44.443) (-19.67,43.387),Pull (-15.94,41.981) (-13.33,39.495),Pull (-10.88,37.705) (-9.153,35.315),Pull (-7.687,32.216) (-6.702,29.117),Pull (-7.539,28.908) (-7.855,28.540),Pull (-4.180,26.522) (-0.504,24.504)]
 |> filled (rgb 74 112 32),
 curve (-6.702,27.963) [Pull (-7.130,31.711) (-6.558,35.459),Pull (-3.899,44.339) (0.3603,52.180),Pull (0.9998,55.384) (7.2792,53.189),Pull (10.037,51.070) (11.315,47.711),Pull (10.777,44.617) (7.2792,43.243),Pull (1.4463,37.168) (-2.666,29.693),Pull (-4.324,28.396) (-5.981,27.099),Pull (-6.414,27.675) (-6.702,27.963)]
 |> filled (rgb 176 125 67),
 curve (6.1261,53.189) [Pull (-0.000,55.356) (1.5135,50.882),Pull (2.6036,48.629) (5.6936,47.135),Pull (8.3958,46.731) (10.018,47.567),Pull (10.536,50.690) (6.1261,53.189)]
 |> filled (rgb 218 162 103)

  ]

sugar = group [
  body2
   , sugar2
   , sugar2 |> move ( 0 , 3) |> scale 1.05
   , sugar2 |> move (7 , -3) |> scaleX 1.3
   ,sugar2 |> rotate (degrees 180) |> move (-5, 70)
   ,sugar2 |> rotate (degrees 180) |> move (-5, 66)
   , logo2

  ]


body2= 
  group 
  [
  curve (-32.32,23.272) [Pull (-34.11,13.575) (-35.23,3.8787),Pull (-35.93,-3.393) (-34.90,-10.66),Pull (-34.54,-17.61) (-33.61,-24.56),Pull (-33.77,-22.46) (-33.93,-20.36),Pull (-34.96,-21.88) (-35.87,-24.56),Pull (-36.97,-27.62) (-38.46,-29.41),Pull (-39.87,-33.03) (-36.52,-32.64),Pull (-31.35,-33.26) (-26.18,-31.35),Pull (-27.95,-31.08) (-29.73,-30.06),Pull (-27.95,-31.34) (-26.18,-31.03),Pull (-14.22,-35.09) (-2.262,-35.55),Pull (10.175,-36.45) (21.333,-31.03),Pull (25.022,-29.02) (27.151,-26.50),Pull (25.108,-28.94) (22.626,-30.06),Pull (26.343,-32.35) (30.060,-32.32),Pull (36.652,-33.42) (36.525,-29.09),Pull (35.267,-25.71) (32.969,-21.97),Pull (32.144,-20.04) (32,-18.10),Pull (31.670,-20.52) (30.060,-22.94),Pull (31.810,-20.52) (32,-18.10),Pull (33.381,-10.98) (32.323,-3.878),Pull (30.907,5.0101) (29.090,13.898),Pull (28.584,17.616) (27.797,21.333),Pull (26.989,23.595) (26.181,25.858),Pull (1.6892,19.685) (-32.32,23.272)]
  |> filled (rgb 204 164 102)
  ,curve (28.121,-22.62) [Pull (19.327,-31.70) (-2.585,-31.35),Pull (-14.36,-30.60) (-25.53,-25.85),Pull (-29.48,-25.88) (-31.03,-28.12),Pull (-34.10,-31.63) (-37.17,-30.70),Pull (-37.04,-28.83) (-35.23,-27.79),Pull (-35.58,-29.42) (-33.61,-29.73),Pull (-30.54,-27.00) (-31.03,-22.94),Pull (-23.43,-25.46) (-15.83,-26.50),Pull (10.003,-30.88) (24.565,-19.07),Pull (28.420,-5.656) (23.595,7.7575),Pull (20.346,11.936) (9.6969,11.636),Pull (-0.646,9.3547) (-10.98,11.313),Pull (-16.32,11.484) (-21.65,13.575),Pull (-28.29,14.787) (-33.29,11.959),Pull (-33.36,13.252) (-32.64,14.545),Pull (-28.96,17.210) (-23.91,15.515),Pull (-10.82,11.983) (2.2626,13.252),Pull (24.308,17.018) (27.474,14.545),Pull (32.079,-3.878) (28.121,-22.62)]
   |> filled ( rgb 184 134 79)
  ,curve (28.121,13.898) [Pull (27.714,18.747) (26.828,23.595),Pull (-2.747,22.787) (-32.32,21.979),Pull (-32.36,18.262) (-32.96,14.545),Pull (-29.43,16.873) (-26.18,16.161),Pull (-15.19,13.025) (-4.202,12.929),Pull (7.4343,13.043) (19.070,15.838),Pull (26.052,16.450) (27.474,14.222),Pull (26.505,12.854) (25.535,12.606),Pull (27.071,8.0808) (28.767,3.5555),Pull (29.550,-0.021) (29.414,-3.878),Pull (30.569,-11.63) (24.565,-19.39),Pull (25.428,-21.01) (25.212,-22.62),Pull (25.706,-24.34) (28.121,-22.30),Pull (28.548,-23.39) (25.535,-25.21),Pull (18.747,-29.13) (11.959,-30.38),Pull (3.8787,-32.00) (-4.202,-31.03),Pull (-11.47,-30.63) (-18.74,-28.44),Pull (-21.97,-27.59) (-25.21,-26.18),Pull (-28.88,-25.39) (-31.03,-28.12),Pull (-34.26,-30.99) (-37.49,-31.03),Pull (-38.45,-31.59) (-37.49,-31.67),Pull (-36.00,-33.51) (-27.79,-31.35),Pull (-30.02,-30.54) (-30.06,-29.73),Pull (-26.18,-31.02) (-22.30,-31.67),Pull (-8.404,-35.67) (5.4949,-34.58),Pull (18.523,-33.58) (27.151,-26.18),Pull (27.611,-26.50) (27.151,-26.82),Pull (25.832,-28.60) (23.272,-30.38),Pull (30.359,-32.13) (32.646,-31.67),Pull (38.136,-32.12) (34.585,-25.85),Pull (33.292,-23.90) (32,-20.04),Pull (31.531,-21.65) (30.383,-23.27),Pull (30.002,-23.86) (30.060,-21.97),Pull (33.105,-14.03) (31.030,-0.646),Pull (29.735,6.6262) (28.121,13.898)]
  |> filled ( rgb 150 102 57)
  ,curve (-32.32,23.272) [Pull (-34.11,13.575) (-35.23,3.8787),Pull (-35.93,-3.393) (-34.90,-10.66),Pull (-34.54,-17.61) (-33.61,-24.56),Pull (-33.77,-22.46) (-33.93,-20.36),Pull (-34.96,-21.88) (-35.87,-24.56),Pull (-36.97,-27.62) (-38.46,-29.41),Pull (-39.87,-33.03) (-36.52,-32.64),Pull (-31.35,-33.26) (-26.18,-31.35),Pull (-27.95,-31.08) (-29.73,-30.06),Pull (-27.95,-31.34) (-26.18,-31.03),Pull (-14.22,-35.09) (-2.262,-35.55),Pull (10.175,-36.45) (21.333,-31.03),Pull (25.022,-29.02) (27.151,-26.50),Pull (25.108,-28.94) (22.626,-30.06),Pull (26.343,-32.35) (30.060,-32.32),Pull (36.652,-33.42) (36.525,-29.09),Pull (35.267,-25.71) (32.969,-21.97),Pull (32.144,-20.04) (32,-18.10),Pull (31.670,-20.52) (30.060,-22.94),Pull (31.810,-20.52) (32,-18.10),Pull (33.381,-10.98) (32.323,-3.878),Pull (30.907,5.0101) (29.090,13.898),Pull (28.584,17.616) (27.797,21.333),Pull (26.989,23.595) (26.181,25.858),Pull (1.6892,19.685) (-32.32,23.272)]
  |> outlined ( solid 0.6) (rgb 41 25 14)
  ,curve (33.292,-25.53) [Pull (31.498,-24.75) (30.383,-25.85),Pull (29.842,-27.47) (30.060,-29.09),Pull (32,-30.55) (33.939,-29.41),Pull (35.016,-28.21) (33.292,-25.53)]
  |> filled (rgb 183 134 78)
  ,curve (20.686,-16.80) [Pull (18.404,-16.46) (12.282,-20.68),Pull (10.869,-23.15) (13.575,-22.94),Pull (20.254,-21.40) (21.333,-17.77),Pull (21.171,-17.13) (20.686,-16.80)]
  |> filled (rgb 217 185 131)
  ,curve (-23.91,10.020) [Pull (-25.04,5.0101) (-28.12,0),Pull (-30.24,-5.929) (-29.09,-13.89),Pull (-28.69,-15.82) (-29.09,-18.10),Pull (-30.48,-17.27) (-31.35,-8.727),Pull (-32.93,7.7529) (-28.44,11.313),Pull (-27.98,9.8585) (-28.76,8.4040),Pull (-24.24,12.612) (-23.91,10.020)]
  |> filled (rgb 219 184 128)
   -- top
  ,curve (27.797,25.212) [Pull (32.117,28.994) (31.676,33.616),Pull (29.989,36.633) (26.181,37.171),Pull (20.525,37.946) (14.868,40.080),Pull (-3.878,39.272) (-22.62,38.464),Pull (-26.22,38.234) (-29.41,36.525),Pull (-30.85,35.117) (-34.26,34.909),Pull (-38.03,32.661) (-36.20,29.414),Pull (-34.90,27.474) (-33.61,25.535),Pull (-34.80,26.828) (-34.90,28.121),Pull (-35.97,26.456) (-36.20,23.272),Pull (-35.69,20.823) (-34.90,21.333),Pull (-27.21,18.532) (-20.36,17.131),Pull (-7.595,13.964) (5.1717,15.838),Pull (13.512,16.056) (21.333,19.393),Pull (26.666,20.608) (32,22.303),Pull (32.775,24.727) (31.030,27.151),Pull (29.795,26.505) (27.797,25.212)]
      |> filled (rgb 204 164 102)
 
  ,curve (-33.93,25.535) [Pull (-31.83,25.633) (-29.73,25.212),Pull (-30.68,28.700) (-24.24,26.828),Pull (-10.03,22.490) (4.8484,23.272),Pull (5.5171,22.464) (2.5858,21.656),Pull (-5.184,19.203) (-15.51,19.070),Pull (-23.28,19.766) (-29.73,22.303),Pull (-32.16,21.604) (-34.58,22.626),Pull (-35.44,23.382) (-33.93,25.535)]
  |> filled ( rgb 220 183 128)
  ,curve (29.090,26.828) [Pull (32.060,30.545) (31.030,34.262),Pull (30.026,35.673) (26.181,36.525),Pull (22.626,36.913) (19.070,38.141),Pull (17.939,37.333) (16.808,36.525),Pull (21.831,36.835) (29.414,34.585),Pull (31.232,30.868) (29.090,26.828)]
    |> filled (rgb 233 212 154)
   ,curve (30.383,27.151) [Pull (30.380,26.828) (29.737,26.505),Pull (31.558,23.067) (30.060,22.949),Pull (28.841,22.523) (26.181,21.656),Pull (22.626,20.763) (19.070,19.070),Pull (22.594,19.703) (27.797,21.656),Pull (29.835,21.279) (31.353,22.303),Pull (31.830,24.727) (30.383,27.151)]
      |> filled (rgb 233 212 154)
    ,curve (-22.30,37.818) [Pull (-25.21,36.845) (-28.12,35.232),Pull (-31.65,34.399) (-34.58,32.646),Pull (-34.85,30.137) (-33.29,26.828),Pull (-34.42,28.087) (-35.87,30.707),Pull (-36.16,34.489) (-29.73,35.232),Pull (-24.66,37.846) (-22.30,37.818)]
    |> filled ( rgb 216 179 124)
    ,curve (25.212,31.353) [Pull (16,27.990) (6.7878,26.828),Pull (-2.524,24.645) (-11.63,26.181),Pull (-21.18,27.797) (-28.44,29.414),Pull (-21.32,26.611) (-12.60,24.888),Pull (6.6230,23.481) (25.212,31.353)]
    |> filled ( rgb 238 205 153)
    ,curve (-33.61,25.858) [Pull (-34.10,26.265) (-34.58,27.151),Pull (-35.45,25.212) (-35.55,23.272),Pull (-36.08,21.861) (-33.93,21.010),Pull (-35.35,23.434) (-33.61,25.858)]
    |> filled (rgb 236 213 157)
  ,curve (13.575,26.181) [Pull (22.508,24.619) (16.161,21.656),Pull (5.3333,17.737) (-5.494,17.777),Pull (-7.321,16.808) (-6.787,15.838),Pull (14.541,15.275) (27.151,23.272),Pull (25.226,29.248) (13.575,26.181)]
  |> filled (rgb 184 134 80)
  ,curve (-34.26,21.010) [Pull (-20.01,16.205) (-5.494,16.161),Pull (12.121,15.310) (29.737,21.979),Pull (31.117,22.274) (29.737,32.969),Pull (29.521,31.030) (22.626,29.090),Pull (17.131,27.033) (11.636,25.535),Pull (17.992,26.058) (22.949,26.181),Pull (24.536,23.919) (20.363,21.656),Pull (9.8494,16.193) (-6.464,17.131),Pull (-16,17.205) (-25.53,20.040),Pull (-30.06,21.613) (-34.58,22.626),Pull (-34.58,21.979) (-34.26,21.010)]
  |> filled ( rgb 156 102 56)
    ,curve (27.797,25.212) [Pull (32.117,28.994) (31.676,33.616),Pull (29.989,36.633) (26.181,37.171),Pull (20.525,37.946) (14.868,40.080),Pull (-3.878,39.272) (-22.62,38.464),Pull (-26.22,38.234) (-29.41,36.525),Pull (-30.85,35.117) (-34.26,34.909),Pull (-38.03,32.661) (-36.20,29.414),Pull (-34.90,27.474) (-33.61,25.535),Pull (-34.80,26.828) (-34.90,28.121),Pull (-35.97,26.456) (-36.20,23.272),Pull (-35.69,20.823) (-34.90,21.333),Pull (-27.21,18.532) (-20.36,17.131),Pull (-7.595,13.964) (5.1717,15.838),Pull (13.512,16.056) (21.333,19.393),Pull (26.666,20.608) (32,22.303),Pull (32.775,24.727) (31.030,27.151),Pull (29.795,26.505) (27.797,25.212)]
  |> outlined ( solid 0.6) (rgb 41 25 14)
  ,curve (-31.35,33.292) [Pull (-32.87,32.243) (-30.70,31.353),Pull (-28.32,28.843) (-27.15,33.292),Pull (-29.25,33.052) (-31.35,33.292)]
  |> filled (rgb 154 107 63)
  ,curve (27.151,34.909) [Pull (25.212,34.084) (23.272,33.939),Pull (24.404,32.192) (25.535,32.646),Pull (27.423,33.557) (27.151,34.909)]
      |> filled (rgb 154 107 63)
  --sugar 
   ,curve (25.212,32.646) [Pull (22.681,36.099) (19.070,35.232),Pull (20.577,35.717) (20.363,36.202),Pull (19.125,38.787) (16.808,41.373),Pull (16.050,42.293) (13.252,41.373),Pull (6.5234,37.991) (7.4343,36.848),Pull (5.9434,37.472) (13.252,41.696),Pull (11.794,43.151) (9.6969,44.606),Pull (8.8456,45.144) (7.4343,44.282),Pull (5.6565,43.151) (3.8787,42.020),Pull (3.1404,41.373) (4.2020,40.727),Pull (2.3381,41.585) (7.4343,44.282),Pull (5.6533,47.509) (3.2323,45.575),Pull (3.2507,44.929) (2.9090,44.282),Pull (2.6416,46.222) (-2.585,48.161),Pull (-4.948,48.553) (-7.111,46.545),Pull (-8.888,45.150) (-10.66,43.636),Pull (-10.44,42.989) (-10.66,42.343),Pull (-10.36,42.989) (-10.66,43.636),Pull (-13.48,45.073) (-14.86,42.989),Pull (-14.94,42.505) (-14.54,42.020),Pull (-8.676,40.242) (-8.727,38.464),Pull (-9.436,40.622) (-14.54,42.020),Pull (-16.76,43.826) (-18.74,43.313),Pull (-21.08,41.050) (-22.62,38.787),Pull (-24.89,38.430) (-24.56,35.232),Pull (-23.37,34.747) (-22.94,34.262),Pull (-23.55,34.887) (-24.56,35.232),Pull (-27.24,35.482) (-28.76,33.292),Pull (-29.19,32.161) (-30.70,31.030),Pull (-25.00,29.917) (-21.33,28.444),Pull (-17.26,32.948) (-14.86,33.292),Pull (-11.65,32.093) (-8.727,29.414),Pull (-8.087,28.929) (-8.727,28.444),Pull (-8.285,28.767) (-8.404,29.090),Pull (-12.08,32.851) (-15.83,33.292),Pull (-17.13,32.244) (-18.42,31.676),Pull (-19.41,30.080) (-21.33,28.444),Pull (3.1193,22.827) (25.212,32.646)]
  |> filled ( rgb 253 254 255)
   ,curve (25.212,32.646) [Pull (22.681,36.099) (19.070,35.232),Pull (20.577,35.717) (20.363,36.202),Pull (19.125,38.787) (16.808,41.373),Pull (16.050,42.293) (13.252,41.373),Pull (6.5234,37.991) (7.4343,36.848),Pull (5.9434,37.472) (13.252,41.696),Pull (11.794,43.151) (9.6969,44.606),Pull (8.8456,45.144) (7.4343,44.282),Pull (5.6565,43.151) (3.8787,42.020),Pull (3.1404,41.373) (4.2020,40.727),Pull (2.3381,41.585) (7.4343,44.282),Pull (5.6533,47.509) (3.2323,45.575),Pull (3.2507,44.929) (2.9090,44.282),Pull (2.6416,46.222) (-2.585,48.161),Pull (-4.948,48.553) (-7.111,46.545),Pull (-8.888,45.150) (-10.66,43.636),Pull (-10.44,42.989) (-10.66,42.343),Pull (-10.36,42.989) (-10.66,43.636),Pull (-13.48,45.073) (-14.86,42.989),Pull (-14.94,42.505) (-14.54,42.020),Pull (-8.676,40.242) (-8.727,38.464),Pull (-9.436,40.622) (-14.54,42.020),Pull (-16.76,43.826) (-18.74,43.313),Pull (-21.08,41.050) (-22.62,38.787),Pull (-24.89,38.430) (-24.56,35.232),Pull (-23.37,34.747) (-22.94,34.262),Pull (-23.55,34.887) (-24.56,35.232),Pull (-27.24,35.482) (-28.76,33.292),Pull (-29.19,32.161) (-30.70,31.030),Pull (-25.00,29.917) (-21.33,28.444),Pull (-17.26,32.948) (-14.86,33.292),Pull (-11.65,32.093) (-8.727,29.414),Pull (-8.087,28.929) (-8.727,28.444),Pull (-8.285,28.767) (-8.404,29.090),Pull (-12.08,32.851) (-15.83,33.292),Pull (-17.13,32.244) (-18.42,31.676),Pull (-19.41,30.080) (-21.33,28.444),Pull (3.1193,22.827) (25.212,32.646)]
  |> outlined (solid 0.5) (rgb 47 33 28)
  ,curve (26.828,34.909) [Pull (28.927,32.771) (22.626,31.353),Pull (13.774,28.052) (4.2020,27.151),Pull (-2.909,25.428) (-10.02,26.505),Pull (-15.51,26.514) (-21.01,28.444),Pull (-24.56,29.672) (-28.12,30.060),Pull (-30.78,29.591) (-32.32,32.323),Pull (-32.63,33.368) (-31.35,33.292)]
    |> outlined ( solid 0.6) (rgb 41 25 14)
   ,curve (16.484,41.373) [Pull (18.238,37.153) (15.191,33.292),Pull (12.767,32.964) (10.343,31.676),Pull (9.1353,30.545) (8.7272,29.414),Pull (1.4545,28.884) (-5.818,27.474),Pull (-6.946,28.529) (-7.434,30.383),Pull (-10.20,34.024) (-13.89,34.585),Pull (-17.91,34.726) (-21.65,30.707),Pull (-24.56,30.071) (-27.47,31.676),Pull (-28.76,32.275) (-30.06,31.353),Pull (-26.69,30.022) (-21.01,29.090),Pull (-18.38,32.133) (-15.51,33.616),Pull (-11.46,33.116) (-8.727,29.737),Pull (-8.328,28.929) (-9.050,28.121),Pull (-9.218,29.252) (-10.66,30.383),Pull (-11.65,28.755) (-12.28,28.767),Pull (-12.62,28.166) (-16.16,28.444),Pull (-18.10,28.507) (-20.04,29.090),Pull (-20.20,28.929) (-20.36,28.767),Pull (-2.998,23.503) (24.565,32),Pull (22.758,35.552) (19.070,34.585),Pull (17.615,35.292) (20.040,35.878),Pull (18.424,38.464) (16.484,41.373)]
  |> filled (rgb 221 225 226) |> makeTransparent 0.8 
   ,curve (-11.63,43.636) [Pull (-11.48,42.989) (-12.60,42.343),Pull (-12.42,41.212) (-12.92,40.080),Pull (-13.20,35.912) (-8.404,38.464),Pull (-7.219,39.111) (-7.434,39.757),Pull (-9.696,40.652) (-11.95,42.666),Pull (-10.97,43.313) (-11.63,43.636)]
    |> filled (rgb 221 225 226) |> makeTransparent 0.8 
    ,curve (9.6969,43.959) [Pull (11.645,42.505) (11.313,41.050),Pull (9.0521,40.942) (7.1111,39.434),Pull (5.4949,38.282) (3.8787,41.050),Pull (4.7749,42.666) (7.1111,44.282),Pull (5.0101,46.746) (2.9090,44.929),Pull (0.8080,46.402) (-1.292,47.515),Pull (-1.112,45.737) (-1.292,43.959),Pull (-1.488,41.858) (-0.323,39.757),Pull (-0.836,38.489) (-2.909,38.141),Pull (-0.161,36.474) (2.5858,36.848),Pull (5.2301,36.166) (7.4343,36.525),Pull (7.8218,39.229) (12.929,41.373),Pull (11.474,42.666) (9.6969,43.959)]
    |> filled (rgb 221 225 226) |> makeTransparent 0.8 


  ]
sugar2 = 
  group 
  [
  curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 5)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 10)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 15)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 20)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 25)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 30)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 35)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 40)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 45)
   ,curve (9.6969,37.494) [Pull (9.0505,37.171) (8.4040,36.848),Pull (8.5656,36.525) (8.7272,36.202),Pull (9.2121,36.525) (9.6969,36.848),Pull (9.5353,37.171) (9.3737,37.494),Pull (9.5353,37.656) (9.6969,37.818),Pull (9.0505,37.494) (8.4040,37.171),Pull (8.4040,37.171) (8.4040,37.171),Pull (8.8888,37.333) (9.3737,37.494),Pull (9.6969,37.333) (10.020,37.171),Pull (10.020,37.171) (9.6969,37.494)]
   |> filled (rgb 206 208 207) |> rotate (degrees 50)
  ]
logo2 = group [
     text "Sugar"
     |> customFont "Iosevka Charon Mono"
     |> size 20
     |> bold
     |> filled (rgb 155 107 58)
     |> move (-25,-5) 
     |> addOutline (solid 0.01) (rgb 42 26 14)
     ]
     


yogurt = group [
  container,
    shadow,
    shadows,
    lid,
    yogurt2,
    label,
    spoon2

  ]
  
container = group[
 curve (-69.52,19.091) [Pull (-28.17,11.731) (13.328,19.091),Pull (11.646,-15.64) (6.6041,-40.70),Pull (6.5227,-44.66) (2.2814,-45.50),Pull (-30.07,-55.90) (-60.39,-44.78),Pull (-63.13,-44.50) (-63.27,-39.74),Pull (-67.26,-16.54) (-69.52,19.091)]
 |> filled (rgb 230 230 220)
 ]
 
shadow = group[
  curve (-77.92,25.095) [Pull (-77.92,23.774) (-77.92,22.454),Pull (-64.71,14.071) (-21.49,15.729),Pull (14.500,16.812) (21.733,22.694),Pull (21.853,23.654) (21.973,24.615),Pull (9.8990,18.273) (-24.85,17.891),Pull (-68.53,16.993) (-77.92,25.095)]
  |> filled (rgb 190 190 180)
  ]
  
shadows = group[
  curve (-61.35,23.174) [Pull (-58.52,26.995) (-26.53,27.257),Pull (-27.13,26.056) (-27.73,24.855),Pull (-20.41,23.135) (-9.966,24.375),Pull (-8.885,25.696) (-7.804,27.016),Pull (1.8011,26.416) (11.407,25.816),Pull (-1.081,28.457) (-17.17,28.697),Pull (-36.74,29.757) (-56.31,27.977),Pull (-77.73,25.715) (-61.35,23.174)]
  |> filled (rgb 190 190 180)
  ]
 
lid = group[
 curve (-77.68,25.335) [Pull (-73.19,18.593) (-24.37,18.131),Pull (16.719,19.653) (21.733,25.095),Pull (19.521,30.237) (-15.72,31.579),Pull (-78.12,31.797) (-77.68,25.575),Pull (-73.00,25.575) (-68.32,25.575),Pull (-64.48,29.137) (-25.09,29.418),Pull (3.2957,29.197) (11.647,26.056),Pull (10.976,22.414) (-21.25,21.493),Pull (-67.10,22.134) (-68.08,25.575)]
  |> filled (rgb 245 245 245)
  ]
 
spoon2 = group[
 curve (-27.25,24.615) [Pull (-19.45,23.295) (-9.966,24.615),Pull (-0.480,37.223) (9.0056,49.831),Pull (12.304,57.954) (4.9230,60.878),Pull (-2.920,65.677) (-6.844,59.917),Pull (-17.17,42.386) (-27.25,24.615)]
 |> filled (rgb 170 170 170)
   ,text "YOGURT"
   |> customFont "Fredoka One"
   |> filled 
          white
          |> move (-52.5,-22)
 ]
 
 
 
label = group[
 curve (-54.63,-22.45) [Pull (-63.13,-16.11) (-55.35,-10.44),Pull (-44.88,-5.425) (-28.21,-6.123),Pull (-9.688,-5.145) (0.6003,-11.88),Pull (5.7993,-17.13) (-2.761,-23.17),Pull (-10.92,-28.89) (-28.45,-29.17),Pull (-45.66,-29.21) (-54.63,-22.45)]
 |> filled (rgb 170 150 255)
 ]
 
yogurt2 = group[
 curve (-60.87,23.414) [Pull (-61.53,25.215) (-52.95,25.816),Pull (-35.84,27.876) (-16.45,27.497),Pull (2.3384,27.496) (11.407,25.575),Pull (-3.963,21.014) (-22.69,21.493),Pull (-44.64,19.933) (-60.87,23.414)]
 |> filled (rgb 225 215 255)
   
 
 ]
 
kiwi = 
  group 
  [
  curve (44.606,6.4646) [Pull (42.495,12.759) (34.585,17.454),Pull (27.664,18.941) (22.303,14.868),Pull (17.036,9.8585) (21.010,4.8484),Pull (26.666,-4.975) (32.323,-3.878),Pull (38.218,-6.269) (43.313,-1.939),Pull (45.221,2.4242) (44.606,6.4646)]
  |> filled (rgb 126 89 37) |> addOutline (solid 0.2) (rgb 101 79 21)
  , curve (41.373,-2.585) [Pull (44.123,-0.015) (43.313,7.4343),Pull (42.158,9.5353) (40.404,11.636),Pull (37.656,13.478) (34.909,16.161),Pull (29.414,17.418) (23.919,15.515),Pull (20.679,13.670) (20.040,10.666),Pull (16.512,1.3739) (26.505,-3.878),Pull (36.759,-7.290) (41.373,-2.585)]
  |> filled (rgb 151 162 57) |> addOutline (solid 0.3) (rgb 94 86 33)
  ,  curve (33.939,3.5555) [Pull (33.686,5.3333) (31.353,7.1111),Pull (28.534,7.8262) (27.474,6.1414),Pull (26.602,4.3636) (29.090,2.5858),Pull (32.755,-0.366) (33.939,3.5555)]
   |> filled (rgb 225 216 130) |> makeTransparent 0.9
  ,curve (34.262,-1.616) [Pull (35.470,-1.789) (35.878,-0.323),Pull (36.802,0.3232) (36.525,0.9696),Pull (37.166,1.6161) (36.848,2.2626),Pull (37.508,3.0707) (36.848,3.8787),Pull (36.985,4.5252) (36.202,5.1717),Pull (36.177,5.8181) (35.232,6.4646),Pull (35.507,7.4311) (34.262,7.7575),Pull (34.016,8.6008) (32.969,8.4040),Pull (32.844,8.9456) (32,8.7272),Pull (31.353,9.3488) (30.707,9.0505),Pull (29.414,9.7888) (28.121,8.7272),Pull (27.474,8.8240) (26.828,8.0808),Pull (26.526,8.4175) (26.505,7.4343),Pull (25.318,7.2694) (25.212,6.4646),Pull (25.036,4.2717) (26.181,3.8787),Pull (24.946,5.5317) (27.151,6.4646),Pull (27.359,7.5527) (28.767,8.0808),Pull (30.923,8.1991) (32,7.7575),Pull (34.431,6.6246) (34.262,5.1717),Pull (35.004,4.5252) (34.585,3.8787),Pull (35.609,3.3939) (35.232,2.9090),Pull (35.852,2.4242) (35.232,1.9393),Pull (36.170,1.2929) (34.909,0.6464),Pull (35.185,0.2848) (34.262,0.3232),Pull (34.836,-1.041) (32.969,-0.646),Pull (33.777,-1.131) (34.262,-1.616)]
  |> filled (rgb 70 65 21) |> makeTransparent 0.9
    ,curve (34.262,-1.616) [Pull (35.470,-1.789) (35.878,-0.323),Pull (36.802,0.3232) (36.525,0.9696),Pull (37.166,1.6161) (36.848,2.2626),Pull (37.508,3.0707) (36.848,3.8787),Pull (36.985,4.5252) (36.202,5.1717),Pull (36.177,5.8181) (35.232,6.4646),Pull (35.507,7.4311) (34.262,7.7575),Pull (34.016,8.6008) (32.969,8.4040),Pull (32.844,8.9456) (32,8.7272),Pull (31.353,9.3488) (30.707,9.0505),Pull (29.414,9.7888) (28.121,8.7272),Pull (27.474,8.8240) (26.828,8.0808),Pull (26.526,8.4175) (26.505,7.4343),Pull (25.318,7.2694) (25.212,6.4646),Pull (25.036,4.2717) (26.181,3.8787),Pull (24.946,5.5317) (27.151,6.4646),Pull (27.359,7.5527) (28.767,8.0808),Pull (30.923,8.1991) (32,7.7575),Pull (34.431,6.6246) (34.262,5.1717),Pull (35.004,4.5252) (34.585,3.8787),Pull (35.609,3.3939) (35.232,2.9090),Pull (35.852,2.4242) (35.232,1.9393),Pull (36.170,1.2929) (34.909,0.6464),Pull (35.185,0.2848) (34.262,0.3232),Pull (34.836,-1.041) (32.969,-0.646),Pull (33.777,-1.131) (34.262,-1.616)]
  |> filled (rgb 89 90 33) |> scale 1.3 |> move (-8, 0) |> makeTransparent 0.9
  
  
  ,curve (33.616,4.8484) [Pull (36.525,5.7165) (39.434,6.4646)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8

  ,curve (27.797,7.1111) [Pull (25.696,9.3850) (23.595,13.898)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8

  ,curve (28.767,7.1111) [Pull (26.989,10.211) (25.212,15.191)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8

  ,curve (29.090,7.1111) [Pull (28.242,10.491) (27.474,15.191)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8

  ,curve (30.383,7.1111) [Pull (31.553,10.989) (32.323,14.868)]

  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8

  ,curve (31.030,7.1111) [Pull (33.228,10.343) (34.585,13.575)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8

  ,curve (32.323,5.4949) [Pull (35.070,8.2008) (37.818,10.666)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8


  ,curve (33.292,3.5555) [Pull (37.468,3.6987) (40.404,4.2020)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8


  ,curve (32.969,2.5858) [Pull (32.969,2.5858) (32.969,2.5858),Pull (36.686,1.7993) (40.404,1.2929)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8


  ,curve (33.292,2.2626) [Pull (36.525,-0.055) (39.757,-1.292)]
  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8


  ,curve (32.646,0.9696) [Pull (35.393,-1.208) (38.141,-2.585)]

  |> outlined (solid 0.5) (rgb 182 193 85) |> makeTransparent 0.8

  ]
  
blueberries = group [
    blueberry2  |> move (50,10)
    ,blueberry3
  ]

blueberry2 = 
  group 
  [
  curve (-87.59,-19.07) [Pull (-92.28,-21.34) (-92.44,-25.85),Pull (-92.69,-28.12) (-90.50,-30.38),Pull (-88.56,-32.21) (-86.62,-32),Pull (-80.92,-33.06) (-78.54,-28.44),Pull (-77.24,-25.05) (-79.19,-21.65),Pull (-81.61,-19.02) (-84.04,-19.07),Pull (-85.81,-18.90) (-87.59,-19.07)]
  |> filled (rgb 83 106 154) |> addOutline (solid 0.2) (rgb 22 24 29)
   ,curve (-81.45,-21.97) [Pull (-81.92,-24.40) (-84.36,-26.82),Pull (-85.97,-26.83) (-87.59,-28.12),Pull (-89.21,-27.96) (-90.82,-28.76),Pull (-88.52,-32.80) (-82.74,-31.67),Pull (-78.46,-29.55) (-78.86,-24.24),Pull (-79.46,-22.42) (-81.45,-21.97)]
  |> filled (rgb 48 63 107) |> makeTransparent 0.8
  
  ,curve (-79.51,-23.27) [Pull (-80.97,-27.04) (-83.39,-29.09),Pull (-86.30,-30.33) (-89.21,-30.06),Pull (-86.78,-32.50) (-83.07,-31.03),Pull (-78.03,-27.86) (-79.51,-23.27)]
  |> filled (rgb 36 45 83) |> makeTransparent 0.8
   ,curve (-83.39,-19.07) [Pull (-83.15,-19.87) (-84.36,-20.68),Pull (-89.36,-21.79) (-91.79,-25.53),Pull (-92.58,-23.81) (-90.18,-21.01),Pull (-86.62,-19.10) (-83.39,-19.07)]
  |> filled (rgb 238 242 239) |> makeTransparent 0.5
  ,curve (-88.24,-23.91) [Pull (-89.77,-23.02) (-90.18,-24.56),Pull (-89.95,-25.76) (-88.56,-25.21),Pull (-88.00,-24.56) (-88.24,-23.91)]
  |> filled (rgb 137 162 206)
  ,curve (-82.42,-21.65) [Pull (-83.71,-23.60) (-85.33,-23.27),Pull (-87.50,-23.40) (-88.24,-21.65),Pull (-88.11,-20.19) (-85.97,-20.36),Pull (-83.86,-19.74) (-82.42,-21.65)]
  |> filled (rgb 69 84 117) |> addOutline (solid 0.2) (rgb 30 47 83)
  ,curve (-83.39,-21.65) [Pull (-83.76,-20.63) (-86.30,-20.68),Pull (-87.70,-21.33) (-87.27,-21.97),Pull (-86.66,-22.70) (-85.65,-22.62),Pull (-84.28,-22.83) (-83.39,-21.65)]
  |> filled (rgb 46 63 92) |> addOutline (solid 0.2) (rgb 9 21 43)
   ,curve (-83.39,-21.65) [Pull (-83.66,-20.87) (-85.97,-21.01),Pull (-87.04,-21.81) (-86.94,-22.62),Pull (-87.94,-21.65) (-86.30,-20.68),Pull (-83.64,-20.37) (-83.39,-21.65)]
  |> filled (rgb 13 18 27)
  
  ]
  
  
blueberry3 = 
  group 
  [
  curve (5.4949,-5.818) [Pull (5.9539,-1.382) (1.2929,1.2929),Pull (-3.070,2.9232) (-7.434,-0.646),Pull (-8.859,-3.070) (-8.404,-5.494),Pull (-7.524,-9.455) (-4.525,-9.696),Pull (0.34,-10.67) (4.5252,-8.404),Pull (5.4301,-6.949) (5.4949,-5.818)]
  |> filled (rgb 53 69 113) |> addOutline (solid 0.3) (rgb 21 27 18)
  ,curve (2.5858,-0.969) [Pull (1.9135,-5.828) (-3.878,-8.727),Pull (0.9783,-8.771) (3.5555,-5.494),Pull (4.6307,-3.232) (2.5858,-0.969)]
  |> filled (rgb 39 53 94)
  ,curve (-0.969,0.6464) [Pull (-2.981,-0.808) (-3.232,-2.262),Pull (-5.010,-4.398) (-6.787,-5.494),Pull (-9.553,-3.024) (-3.878,0.6464),Pull (-2.424,0.8080) (-0.969,0.6464)]
  |> filled (rgb 99 121 173) |> makeTransparent 0.8
  ,curve (-4.525,-0.323) [Pull (-5.854,0.0086) (-6.464,-1.939),Pull (-6.499,-2.861) (-5.494,-2.262),Pull (-4.610,-1.292) (-4.525,-0.323)]
  |> filled (rgb 229 226 216)
  , curve (0.9696,-0.969) [Pull (0.5800,0.2567) (-0.969,0.3232),Pull (-2.281,0.4400) (-3.232,-0.323),Pull (-4.337,-1.616) (-4.202,-2.909),Pull (-3.232,-5.017) (-2.262,-4.525),Pull (0.1919,-4.880) (0.6464,-3.555),Pull (1.9880,-2.602) (0.9696,-0.969)]
  |> filled (rgb 68 81 112) |> addOutline ( solid 0.1) (rgb 22 26 36)
  , curve (0.6464,-1.939) [Pull (0.3232,-1.896) (0,-1.292),Pull (-0.812,-0.391) (-2.585,-0.969),Pull (-3.189,-1.737) (-3.232,-2.585),Pull (-2.924,-4.132) (-1.616,-3.878),Pull (-0.204,-4.489) (0.6464,-1.939)]
  |> filled (rgb 51 72 114) |> addOutline (solid 0.1) (rgb 22 26 36)
  ,curve (0.6464,-1.939) [Pull (0.3232,-1.896) (0,-1.292),Pull (-0.812,-0.391) (-2.585,-0.969),Pull (-3.189,-1.737) (-3.232,-2.585),Pull (-2.924,-4.132) (-1.616,-3.878),Pull (-2.761,-3.232) (-2.585,-2.585),Pull (-2.069,-0.262) (0.6464,-1.939)]
  |> filled (rgb 25 30 56)
  ]

cinnamonSticks = [
  body
  , cinnamonPowder
   , spoon 
  , cinnamonPowderBottom
   ,cinnamonSticks2 |>move (5,-10)
   ,cinnamonSticks2 |> move (-12, -10)
   ,cinnamonSticks2
   ,logo

  ]

cinnamonSticks2 =
  group 
  [curve (33.939,-39.11) [Pull (30.060,-36.04) (26.181,-32.96),Pull (24.248,-35.47) (23.595,-38.78),Pull (27.636,-43.82) (31.676,-42.34),Pull (32.808,-40.56) (33.939,-39.11)]
  |> filled (rgb 125 71 31) 
 ,curve (49.777,-19.39) [Pull (49.921,-16.10) (46.545,-16.80),Pull (35.692,-25.53) (23.919,-34.26),Pull (28.218,-33.77) (27.797,-37.17),Pull (39.727,-28.28) (49.777,-19.39)]
  |> filled (rgb 180 112 44) 
  ,curve (49.777,-19.39) [Pull (49.921,-16.10) (46.545,-16.80),Pull (35.692,-25.53) (23.919,-34.26),Pull (28.218,-33.77) (27.797,-37.17),Pull (39.727,-28.28) (49.777,-19.39)]
  |> filled (rgb 180 112 44) 
   ,curve (31.353,-38.46) [Pull (29.465,-37.59) (29.737,-39.75),Pull (28.710,-40.47) (28.444,-39.11),Pull (28.338,-36.95) (31.353,-36.84),Pull (34.344,-38.34) (33.616,-40.40),Pull (32.865,-44.65) (27.474,-43.31),Pull (24.853,-43.13) (23.272,-39.43),Pull (22.324,-34.40) (25.535,-33.93),Pull (28.526,-34.93) (27.797,-37.17),Pull (26.643,-38.87) (24.888,-37.81),Pull (24.492,-37.11) (25.535,-37.17),Pull (26.640,-37.24) (26.505,-36.52),Pull (26.583,-35.87) (26.181,-35.23),Pull (23.792,-34.74) (24.242,-38.14),Pull (25.861,-41.64) (28.121,-42.02),Pull (31.242,-42.79) (32.323,-40.72),Pull (32.538,-39.43) (31.353,-38.46)]
   |> filled ( rgb 193 125 66) 
 ,curve (49.777,-17.77) [Pull (50.159,-18.58) (50.101,-19.39),Pull (39.891,-28.20) (28.121,-36.84),Pull (28.239,-36.20) (27.797,-35.55),Pull (38.787,-26.66) (49.777,-17.77)]
  |> filled (rgb 75 37 14) 
  ,curve (49.131,-17.13) [Pull (37.979,-25.69) (26.828,-34.26),Pull (27.914,-34.90) (28.121,-35.55),Pull (39.209,-26.82) (49.777,-18.10),Pull (49.694,-17.49) (49.131,-17.13)]
  |> filled (rgb 154  89 33) 
  -- side 2 
  ,curve (51.070,-19.07) [Pull (56.508,-19.97) (54.626,-24.24),Pull (43.797,-33.27) (32.969,-42.02),Pull (35.550,-37.63) (29.090,-36.84),Pull (40.080,-27.79) (51.070,-19.07)]
  |> filled ( rgb 170 100 45)
  ,curve (54.303,-20.04) [Pull (44.697,-28.92) (33.292,-37.81),Pull (34.311,-40.08) (32.969,-42.34),Pull (44.456,-32.95) (54.303,-24.24),Pull (55.943,-22.02) (54.303,-20.04)]
   |> filled ( rgb 158 95 42) 
 ,  curve (55.272,-22.30) [Pull (44.804,-31.19) (33.616,-40.08),Pull (33.896,-41.05) (33.616,-42.02),Pull (43.959,-33.13) (54.303,-24.24),Pull (55.506,-23.27) (55.272,-22.30)]
  |> filled ( rgb 67 37 19) ]
spoon = 
  group 
  [
   curve (20.686,56.565) [Pull (16.464,56.963) (16.161,52.040),Pull (15.561,49.131) (16.161,46.222),Pull (15.328,44.204) (13.575,42.666),Pull (7.8466,37.333) (7.7575,32),Pull (6.9094,30.097) (6.1414,27.474),Pull (8.3072,25.471) (11.313,26.828),Pull (15.191,25.565) (19.070,26.181),Pull (20.686,27.695) (22.303,32.969),Pull (23.306,37.816) (19.070,42.343),Pull (20.003,45.770) (21.656,47.838),Pull (24.004,50.585) (23.272,53.333),Pull (23.139,55.429) (20.686,56.565)]
  |> filled (gradient [stop (rgb 184 142 90) 45 , stop (rgb 197 157 101) 65 ] ) 
  ,curve (21.010,56.242) [Pull (21.950,51.070) (17.131,45.898),Pull (15.946,47.075) (16.161,49.131),Pull (15.825,56.406) (21.010,56.242)]  
  |> filled (rgb 220 189 132) |> makeTransparent 0.7
  ,curve (16.808,44.929) [Pull (14.803,40.727) (15.838,36.525),Pull (16.291,32.484) (14.545,28.444)]
  |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9
  ,curve (20.363,56.565) [Pull (20.045,51.717) (16.808,46.868)]
  |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9
  ,curve (19.393,55.595) [Pull (19.182,52.202) (17.131,48.808),Pull (16.182,53.002) (19.393,55.595)]

   |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9
   
  ,curve (18.101,45.252) [Pull (17.114,43.954) (16.808,41.696),Pull (18.101,35.393) (15.515,29.090),Pull (15.733,28.444) (15.191,27.797)]
   |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9

  ,curve (11.313,40.404) [Pull (10.560,37.739) (8.7272,35.555)]
   |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9

  ,curve (12.282,41.373) [Pull (13.188,35.070) (9.3737,28.767)]
   |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9

  ,curve (21.010,56.242) [Pull (21.150,51.070) (17.131,45.898)]
     |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9
   ,curve (22.626,54.949) [Pull (21.606,52.686) (22.626,50.424)]
      |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9
  ,curve (21.656,55.595) [Pull (20.301,52.363) (22.626,49.131)]
        |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9
  ,curve (19.393,43.313) [Pull (21.970,35.070) (18.747,26.828),Pull (18.590,26.181) (19.393,25.535),Pull (24.913,34.262) (19.393,43.313)]
        |> filled (rgb 175 131 78) |> makeTransparent 0.9
   ,curve (17.777,27.151) [Pull (20.444,33.616) (19.070,40.080),Pull (15.258,43.480) (12.606,40.080),Pull (8.4002,33.777) (7.4343,27.474),Pull (7.7608,26.749) (8.7272,26.505),Pull (10.966,37.691) (16.484,39.757),Pull (21.781,39.467) (17.777,27.151)]
   |> filled (rgb 123 81 43) |> makeTransparent 0.8
   ,curve (22.303,50.101) [Pull (19.283,45.737) (18.424,41.373),Pull (20.582,33.777) (18.101,26.181)]
      |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9

  ,curve (21.656,50.747) [Pull (20.023,48.416) (19.070,44.606),Pull (18.287,42.505) (18.424,40.404),Pull (18.862,37.171) (18.101,33.939),Pull (17.652,30.060) (16.484,26.181),Pull (16.484,26.020) (16.484,25.858)]

      |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9

  ,curve (13.898,43.313) [Pull (13.538,40.888) (13.898,38.464),Pull (13.767,32.969) (11.636,27.474),Pull (11.154,27.151) (11.313,26.828)]

      |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9

  ,curve (16.484,45.252) [Pull (14.795,41.738) (14.545,38.464),Pull (14.797,32.808) (12.929,27.151),Pull (12.929,26.828) (12.929,26.505)]

      |> outlined (solid 0.2) (rgb 175 131 78) |> makeTransparent 0.9
  ,curve (13.898,27.474) [Pull (11.313,26.733) (8.7272,27.151),Pull (11.214,35.949) (14.222,38.787),Pull (17.749,40.304) (19.717,38.141),Pull (20.515,33.939) (19.393,29.737),Pull (19.989,31.838) (18.424,33.939),Pull (16.646,36.077) (14.868,33.616),Pull (14.383,30.545) (13.898,27.474)]
  |> filled ( rgb 179 139 83) |> makeTransparent 0.8
  ,curve (19.717,31.676) [Pull (18.896,34.471) (15.515,34.585),Pull (13.707,32.250) (13.898,27.474),Pull (16,27.151) (18.101,26.828),Pull (19.689,29.414) (19.717,31.676)]
  |> filled (rgb 205 179 125) |> makeTransparent 0.8

  ] 
body = 
  group 
  [
  curve (-11.31,6.1414) [Pull (-17.01,1.4448) (-16.48,-5.171),Pull (-19.77,-13.25) (-18.10,-21.33),Pull (-19.92,-28.01) (-21.97,-33.61),Pull (-1.777,-47.54) (18.424,-42.66),Pull (28.349,-39.86) (39.434,-35.23),Pull (41.224,-21.70) (37.494,-10.02),Pull (35.503,-6.381) (35.232,-2.262),Pull (34.825,-0.976) (33.939,-0.969),Pull (35.465,0.6745) (35.232,3.8787),Pull (11.959,5.0101) (-11.31,6.1414)]
  |> filled (rgb 195 161 116)
  ,curve (35.555,4.8484) [Pull (35.505,1.7777) (33.616,-1.292),Pull (35.065,-1.922) (35.555,-3.232),Pull (35.746,-7.111) (37.818,-10.98),Pull (40.163,-18.74) (38.787,-26.50),Pull (29.809,-36.32) (19.070,-42.66),Pull (10.669,-44.37) (2.9090,-44.60),Pull (-12.63,-44.00) (-21.65,-35.87),Pull (-7.919,-40.09) (5.8181,-39.11),Pull (32.402,-36.04) (30.707,-18.42),Pull (26.642,-7.717) (25.858,2.9090),Pull (30.868,4.0404) (35.555,4.8484)]

  |> filled (rgb 138 99 56) |> makeTransparent 0.8
  ,curve (34.909,4.5252) [Pull (24.080,2.5858) (13.252,0.6464),Pull (19.164,-8.404) (19.717,-17.45),Pull (17.212,-31.86) (6.7878,-32.32),Pull (-6.033,-36.51) (-17.45,-30.06),Pull (-19.19,-27.54) (-18.42,-22.94),Pull (-19.57,-27.47) (-21.33,-32),Pull (-21.34,-35.41) (-19.39,-35.55),Pull (-10.44,-39.73) (3.2323,-39.11),Pull (24.041,-37.52) (29.090,-26.82),Pull (32.747,-17.50) (28.444,-6.787),Pull (24.184,-1.616) (34.909,4.5252)]
  |> filled (rgb 155 116 73) |> makeTransparent 0.8 |> move (2, -1)
  ,curve (35.232,-3.555) [Pull (34.116,-5.171) (32,-6.787),Pull (35.164,-7.595) (36.848,-8.404),Pull (36.342,-7.111) (35.555,-5.818),Pull (35.673,-4.525) (35.232,-3.555)]
  |> filled (rgb 113 73 36)
  ,curve (-16.48,-2.585) [Pull (-14.64,-3.878) (-13.25,-5.171),Pull (-13.68,-5.979) (-15.51,-6.787),Pull (-16.26,-7.737) (-17.45,-8.727),Pull (-17.50,-7.111) (-15.83,-5.494),Pull (-16.47,-4.040) (-16.48,-2.585)]
  |> filled (rgb 171 136 94)
  ,curve (-11.63,-8.080) [Pull (-7.865,-8.310) (-5.494,-10.02),Pull (-0.323,-9.195) (4.8484,-9.050),Pull (9.0749,-10.23) (6.1414,-14.54),Pull (3.8745,-20.23) (-3.232,-24.56),Pull (-8.819,-27.47) (-12.60,-22.30),Pull (-16.71,-16.80) (-11.63,-8.080)]
   |> filled (rgb 202 173 131)
  ,curve (28.121,25.212) [Pull (34.773,23.651) (34.585,21.010),Pull (34.573,19.393) (36.202,17.777),Pull (37.963,15.353) (36.525,12.929),Pull (37.454,11.474) (38.464,10.020),Pull (39.625,3.3830) (34.585,2.5858),Pull (30.987,0.3232) (14.868,-1.939),Pull (6.6262,-1.261) (-1.616,-2.262),Pull (-6.626,-3.549) (-11.63,0.3232),Pull (-15.88,2.1107) (-18.10,5.8181),Pull (-18.05,6.6430) (-17.45,6.7878),Pull (-18.16,10.313) (-15.83,11.959),Pull (-16.31,16.323) (-14.86,20.686),Pull (-13.59,22.761) (-11.31,23.595),Pull (-5.333,26.548) (0.6464,26.181),Pull (14.383,25.696) (28.121,25.212)]
   |> filled ( gradient [stop (rgb 206 177 135) -30, stop (rgb 190 156 110) 30] ) 
   ,curve (27.151,18.424) [Pull (24.424,15.283) (17.777,14.222),Pull (17.281,12.606) (18.424,10.989),Pull (21.926,3.5478) (14.868,2.5858),Pull (10.505,3.2458) (6.1414,2.5858),Pull (0.9696,3.0442) (-4.202,2.2626),Pull (-8.682,2.1274) (-12.28,3.2323),Pull (-15.10,4.5468) (-16.48,6.1414),Pull (-17.32,7.7575) (-16.80,9.3737),Pull (-16.32,10.623) (-15.83,11.313),Pull (-15.67,11.977) (-15.51,12.282),Pull (-18.10,10.115) (-17.77,6.7878),Pull (-16.23,3.1620) (-9.696,1.6161),Pull (-4.052,0.1745) (3.2323,1.2929),Pull (16.069,-0.540) (22.626,2.5858),Pull (32.056,4.6733) (28.767,8.0808),Pull (34.899,13.252) (27.151,18.424)]
  |> filled (rgb 157 118 75) |> move (0, -0.3) 
   , curve (28.121,25.212) [Pull (34.773,23.651) (34.585,21.010),Pull (34.573,19.393) (36.202,17.777),Pull (37.963,15.353) (36.525,12.929),Pull (37.454,11.474) (38.464,10.020),Pull (39.625,3.3830) (34.585,2.5858),Pull (30.987,0.3232) (14.868,-1.939),Pull (6.6262,-1.261) (-1.616,-2.262),Pull (-6.626,-3.549) (-11.63,0.3232),Pull (-15.88,2.1107) (-18.10,5.8181),Pull (-18.05,6.6430) (-17.45,6.7878),Pull (-16.00,2.2955) (-2.585,0.3232),Pull (4.8149,1.7848) (13.575,0.6464),Pull (21.313,1.5610) (25.212,3.5555),Pull (28.688,4.7165) (28.444,7.7575),Pull (28.918,10.056) (31.353,11.636),Pull (29.226,11.036) (25.858,11.636),Pull (25.706,12.282) (27.474,12.929),Pull (24.843,14.005) (25.212,16.161),Pull (26.828,20.686) (28.121,25.212)]
  |> filled (rgb 138 99 56) 
  ,curve (32.323,22.626) [Pull (33.747,18.972) (25.212,15.838),Pull (22.626,15.348) (20.040,13.898),Pull (22.291,13.025) (26.181,15.191),Pull (36.372,19.210) (32.323,22.626)]
  |> filled (rgb 184 153 109)
  ,curve (34.585,20.040) [Pull (33.629,18.262) (31.353,16.484),Pull (33.616,17.976) (35.878,18.747),Pull (34.652,18.935) (34.585,20.040)]
   |> filled (rgb 139 100 59)
  ,curve (36.848,14.545) [Pull (34.401,12.121) (31.353,9.6969),Pull (36.105,11.543) (37.818,10.989),Pull (37.231,11.959) (36.525,12.929),Pull (36.946,13.737) (36.848,14.545)]
    |> filled (rgb 139 100 59)
  ,curve (36.848,7.1111) [Pull (34.228,4.4501) (28.767,2.9090),Pull (36.128,2.7501) (36.848,7.1111)]
    |> filled (rgb 139 100 59)
   ,curve (16.161,11.959) [Pull (16.043,12.521) (12.606,12.282),Pull (10.828,11.887) (9.0505,13.252),Pull (7.1678,13.710) (4.5252,12.929),Pull (-0.646,13.420) (-5.818,15.191),Pull (-9.810,16.671) (-12.28,19.070),Pull (-12.33,22.933) (-6.141,23.595),Pull (-10.33,24.856) (-13.57,19.717),Pull (-14.21,17.341) (-10.34,16.484),Pull (-7.919,14.591) (-5.494,13.898),Pull (-1.939,12.812) (1.6161,12.606),Pull (8.8888,10.282) (16.161,11.959)]
  |> filled (rgb 220 192 152)
  
  ]
cinnamonPowder = 
  group 
  [
  curve (16.484,6.4646) [Pull (8.4785,5.0814) (3.2323,5.8181),Pull (2.5155,5.4949) (3.8787,5.1717),Pull (11.721,3.7181) (16.484,6.4646)]
   |> filled ( rgb 176 142 96)
   ,curve (-0.323,7.7575) [Pull (-8.432,9.3234) (-14.22,12.929),Pull (-16.93,11.313) (-12.28,9.6969),Pull (-6.303,6.8272) (-0.323,7.7575)]
    |> filled ( rgb 176 142 96)
   ,curve (-15.19,18.101) [Pull (-14.54,16.651) (-13.57,16.161),Pull (-14.38,16.461) (-15.19,16.161),Pull (-14.75,17.131) (-15.19,18.101)]
    |> filled ( rgb 198 166 125)
   ,curve (25.535,27.474) [Pull (31.652,19.559) (21.010,16.484),Pull (17.788,15.601) (8.7272,15.838),Pull (3.2571,15.686) (-1.292,17.454),Pull (-6.248,18.097) (-8.404,21.979),Pull (-9.927,20.525) (-9.050,19.070),Pull (-7.711,16.621) (-5.171,17.131),Pull (-2.397,15.178) (1.6161,14.545),Pull (9.4943,14.680) (13.252,13.575),Pull (18.947,14.091) (24.242,16.808),Pull (28.397,16.052) (31.353,21.656),Pull (31.744,24.945) (25.535,27.474)]
  |> filled (rgb 124 79 48)
  ,curve (31.030,21.979) [Pull (30.458,16.829) (20.686,15.838),Pull (19.019,13.487) (11.313,13.575),Pull (7.1111,14.518) (2.9090,14.222),Pull (-1.103,14.435) (-3.555,16.808),Pull (-7.664,15.582) (-9.373,19.717),Pull (-8.443,23.951) (-3.232,26.505),Pull (-0.646,27.661) (1.9393,29.737),Pull (12.266,34.480) (19.393,30.383),Pull (25.669,28.444) (26.505,26.505),Pull (31.687,24.242) (31.030,21.979)]
  |> filled ( rgb 151 97 59)
  ,curve (27.797,25.858) [Pull (29.684,23.534) (29.090,21.010),Pull (27.860,17.007) (22.949,16.484),Pull (20.611,16.356) (19.393,14.868),Pull (19.966,14.493) (21.979,15.838),Pull (28.106,16.267) (31.353,21.656),Pull (30.937,24.837) (27.797,25.858)]
  |> filled ( rgb 78 42 21)
  ,curve (14.868,13.575) [Pull (11.990,14.145) (11.313,15.515),Pull (11.426,15.030) (10.020,14.545),Pull (6.4646,15.447) (2.9090,14.868),Pull (0.9913,15.653) (-0.646,15.838),Pull (-2.909,16.821) (-5.171,16.484),Pull (-7.289,17.796) (-8.727,18.747),Pull (-8.727,18.747) (-8.727,18.747),Pull (-9.287,20.202) (-8.727,21.656),Pull (-10.79,18.953) (-6.787,17.131),Pull (-1.564,15.556) (1.9393,14.222),Pull (8.2424,13.898) (14.868,13.575)]
    |> filled ( rgb 78 42 21)
  ,curve (5.4949,29.414) [Pull (3.4949,27.151) (5.4949,24.888),Pull (13.426,25.180) (15.838,23.272),Pull (14.006,22.494) (9.3737,23.595),Pull (7.0527,23.491) (5.1717,22.626),Pull (3.3939,22.011) (1.6161,23.595),Pull (-0.323,22.274) (-2.262,23.272),Pull (-5.211,25.212) (0,27.151),Pull (3.3874,30.104) (5.4949,29.414)]
  |> filled (rgb 155 107 71)
  
  ]
cinnamonPowderBottom = 
  group 
  [curve (7.7575,-43.95) [Pull (-1.203,-41.47) (-8.404,-30.38),Pull (-13.43,-28.86) (-14.54,-35.23),Pull (-3.393,-42.87) (7.7575,-43.95)]
  |> filled  black  |> makeTransparent 0.4
   ,curve (-5.171,-39.43) [Pull (-3.793,-39.04) (-1.616,-40.72),Pull (1.6010,-42.02) (5.8181,-44.28),Pull (6.7284,-46.45) (3.8787,-47.19),Pull (1.7000,-49.14) (-3.878,-49.77),Pull (-8.727,-49.47) (-13.57,-49.77),Pull (-14.22,-49.95) (-14.86,-49.13),Pull (-18.10,-50.26) (-21.33,-47.51),Pull (-24.88,-49.20) (-28.44,-48.48),Pull (-30.22,-48.62) (-32,-47.83),Pull (-32.69,-47.03) (-30.70,-46.22),Pull (-30.04,-45.41) (-34.26,-43.95),Pull (-35.92,-41.87) (-30.38,-38.78),Pull (-24.51,-34.51) (-21.01,-31.35),Pull (-17.93,-29.75) (-5.171,-39.43)]
    |> filled (rgb 146 96 59) --} 
    
    
  
  ,curve (4.2020,-46.54) [Pull (0.8080,-48.59) (-2.585,-49.13),Pull (-4.305,-48.41) (-6.464,-49.13),Pull (-9.050,-48.08) (-11.63,-48.16),Pull (-13.89,-47.18) (-16.16,-48.48),Pull (-18.58,-48.15) (-21.01,-47.19),Pull (-17.45,-49.90) (-13.89,-49.13),Pull (0.8498,-50.95) (3.8787,-46.54)]
  |> filled (rgb 98 59 36)  
  ,curve (0.9696,-41.69) [Pull (1.4454,-43.77) (-3.878,-44.60),Pull (-5.818,-45.79) (-7.757,-45.89),Pull (-11.16,-44.18) (-13.89,-39.75),Pull (-15.39,-39.59) (-16.48,-43.31),Pull (-18.90,-44.43) (-21.33,-43.95),Pull (-22.27,-41.13) (-25.85,-43.63),Pull (-26.65,-42.55) (-30.06,-43.31),Pull (-28.04,-41.85) (-27.15,-40.40),Pull (-27.23,-39.08) (-32,-40.72),Pull (-33.02,-44.62) (-28.12,-43.95),Pull (-27.48,-44.76) (-29.09,-45.57),Pull (-29.19,-47.25) (-25.21,-45.25),Pull (-17.85,-46.69) (-14.22,-45.25),Pull (-13.56,-42.98) (-14.22,-40.72),Pull (-10.34,-48.01) (-6.464,-46.86),Pull (-2.424,-46.49) (1.6161,-44.60),Pull (2.9226,-45.02) (2.9090,-44.28),Pull (3.2810,-42.82) (0.9696,-41.69)]
  |> filled ( rgb 135 86 53)
  
  ,curve (-8.404,-38.78) [Pull (-5.824,-40.40) (-4.525,-42.02),Pull (-3.555,-41.80) (-2.585,-42.34),Pull (-4.894,-40.40) (-8.404,-38.78)]
  |> filled (rgb 134 86 50)
  ,curve (-8.727,-42.02) [Pull (-9.400,-44.66) (-7.434,-43.95),Pull (-8.759,-43.22) (-8.727,-42.02)]
    |> filled (rgb 134 86 50)
  ,curve (-18.10,-40.08) [Pull (-18.41,-42.93) (-20.68,-42.98),Pull (-19.39,-41.91) (-18.10,-40.08)]
    |> filled (rgb 134 86 50)
   ,curve (-6.141,-40.72) [Pull (-7.757,-41.32) (-9.373,-40.72),Pull (-10.66,-41.93) (-11.95,-41.37),Pull (-11.49,-39.93) (-14.22,-37.17),Pull (-14.16,-36.04) (-14.54,-34.90),Pull (-13.22,-33.61) (-10.98,-36.84),Pull (-8.565,-39.54) (-6.141,-40.72)]
    |> filled (rgb 155 107 71)
    ,curve (-15.83,-36.84) [Pull (-15.83,-36.84) (-15.83,-36.84),Pull (-17.00,-37.76) (-16.80,-40.72),Pull (-18.04,-37.48) (-15.83,-36.84)]
      |> filled (rgb 155 107 71)]
logo = group [
     text "CINNAMON"
     |> customFont "Iosevka Charon Mono"
     |> size 10
     |> bold
     
      |> filled (rgb 69 52 42)
     |> move (-10,-15) 
     |> addOutline (solid 0.01) (rgb 42 26 14)
     
     
     ] 

lemon = group[
 curve (12.656,36.034) [Pull (8.2437,35.656) (1.2711,32.718),Pull (-10.72,31.907) (-20.83,25.975),Pull (-32.64,19.069) (-38.74,6.9637),Pull (-44.72,-2.461) (-46.59,-15.80),Pull (-47.71,-27.21) (-43.16,-39.46),Pull (-41.01,-44.05) (-37.30,-49.40),Pull (-37.61,-54.73) (-32.77,-59.46),Pull (-30.61,-61.74) (-27.13,-62.45),Pull (-22.08,-62.90) (-18.51,-61.12),Pull (-14.03,-59.70) (-10.55,-58.80),Pull (-4.727,-58.55) (-0.939,-56.59),Pull (3.5244,-55.20) (6.9084,-53.05),Pull (19.288,-24.53) (31.668,3.9792),Pull (30.704,10.210) (28.020,14.922),Pull (26.226,18.140) (24.151,22.438),Pull (23.257,27.438) (20.283,32.718),Pull (18.454,36.577) (12.656,36.034)]
 |> filled (rgb 255 212 0),
 curve (-35.20,5.6373) [Pull (-31.68,12.088) (-27.35,16.580),Pull (-22.76,21.432) (-13.09,23.765),Pull (-9.067,24.731) (-6.355,24.538),Pull (-2.859,23.171) (-5.803,19.564),Pull (-9.021,17.091) (-13.31,16.138),Pull (-17.35,15.406) (-23.59,9.3955),Pull (-26.29,6.9147) (-30.78,2.8739),Pull (-35.83,1.1308) (-35.20,5.6373)]
 |> filled (rgb 255 229 96),
 curve (0.7184,21.222) [Pull (-1.454,24.346) (1.4922,26.749),Pull (4.5029,28.401) (5.9136,25.533),Pull (7.2394,23.858) (6.2452,21.222),Pull (3.2724,18.362) (0.7184,21.222)]
 |> filled (rgb 255 229 96),
 curve (-34.54,-54.16) [Pull (-27.61,-58.29) (-20.61,-55.26),Pull (-17.51,-53.57) (-13.54,-53.27),Pull (-8.431,-52.76) (-5.803,-51.73),Pull (-1.208,-50.52) (2.2659,-48.19),Pull (2.8739,-47.86) (3.4818,-47.53),Pull (4.6424,-49.46) (5.8031,-51.39),Pull (1.0163,-54.57) (-5.250,-56.15),Pull (-9.878,-57.20) (-14.86,-57.81),Pull (-17.58,-58.27) (-22.82,-61.45),Pull (-27.01,-63.00) (-30.12,-59.91),Pull (-32.93,-57.37) (-34.54,-54.16)]
 |> filled (rgb 252 199 0),
 curve (21.499,27.191) [Pull (21.642,24.317) (22.825,21.443),Pull (22.095,20.948) (20.725,21.333),Pull (19.537,22.723) (17.630,23.433),Pull (20.584,24.087) (21.499,27.191)]
 |> filled (rgb 252 199 0),
 curve (39.958,50.625) [Pull (40.941,47.603) (37.084,43.661),Pull (32.242,44.713) (25.920,42.445),Pull (21.187,40.431) (18.293,36.697),Pull (17.519,35.741) (18.625,34.265),Pull (19.122,34.100) (19.620,33.934),Pull (20.361,32.669) (20.062,31.723),Pull (15.749,31.536) (12.877,35.150),Pull (13.905,36.518) (16.414,36.366),Pull (17.501,37.747) (17.188,39.129),Pull (16.414,40.290) (15.640,41.450),Pull (9.1669,35.427) (-0.386,34.044),Pull (-13.30,34.678) (-23.82,47.751),Pull (-26.16,50.514) (-26.91,53.278),Pull (-20.95,59.578) (-6.355,59.799),Pull (0.6621,59.510) (7.2400,53.941),Pull (11.987,50.558) (14.535,44.656),Pull (16.079,41.813) (18.183,39.571),Pull (21.161,43.413) (25.699,46.535),Pull (31.089,51.185) (39.958,50.625)]
 |> filled (rgb 206 222 0),
 curve (39.958,50.625) [Pull (40.941,47.603) (37.084,43.661),Pull (32.242,44.713) (25.920,42.445),Pull (21.187,40.431) (18.293,36.697),Pull (17.519,35.741) (18.625,34.265),Pull (17.504,34.242) (16.303,34.818),Pull (16.992,36.329) (17.962,37.360),Pull (20.090,40.162) (23.378,42.003),Pull (26.441,44.241) (30.784,45.319),Pull (33.548,45.714) (36.753,45.430),Pull (36.729,49.272) (39.958,50.625)]
 |> filled (rgb 173 186 0),
 curve (4.3661,-50.40) [Pull (27.136,-18.95) (49.906,12.490),Pull (61.257,5.7276) (66.929,-5.195),Pull (72.458,-16.41) (72.787,-29.95),Pull (72.121,-35.14) (74.335,-39.90),Pull (76.395,-44.33) (72.455,-49.51),Pull (70.126,-53.01) (66.597,-54.71),Pull (64.730,-55.38) (61.623,-55.82),Pull (56.542,-56.72) (50.901,-59.35),Pull (44.896,-63.37) (34.210,-62.78),Pull (25.633,-63.25) (12.656,-57.81),Pull (7.2090,-55.71) (3.4818,-51.73),Pull (4.0898,-50.84) (4.3661,-50.40)]
 |> filled (rgb 255 212 0),
  curve (22.936,-55.82) [Pull (32.564,-58.39) (42.832,-57.25),Pull (50.665,-56.29) (56.538,-53.16),Pull (61.782,-51.65) (66.265,-50.73),Pull (69.809,-49.68) (71.792,-47.19),Pull (73.388,-45.11) (74.224,-42.99),Pull (74.493,-46.77) (71.682,-51.06),Pull (69.148,-54.22) (64.055,-55.26),Pull (58.717,-55.87) (54.659,-57.81),Pull (50.791,-60.38) (45.043,-61.23),Pull (34.815,-63.75) (23.267,-61.67),Pull (16.516,-60.40) (10.445,-56.81),Pull (9.2297,-55.87) (8.0138,-54.93),Pull (15.419,-55.26) (22.936,-55.82)]
 |> filled (rgb 252 199 0),
 curve (-27.13,53.278) [Pull (-19.66,55.023) (-8.345,53.609),Pull (3.8902,51.873) (14.645,42.777),Pull (16.402,41.304) (17.519,39.792),Pull (17.685,40.369) (15.530,42.666),Pull (12.820,52.263) (5.4715,55.820),Pull (-2.001,60.644) (-12.43,59.468),Pull (-22.11,58.773) (-27.13,53.278)]
 |> filled (rgb 173 186 0),
 curve (13.872,35.702) [Pull (12.535,34.852) (15.198,33.602),Pull (17.635,32.253) (19.951,31.944),Pull (20.041,31.778) (19.730,31.613),Pull (18.524,31.465) (15.198,32.718),Pull (13.602,33.322) (12.766,34.487),Pull (12.644,35.094) (13.872,35.702)]
 |> filled (rgb 173 186 0),
 curve (11.550,-3.426) [Pull (16.987,4.0291) (24.704,9.2849),Pull (29.824,13.343) (36.863,14.922),Pull (44.941,16.179) (48.580,13.595),Pull (53.934,10.717) (56.649,3.7582),Pull (58.636,-3.870) (57.423,-12.37),Pull (55.893,-23.04) (49.243,-33.71),Pull (45.686,-39.89) (40.290,-45.31),Pull (34.273,-52.06) (25.257,-55.93),Pull (18.556,-58.36) (10.335,-56.48),Pull (3.9699,-53.87) (2.0449,-48.85),Pull (-0.885,-39.79) (-0.055,-30.72),Pull (0.6401,-23.76) (4.2556,-16.80),Pull (6.9985,-9.908) (11.550,-3.426)]
 |> filled (rgb 245 178 0),
 curve (6.2452,-16.46) [Pull (9.9404,-7.220) (16.635,-0.331),Pull (22.052,5.7388) (29.789,10.169),Pull (36.060,13.134) (42.611,12.379),Pull (49.960,10.693) (52.670,5.5267),Pull (56.207,-2.125) (55.544,-10.05),Pull (54.708,-17.79) (51.233,-25.53),Pull (48.029,-33.69) (41.506,-41.45),Pull (36.601,-47.30) (29.457,-51.39),Pull (23.630,-54.48) (16.082,-55.04),Pull (9.2997,-54.50) (4.4766,-47.64),Pull (1.3607,-40.55) (2.0449,-32.27),Pull (2.6956,-23.79) (6.2452,-16.46)]
 |> filled (rgb 255 250 211),
 curve (25.257,3.4265) [Pull (28.022,7.6110) (33.547,9.3955),Pull (37.097,10.182) (41.727,8.2901),Pull (36.389,-3.924) (30.452,-16.13),Pull (29.018,-18.06) (28.905,-16.35),Pull (26.856,-6.411) (25.257,3.4265)]
 |> filled (rgb 255 212 0),
 curve (42.832,7.7374) [Pull (48.538,8.7515) (51.564,3.2055),Pull (52.621,-0.165) (52.117,-3.537),Pull (42.559,-10.60) (32.442,-17.35),Pull (30.803,-18.19) (31.005,-16.80),Pull (37.079,-4.567) (42.832,7.7374)]
 |> filled (rgb 255 212 0),
 curve (52.449,-4.863) [Pull (54.320,-9.649) (53.112,-15.47),Pull (51.655,-21.02) (48.359,-24.98),Pull (40.291,-23.28) (32.663,-21.11),Pull (31.649,-19.89) (32.994,-18.68),Pull (42.376,-11.63) (52.449,-4.863)]
 |> filled (rgb 255 212 0),
 curve (47.585,-26.74) [Pull (46.719,-32.05) (43.053,-37.36),Pull (39.632,-41.68) (34.210,-44.21),Pull (31.916,-34.37) (30.341,-24.53),Pull (29.650,-22.64) (32,-22.99),Pull (39.997,-24.65) (47.585,-26.74)]
 |> filled (rgb 255 212 0),
 curve (15.861,-50.51) [Pull (18.927,-52.72) (24.594,-51.73),Pull (30.038,-49.34) (32.442,-45.76),Pull (30.618,-35.92) (28.794,-26.08),Pull (28.575,-24.16) (27.357,-25.75),Pull (21.259,-37.85) (15.861,-50.51)]
 |> filled (rgb 255 212 0),
 curve (5.6925,-39.01) [Pull (5.4405,-42.83) (6.9084,-46.64),Pull (8.5277,-50.02) (14.867,-49.85),Pull (20.799,-37.74) (26.252,-25.64),Pull (26.990,-23.32) (25.367,-24.64),Pull (15.054,-31.76) (5.6925,-39.01)]
 |> filled (rgb 255 212 0),
 curve (5.3609,-37.80) [Pull (3.6835,-32.71) (4.3661,-27.63),Pull (5.3273,-21.69) (9.0086,-16.91),Pull (16.766,-18.93) (24.483,-21.00),Pull (26.964,-21.68) (24.925,-23.32),Pull (15.538,-30.90) (5.3609,-37.80)]
 |> filled (rgb 255 212 0),
 curve (10.224,-15.14) [Pull (11.043,-10.37) (13.982,-6.411),Pull (17.681,-0.880) (23.820,2.2107),Pull (26.024,-7.085) (27.468,-17.02),Pull (28.142,-20.09) (25.257,-19.56),Pull (17.831,-17.65) (10.224,-15.14)]
 |> filled (rgb 255 212 0)
 
 
 ]
 
milk = group [
   curve (-76.44,28.327) [Pull (-69.39,37.470) (-62.35,46.613),Pull (-62.35,50.360) (-62.35,54.107),Pull (-61.92,58.206) (-55.45,57.704),Pull (-30.27,56.805) (-5.096,55.906),Pull (-1.667,56.107) (-2.398,52.309),Pull (-2.248,48.412) (-2.098,44.515),Pull (3.5971,37.320) (9.2927,30.126),Pull (9.2927,-5.545) (9.2927,-41.21),Pull (9.1037,-43.96) (6.5948,-44.51),Pull (-3.147,-49.61) (-12.88,-54.70),Pull (-13.78,-55.08) (-14.68,-54.70),Pull (-44.51,-52.30) (-74.34,-49.91),Pull (-76.79,-49.51) (-77.03,-46.91),Pull (-77.03,-10.04) (-77.03,26.829),Pull (-76.93,28.088) (-76.44,28.327)]
  |> filled (rgb 255 243 224) -- Bg white
  |> addOutline (solid 3) black
  ,
  curve (-74.64,25.030) [Pull (-74.79,14.088) (-74.94,3.1475),Pull (-44.96,1.7985) (-14.98,0.4496),Pull (-14.98,12.140) (-14.98,23.831),Pull (-44.96,24.430) (-74.64,25.030)]
  |> filled (rgb 100 178 204) -- "Milk" blue light bg
  ,
  curve (-13.48,0.1498) [Pull (-2.997,3.2974) (7.4941,6.4449),Pull (7.6440,17.536) (7.7939,28.627),Pull (-2.548,26.529) (-12.88,24.430),Pull (-13.33,12.590) (-13.48,0.1498)]
  |> filled (rgb 83 149 175) -- "Milk" blue dark bg
  ,
  curve (-68.34,8.5433) [Pull (-67.59,13.939) (-66.84,19.334),Pull (-65.17,21.464) (-62.95,19.634),Pull (-61.45,16.936) (-59.95,14.238),Pull (-58.45,16.487) (-56.95,18.735),Pull (-54.50,21.715) (-53.05,18.735),Pull (-52.45,12.889) (-51.85,7.0444),Pull (-53.16,5.1244) (-55.15,7.0444),Pull (-55.60,10.791) (-56.05,14.538),Pull (-57.40,12.290) (-58.75,10.042),Pull (-60.25,8.7320) (-61.75,10.341),Pull (-62.80,12.590) (-63.85,14.838),Pull (-64.44,11.391) (-65.04,7.9437),Pull (-67.03,5.2235) (-68.34,8.5433)]
  |> filled (rgb 255 243 224) -- "M"
  ,
  curve (-48.56,7.0444) [Pull (-48.56,13.039) (-48.56,19.035),Pull (-46.57,20.995) (-45.26,18.435),Pull (-45.26,12.740) (-45.26,7.0444),Pull (-46.65,5.4644) (-48.56,7.0444)]
  |> filled (rgb 255 243 224) -- "I"
  ,
  curve (-40.16,5.5456) [Pull (-42.20,5.4150) (-41.96,7.0444),Pull (-41.96,12.740) (-41.96,18.435),Pull (-41.56,19.775) (-39.56,19.634),Pull (-38.30,19.405) (-38.37,18.135),Pull (-38.37,13.639) (-38.37,9.1428),Pull (-35.97,8.8430) (-33.57,8.5433),Pull (-32.34,7.0444) (-33.87,5.5456),Pull (-37.17,5.5456) (-40.16,5.5456)]
  |> filled (rgb 255 243 224) -- "L"
  ,
  curve (-30.87,6.7447) [Pull (-30.72,12.440) (-30.57,18.135),Pull (-29.20,20.255) (-27.27,18.135),Pull (-27.27,16.187) (-27.27,14.238),Pull (-24.73,16.637) (-22.18,19.035),Pull (-19.96,19.275) (-19.78,17.236),Pull (-22.03,14.838) (-24.28,12.440),Pull (-22.18,9.7423) (-20.08,7.0444),Pull (-19.83,4.5451) (-22.78,5.2459),Pull (-25.03,7.7939) (-27.27,10.341),Pull (-27.42,8.2435) (-27.57,6.1451),Pull (-30.63,4.4948) (-30.87,6.7447)]
  |> filled (rgb 255 243 224) -- "K"
  ,
  curve (-62.05,45.414) [Pull (-32.52,44.665) (-2.997,43.915),Pull (-2.548,44.814) (-2.098,45.714),Pull (-32.07,46.463) (-62.05,47.213),Pull (-62.05,46.463) (-62.05,45.414)]
  |> filled black -- Main Outline
  ,
  curve (-4.496,45.114) [Pull (-9.442,35.372) (-14.38,25.629),Pull (-45.56,26.829) (-76.74,28.028),Pull (-76.74,26.529) (-76.74,25.030),Pull (-45.71,24.281) (-14.68,23.531),Pull (-14.83,-15.13) (-14.98,-53.80),Pull (-14.38,-54.25) (-13.78,-54.70),Pull (-12.74,-53.80) (-11.69,-52.90),Pull (-11.84,-41.21) (-11.99,-29.52),Pull (-12.14,-2.997) (-12.29,23.531),Pull (-2.697,25.779) (6.8946,28.028),Pull (8.0936,28.327) (9.2927,28.627),Pull (7.7939,31.475) (6.2950,34.323),Pull (1.4988,39.718) (-3.297,45.114),Pull (-3.297,43.765) (-3.297,42.416),Pull (1.3489,36.121) (5.9953,29.826),Pull (5.6955,29.826) (5.3957,29.826),Pull (-0.299,32.974) (-5.995,36.121),Pull (-6.444,35.372) (-6.894,34.622),Pull (-1.948,31.925) (2.9976,29.227),Pull (-4.346,27.578) (-11.69,25.929),Pull (-7.494,34.173) (-3.297,42.416),Pull (-3.447,43.915) (-3.597,45.414),Pull (-4.196,45.264) (-4.496,45.114)]
  |> filled black -- Main Outline
  ,
  curve (-8.693,35.222) [Pull (-7.344,34.922) (-5.995,34.622),Pull (-5.245,34.772) (-4.496,34.922),Pull (-5.845,36.121) (-7.194,37.320),Pull (-8.093,36.721) (-8.693,35.222)]
  |> filled black -- Main Outline


  ]

egg = group [  curve (-48.86,9.4426) [Pull (-44.78,17.167) (-39.26,23.531),Pull (-34.73,28.019) (-27.27,28.028),Pull (-19.77,27.090) (-15.58,20.833),Pull (-5.702,10.833) (-4.496,-5.245),Pull (-3.234,-19.31) (-9.292,-28.02),Pull (-16.32,-37.84) (-27.87,-38.22),Pull (-44.86,-39.05) (-52.45,-25.33),Pull (-56.46,-12.80) (-53.95,-3.447),Pull (-52.10,3.9675) (-48.86,9.4426)]
  |> filled (rgb 231 151 63) -- Orangish dark shadow
  ,
  curve (-54.25,-9.442) [Pull (-52.36,5.4171) (-44.66,16.637),Pull (-37.71,25.682) (-29.07,27.128),Pull (-22.48,27.171) (-15.28,19.934),Pull (-10.19,5.5456) (-5.096,-8.843),Pull (-8.393,-18.28) (-11.69,-27.72),Pull (-15.13,-29.67) (-18.58,-31.62),Pull (-23.98,-33.12) (-29.37,-34.62),Pull (-34.02,-34.47) (-38.66,-34.32),Pull (-44.51,-31.02) (-50.36,-27.72),Pull (-51.70,-24.43) (-53.05,-21.13),Pull (-53.65,-15.13) (-54.25,-9.442)]
  |> filled (rgb 246 194 127) -- Main color
  ,
  curve (-24.58,25.629) [Pull (-9.815,10.004) (-11.69,-12.74),Pull (-13.50,-32.55) (-35.67,-33.12),Pull (-43.82,-32.87) (-48.86,-28.02),Pull (-43.59,-36.00) (-31.77,-38.22),Pull (-19.05,-36.92) (-12.29,-29.82),Pull (-9.742,-25.92) (-7.194,-22.03),Pull (-6.744,-16.48) (-6.295,-10.94),Pull (-6.145,-4.646) (-5.995,1.6487),Pull (-7.793,6.2950) (-9.592,10.941),Pull (-12.44,14.988) (-15.28,19.035),Pull (-18.13,21.583) (-20.98,24.131),Pull (-22.63,25.180) (-24.28,26.229),Pull (-24.43,25.929) (-24.58,25.629)]
  |> filled (rgb 228 169 105) -- Brownish dark shadow
  ,
  curve (-12.29,-29.52) [Pull (-8.822,-26.78) (-7.194,-21.73),Pull (-3.194,-10.66) (-5.995,1.6487),Pull (-7.073,6.4449) (-9.592,11.241),Pull (-11.58,14.988) (-15.28,18.735),Pull (-15.13,18.735) (-14.98,18.735),Pull (-17.97,24.432) (-24.28,25.929),Pull (-19.33,20.084) (-14.38,14.238),Pull (-12.44,10.192) (-10.49,6.1451),Pull (-10.19,-8.243) (-9.892,-22.63),Pull (-11.09,-25.92) (-12.29,-29.52)]
  |> filled (rgb 228 169 105) -- Brownish dark shadow filler
  ,
  curve (-33.87,17.536) [Pull (-38.83,17.829) (-42.86,8.8430),Pull (-45.96,2.8482) (-45.86,-4.346),Pull (-45.40,-8.294) (-41.06,-10.04),Pull (-33.51,-11.05) (-32.67,-7.344),Pull (-28.70,0.6684) (-30.57,11.241),Pull (-31.17,17.938) (-33.87,17.536)]
  |> filled (rgb 255 211 164) -- Light shadow
  ]
  
pineapple = group [
  -- leafs
 
 curve (1.2985,9.0898) [Pull (2.2260,12.057) (3.1536,15.026),Pull (5.1942,18.736) (7.2347,22.446),Pull (10.202,25.043) (13.171,27.640),Pull (15.953,29.124) (18.736,30.608),Pull (22.260,31.907) (25.785,33.205),Pull (29.681,34.318) (33.576,35.431),Pull (34.875,35.802) (36.173,36.173),Pull (31.165,32.649) (26.156,29.124),Pull (23.559,26.527) (20.962,23.930),Pull (18.736,20.220) (16.510,16.510),Pull (15.953,14.840) (15.397,13.171),Pull (13.727,12.428) (12.057,11.686),Pull (8.5333,10.573) (5.0086,9.4608),Pull (4.2666,8.7188) (3.5246,7.9768),Pull (2.7826,8.3478) (1.2985,9.0898)]
   |> filled green
   ,
   curve (5.0086,17.994) [Pull (3.1536,19.478) (1.2985,20.962),Pull (-1.298,22.817) (-3.895,24.672),Pull (-6.678,26.713) (-9.460,28.753),Pull (-13.72,29.866) (-17.99,30.979),Pull (-21.70,31.907) (-25.41,32.834),Pull (-29.12,32.649) (-32.83,32.463),Pull (-26.71,29.681) (-20.59,26.898),Pull (-16.51,23.559) (-12.42,20.220),Pull (-10.20,16.510) (-7.976,12.8),Pull (-7.605,12.428) (-7.234,12.057),Pull (-5.194,11.130) (-3.153,10.202),Pull (-1.669,9.0898) (-0.185,7.9768),Pull (0.3710,8.3478) (0.9275,8.7188),Pull (2.0405,11.872) (5.0086,17.994)]
   |> filled green
   ,
   curve (2.0405,20.962) [Pull (3.8956,25.043) (5.7507,29.124),Pull (8.3478,32.649) (10.944,36.173),Pull (13.356,38.585) (15.768,40.997),Pull (19.292,43.779) (22.817,46.562),Pull (26.527,48.602) (30.237,50.643),Pull (31.721,51.2) (33.205,51.756),Pull (29.681,47.860) (26.156,43.965),Pull (24.115,39.884) (22.075,35.802),Pull (21.518,34.133) (20.962,32.463),Pull (20.591,31.907) (20.220,31.350),Pull (17.623,30.237) (15.026,29.124),Pull (12.243,26.898) (9.4608,24.672),Pull (7.6057,22.446) (5.7507,20.220),Pull (5.1942,19.107) (4.6376,17.994),Pull (3.3391,19.292) (2.0405,20.962)]
   |> filled green
   ,
   curve (-25.78,51.014) [Pull (-23.00,47.489) (-20.22,43.965),Pull (-18.17,39.513) (-16.13,35.060),Pull (-15.58,33.020) (-15.02,30.979),Pull (-14.84,30.608) (-14.65,30.237),Pull (-10.94,28.753) (-7.234,27.269),Pull (-2.597,23.930) (2.0405,20.591),Pull (3.1536,23.744) (4.2666,26.898),Pull (1.4840,29.681) (-1.298,32.463),Pull (-3.153,34.318) (-5.008,36.173),Pull (-8.162,39.327) (-11.31,42.481),Pull (-14.09,44.892) (-16.88,47.304),Pull (-19.29,48.602) (-25.78,51.014)]
   |> filled green
   ,
   curve (1.2985,30.608) [Pull (2.4115,34.504) (3.5246,38.4),Pull (5.0086,41.739) (6.4927,45.078),Pull (8.3478,48.602) (10.202,52.127),Pull (12.243,54.539) (14.284,56.950),Pull (15.582,58.991) (16.881,61.031),Pull (18.365,62.330) (19.849,63.628),Pull (20.034,62.330) (20.220,61.031),Pull (19.663,58.805) (19.107,56.579),Pull (18.365,54.168) (17.623,51.756),Pull (17.252,49.530) (16.881,47.304),Pull (16.881,46.005) (16.881,44.707),Pull (16.695,43.408) (16.510,42.110),Pull (15.211,40.626) (13.913,39.142),Pull (11.315,35.988) (8.7188,32.834),Pull (7.0492,30.608) (5.3797,28.382),Pull (4.8231,27.640) (4.2666,26.898),Pull (2.9681,28.382) (1.2985,30.608)]
   |> filled green
   ,
   curve (-3.524,63.628) [Pull (-3.710,62.886) (-3.895,62.144),Pull (-4.266,61.031) (-4.637,59.918),Pull (-5.008,57.507) (-5.379,55.095),Pull (-5.379,50.457) (-5.379,45.820),Pull (-5.379,41.739) (-5.379,37.657),Pull (-5.008,36.730) (-4.637,35.802),Pull (-1.855,33.205) (0.9275,30.608),Pull (1.6695,33.020) (2.4115,35.431),Pull (4.0811,39.327) (5.7507,43.223),Pull (5.0086,46.562) (4.2666,49.901),Pull (3.3391,52.127) (2.4115,54.353),Pull (1.6695,56.579) (0.9275,58.805),Pull (-1.113,61.031) (-3.524,63.628)]
   |> filled green
   ,
    
 -- pineapple
 
 curve (-7.976,11.686) [Pull (-9.646,10.759) (-11.31,9.8318),Pull (-11.87,8.7188) (-12.42,7.6057),Pull (-12.8,8.3478) (-13.17,9.0898),Pull (-14.65,8.1623) (-16.13,7.2347),Pull (-17.43,5.9362) (-18.73,4.6376),Pull (-20.59,1.6695) (-22.44,-1.298),Pull (-22.63,-2.226) (-22.81,-3.153),Pull (-23.00,-1.298) (-23.18,0.5565),Pull (-24.30,-1.484) (-25.41,-3.524),Pull (-26.15,-6.307) (-26.89,-9.089),Pull (-27.26,-11.50) (-27.64,-13.91),Pull (-27.64,-15.39) (-27.64,-16.88),Pull (-27.82,-16.13) (-28.01,-15.39),Pull (-28.93,-13.35) (-29.86,-11.31),Pull (-29.86,-15.21) (-29.86,-19.10),Pull (-29.86,-21.51) (-29.86,-23.93),Pull (-29.12,-27.82) (-28.38,-31.72),Pull (-28.38,-32.83) (-28.38,-33.94),Pull (-27.82,-35.06) (-27.26,-36.17),Pull (-28.01,-34.87) (-28.75,-33.57),Pull (-29.12,-33.76) (-29.49,-33.94),Pull (-29.49,-36.35) (-29.49,-38.77),Pull (-28.93,-41.73) (-28.38,-44.70),Pull (-27.45,-46.74) (-26.52,-48.78),Pull (-26.71,-49.53) (-26.89,-50.27),Pull (-25.78,-51.94) (-24.67,-53.61),Pull (-20.22,-57.13) (-15.76,-60.66),Pull (-6.863,-62.14) (2.0405,-63.62),Pull (6.8637,-63.07) (11.686,-62.51),Pull (16.324,-60.84) (20.962,-59.17),Pull (24.115,-57.87) (27.269,-56.57),Pull (29.681,-55.09) (32.092,-53.61),Pull (32.834,-51.38) (33.576,-49.15),Pull (34.133,-47.30) (34.689,-45.44),Pull (34.318,-44.89) (33.947,-44.33),Pull (34.689,-41.55) (35.431,-38.77),Pull (35.431,-35.61) (35.431,-32.46),Pull (35.431,-30.42) (35.431,-28.38),Pull (34.689,-28.93) (33.947,-29.49),Pull (34.875,-27.08) (35.802,-24.67),Pull (35.802,-22.44) (35.802,-20.22),Pull (35.246,-17.99) (34.689,-15.76),Pull (33.762,-16.13) (32.834,-16.51),Pull (32.092,-16.88) (31.350,-17.25),Pull (31.536,-14.46) (31.721,-11.68),Pull (31.165,-9.089) (30.608,-6.492),Pull (29.495,-3.895) (28.382,-1.298),Pull (27.826,-1.484) (27.269,-1.669),Pull (25.785,0.7420) (24.301,3.1536),Pull (22.075,5.9362) (19.849,8.7188),Pull (19.292,8.3478) (18.736,7.9768),Pull (17.437,10.388) (16.139,12.8),Pull (13.727,12.243) (11.315,11.686),Pull (8.9043,10.944) (6.4927,10.202),Pull (5.1942,9.2753) (3.8956,8.3478),Pull (2.9681,8.5333) (2.0405,8.7188),Pull (0.9275,8.1623) (-0.185,7.6057),Pull (-2.040,9.0898) (-3.895,10.573),Pull (-5.565,11.315) (-7.976,11.686)]
   |> filled yellow
   ,
    curve (-12.42,7.9768) [Pull (-11.68,6.3072) (-10.94,4.6376),Pull (-10.38,3.5246) (-9.831,2.4115),Pull (-9.460,1.6695) (-9.089,0.9275),Pull (-8.533,1.4840) (-7.976,2.0405),Pull (-7.605,1.6695) (-7.234,1.2985),Pull (-5.194,3.3391) (-3.153,5.3797),Pull (-2.040,6.4927) (-0.927,7.6057),Pull (0.1855,7.9768) (1.2985,8.3478),Pull (1.6695,8.5333) (2.0405,8.7188),Pull (3.8956,7.2347) (5.7507,5.7507),Pull (7.7913,3.5246) (9.8318,1.2985),Pull (10.017,0.7420) (10.202,0.1855),Pull (10.759,0.5565) (11.315,0.9275),Pull (11.872,0.7420) (12.428,0.5565),Pull (13.727,2.5971) (15.026,4.6376),Pull (16.510,5.9362) (17.994,7.2347),Pull (18.550,7.7913) (19.107,8.3478),Pull (22.631,4.0811) (26.156,-0.185),Pull (26.527,-0.927) (26.898,-1.669),Pull (26.527,-2.782) (26.156,-3.895),Pull (25.228,-6.121) (24.301,-8.347),Pull (23.373,-7.791) (22.446,-7.234),Pull (21.704,-7.791) (20.962,-8.347),Pull (16.695,-4.081) (12.428,0.1855),Pull (11.872,0.1855) (11.315,0.1855),Pull (9.6463,-1.113) (7.9768,-2.411),Pull (5.9362,-4.823) (3.8956,-7.234),Pull (3.3391,-8.533) (2.7826,-9.831),Pull (2.7826,-10.01) (2.7826,-10.20),Pull (2.0405,-9.646) (1.2985,-9.089),Pull (0.5565,-9.460) (-0.185,-9.831),Pull (-2.782,-5.565) (-5.379,-1.298),Pull (-6.121,-0.185) (-6.863,0.9275),Pull (-7.234,1.4840) (-7.605,2.0405),Pull (-8.347,1.6695) (-9.089,1.2985),Pull (-10.57,0) (-12.05,-1.298),Pull (-13.91,-3.524) (-15.76,-5.750),Pull (-16.51,-7.234) (-17.25,-8.718),Pull (-17.80,-8.162) (-18.36,-7.605),Pull (-18.92,-7.976) (-19.47,-8.347),Pull (-20.96,-6.121) (-22.44,-3.895),Pull (-22.63,-3.524) (-22.81,-3.153),Pull (-19.66,1.8550) (-16.51,6.8637),Pull (-14.84,7.6057) (-12.42,7.9768)]
   |> outlined (solid 0.75) black
   ,
   curve (-27.64,-16.13) [Pull (-25.78,-14.09) (-23.93,-12.05),Pull (-22.26,-10.57) (-20.59,-9.089),Pull (-19.84,-8.533) (-19.10,-7.976),Pull (-18.73,-7.605) (-18.36,-7.234),Pull (-17.62,-8.162) (-16.88,-9.089),Pull (-13.91,-12.42) (-10.94,-15.76),Pull (-10.38,-16.88) (-9.831,-17.99),Pull (-9.831,-18.17) (-9.831,-18.36),Pull (-9.275,-17.99) (-8.718,-17.62),Pull (-7.976,-17.99) (-7.234,-18.36),Pull (-3.895,-14.28) (-0.556,-10.20),Pull (0.3710,-9.646) (1.2985,-9.089),Pull (2.7826,-10.01) (4.2666,-10.94),Pull (6.1217,-12.42) (7.9768,-13.91),Pull (9.4608,-15.21) (10.944,-16.51),Pull (11.686,-17.25) (12.428,-17.99),Pull (12.428,-18.17) (12.428,-18.36),Pull (12.8,-17.99) (13.171,-17.62),Pull (13.727,-17.99) (14.284,-18.36),Pull (16.324,-14.46) (18.365,-10.57),Pull (19.849,-9.275) (21.333,-7.976),Pull (22.260,-7.605) (23.188,-7.234),Pull (26.898,-11.31) (30.608,-15.39),Pull (30.794,-16.13) (30.979,-16.88),Pull (31.721,-16.88) (32.463,-16.88),Pull (30.979,-19.10) (29.495,-21.33),Pull (28.382,-22.81) (27.269,-24.30),Pull (27.084,-24.85) (26.898,-25.41),Pull (26.342,-25.22) (25.785,-25.04),Pull (25.228,-25.6) (24.672,-26.15),Pull (22.631,-24.30) (20.591,-22.44),Pull (16.881,-20.22) (13.171,-17.99),Pull (11.686,-19.29) (10.202,-20.59),Pull (8.1623,-22.07) (6.1217,-23.55),Pull (5.3797,-24.48) (4.6376,-25.41),Pull (4.6376,-25.78) (4.6376,-26.15),Pull (4.0811,-25.78) (3.5246,-25.41),Pull (3.1536,-25.78) (2.7826,-26.15),Pull (2.4115,-26.34) (2.0405,-26.52),Pull (-2.968,-22.44) (-7.976,-18.36),Pull (-8.347,-18.17) (-8.718,-17.99),Pull (-10.38,-19.10) (-12.05,-20.22),Pull (-14.28,-21.70) (-16.51,-23.18),Pull (-17.80,-24.30) (-19.10,-25.41),Pull (-19.10,-25.6) (-19.10,-25.78),Pull (-19.29,-25.41) (-19.47,-25.04),Pull (-20.03,-25.22) (-20.59,-25.41),Pull (-21.14,-25.6) (-21.70,-25.78),Pull (-24.67,-21.14) (-27.64,-16.13)]
   |> outlined (solid 0.75 ) black
   ,
    curve (-26.89,-36.54) [Pull (-27.26,-35.80) (-27.64,-35.06),Pull (-28.01,-34.31) (-28.38,-33.57),Pull (-27.26,-31.72) (-26.15,-29.86),Pull (-24.11,-28.01) (-22.07,-26.15),Pull (-20.96,-25.78) (-19.84,-25.41),Pull (-14.84,-30.79) (-9.831,-36.17),Pull (-9.646,-36.73) (-9.460,-37.28),Pull (-8.718,-36.91) (-7.976,-36.54),Pull (-7.605,-36.73) (-7.234,-36.91),Pull (-4.637,-33.76) (-2.040,-30.60),Pull (0.5565,-28.19) (3.1536,-25.78),Pull (6.8637,-28.93) (10.573,-32.09),Pull (12.057,-33.39) (13.542,-34.68),Pull (13.727,-35.24) (13.913,-35.80),Pull (14.469,-35.06) (15.026,-34.31),Pull (15.953,-34.68) (16.881,-35.06),Pull (20.776,-30.60) (24.672,-26.15),Pull (25.043,-25.78) (25.414,-25.41),Pull (26.342,-25.6) (27.269,-25.78),Pull (30.608,-27.45) (33.947,-29.12),Pull (33.947,-30.42) (33.947,-31.72),Pull (31.721,-35.43) (29.495,-39.14),Pull (29.124,-39.88) (28.753,-40.62),Pull (28.011,-40.25) (27.269,-39.88),Pull (27.084,-40.81) (26.898,-41.73),Pull (23.188,-39.32) (19.478,-36.91),Pull (17.252,-35.61) (15.026,-34.31),Pull (13.171,-36.54) (11.315,-38.77),Pull (8.7188,-42.48) (6.1217,-46.19),Pull (5.7507,-46.19) (5.3797,-46.19),Pull (4.8231,-45.82) (4.2666,-45.44),Pull (3.3391,-46.19) (2.4115,-46.93),Pull (-0.742,-44.33) (-3.895,-41.73),Pull (-5.936,-39.14) (-7.976,-36.54),Pull (-11.68,-39.51) (-15.39,-42.48),Pull (-16.32,-43.96) (-17.25,-45.44),Pull (-17.43,-45.26) (-17.62,-45.07),Pull (-18.55,-45.26) (-19.47,-45.44),Pull (-23.37,-40.99) (-26.89,-36.54)]
   |> outlined (solid 0.75) black
   ,
   curve (-26.15,-49.90) [Pull (-24.48,-48.41) (-22.81,-46.93),Pull (-20.40,-46.00) (-17.99,-45.07),Pull (-15.58,-47.86) (-13.17,-50.64),Pull (-11.68,-51.57) (-10.20,-52.49),Pull (-9.460,-53.61) (-8.718,-54.72),Pull (-7.976,-53.79) (-7.234,-52.86),Pull (-6.492,-53.42) (-5.750,-53.98),Pull (-3.895,-52.12) (-2.040,-50.27),Pull (0.9275,-48.04) (3.8956,-45.82),Pull (8.5333,-48.78) (13.171,-51.75),Pull (13.356,-52.12) (13.542,-52.49),Pull (14.469,-51.75) (15.397,-51.01),Pull (16.324,-51.38) (17.252,-51.75),Pull (21.704,-46.74) (26.156,-41.73),Pull (26.713,-40.99) (27.269,-40.25),Pull (30.423,-41.92) (33.576,-43.59),Pull (33.576,-46.00) (33.576,-48.41),Pull (32.834,-50.64) (32.092,-52.86),Pull (30.237,-54.53) (28.382,-56.20),Pull (22.075,-53.98) (15.768,-51.75),Pull (9.8318,-56.95) (3.8956,-62.14),Pull (3.8956,-62.51) (3.8956,-62.88),Pull (2.2260,-60.10) (0.5565,-57.32),Pull (-3.339,-55.28) (-7.234,-53.24),Pull (-11.13,-56.76) (-15.02,-60.28),Pull (-16.88,-59.17) (-18.73,-58.06),Pull (-20.96,-56.20) (-23.18,-54.35),Pull (-24.48,-52.86) (-26.15,-49.90)]
   |> outlined (solid 0.75) black
   ,
 curve (-7.976,11.686) [Pull (-9.646,10.759) (-11.31,9.8318),Pull (-11.87,8.7188) (-12.42,7.6057),Pull (-12.8,8.3478) (-13.17,9.0898),Pull (-14.65,8.1623) (-16.13,7.2347),Pull (-17.43,5.9362) (-18.73,4.6376),Pull (-20.59,1.6695) (-22.44,-1.298),Pull (-22.63,-2.226) (-22.81,-3.153),Pull (-23.00,-1.298) (-23.18,0.5565),Pull (-24.30,-1.484) (-25.41,-3.524),Pull (-26.15,-6.307) (-26.89,-9.089),Pull (-27.26,-11.50) (-27.64,-13.91),Pull (-27.64,-15.39) (-27.64,-16.88),Pull (-27.82,-16.13) (-28.01,-15.39),Pull (-28.93,-13.35) (-29.86,-11.31),Pull (-29.86,-15.21) (-29.86,-19.10),Pull (-29.86,-21.51) (-29.86,-23.93),Pull (-29.12,-27.82) (-28.38,-31.72),Pull (-28.38,-32.83) (-28.38,-33.94),Pull (-27.82,-35.06) (-27.26,-36.17),Pull (-28.01,-34.87) (-28.75,-33.57),Pull (-29.12,-33.76) (-29.49,-33.94),Pull (-29.49,-36.35) (-29.49,-38.77),Pull (-28.93,-41.73) (-28.38,-44.70),Pull (-27.45,-46.74) (-26.52,-48.78),Pull (-26.71,-49.53) (-26.89,-50.27),Pull (-25.78,-51.94) (-24.67,-53.61),Pull (-20.22,-57.13) (-15.76,-60.66),Pull (-6.863,-62.14) (2.0405,-63.62),Pull (6.8637,-63.07) (11.686,-62.51),Pull (16.324,-60.84) (20.962,-59.17),Pull (24.115,-57.87) (27.269,-56.57),Pull (29.681,-55.09) (32.092,-53.61),Pull (32.834,-51.38) (33.576,-49.15),Pull (34.133,-47.30) (34.689,-45.44),Pull (34.318,-44.89) (33.947,-44.33),Pull (34.689,-41.55) (35.431,-38.77),Pull (35.431,-35.61) (35.431,-32.46),Pull (35.431,-30.42) (35.431,-28.38),Pull (34.689,-28.93) (33.947,-29.49),Pull (34.875,-27.08) (35.802,-24.67),Pull (35.802,-22.44) (35.802,-20.22),Pull (35.246,-17.99) (34.689,-15.76),Pull (33.762,-16.13) (32.834,-16.51),Pull (32.092,-16.88) (31.350,-17.25),Pull (31.536,-14.46) (31.721,-11.68),Pull (31.165,-9.089) (30.608,-6.492),Pull (29.495,-3.895) (28.382,-1.298),Pull (27.826,-1.484) (27.269,-1.669),Pull (25.785,0.7420) (24.301,3.1536),Pull (22.075,5.9362) (19.849,8.7188),Pull (19.292,8.3478) (18.736,7.9768),Pull (17.437,10.388) (16.139,12.8),Pull (13.727,12.243) (11.315,11.686),Pull (8.9043,10.944) (6.4927,10.202),Pull (5.1942,9.2753) (3.8956,8.3478),Pull (2.9681,8.5333) (2.0405,8.7188),Pull (0.9275,8.1623) (-0.185,7.6057),Pull (-2.040,9.0898) (-3.895,10.573),Pull (-5.565,11.315) (-7.976,11.686)]
    |> outlined (solid 1 ) black
    ,
    
   
   -- leafs shading
   curve (-30.97,32.463) [Pull (-21.33,28.382) (-11.68,24.301),Pull (-5.565,17.066) (0.5565,9.8318),Pull (0,9.2753) (-0.556,8.7188),Pull (-1.484,9.4608) (-2.411,10.202),Pull (-4.452,11.130) (-6.492,12.057),Pull (-7.976,13.913) (-9.460,15.768),Pull (-12.24,19.478) (-15.02,23.188),Pull (-17.80,25.414) (-30.97,32.463)]
    |> filled (rgb 31 155 0)
   ,
   curve (-24.30,49.530) [Pull (-20.77,44.521) (-17.25,39.513),Pull (-15.95,35.246) (-14.65,30.979),Pull (-10.01,28.939) (-5.379,26.898),Pull (-4.081,25.971) (-24.30,49.530)]
   |> filled (rgb 31 155 0)
   ,
   curve (-3.153,62.515) [Pull (-4.081,59.176) (-5.008,55.837),Pull (-4.823,46.747) (-4.637,37.657),Pull (-3.524,35.988) (-2.411,34.318),Pull (-0.927,33.020) (-3.153,62.515)]
   |> filled (rgb 31 155 0) 
   ,
   curve (1.2985,9.0898) [Pull (2.2260,12.057) (3.1536,15.026),Pull (5.1942,18.736) (7.2347,22.446),Pull (10.202,25.043) (13.171,27.640),Pull (15.953,29.124) (18.736,30.608),Pull (22.260,31.907) (25.785,33.205),Pull (29.681,34.318) (33.576,35.431),Pull (34.875,35.802) (36.173,36.173),Pull (31.165,32.649) (26.156,29.124),Pull (23.559,26.527) (20.962,23.930),Pull (18.736,20.220) (16.510,16.510),Pull (15.953,14.840) (15.397,13.171),Pull (13.727,12.428) (12.057,11.686),Pull (8.5333,10.573) (5.0086,9.4608),Pull (4.2666,8.7188) (3.5246,7.9768),Pull (2.7826,8.3478) (1.2985,9.0898)]
   |> outlined (solid 0.7) black
   ,
   curve (5.0086,17.994) [Pull (3.1536,19.478) (1.2985,20.962),Pull (-1.298,22.817) (-3.895,24.672),Pull (-6.678,26.713) (-9.460,28.753),Pull (-13.72,29.866) (-17.99,30.979),Pull (-21.70,31.907) (-25.41,32.834),Pull (-29.12,32.649) (-32.83,32.463),Pull (-26.71,29.681) (-20.59,26.898),Pull (-16.51,23.559) (-12.42,20.220),Pull (-10.20,16.510) (-7.976,12.8),Pull (-7.605,12.428) (-7.234,12.057),Pull (-5.194,11.130) (-3.153,10.202),Pull (-1.669,9.0898) (-0.185,7.9768),Pull (0.3710,8.3478) (0.9275,8.7188),Pull (2.0405,11.872) (5.0086,17.994)]
   |> outlined (solid 0.7) black
   ,
   curve (2.0405,20.962) [Pull (3.8956,25.043) (5.7507,29.124),Pull (8.3478,32.649) (10.944,36.173),Pull (13.356,38.585) (15.768,40.997),Pull (19.292,43.779) (22.817,46.562),Pull (26.527,48.602) (30.237,50.643),Pull (31.721,51.2) (33.205,51.756),Pull (29.681,47.860) (26.156,43.965),Pull (24.115,39.884) (22.075,35.802),Pull (21.518,34.133) (20.962,32.463),Pull (20.591,31.907) (20.220,31.350),Pull (17.623,30.237) (15.026,29.124),Pull (12.243,26.898) (9.4608,24.672),Pull (7.6057,22.446) (5.7507,20.220),Pull (5.1942,19.107) (4.6376,17.994),Pull (3.3391,19.292) (2.0405,20.962)]
   |> outlined (solid 0.7) black
   ,
   curve (-25.78,51.014) [Pull (-23.00,47.489) (-20.22,43.965),Pull (-18.17,39.513) (-16.13,35.060),Pull (-15.58,33.020) (-15.02,30.979),Pull (-14.84,30.608) (-14.65,30.237),Pull (-10.94,28.753) (-7.234,27.269),Pull (-2.597,23.930) (2.0405,20.591),Pull (3.1536,23.744) (4.2666,26.898),Pull (1.4840,29.681) (-1.298,32.463),Pull (-3.153,34.318) (-5.008,36.173),Pull (-8.162,39.327) (-11.31,42.481),Pull (-14.09,44.892) (-16.88,47.304),Pull (-19.29,48.602) (-25.78,51.014)]
   |>  outlined (solid 0.7) black
   ,
   curve (1.2985,30.608) [Pull (2.4115,34.504) (3.5246,38.4),Pull (5.0086,41.739) (6.4927,45.078),Pull (8.3478,48.602) (10.202,52.127),Pull (12.243,54.539) (14.284,56.950),Pull (15.582,58.991) (16.881,61.031),Pull (18.365,62.330) (19.849,63.628),Pull (20.034,62.330) (20.220,61.031),Pull (19.663,58.805) (19.107,56.579),Pull (18.365,54.168) (17.623,51.756),Pull (17.252,49.530) (16.881,47.304),Pull (16.881,46.005) (16.881,44.707),Pull (16.695,43.408) (16.510,42.110),Pull (15.211,40.626) (13.913,39.142),Pull (11.315,35.988) (8.7188,32.834),Pull (7.0492,30.608) (5.3797,28.382),Pull (4.8231,27.640) (4.2666,26.898),Pull (2.9681,28.382) (1.2985,30.608)]
   |>  outlined (solid 0.7) black
   ,
   curve (-3.524,63.628) [Pull (-3.710,62.886) (-3.895,62.144),Pull (-4.266,61.031) (-4.637,59.918),Pull (-5.008,57.507) (-5.379,55.095),Pull (-5.379,50.457) (-5.379,45.820),Pull (-5.379,41.739) (-5.379,37.657),Pull (-5.008,36.730) (-4.637,35.802),Pull (-1.855,33.205) (0.9275,30.608),Pull (1.6695,33.020) (2.4115,35.431),Pull (4.0811,39.327) (5.7507,43.223),Pull (5.0086,46.562) (4.2666,49.901),Pull (3.3391,52.127) (2.4115,54.353),Pull (1.6695,56.579) (0.9275,58.805),Pull (-1.113,61.031) (-3.524,63.628)]
   |>  outlined (solid 0.7) black


  ]
  
mangosteen = group [
  circle 35
 |> filled (rgb 113 34 137)
  |> move (-8, -10)
  ,
  

 curve (-32.24,12.539) [Pull (-32.73,12.702) (-33.22,12.865),Pull (-33.87,12.539) (-34.52,12.213),Pull (-36.47,10.748) (-38.43,9.2824),Pull (-39.40,6.6768) (-40.38,4.0712),Pull (-41.03,0.9770) (-41.68,-2.117),Pull (-41.68,-3.582) (-41.68,-5.048),Pull (-41.20,-6.676) (-40.71,-8.305),Pull (-39.57,-10.25) (-38.43,-12.21),Pull (-37.12,-14.49) (-35.82,-16.77),Pull (-35.01,-18.40) (-34.19,-20.03),Pull (-33.05,-22.63) (-31.91,-25.24),Pull (-31.43,-27.19) (-30.94,-29.15),Pull (-30.61,-31.91) (-30.29,-34.68),Pull (-29.96,-36.15) (-29.63,-37.61),Pull (-27.68,-38.92) (-25.73,-40.22),Pull (-22.63,-41.20) (-19.54,-42.17),Pull (-18.07,-42.82) (-16.61,-43.48),Pull (-13.51,-43.80) (-10.42,-44.13),Pull (-7.165,-43.96) (-3.908,-43.80),Pull (-1.139,-43.64) (1.6284,-43.48),Pull (1.9541,-42.50) (2.2798,-41.52),Pull (0.4885,-41.36) (-1.302,-41.20),Pull (-5.536,-40.06) (-9.770,-38.92),Pull (-13.35,-36.64) (-16.93,-34.36),Pull (-21.00,-30.77) (-25.07,-27.19),Pull (-27.03,-25.07) (-28.98,-22.96),Pull (-30.29,-19.70) (-31.59,-16.44),Pull (-32.56,-13.84) (-33.54,-11.23),Pull (-34.19,-7.816) (-34.84,-4.396),Pull (-35.17,-1.791) (-32.24,12.539)]
 |> filled (hsl(degrees 295) 0.639 0.287)
     
     
      ,
   
   
   curve (-5.008,23.930) [Pull (-5.194,23.744) (-5.379,23.559),Pull (-6.492,23.744) (-7.605,23.930),Pull (-9.275,23.930) (-10.94,23.930),Pull (-12.05,23.930) (-13.17,23.930),Pull (-14.28,23.930) (-15.39,23.930),Pull (-16.32,23.559) (-17.25,23.188),Pull (-17.99,22.817) (-18.73,22.446),Pull (-19.10,21.518) (-19.47,20.591),Pull (-19.84,19.478) (-20.22,18.365),Pull (-20.22,16.881) (-20.22,15.397),Pull (-20.03,14.469) (-19.84,13.542),Pull (-19.10,12.428) (-18.36,11.315),Pull (-17.99,10.944) (-17.62,10.573),Pull (-16.51,9.6463) (-15.39,8.7188),Pull (-13.72,7.9768) (-12.05,7.2347),Pull (-10.57,6.4927) (-9.089,5.7507),Pull (-7.791,5.5652) (-6.492,5.3797),Pull (-5.750,5.1942) (-5.008,5.0086),Pull (-3.895,5.1942) (-2.782,5.3797),Pull (-1.484,5.7507) (-0.185,6.1217),Pull (0.3710,6.3072) (0.9275,6.4927),Pull (2.4115,6.8637) (3.8956,7.2347),Pull (5.0086,8.1623) (6.1217,9.0898),Pull (6.6782,9.6463) (7.2347,10.202),Pull (8.3478,11.130) (9.4608,12.057),Pull (9.8318,13.356) (10.202,14.655),Pull (10.017,15.582) (9.8318,16.510),Pull (9.6463,17.808) (9.4608,19.107),Pull (9.0898,19.849) (8.7188,20.591),Pull (7.9768,20.962) (7.2347,21.333),Pull (6.4927,21.704) (5.7507,22.075),Pull (5.0086,22.446) (4.2666,22.817),Pull (3.3391,23.188) (2.4115,23.559),Pull (1.4840,23.744) (0.5565,23.930),Pull (-0.556,23.930) (-1.669,23.930),Pull (-2.226,23.744) (-5.008,23.930)]
   |> filled (rgb 4 173 55)
   ,
  
   curve (-17.99,28.382) [Pull (-17.80,28.382) (-17.62,28.382),Pull (-17.43,28.753) (-17.25,29.124),Pull (-17.25,29.310) (-17.25,29.495),Pull (-16.69,30.052) (-16.13,30.608),Pull (-15.76,30.979) (-15.39,31.350),Pull (-14.84,31.907) (-14.28,32.463),Pull (-13.72,32.834) (-13.17,33.205),Pull (-12.05,33.576) (-10.94,33.947),Pull (-10.57,34.133) (-10.20,34.318),Pull (-9.275,34.318) (-8.347,34.318),Pull (-7.791,34.318) (-7.234,34.318),Pull (-6.863,34.318) (-6.492,34.318),Pull (-6.307,34.318) (-6.121,34.318),Pull (-6.307,34.133) (-6.492,33.947),Pull (-7.049,33.391) (-7.605,32.834),Pull (-7.605,32.834) (-7.605,32.834),Pull (-7.791,32.463) (-7.976,32.092),Pull (-8.162,31.350) (-8.347,30.608),Pull (-8.533,30.052) (-8.718,29.495),Pull (-9.089,28.939) (-9.460,28.382),Pull (-9.831,27.826) (-10.20,27.269),Pull (-10.38,26.713) (-10.57,26.156),Pull (-10.57,25.785) (-10.57,25.414),Pull (-10.75,25.043) (-10.94,24.672),Pull (-11.31,24.672) (-11.68,24.672),Pull (-12.05,24.672) (-12.42,24.672),Pull (-13.35,24.672) (-14.28,24.672),Pull (-14.46,24.672) (-14.65,24.672),Pull (-15.02,24.672) (-15.39,24.672),Pull (-15.95,25.414) (-16.51,26.156),Pull (-16.51,26.342) (-16.51,26.527),Pull (-16.69,26.898) (-16.88,27.269),Pull (-16.88,27.455) (-16.88,27.640),Pull (-17.06,27.826) (-17.99,28.382)]
    |> filled (rgb 4 173 55)
   ,
   curve (5.0086,29.866) [Pull (5.0086,29.866) (5.0086,29.866),Pull (5.3797,29.310) (5.7507,28.753),Pull (6.3072,28.382) (6.8637,28.011),Pull (7.2347,27.269) (7.6057,26.527),Pull (7.6057,25.971) (7.6057,25.414),Pull (7.6057,25.043) (7.6057,24.672),Pull (7.2347,24.301) (6.8637,23.930),Pull (6.6782,23.559) (6.4927,23.188),Pull (6.3072,23.002) (6.1217,22.817),Pull (5.9362,22.817) (5.7507,22.817),Pull (5.1942,23.188) (4.6376,23.559),Pull (3.8956,23.744) (3.1536,23.930),Pull (2.2260,24.115) (1.2985,24.301),Pull (0.9275,24.301) (0.5565,24.301),Pull (0,24.486) (-0.556,24.672),Pull (-0.371,24.857) (-0.185,25.043),Pull (0,25.785) (0.1855,26.527),Pull (0.7420,26.898) (1.2985,27.269),Pull (1.6695,27.640) (2.0405,28.011),Pull (2.7826,28.939) (3.5246,29.866),Pull (4.0811,30.052) (4.6376,30.237),Pull (4.6376,30.237) (5.0086,29.866)]
    |> filled (rgb 4 173 55)
   ,
   curve (-15.76,24.672) [Pull (-15.76,24.672) (-15.76,24.672),Pull (-15.95,25.228) (-16.13,25.785),Pull (-17.06,26.713) (-17.99,27.640),Pull (-19.29,28.568) (-20.59,29.495),Pull (-22.07,30.052) (-23.55,30.608),Pull (-25.97,30.794) (-28.38,30.979),Pull (-29.31,30.794) (-30.23,30.608),Pull (-31.35,30.237) (-32.46,29.866),Pull (-34.13,29.310) (-35.80,28.753),Pull (-36.73,28.011) (-37.65,27.269),Pull (-38.21,26.713) (-38.77,26.156),Pull (-39.51,25.228) (-40.25,24.301),Pull (-40.99,23.559) (-41.73,22.817),Pull (-42.29,22.075) (-42.85,21.333),Pull (-42.85,20.962) (-42.85,20.591),Pull (-43.03,19.292) (-43.22,17.994),Pull (-43.03,17.437) (-42.85,16.881),Pull (-42.48,16.324) (-42.11,15.768),Pull (-40.81,15.397) (-39.51,15.026),Pull (-38.77,14.284) (-38.02,13.542),Pull (-36.91,13.171) (-35.80,12.8),Pull (-33.94,12.985) (-32.09,13.171),Pull (-31.35,12.985) (-30.60,12.8),Pull (-29.68,12.8) (-28.75,12.8),Pull (-28.01,12.614) (-27.26,12.428),Pull (-26.15,12.428) (-25.04,12.428),Pull (-24.30,12.428) (-23.55,12.428),Pull (-22.81,12.428) (-22.07,12.428),Pull (-21.51,12.614) (-20.96,12.8),Pull (-20.96,13.171) (-20.96,13.542),Pull (-20.96,14.284) (-20.96,15.026),Pull (-20.96,15.768) (-20.96,16.510),Pull (-20.77,17.623) (-20.59,18.736),Pull (-20.40,19.292) (-20.22,19.849),Pull (-19.47,20.962) (-18.73,22.075),Pull (-18.55,22.260) (-18.36,22.446),Pull (-18.17,22.817) (-17.99,23.188),Pull (-17.25,23.744) (-16.51,24.301),Pull (-16.32,24.486) (-16.13,24.672)]
    |> filled (rgb 4 173 55)
    ,
    
 curve (-0.185,40.997) [Pull (-0.556,41.182) (-0.927,41.368),Pull (-1.855,40.255) (-2.782,39.142),Pull (-3.339,38.214) (-3.895,37.286),Pull (-4.452,36.359) (-5.008,35.431),Pull (-5.750,34.318) (-6.492,33.205),Pull (-7.234,32.092) (-7.976,30.979),Pull (-8.347,30.052) (-8.718,29.124),Pull (-9.089,28.011) (-9.460,26.898),Pull (-9.646,26.342) (-9.831,25.785),Pull (-9.646,25.414) (-9.460,25.043),Pull (-9.275,24.857) (-9.089,24.672),Pull (-8.347,24.486) (-7.605,24.301),Pull (-6.863,24.301) (-6.121,24.301),Pull (-5.379,24.301) (-4.637,24.301),Pull (-4.081,24.301) (-3.524,24.301),Pull (-2.968,24.301) (-2.411,24.301),Pull (-1.855,24.486) (-1.298,24.672),Pull (-0.742,24.672) (-0.185,24.672),Pull (-0.185,25.228) (-0.185,25.785),Pull (0.1855,26.527) (0.5565,27.269),Pull (1.1130,28.011) (1.6695,28.753),Pull (2.7826,29.681) (3.8956,30.608),Pull (4.8231,30.979) (5.7507,31.350),Pull (6.4927,31.721) (7.2347,32.092),Pull (7.7913,32.463) (8.3478,32.834),Pull (8.5333,33.576) (8.7188,34.318),Pull (8.7188,35.246) (8.7188,36.173),Pull (8.5333,36.915) (8.3478,37.657),Pull (7.7913,38.4) (7.2347,39.142),Pull (6.8637,39.698) (6.4927,40.255),Pull (5.5652,40.626) (4.6376,40.997),Pull (3.8956,41.182) (3.1536,41.368),Pull (2.2260,41.739) (1.2985,42.110),Pull (0.7420,41.553) (0.1855,40.997),Pull (0.5565,40.069) (0.9275,39.142),Pull (1.4840,38.214) (2.0405,37.286),Pull (2.4115,36.359) (2.7826,35.431),Pull (3.3391,34.875) (3.8956,34.318),Pull (4.2666,33.762) (4.6376,33.205),Pull (5.3797,33.205) (6.1217,33.205),Pull (6.3072,33.020) (6.4927,32.834),Pull (6.8637,32.834) (7.2347,32.834),Pull (7.6057,33.020) (-0.185,40.997)]
     |> filled (rgb 4 173 55)
    ,
   
 curve (-6.121,23.930) [Pull (-3.339,24.115) (-0.556,24.301),Pull (1.4840,23.930) (3.5246,23.559),Pull (5.0086,23.002) (6.4927,22.446),Pull (8.1623,20.220) (9.8318,17.994),Pull (9.8318,16.139) (9.8318,14.284),Pull (7.9768,11.501) (6.1217,8.7188),Pull (4.4521,7.6057) (2.7826,6.4927),Pull (0.5565,5.9362) (-1.669,5.3797),Pull (-5.750,5.5652) (-9.831,5.7507),Pull (-12.05,6.4927) (-14.28,7.2347),Pull (-15.76,8.5333) (-17.25,9.8318),Pull (-18.55,10.944) (-19.84,12.057),Pull (-20.22,13.727) (-20.59,15.397),Pull (-20.40,17.252) (-20.22,19.107),Pull (-19.47,20.776) (-18.73,22.446),Pull (-17.06,23.373) (-15.39,24.301),Pull (-13.54,24.301) (-6.121,23.930)]
   |> filled (rgb 4 173 55)
    ,
    
 curve (6.8637,23.188) [Pull (6.8637,23.373) (6.8637,23.559),Pull (8.7188,24.486) (10.573,25.414),Pull (13.913,25.414) (17.252,25.414),Pull (20.962,24.301) (24.672,23.188),Pull (26.898,19.849) (29.124,16.510),Pull (29.866,13.727) (30.608,10.944),Pull (29.124,8.1623) (27.640,5.3797),Pull (24.486,4.8231) (21.333,4.2666),Pull (18.179,4.6376) (15.026,5.0086),Pull (12.614,6.4927) (10.202,7.9768),Pull (8.7188,9.0898) (7.2347,10.202),Pull (8.5333,12.243) (9.8318,14.284),Pull (10.202,16.139) (10.573,17.994),Pull (9.4608,19.663) (6.8637,23.188)]
 |> filled (rgb 4 173 55)
    ,
    
 curve (-6.492,34.689) [Pull (-6.492,34.689) (-6.492,34.689),Pull (-8.904,34.689) (-11.31,34.689),Pull (-12.42,34.133) (-13.54,33.576),Pull (-14.65,32.834) (-15.76,32.092),Pull (-16.69,30.979) (-17.62,29.866),Pull (-17.62,29.124) (-17.62,28.382),Pull (-17.06,27.455) (-16.51,26.527),Pull (-16.13,25.785) (-15.76,25.043),Pull (-13.72,24.857) (-11.68,24.672),Pull (-10.94,24.672) (-10.20,24.672),Pull (-10.01,25.414) (-9.831,26.156),Pull (-9.460,27.640) (-9.089,29.124),Pull (-8.533,30.237) (-7.976,31.350),Pull (-7.234,32.463) (-6.492,33.576),Pull (-6.307,33.947) (-6.492,34.689)]
 |> filled (rgb 4 173 55)
    ,
    
 curve (5.0086,29.866) [Pull (5.0086,29.866) (5.0086,29.866),Pull (6.3072,28.568) (7.6057,27.269),Pull (7.7913,26.156) (7.9768,25.043),Pull (7.2347,24.301) (6.4927,23.559),Pull (5.3797,23.744) (4.2666,23.930),Pull (2.2260,24.486) (0.1855,25.043),Pull (0.3710,26.342) (0.5565,27.640),Pull (1.2985,28.197) (5.0086,29.866)]
 |> filled (rgb 4 173 55)
    ,
    
 curve (0.9275,42.110) [Pull (0.3710,42.110) (-0.185,42.110),Pull (-1.484,40.811) (-2.782,39.513),Pull (-4.081,37.843) (-5.379,36.173),Pull (-5.936,35.060) (-6.492,33.947),Pull (-7.234,32.834) (-7.976,31.721),Pull (-9.089,29.124) (-10.20,26.527),Pull (-10.20,25.785) (-10.20,25.043),Pull (-8.718,24.486) (-7.234,23.930),Pull (-5.379,23.930) (-3.524,23.930),Pull (-1.855,24.115) (-0.185,24.301),Pull (0,25.414) (0.1855,26.527),Pull (1.1130,27.826) (2.0405,29.124),Pull (3.1536,29.866) (4.2666,30.608),Pull (6.4927,31.350) (8.7188,32.092),Pull (8.5333,33.947) (8.3478,35.802),Pull (7.9768,37.286) (7.6057,38.771),Pull (6.6782,39.698) (5.7507,40.626),Pull (4.4521,41.182) (0.9275,42.110)]
  |> filled (rgb 4 173 55)
    ,
    
 curve (-16.13,25.043) [Pull (-16.13,25.228) (-16.13,25.414),Pull (-17.62,27.269) (-19.10,29.124),Pull (-21.88,30.052) (-24.67,30.979),Pull (-27.08,31.165) (-29.49,31.350),Pull (-31.16,30.608) (-32.83,29.866),Pull (-34.50,29.124) (-36.17,28.382),Pull (-38.21,26.527) (-40.25,24.672),Pull (-41.18,23.373) (-42.11,22.075),Pull (-42.48,20.034) (-42.85,17.994),Pull (-41.92,16.510) (-40.99,15.026),Pull (-38.77,14.098) (-36.54,13.171),Pull (-34.13,12.985) (-31.72,12.8),Pull (-29.49,12.614) (-27.26,12.428),Pull (-24.85,12.243) (-22.44,12.057),Pull (-21.51,12.428) (-20.59,12.8),Pull (-20.40,12.8) (-20.22,12.8),Pull (-20.40,15.026) (-20.59,17.252),Pull (-19.84,19.292) (-19.10,21.333),Pull (-17.99,22.631) (-16.13,25.043)]
 |> filled (rgb 4 173 55)
 ,
 
 curve (-15.76,23.930) [Pull (-15.21,24.115) (-14.65,24.301),Pull (-13.17,24.301) (-11.68,24.301),Pull (-9.089,23.930) (-6.492,23.559),Pull (-2.968,23.559) (0.5565,23.559),Pull (2.5971,23.373) (4.6376,23.188),Pull (2.5971,23.930) (0.5565,24.672),Pull (-2.411,24.672) (-15.76,23.930)]
 |> filled (rgb 4 173 55)
 ,
 
 curve (3.5246,23.188) [Pull (4.6376,22.631) (5.7507,22.075),Pull (7.2347,21.518) (8.7188,20.962),Pull (9.0898,19.107) (9.4608,17.252),Pull (9.2753,15.953) (9.0898,14.655),Pull (9.8318,15.211) (10.573,15.768),Pull (10.388,17.066) (10.202,18.365),Pull (9.6463,19.478) (9.0898,20.591),Pull (8.7188,21.333) (8.3478,22.075),Pull (7.6057,22.260) (6.8637,22.446),Pull (6.1217,22.817) (3.5246,23.188)]
    |> filled (rgb 4 173 55)
    ,
    
 curve (6.8637,22.817) [Pull (6.8637,23.188) (6.8637,23.559),Pull (8.7188,24.301) (10.573,25.043),Pull (13.727,25.228) (16.881,25.414),Pull (19.849,24.672) (22.817,23.930),Pull (24.857,22.075) (26.898,20.220),Pull (28.011,18.550) (29.124,16.881),Pull (29.681,14.469) (30.237,12.057),Pull (29.681,9.4608) (29.124,6.8637),Pull (27.640,5.5652) (26.156,4.2666),Pull (22.631,4.2666) (19.107,4.2666),Pull (16.510,5.0086) (13.913,5.7507),Pull (11.872,6.8637) (9.8318,7.9768),Pull (8.9043,8.9043) (7.9768,9.8318),Pull (9.0898,12.243) (10.202,14.655),Pull (9.8318,17.066) (9.4608,19.478),Pull (8.5333,20.591) (7.6057,21.704),Pull (6.8637,22.260) (6.1217,22.817),Pull (6.4927,23.188) (6.8637,22.817)]
    |> outlined (solid 1) (rgb 4 173 55)
    ,
    
 curve (-5.379,24.301) [Pull (-8.533,24.486) (-11.68,24.672),Pull (-13.91,24.486) (-16.13,24.301),Pull (-17.99,23.188) (-19.84,22.075),Pull (-20.40,19.292) (-20.96,16.510),Pull (-19.84,13.913) (-18.73,11.315),Pull (-16.13,9.2753) (-13.54,7.2347),Pull (-9.831,6.1217) (-6.121,5.0086),Pull (-1.484,5.9362) (3.1536,6.8637),Pull (5.1942,8.5333) (7.2347,10.202),Pull (8.5333,11.872) (9.8318,13.542),Pull (10.017,15.582) (10.202,17.623),Pull (8.3478,20.034) (6.4927,22.446),Pull (4.2666,23.373) (-5.379,24.301)]
    |> outlined (solid 1) (rgb 4 173 55)
    ,
    
    
    
  
 
  
 
 circle 25
 |> filled (rgb 113 34 137)
 |> move (-55, -30)
  
 ,   
 
  curve (-35.06,52.127) [Pull (-35.06,52.313) (-35.06,52.498),Pull (-32.83,51.756) (-30.60,51.014),Pull (-29.68,49.901) (-28.75,48.788),Pull (-26.89,48.788) (-25.04,48.788),Pull (-23.93,48.046) (-22.81,47.304),Pull (-21.70,46.562) (-20.59,45.820),Pull (-19.84,43.779) (-19.10,41.739),Pull (-19.66,40.440) (-20.22,39.142),Pull (-20.77,38.4) (-21.33,37.657),Pull (-24.30,37.101) (-27.26,36.544),Pull (-27.45,36.730) (-27.64,36.915),Pull (-28.56,35.617) (-29.49,34.318),Pull (-30.60,33.391) (-31.72,32.463),Pull (-33.20,32.278) (-34.68,32.092),Pull (-36.91,33.205) (-39.14,34.318),Pull (-40.06,35.802) (-40.99,37.286),Pull (-42.11,36.915) (-43.22,36.544),Pull (-44.70,36.359) (-46.19,36.173),Pull (-48.41,37.101) (-50.64,38.028),Pull (-51.01,40.626) (-51.38,43.223),Pull (-50.82,43.965) (-50.27,44.707),Pull (-48.97,46.191) (-47.67,47.675),Pull (-46.37,48.231) (-45.07,48.788),Pull (-43.22,48.788) (-41.36,48.788),Pull (-40.62,48.973) (-39.88,49.159),Pull (-39.69,49.530) (-35.06,52.127)]
    |> filled green
    |> move (-20,-53)
    ,
    curve (-58.62,-2.768) [Pull (-58.78,-2.931) (-58.95,-3.094),Pull (-59.92,-3.419) (-60.90,-3.745),Pull (-62.20,-3.908) (-63.51,-4.071),Pull (-65.46,-4.559) (-67.41,-5.048),Pull (-68.07,-5.536) (-68.72,-6.025),Pull (-69.37,-6.676) (-70.02,-7.328),Pull (-70.67,-8.305) (-71.32,-9.282),Pull (-71.49,-9.770) (-71.65,-10.25),Pull (-71.49,-11.07) (-71.32,-11.88),Pull (-71.16,-12.70) (-71.00,-13.51),Pull (-70.67,-14.33) (-70.35,-15.14),Pull (-69.21,-15.63) (-68.07,-16.12),Pull (-67.74,-16.28) (-67.41,-16.44),Pull (-66.60,-16.61) (-65.79,-16.77),Pull (-63.83,-16.44) (-61.88,-16.12),Pull (-61.55,-15.95) (-61.23,-15.79),Pull (-61.23,-16.12) (-61.23,-16.44),Pull (-60.74,-17.26) (-60.25,-18.07),Pull (-59.60,-18.56) (-58.95,-19.05),Pull (-58.46,-19.37) (-57.97,-19.70),Pull (-57.32,-20.03) (-56.67,-20.35),Pull (-56.02,-20.51) (-55.36,-20.68),Pull (-54.88,-20.84) (-54.39,-21.00),Pull (-53.57,-20.84) (-52.76,-20.68),Pull (-52.11,-20.51) (-51.46,-20.35),Pull (-50.97,-20.19) (-50.48,-20.03),Pull (-49.83,-19.54) (-49.18,-19.05),Pull (-48.85,-18.40) (-48.52,-17.75),Pull (-48.36,-17.26) (-48.20,-16.77),Pull (-47.71,-16.77) (-47.22,-16.77),Pull (-46.57,-16.93) (-45.92,-17.09),Pull (-44.45,-16.77) (-42.99,-16.44),Pull (-42.50,-15.95) (-42.01,-15.47),Pull (-41.52,-14.98) (-41.03,-14.49),Pull (-40.54,-13.84) (-40.06,-13.19),Pull (-39.57,-12.21) (-39.08,-11.23),Pull (-39.08,-10.74) (-39.08,-10.25),Pull (-39.40,-9.119) (-39.73,-7.979),Pull (-40.06,-7.491) (-40.38,-7.002),Pull (-41.03,-6.513) (-41.68,-6.025),Pull (-42.34,-5.536) (-42.99,-5.048),Pull (-43.64,-4.722) (-44.29,-4.396),Pull (-45.27,-4.234) (-46.24,-4.071),Pull (-47.55,-3.908) (-48.85,-3.745),Pull (-49.01,-3.582) (-49.18,-3.419),Pull (-50.15,-2.605) (-51.13,-1.791),Pull (-51.94,-1.465) (-52.76,-1.139),Pull (-53.57,-0.651) (-54.39,-0.162),Pull (-54.71,-0.325) (-58.62,-2.768)]
   |> filled green
  
  ,
   curve (-42.11,53.982) [Pull (-42.29,53.611) (-42.48,53.240),Pull (-42.66,52.684) (-42.85,52.127),Pull (-42.29,51.571) (-41.73,51.014),Pull (-40.62,50.828) (-39.51,50.643),Pull (-38.21,50.086) (-36.91,49.530),Pull (-36.54,48.417) (-36.17,47.304),Pull (-35.98,46.747) (-35.80,46.191),Pull (-35.06,46.376) (-34.31,46.562),Pull (-33.76,46.562) (-33.20,46.562),Pull (-33.39,47.118) (-33.57,47.675),Pull (-33.57,48.417) (-33.57,49.159),Pull (-34.13,50.086) (-34.68,51.014),Pull (-35.61,51.756) (-36.54,52.498),Pull (-37.47,53.055) (-38.4,53.611),Pull (-39.51,53.982) (-42.11,53.982)]
 |> filled brown
 |> move (-20, -53)
 ,
 
 
 
 
 circle 25
 |> filled (rgb 113 34 137)
 |> move (25, -35)
 ,
 
  curve (-35.06,52.127) [Pull (-35.06,52.313) (-35.06,52.498),Pull (-32.83,51.756) (-30.60,51.014),Pull (-29.68,49.901) (-28.75,48.788),Pull (-26.89,48.788) (-25.04,48.788),Pull (-23.93,48.046) (-22.81,47.304),Pull (-21.70,46.562) (-20.59,45.820),Pull (-19.84,43.779) (-19.10,41.739),Pull (-19.66,40.440) (-20.22,39.142),Pull (-20.77,38.4) (-21.33,37.657),Pull (-24.30,37.101) (-27.26,36.544),Pull (-27.45,36.730) (-27.64,36.915),Pull (-28.56,35.617) (-29.49,34.318),Pull (-30.60,33.391) (-31.72,32.463),Pull (-33.20,32.278) (-34.68,32.092),Pull (-36.91,33.205) (-39.14,34.318),Pull (-40.06,35.802) (-40.99,37.286),Pull (-42.11,36.915) (-43.22,36.544),Pull (-44.70,36.359) (-46.19,36.173),Pull (-48.41,37.101) (-50.64,38.028),Pull (-51.01,40.626) (-51.38,43.223),Pull (-50.82,43.965) (-50.27,44.707),Pull (-48.97,46.191) (-47.67,47.675),Pull (-46.37,48.231) (-45.07,48.788),Pull (-43.22,48.788) (-41.36,48.788),Pull (-40.62,48.973) (-39.88,49.159),Pull (-39.69,49.530) (-35.06,52.127)]
    |> filled green
    |> move (60,-58) 
    ,
    
 
 curve (20.844,-8.305) [Pull (19.704,-8.631) (18.564,-8.956),Pull (16.610,-8.956) (14.656,-8.956),Pull (13.190,-9.770) (11.725,-10.58),Pull (10.422,-11.72) (9.1195,-12.86),Pull (8.7938,-14.33) (8.4681,-15.79),Pull (8.6310,-17.26) (8.7938,-18.72),Pull (9.6081,-19.54) (10.422,-20.35),Pull (11.562,-20.84) (12.702,-21.33),Pull (13.353,-21.49) (14.005,-21.65),Pull (15.633,-21.82) (17.262,-21.98),Pull (18.239,-21.17) (19.216,-20.35),Pull (19.216,-21.00) (19.216,-21.65),Pull (19.867,-22.79) (20.519,-23.93),Pull (21.496,-24.42) (22.473,-24.91),Pull (23.613,-25.40) (24.753,-25.89),Pull (25.730,-25.89) (26.707,-25.89),Pull (28.010,-25.73) (29.312,-25.56),Pull (30.452,-24.75) (31.592,-23.93),Pull (31.592,-23.77) (31.592,-23.61),Pull (32.081,-22.47) (32.569,-21.33),Pull (33.058,-21.33) (33.547,-21.33),Pull (34.524,-21.49) (35.501,-21.65),Pull (37.129,-21.17) (38.758,-20.68),Pull (39.572,-20.19) (40.386,-19.70),Pull (40.712,-18.72) (41.038,-17.75),Pull (41.038,-15.95) (41.038,-14.16),Pull (40.223,-13.02) (39.409,-11.88),Pull (37.781,-10.91) (36.152,-9.933),Pull (35.012,-9.445) (33.872,-8.956),Pull (32.244,-8.793) (30.615,-8.631),Pull (30.941,-8.631) (31.267,-8.631),Pull (30.452,-7.653) (29.638,-6.676),Pull (28.661,-6.188) (27.684,-5.699),Pull (26.218,-5.536) (24.753,-5.374),Pull (24.427,-5.536) (20.844,-8.305)]
   |> filled green 
   ,
   
   curve (-42.11,53.982) [Pull (-42.29,53.611) (-42.48,53.240),Pull (-42.66,52.684) (-42.85,52.127),Pull (-42.29,51.571) (-41.73,51.014),Pull (-40.62,50.828) (-39.51,50.643),Pull (-38.21,50.086) (-36.91,49.530),Pull (-36.54,48.417) (-36.17,47.304),Pull (-35.98,46.747) (-35.80,46.191),Pull (-35.06,46.376) (-34.31,46.562),Pull (-33.76,46.562) (-33.20,46.562),Pull (-33.39,47.118) (-33.57,47.675),Pull (-33.57,48.417) (-33.57,49.159),Pull (-34.13,50.086) (-34.68,51.014),Pull (-35.61,51.756) (-36.54,52.498),Pull (-37.47,53.055) (-38.4,53.611),Pull (-39.51,53.982) (-42.11,53.982)]
 |> filled brown
 |> move (60, -58)
 ,
 oval 2 5
    |> filled white
    |> move (-27,-40)
    |> rotate (degrees 90)
    ,
    oval 2 5
    |> filled white
    |> move (-25,39)
    |> rotate (degrees 90)
    ,
    
 curve (-71.42,-13.54) [Pull (-71.42,-15.02) (-71.42,-16.51),Pull (-71.60,-19.29) (-71.79,-22.07),Pull (-71.42,-25.78) (-71.04,-29.49),Pull (-70.30,-33.20) (-69.56,-36.91),Pull (-68.63,-39.14) (-67.71,-41.36),Pull (-66.78,-43.77) (-65.85,-46.19),Pull (-64.74,-47.86) (-63.62,-49.53),Pull (-62.14,-50.64) (-60.66,-51.75),Pull (-59.54,-52.49) (-58.43,-53.24),Pull (-56.95,-53.79) (-55.46,-54.35),Pull (-58.80,-54.35) (-62.14,-54.35),Pull (-66.41,-52.49) (-70.67,-50.64),Pull (-72.90,-47.67) (-75.13,-44.70),Pull (-76.05,-41.92) (-76.98,-39.14),Pull (-77.91,-35.43) (-78.84,-31.72),Pull (-78.46,-28.93) (-78.09,-26.15),Pull (-76.8,-22.07) (-75.50,-17.99),Pull (-73.46,-15.21) (-71.42,-12.42)]
  |> filled (hsl (degrees 295) 0.639 0.287)
  ,
  
 curve (-71.42,-13.54) [Pull (-71.42,-15.02) (-71.42,-16.51),Pull (-71.60,-19.29) (-71.79,-22.07),Pull (-71.42,-25.78) (-71.04,-29.49),Pull (-70.30,-33.20) (-69.56,-36.91),Pull (-68.63,-39.14) (-67.71,-41.36),Pull (-66.78,-43.77) (-65.85,-46.19),Pull (-64.74,-47.86) (-63.62,-49.53),Pull (-62.14,-50.64) (-60.66,-51.75),Pull (-59.54,-52.49) (-58.43,-53.24),Pull (-56.95,-53.79) (-55.46,-54.35),Pull (-58.80,-54.35) (-62.14,-54.35),Pull (-66.41,-52.49) (-70.67,-50.64),Pull (-72.90,-47.67) (-75.13,-44.70),Pull (-76.05,-41.92) (-76.98,-39.14),Pull (-77.91,-35.43) (-78.84,-31.72),Pull (-78.46,-28.93) (-78.09,-26.15),Pull (-76.8,-22.07) (-75.50,-17.99),Pull (-73.46,-15.21) (-71.42,-12.42)]
  |> filled (hsl(degrees 295) 0.639 0.287)
  |> move (79, -4)
  ,
  
  oval 2 5
  |> filled white
  |> rotate (degrees 90)
  |> move (20,20)
  ,
  
  
 curve (-35.17,12.865) [Pull (-35.17,12.865) (-35.17,12.865),Pull (-35.17,12.865) (-35.17,12.865),Pull (-35.66,12.539) (-36.15,12.213),Pull (-36.64,11.888) (-37.12,11.562),Pull (-37.61,10.748) (-38.10,9.9338),Pull (-38.26,9.7709) (-38.43,9.6081),Pull (-38.43,9.4452) (-38.43,9.2824),Pull (-37.94,9.4452) (-37.45,9.6081),Pull (-36.96,10.096) (-36.47,10.585),Pull (-36.15,11.073) (-35.17,12.865)]
  |> filled (hsl(degrees 295) 0.639 0.287)
  ,
  
 curve (-35.50,12.865) [Pull (-35.33,12.865) (-35.17,12.865),Pull (-35.01,12.865) (-34.84,12.865),Pull (-34.52,12.865) (-34.19,12.865),Pull (-34.19,12.865) (-34.19,12.865),Pull (-34.52,12.702) (-34.84,12.539),Pull (-35.01,12.376) (-35.17,12.213),Pull (-35.50,11.888) (-35.82,11.562),Pull (-35.98,11.399) (-36.15,11.236),Pull (-36.15,11.236) (-36.15,11.236),Pull (-36.15,11.236) (-36.15,11.236),Pull (-35.98,11.562) (-35.82,11.888),Pull (-35.66,12.213) (-35.50,12.539),Pull (-35.50,12.539) (-35.50,12.539),Pull (-35.82,11.888) (-36.15,11.236),Pull (-36.15,11.236) (-36.15,11.236),Pull (-35.82,11.236) (-35.50,11.236),Pull (-35.33,11.562) (-35.17,11.888),Pull (-35.01,12.213) (-34.84,12.539),Pull (-34.84,12.539) (-34.84,12.539)]
  |> filled (hsl(degrees 295) 0.639 0.287)
  ,
  
  
 curve (-33.54,30.127) [Pull (-34.52,29.801) (-35.50,29.475),Pull (-36.80,28.661) (-38.10,27.847),Pull (-38.75,27.033) (-39.40,26.218),Pull (-40.38,25.241) (-41.36,24.264),Pull (-42.01,23.450) (-42.66,22.636),Pull (-42.82,21.984) (-42.99,21.333),Pull (-43.15,20.030) (-43.31,18.727),Pull (-43.31,18.076) (-43.31,17.424),Pull (-42.66,16.610) (-42.01,15.796),Pull (-41.36,15.145) (-40.71,14.493),Pull (-39.89,14.330) (-39.08,14.167),Pull (-37.94,13.516) (-36.80,12.865),Pull (-36.15,12.865) (-35.50,12.865),Pull (-33.38,12.865) (-31.26,12.865),Pull (-30.45,12.702) (-29.63,12.539),Pull (-28.66,12.539) (-27.68,12.539),Pull (-26.05,12.539) (-24.42,12.539),Pull (-23.77,12.376) (-23.12,12.213),Pull (-22.47,12.213) (-21.82,12.213),Pull (-21.00,12.539) (-20.19,12.865),Pull (-20.03,12.702) (-19.86,12.539),Pull (-19.21,11.888) (-18.56,11.236),Pull (-17.42,10.259) (-16.28,9.2824),Pull (-15.47,8.3053) (-14.65,7.3282),Pull (-12.86,6.6768) (-11.07,6.0254),Pull (-9.282,5.6997) (-7.491,5.3740),Pull (-6.351,5.0483) (-5.211,4.7226),Pull (-3.908,5.2111) (-2.605,5.6997),Pull (-5.211,6.3511) (-7.816,7.0025),Pull (-9.770,7.9796) (-11.72,8.9567),Pull (-14.49,10.910) (-17.26,12.865),Pull (-19.05,14.167) (-20.84,15.470),Pull (-22.79,15.633) (-24.75,15.796),Pull (-26.87,15.959) (-28.98,16.122),Pull (-31.43,16.773) (-33.87,17.424),Pull (-35.50,18.076) (-37.12,18.727),Pull (-37.61,20.356) (-38.10,21.984),Pull (-37.45,22.798) (-36.80,23.613),Pull (-36.15,24.916) (-35.50,26.218),Pull (-35.17,27.033) (-34.84,27.847),Pull (-34.19,28.824) (-33.54,30.127)]
  |>  filled (hsl (degrees 117) 0.753 0.248)
  ,
  
 curve (-20.19,12.865) [Pull (-20.03,12.539) (-19.86,12.213),Pull (-19.70,11.725) (-19.54,11.236),Pull (-19.05,10.910) (-18.56,10.585),Pull (-17.58,9.7709) (-16.61,8.9567),Pull (-15.95,8.4681) (-15.30,7.9796),Pull (-14.65,7.4910) (-14.00,7.0025),Pull (-13.02,6.5139) (-12.05,6.0254),Pull (-10.58,5.6997) (-9.119,5.3740),Pull (-8.142,5.2111) (-7.165,5.0483),Pull (-6.839,4.8854) (-6.513,4.7226),Pull (-6.188,4.7226) (-5.862,4.7226),Pull (-7.002,5.3740) (-20.19,12.865)]
    |>  filled (hsl (degrees 117) 0.753 0.248)   
    ,
    
 curve (-33.87,29.475) [Pull (-34.19,28.987) (-34.52,28.498),Pull (-35.17,27.195) (-35.82,25.893),Pull (-36.31,24.101) (-36.80,22.310),Pull (-36.31,21.333) (-35.82,20.356),Pull (-35.17,19.541) (-34.52,18.727),Pull (-33.87,18.239) (-33.22,17.750),Pull (-32.73,17.424) (-32.24,17.099),Pull (-31.75,16.773) (-31.26,16.447),Pull (-32.40,16.122) (-33.54,15.796),Pull (-35.66,16.773) (-37.78,17.750),Pull (-38.59,19.541) (-39.40,21.333),Pull (-38.92,23.450) (-33.87,29.475)]
  |>  filled (hsl (degrees 117) 0.753 0.248)  
  ,
  
 curve (-33.54,30.127) [Pull (-33.54,30.127) (-33.54,30.127),Pull (-32.40,30.452) (-31.26,30.778),Pull (-30.29,31.104) (-29.31,31.430),Pull (-28.01,31.104) (-26.70,30.778),Pull (-27.68,31.104) (-28.66,31.430),Pull (-27.03,31.267) (-25.40,31.104),Pull (-23.28,30.615) (-21.17,30.127),Pull (-20.19,29.801) (-19.21,29.475),Pull (-18.23,28.498) (-17.26,27.521),Pull (-16.93,26.870) (-16.61,26.218),Pull (-17.75,26.707) (-33.54,30.127)]
   |> filled (rgb 4 173 55)

  ]
  
burger = group [
   curve (-75.84,-29.82) [Pull (-82.83,-36.20) (-77.33,-44.81),Pull (-56.54,-58.19) (-8.393,-56.20),Pull (19.752,-54.61) (28.777,-45.41),Pull (33.456,-43.63) (32.374,-34.02),Pull (-22.03,-31.77) (-75.84,-29.82)]
  |> filled lightBrown
  |> addOutline (solid 2) brown -- bottom bun
  |> move (0,5)
  ,
  curve (-81.83,-24.73) [Pull (-81.88,-26.37) (-81.53,-28.02),Pull (-73.14,-37.57) (-55.15,-40.31),Pull (-8.446,-47.61) (21.583,-36.42),Pull (29.018,-34.46) (32.974,-28.62),Pull (33.694,-25.77) (33.573,-22.93),Pull (20.150,-36.37) (-9.592,-35.22),Pull (-45.95,-42.06) (-81.23,-26.22),Pull (-81.68,-25.62) (-81.83,-24.73)]
  |> filled darkBrown
  |> addOutline (solid 3) (rgb 56 3 4) -- pattie
  |> move (0,5)
  ,  
  curve (-78.53,-2.847) [Pull (-88.33,-10.48) (-94.72,-21.43),Pull (-79.66,-20.63) (-66.24,-26.22),Pull (-38.91,-35.41) (-20.98,-53.20),Pull (-6.608,-35.66) (16.487,-26.52),Pull (34.804,-19.11) (49.161,-19.93),Pull (44.509,-8.781) (29.976,-0.749),Pull (2.8477,15.587) (-24.28,31.925),Pull (-51.70,14.538) (-78.53,-2.847)]
  |> filled yellow
  |> addOutline (solid 0.5) darkYellow -- cheese 
  ,
  curve (-74.34,1.0491) [Pull (-76.61,-5.225) (-77.63,-12.14),Pull (-71.61,-18.97) (-59.35,-21.13),Pull (-16.93,-29.20) (23.081,-18.43),Pull (29.957,-16.92) (33.274,-11.54),Pull (33.124,-9.442) (32.974,-7.344),Pull (23.389,-15.57) (-5.995,-18.73),Pull (-33.84,-21.59) (-59.05,-15.13),Pull (-61.60,-3.447) (-64.14,8.2435),Pull (-69.54,4.4964) (-74.34,1.0491)]
  |> filled lightRed
  |> addOutline (solid 2) red -- tomato
  ,
  curve (-83.63,6.1451) [Pull (-86.10,3.7066) (-89.33,2.5480),Pull (-92.01,-0.520) (-86.93,-1.348),Pull (-81.63,-1.967) (-82.13,-5.545),Pull (-81.96,-10.48) (-74.64,-9.742),Pull (-71.51,-13.72) (-71.34,-16.63),Pull (-66.75,-22.28) (-60.85,-16.33),Pull (-57.55,-14.43) (-53.05,-17.53),Pull (-42.79,-11.62) (-37.17,-17.83),Pull (-37.78,-22.22) (-18.28,-21.13),Pull (-12.92,-20.86) (-11.69,-15.43),Pull (-7.793,-15.74) (-3.896,-15.13),Pull (-0.920,-18.89) (5.6955,-19.93),Pull (15.210,-19.25) (19.484,-9.742),Pull (22.441,-9.202) (27.278,-9.142),Pull (28.648,-7.344) (28.777,-5.545),Pull (39.712,-5.686) (41.367,-3.747),Pull (43.427,-1.798) (42.566,0.1498),Pull (37.546,1.4666) (41.967,8.5433),Pull (43.099,11.142) (35.072,11.540),Pull (8.6932,10.491) (-17.68,9.4426),Pull (-50.51,8.0936) (-83.63,6.1451)]
  |> filled lightGreen
  |> addOutline (solid 2) green -- lettuce
  ,  
  curve (-80.93,6.7447) [Pull (-82.03,38.797) (-40.76,49.611),Pull (-6.411,55.935) (17.985,37.620),Pull (33.330,26.492) (32.074,7.0444),Pull (25.551,-5.049) (-9.892,-8.543),Pull (-7.612,-8.423) (-9.892,-8.543),Pull (-74.72,-9.739) (-80.93,6.7447)]
  |> filled lightBrown
  |> addOutline (solid 2) brown -- top bun  

  ]
hotdog = group [
   curve (-57.85,38.819) [Pull (-49.14,40.820) (-42.26,36.421),Pull (-26.20,16.642) (-3.297,8.5433),Pull (9.7887,3.9694) (6.5948,-7.044),Pull (-27.27,-9.292) (-61.15,-11.54),Pull (-59.50,13.789) (-57.85,38.819)]
  |> filled lightBrown -- back bun
  |> addOutline (solid 1) black
  ,
  curve (-69.84,19.934) [Pull (-75.99,34.996) (-68.94,41.217),Pull (-58.66,44.759) (-53.65,35.822),Pull (-46.16,23.381) (-38.66,10.941),Pull (-23.53,6.7447) (-8.393,2.5480),Pull (-4.946,1.7985) (-1.498,1.0491),Pull (11.436,-3.904) (9.2927,-15.13),Pull (6.6378,-25.62) (-3.896,-23.23),Pull (-10.49,-11.99) (-17.08,-0.749),Pull (-43.31,10.192) (-69.84,19.934)]
  |> filled lightRed -- meat 1
  |> addOutline (solid 1) black
  ,
  curve (-47.36,17.236) [Pull (-42.86,16.786) (-38.37,16.337),Pull (-33.57,13.639) (-28.77,10.941),Pull (-26.37,10.641) (-23.98,10.341),Pull (-21.43,5.8454) (-18.88,1.3489),Pull (-22.63,-1.498) (-26.37,-4.346),Pull (-37.62,0.5995) (-48.86,5.5456),Pull (-48.26,11.241) (-47.36,17.236)]
  |> filled lightRed -- meat 2
  ,
  curve (-81.23,9.7423) [Pull (-84.04,24.214) (-75.54,29.526),Pull (-67.40,34.477) (-60.55,27.428),Pull (-42.76,3.0094) (-15.88,-0.449),Pull (5.1792,-13.46) (-7.793,-27.72),Pull (-44.36,-8.393) (-81.23,9.7423)]
  |> filled lightBrown -- big bun 1
  |> addOutline (solid 1) black
  ,
  curve (-81.23,9.7423) [Pull (-54.91,-25.71) (-23.08,-33.72),Pull (-4.161,-35.51) (0.5995,-24.43),Pull (-38.65,-18.15) (-81.23,9.7423)]
  |> filled lightBrown -- big bun 2
  |> addOutline (solid 1) black
  ,
  curve (-80.93,11.540) [Pull (-78.98,8.2435) (-77.03,4.9461),Pull (-50.21,-8.843) (-23.38,-22.63),Pull (-12.74,-24.28) (-2.098,-25.92),Pull (-5.245,-22.03) (-8.393,-18.13),Pull (-44.81,-3.447) (-80.93,11.540)]
  |> filled lightBrown -- big bun 3
  ,
  curve (-56.35,30.126) [Pull (-60.93,32.314) (-55.75,34.622),Pull (-48.67,34.294) (-48.56,31.325),Pull (-48.65,26.908) (-46.46,24.131),Pull (-43.31,22.601) (-40.16,22.632),Pull (-34.67,20.885) (-35.97,15.737),Pull (-31.61,13.348) (-25.18,13.639),Pull (-22.93,16.852) (-15.88,4.9461),Pull (-12.45,5.8762) (-6.894,4.6463),Pull (0.8642,1.8595) (-3.896,-3.447),Pull (-8.734,-1.669) (-11.09,2.5480),Pull (-16.87,2.3971) (-20.98,4.6463),Pull (-24.73,10.103) (-28.47,11.241),Pull (-33.72,9.8713) (-37.17,10.941),Pull (-41.15,13.888) (-43.46,18.435),Pull (-46.46,18.824) (-49.46,20.533),Pull (-51.41,23.831) (-50.96,27.128),Pull (-54.10,30.507) (-56.35,30.126)]
  |> filled lightYellow -- mustard
  |> addOutline (solid 1) black
  

  ]
  
candisteen = group [
  candisteen2
  |> scale 2
  |> move (50,0) 


 , 
 light
 |> scale 0.2
 |> move (-36,20)
 
  , 
 light
 |> scale 0.2
 |> move (-30,5)
 
 
  , 
 light
 |> scale 0.15
 |> move (-25,4)
 
   , 
 light
 |> scale 0.2
 |> move (-10,4) 
  , 
 light
 |> scale 0.15
 |> move (-2,11)

  ]
  
candisteen2 = group [
     circle 17 --shadow
 |> filled (rgba 84 96 95 255)  
 |> scaleY 0.3
 |> scaleX 0.6
 |> move (-30,-8)
 
 
  ,
    circle 17
 |> filled red
 |> scaleY 0.7
 |> scaleX 0.8
 |> move (-36,6)
 ,
  circle 16
 |> filled (hsl (degrees 0) 0.743 0.682)--redpart
 |> scaleY 0.7
 |> scaleX 0.8
 |> move (-36,6)
 ,

 curve (-45.19,6.1629) [Pull (-40.52,10.075) (-34.76,10.587),Pull (-32.19,5.3906) (-32.55,-2.686),Pull (-43.49,-3.833) (-45.82,4.8987)]
 |> filled (rgb 255 243 128)  
 |> addOutline (solid 0.5) yellow 
 ,  
 curve (-34.44,9.3234) [Pull (-32.38,3.9424) (-32.55,-3.318),Pull (-27.09,-1.398) (-26.23,3.0024),Pull (-29.04,7.7009) (-34.44,9.6395)]
 |> filled (rgb 255 243 128)   
 |> addOutline (solid 0.5) yellow 
 |> move (0,1)
 
 ,
 
 curve (-33.18,9.6395) [Pull (-28.13,7.4049) (-25.6,2.3703),Pull (-22.73,7.0911) (-27.18,11.851),Pull (-31.87,12.283) (-33.81,9.9555)]
 |> filled (rgb 255 243 128)  
 |> addOutline (solid 0.5) yellow 
 |> move (-0.5,0)
 ,
 
 curve (-28.12,11.219) [Pull (-31.28,11.729) (-34.44,9.6395),Pull (-34.32,13.118) (-34.76,16.276),Pull (-28.85,16.010) (-27.49,10.903)]
 |> filled (rgb 255 243 128)   
 |> addOutline (solid 0.5) yellow 
 
 ,
 
 curve (-34.44,9.3234) [Pull (-34.50,12.981) (-34.76,15.960),Pull (-38.48,18.390) (-41.40,14.380),Pull (-36.96,12.931) (-34.76,9.3234)]
 |> filled (rgb 255 243 128)   
 |> addOutline (solid 0.5) yellow 
 
 ,
 
 curve (-34.76,9.3234) [Pull (-36.52,13.411) (-41.40,14.380),Pull (-47.39,13.081) (-46.14,4.5827),Pull (-39.55,8.6790) (-34.44,8.3753)]
 |> filled (rgb 255 243 128)   
 |> addOutline (solid 0.5) yellow 
 
 ,
 
 curve (-49.93,5.8469) [Pull (-49.22,1.2160) (-45.19,-5.214),Pull (-44.41,-7.271) (-42.03,-9.007),Pull (-38.32,-10.71) (-33.18,-10.90),Pull (-27.08,-6.556) (-24.33,0.7901),Pull (-28.14,-5.950) (-36.34,-5.530),Pull (-44.70,-6.656) (-49.93,4.8987)]
 |> filled (hsl (degrees 329) 0.43 0.267) --black

  ]

light = group [
  
    circle 10
      |> filled (rgb 255 255 194) 
        |> scaleY 2
        |> rotate (degrees -10)
  
 ]
 
chocolateStrawberry = group [
   -- leaves
    group
  [
    curve (30.9, -12.1) [Pull (18.1, 3.7) (-2.9, 6.0), Pull (-7.0, 8.7) (-8.5, 12.6), Pull (-3.2, 15.0) (7.7, 8.8), Pull (5.2, 16.6) (12.1, 23.4), Pull (15.6, 19.8) (18.3, 14.8), Pull (19.2, 10.6) (18.7, 3.7), Pull (27.3, 17.0) (35.7, 16.0), Pull (35.9, 8.6) (31.2, 3.7), Pull (38.7, 2.9) (42.3, 1.5), Pull (39.9, -3.9) (32.4, -5.0), Pull (38.3, -6.3) (41.2, -9.8), Pull (35.4, -12.9) (30.9, -12.1)]
      |> filled darkGreen
      |> addOutline (solid 0.75) black
  ]
  
  ,  -- red part of strawberry
    group
  [
    curve (33.5, -19.9) [Pull (15.5, -1.7) (6.2, 1.6), Pull (-0.5, 4.7) (-8.1, 5.6), Pull (5.2, 7.3) (19.5, -1.0), Pull (27.4, -4.1) (33.5, -19.9)]
    |> filled lightRed
    |> addOutline (solid 0.75) black
  ]
  ,
   -- chocolate part of strawberry
  group
  [
    curve (33.5, -19.9) [Pull (40.2, -28.3) (28.0, -41.1), Pull (19.8, -45.8) (11.7, -50.4), Pull (-3.6, -58.3) (-15.9, -50.8), Pull (-25.3, -44.3) (-24.8, -27.4), Pull (-25.3, -12.8) (-19.1, 1.2), Pull (-15.7, 6.0) (-8.5, 5.6), Pull (14.7, 2.1) (33.5, -19.9)]
      |> filled (rgb 153 73 44)
      |> addOutline (solid 0.75) black
   
   ]
   ,
      --Glazing on the chocolate
      group
  [
    curve (36.8, -24.3) [Pull (21.8, -11.3) (9.9, -8.3), Pull (-3.5, 2.8) (-18.1, 3.4), Pull (-19.5, 1.8) (-18.1, -0.3), Pull (-10.2, -0.2) (-1.8, -2.7), Pull (8.9, -9.0) (19.8, -15.4), Pull (39.8, -28.8) (36.8, -24.3)]
      |> filled (rgb 232 207 197)
      |> addOutline (solid 0.75) black
  ]
  
  ,
    -- Glazing #2
   group
  [
    curve (-23.6, -4.0) [Pull (-4.3, -6.9) (4.0, -15.3), Pull (13.6, -25.1) (25.3, -28.3), Pull (37.2, -36.9) (35.0, -29.0), Pull (29.5, -28.6) (23.2, -24.9), Pull (14.5, -23.3) (6.1, -12.8), Pull (-5.1, -1.5) (-23.6, -4.0)]
      |> filled (rgb 232 207 197)
      |> addOutline (solid 0.75) black
  ]
  
  ,
  
  group -- Glaze #3
  [
    curve (26.1, -42.4) [Pull (19.2, -36.4) (11.8, -34.5), Pull (3.8, -32.7) (-8.1, -21.3), Pull (-16.9, -16.2) (-25.1, -15.8), Pull (-27.9, -19.8) (-25.0, -24.1), Pull (-15.3, -25.8) (-10.0, -32.7), Pull (-4.0, -38.4) (4.0, -40.1), Pull (8.1, -42.7) (11.0, -50.3), Pull (14.3, -52.8) (16.1, -48.2), Pull (10.3, -40.6) (3.2, -37.9), Pull (-6.9, -35.3) (-11.8, -26.3), Pull (-20.5, -22.7) (-24.0, -19.8), Pull (-21.3, -15.9) (-12.5, -21.3), Pull (-7.6, -22.7) (-2.2, -28.6), Pull (3.0, -35.1) (12.0, -37.1), Pull (22.9, -45.4) (26.1, -42.4)]
      |> filled (rgb 232 207 197)
      |> addOutline (solid 0.75) black
  ]
  
  ,
  
  group -- glaze #4
  [
    curve (2.5, -52.7) [Pull (5.6, -55.2) (9.2, -52.5), Pull (1.6, -48.0) (-5.9, -43.4), Pull (-12.8, -32.1) (-24.3, -32.7), Pull (-27.2, -37.6) (-25.1, -33.1), Pull (-14.0, -42.6) (-15.5, -36.0), Pull (-2.8, -44.9) (-10.3, -44.8), Pull (-10.3, -44.8) (2.5, -52.0)]
      |> filled (rgb 232 207 197)
      |> addOutline (solid 0.75) black
    
  ]

  ]

acai = group [

  polygon [(32.371,6.6847),(52.301,4.9516),(72.851,-13.98),(46.854,-8.912),(30.143,-3.713),(32.371,6.6847)]
      |> filled white
  , curve (36.704,17.083) [Pull (55.912,17.144) (69.880,-1.114),Pull (73.176,-6.384) (73.593,-14.85),Pull (62.345,-4.008) (45.617,1.2379),Pull (39.428,3.5271) (32,4.4564),Pull (29.152,10.955) (26.305,17.454),Pull (31.504,17.454) (36.704,17.083)]
      |> filled (rgb 104 152 2)
  , curve (35.342,-1.361) [Pull (45.678,-2.306) (56.015,-5.570),Pull (64.557,-8.847) (73.098,-14.48),Pull (61.400,-14.65) (49.702,-16.58),Pull (43.388,-18.67) (37.075,-16.95),Pull (31.690,-15.40) (26.305,-13.36),Pull (31.319,-7.241) (35.342,-1.361)]
      |> filled (rgb 76 107 3)
  
  , polygon [(-84.61,-35.52),(-79.53,-25.25),(-40.41,-1.856),(-30.39,-14.85),(-84.61,-35.52)]
      |> filled white
  , curve (-48.58,2.3520) [Pull (-62.35,-0.351) (-72.47,-9.655),Pull (-80.37,-16.88) (-84.98,-27.35),Pull (-86.29,-30.97) (-85.84,-36.27),Pull (-74.52,-26.04) (-59.72,-19.18),Pull (-50.44,-14.07) (-41.16,-10.64),Pull (-39.48,-5.446) (-37.81,-0.247),Pull (-43.26,1.1760) (-48.58,2.3520)]
      |> filled (rgb 104 152 2)
  , curve (-85.84,-36.02) [Pull (-60.19,-20.93) (-37.81,-12.99),Pull (-30.45,-8.108) (-23.08,-3.218),Pull (-17.51,-1.361) (-11.94,0.4951),Pull (-9.284,-8.665) (-6.622,-17.82),Pull (-11.04,-25.90) (-17.51,-30.70),Pull (-25.81,-37.08) (-34.10,-38.87),Pull (-45.81,-42.39) (-54.65,-38.99),Pull (-64.12,-36.96) (-73.59,-37.01),Pull (-79.90,-36.56) (-85.84,-36.02)]
      |> filled (rgb 76 107 3)
  
  , curve (-10.36,28.284) [Pull (-7.535,38.867) (1.3736,43.769),Pull (17.049,51.316) (30.844,40.023),Pull (40.711,30.047) (37.338,16.671),Pull (35.262,11.994) (33.467,9.6780),Pull (17.607,11.114) (1.7482,12.550),Pull (-4.120,20.854) (-10.36,28.284)]
      |> filled (rgb 48 33 64)
      |> move (0, -1)
  , curve (1.1239,43.769) [Pull (10.097,48.396) (20.230,46.142),Pull (29.598,43.500) (34.965,34.778),Pull (39.221,28.141) (37.838,18.544),Pull (34.232,16.707) (28.347,16.671),Pull (19.418,19.543) (10.489,22.415),Pull (-0.388,29.877) (1.1239,43.769)]
      |> filled (rgb 66 48 90)
      |> move (0, -1)
  , curve (10.989,35.402) [Pull (13.611,33.722) (16.234,35.402),Pull (16.152,31.715) (19.231,30.907),Pull (16.795,29.569) (16.359,25.912),Pull (13.674,26.952) (10.989,25.912),Pull (11.055,28.942) (8.2419,30.532),Pull (10.718,31.707) (10.989,35.402)]
      |> filled (rgb 199 211 213)
      |> move (0, -1)
  , curve (11.114,31.781) [Pull (11.962,33.973) (14.610,33.404),Pull (16.884,32.071) (16.359,29.658),Pull (15.355,27.526) (13.112,28.035),Pull (10.653,28.668) (11.114,31.781)]
      |> filled (rgb 143 103 202)
      |> move (0, -1)
  , curve (11.945,31.442) [Pull (12.796,32.536) (13.926,32.309),Pull (15.407,31.901) (15.288,30.452),Pull (14.895,28.775) (13.183,29.338),Pull (11.386,29.814) (11.945,31.442)]
      |> filled (rgb 47 35 67)  
      |> move (0, -1)
      
  , curve (-28.72,32.530) [Pull (-8.762,33.955) (-2.122,17.420),Pull (-6.056,3.2468) (-9.990,-10.92),Pull (-16.34,-17.94) (-29.09,-15.79),Pull (-42.91,-14.14) (-48.45,0.3121),Pull (-52.87,20.257) (-36.08,30.282),Pull (-32.63,31.931) (-28.72,32.530)]
      |> filled (rgb 48 33 64)
  , curve (-39.96,27.660) [Pull (-33.45,32.805) (-23.47,33.030),Pull (-15.11,32.217) (-10.24,28.284),Pull (-4.799,24.452) (-1.998,17.420),Pull (-6.493,11.426) (-10.98,5.4321),Pull (-19.19,5.3058) (-24.60,8.1795),Pull (-29.34,10.199) (-32.21,13.299),Pull (-39.94,19.042) (-39.71,27.785),Pull (-39.71,27.785) (-39.71,27.785),Pull (-39.71,27.785) (-39.96,27.660)]
      |> filled (rgb 70 47 91)
  , curve (-39.33,21.166) [Pull (-36.78,18.267) (-33.84,20.167),Pull (-34.71,15.703) (-32.21,13.799),Pull (-35.27,12.426) (-36.08,9.0536),Pull (-38.41,10.473) (-41.58,10.052),Pull (-41.05,13.237) (-43.20,16.421),Pull (-40.05,17.114) (-39.33,21.166)]
      |> filled (rgb 199 211 213)
  , curve (-38.46,18.044) [Pull (-40.66,17.251) (-40.71,14.298),Pull (-40.42,12.089) (-38.46,11.800),Pull (-35.98,11.834) (-35.34,14.548),Pull (-35.14,16.976) (-36.71,18.044),Pull (-37.97,18.387) (-38.46,18.044)]
      |> filled (rgb 143 103 202)
  , curve (-39.65,14.232) [Pull (-39.65,12.815) (-37.86,13.158),Pull (-36.62,14.232) (-36.78,15.306),Pull (-36.77,16.962) (-38.4,16.738),Pull (-39.67,16.050) (-39.65,14.232)]
      |> filled (rgb 47 35 67)      
      
  , curve (-5.102,15.395) [Pull (3.9086,23.061) (16.559,22.288),Pull (28.446,20.016) (34.013,10.025),Pull (40.373,-0.994) (34.372,-13.69),Pull (28.910,-25.69) (14.769,-26.85),Pull (1.1974,-27.08) (-6.534,-17.99),Pull (-15.00,-5.281) (-10.83,5.9076),Pull (-9.400,10.651) (-5.102,15.395)]
      |> filled (rgb 57 35 73)
  , curve (-4.870,15.422) [Pull (2.7302,22.399) (14.610,22.415),Pull (25.792,21.334) (31.094,14.173),Pull (36.679,7.9892) (37.463,-2.435),Pull (24.939,-5.575) (15.734,-2.435),Pull (5.3502,1.3775) (-0.874,7.4302),Pull (-3.932,10.571) (-4.870,15.422)]
      |> filled (rgb 79 52 103)
  , curve (16.234,-6.431) [Pull (19.043,-8.853) (21.853,-6.556),Pull (21.712,-10.39) (24.850,-11.42),Pull (22.354,-13.68) (21.978,-16.67),Pull (19.043,-15.02) (16.109,-16.54),Pull (16.273,-13.24) (13.237,-11.55),Pull (16.018,-11.15) (16.359,-6.431),Pull (16.359,-6.431) (16.234,-6.431)]
      |> filled (rgb 199 211 213)
  , curve (16.109,-10.92) [Pull (16.915,-8.605) (19.480,-8.803),Pull (21.867,-9.247) (21.853,-12.05),Pull (21.477,-14.31) (18.981,-14.54),Pull (15.907,-14.29) (16.234,-10.80),Pull (16.234,-10.80) (16.109,-10.92)]
      |> filled (rgb 143 103 202)
  , curve (17.358,-11.05) [Pull (17.739,-9.807) (19.480,-9.802),Pull (20.900,-10.24) (20.48,-11.92),Pull (19.688,-13.76) (17.857,-12.8),Pull (17.025,-11.97) (17.358,-11.05)]
      |> filled (rgb 47 35 67)
  ]

oats = group[
  --bag
  roundedRect 53 85 9
  |>filled (rgb 200 150 100)
  |>move (15,-7)
  |>rotate(degrees -5)
  
  ,
  
  roundedRect 23 83 9
  |>filled (rgb 200 150 100)
  |>move (48, -14)
  |>rotate(degrees 10)
  
  ,
  
  curve (-15, -43)[Pull(40,-70)(65,-40), Pull(60,50)(-15,-43)]
  |>filled (rgb 200 150 100)
  
  ,
  
  circle (6)
  |> filled (rgb 200 150 100)
  |> move (-9,37)
  
  ,
  
  curve (-10, 23) [Pull(-10.5,53)(-1.5,46), Pull(0.5,49)(8,47), Pull(17,53)(23,48), Pull(34,52)(37,49), Pull(40,45)(47,49.5), Pull(54,48)(52,40), Pull(50,37)(54,32), Pull(0,0)(-10, 23)]
  |>filled (rgb 200 150 100)
  
  ,
  
  --word
  curve (37, 40)[Pull(40,36)(39,34), Pull(37,32)(35,32), Pull(33,31)(31,31), Pull(25,31)(23,31.5), Pull(20, 31.5)(17, 32), Pull(15,32)(9,33.5)]
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (47,37)(38,33)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  curve (37,33)[Pull(37,-20)(37.5,-33), Pull(37.5,-35)(38,-38), Pull(38.5,-40)(39,-40),Pull(39.5,-40.5)(40.5,-40.5)]
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  circle (3.5)
  |>outlined (solid 4) (rgb 150 100 50)
  |>move (-0.75, 1)
  
  ,
  
  curve (6,-6)[Pull(8,9)(11,3), Pull(11,1)(12,-6)]
  |>outlined (solid 3.5) (rgb 150 100 50)
  
  ,
  
  line (6.5,-2)(11,-2)
  |>outlined (solid 3.5) (rgb 150 100 50)
  
  ,
  
  line (14,3)(24,1.5)
  |>outlined (solid 3.5) (rgb 150 100 50)
  
  ,
  
  line (19,2)(17.5,-7)
  |>outlined (solid 3.5) (rgb 150 100 50)
  
  ,
  
  curve(30, 1.5)[Pull(23,1)(29,-4), Pull(30,-4.5)(25,-6),Pull(23,-5.5)(22,-4)]
  |>outlined (solid 3.5) (rgb 150 100 50)
  
  ,
  
  --details
  line (-7,-15)(-4,-18)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (-4,-16)(-2,-18)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (5,-22)(7,-25)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (2,-24)(4,-26)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (25,-45)(23,-48)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (28,-45)(26,-48)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (57,-22)(55,-25)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (58,-24)(56,-27)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (49,18)(50,14)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (52.5,16)(53,13)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (43,-3)(41,-3.5)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (42,-6)(40,-6.5)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (0,27)(3,28)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (25,22)(26,20)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (27,21)(28.5,18)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (10,42)(12,40)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (18,35)(20,38)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (22,42)(25,39)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (32,44)(34,41)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (46,42)(45,41)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (-8,38)(-6.5,34)
  |>outlined (solid 1) (rgb 150 100 50)
  
  ,
  
  line (-5,42)(-6,41)
  |>outlined (solid 1) (rgb 150 100 50)

  ]



cottoncandy = group [

     stick 
  |> addOutline (solid 0.3) black 
  
   ,
  
  candybody
  ,
  
  
  effect 
  |> rotate (degrees -60)
  |> move (-20,-20)
  
  ,
  elec
    ,
    
   effect 
  , 
  elec
  |> move (60,-30)
  |> rotate (degrees 30)
  |> scale 0.7
  
  ,
  
  elec
  |> move (-10,-40)
  |> scale 0.8 
  |> rotate (degrees 20)
  
  ,
  circle 2
  |> filled yellow
  |> move (-10,70)
  |> scaleY 0.5
 
   ,
  circle 2
  |> filled yellow
  |> move (-7,60)
  |> scaleY 0.5
  
     ,
  circle 2
  |> filled yellow
  |> move (-12,60)
  |> scaleY 0.5
 
 
  ]
  
  
  
effect = group [

  curve (-66.10,-7.539) [Pull (-70.37,-12.97) (-65.05,-18.41),Pull (-36.97,-25.18) (-13.50,-14.55),Pull (2.5857,-3.677) (4.0328,21.917),Pull (4.5380,27.507) (-0.876,27.178),Pull (-2.104,31.035) (-3.331,34.893),Pull (12.492,26.063) (5.4356,-0.526),Pull (-21.06,-39.23) (-65.05,-19.11)]
   |> filled (radialGradient [ stop blue 0, stop white 50, stop blue 100])
  |> move (0,0)

  ]

elec = group [
  
  curve (-69.26,17.709) [Pull (-72.24,7.0136) (-75.22,-3.682),Pull (-70.83,-2.980) (-66.45,-2.279),Pull (-68.73,-9.819) (-71.01,-17.35),Pull (-66.45,-8.241) (-61.89,0.8767),Pull (-65.05,1.5780) (-68.20,2.2794),Pull (-68.55,9.8191) (-68.90,17.358)]
  |> filled yellow
  |> rotate (degrees -20) 
  |> addOutline (solid 1) black 
 
  
  
  ]
candybody = group [
    curve (-26.12,-41.20) [Pull (-17.76,-42.47) (-12.8,-40.15),Pull (-16.30,-37.17) (-19.81,-34.19),Pull (-22.96,-37.69) (-26.12,-41.20)]
  |> filled (gradient [ stop blue 0, stop (hsl (degrees 180) 0.576 0.893) 50, stop blue 100])
  |> addOutline (solid 1) black 
  
  
  ,
  
  curve (-20.51,-40.15) [Pull (-12.09,-42.08) (-3.682,-42.60),Pull (-1.578,-39.92) (0.5260,-38.04),Pull (1.7073,-34.69) (1.9287,-31.73),Pull (-0.084,-28.13) (-1.578,-24.72),Pull (-1.052,-20.33) (-0.526,-15.95),Pull (-0.198,-10.34) (1.9287,-4.734),Pull (3.9515,-4.852) (4.7342,-3.331),Pull (2.9808,-0.542) (1.2273,0.5260),Pull (2.6167,9.3997) (0.5260,14.553),Pull (0.1753,19.463) (-0.175,24.372),Pull (-3.167,36.304) (-12.8,41.556),Pull (-27.17,49.258) (-41.55,44.361),Pull (-46.15,38.768) (-53.47,36.295),Pull (-59.64,31.748) (-60.84,23.320),Pull (-66.82,11.973) (-66.80,-4.734),Pull (-63.32,-9.983) (-65.40,-14.55),Pull (-63.52,-22.49) (-65.40,-31.03),Pull (-58.32,-39.83) (-46.81,-42.95),Pull (-38.92,-41.64) (-32.78,-43.66),Pull (-25.07,-43.87) (-20.51,-41.20)]
  |> filled (gradient [ stop blue 0, stop (hsl (degrees 180) 0.576 0.893) 50, stop blue 100])
  |> addOutline (solid 1) black 
  
  

 
    ]
    

stick = group [

    rectangle 2 10
    |> filled brown
    |> scale 2
    |> move (-33,-50)
    
    ,
       rectangle 2 10
    |> filled (hsl (degrees 20) 0.343 0.387)
    |> scale 2
    |> scaleY 0.5
    |> move (-33,-43)
    
    ]

turnip = group [
    curve (-27.71,-2.682) [Pull (-24.50,-0.175) (-21.29,2.0509),Pull (-15.05,2.2591) (-6.573,-0.052),Pull (0.8563,-1.440) (5.2062,2.0509),Pull (7.7002,3.1855) (6.9942,7.5201),Pull (5.7711,11.336) (9.3081,11.832),Pull (14.150,13.680) (15.513,19.089),Pull (16.535,21.847) (15.198,25.084),Pull (10.928,28.877) (4.2596,28.029),Pull (-0.217,26.931) (-3.733,24.874),Pull (-12.72,19.036) (-21.71,13.199),Pull (-24.03,8.5955) (-23.50,5.3114),Pull (-26.37,2.1671) (-30.44,0.2629),Pull (-30.92,-1.314) (-31.39,-2.892),Pull (-30.18,-2.944) (-27.71,-2.682)]
      |> filled (rgb 84 189 37)
  , curve (-39.91,5.2062) [Pull (-41.80,4.7855) (-43.70,4.3648),Pull (-43.43,6.2054) (-43.17,8.0460),Pull (-43.17,8.0460) (-43.17,8.0460),Pull (-41.66,11.884) (-41.28,15.723),Pull (-44.96,22.254) (-50.64,28.345),Pull (-53.76,33.949) (-52.32,39.914),Pull (-51.76,41.667) (-50.64,42.859),Pull (-50.30,43.720) (-46.85,43.700),Pull (-42.93,43.316) (-43.17,47.171),Pull (-42.10,53.899) (-37.70,56.427),Pull (-34.87,58.674) (-32.97,59.161),Pull (-28.43,60.481) (-25.82,56.322),Pull (-23.44,52.495) (-23.82,45.909),Pull (-29.87,31.237) (-35.91,16.565),Pull (-37.13,15.280) (-38.75,14.356),Pull (-39.57,9.9391) (-39.91,5.2062)]
      |> filled (rgb 84 189 37)
  , curve (-46.50,22.755) [Pull (-44.23,27.662) (-43.80,32.568),Pull (-42.54,38.757) (-38.4,41.386),Pull (-31.17,47.526) (-29.58,59.306),Pull (-24.38,57.308) (-23.75,50.631),Pull (-29.65,33.351) (-35.55,16.071),Pull (-36.69,15.36) (-37.83,14.648),Pull (-40.52,15.644) (-46.50,22.755)]
      |> filled (rgb 27 148 7)
  , curve (0.9955,26.595) [Pull (-4.186,21.537) (-6.968,14.08),Pull (-11.87,10.808) (-16.78,7.5377),Pull (-12.01,8.7022) (-7.253,8.1066),Pull (-10.52,5.5088) (-15.36,4.5511),Pull (-11.30,4.5488) (-5.688,2.9866),Pull (-1.317,2.9066) (2.1333,4.2666),Pull (5.0444,5.6733) (4.8355,10.24),Pull (4.8400,13.971) (9.2444,14.222),Pull (15.444,16.900) (15.644,24.177),Pull (16.908,22.328) (16.213,20.48),Pull (15.531,16.491) (13.368,14.222),Pull (11.524,12.380) (8.96,11.377),Pull (6.3644,10.737) (6.9688,7.5377),Pull (7.2799,1.9422) (3.2711,0.4266),Pull (-4.635,-2.422) (-14.22,1.8488),Pull (-18.89,3.1111) (-21.33,2.1333),Pull (-22.18,3.9111) (-23.04,5.6888),Pull (-24.05,9.5266) (-21.47,13.084),Pull (-17.63,20.124) (-13.79,27.164),Pull (-7.466,26.880) (0.9955,26.595)]
      |> filled (rgb 27 148 7)
  , curve (-39.39,6.4) [Pull (-38.52,12.871) (-37.40,19.342),Pull (-36.50,29.653) (-34.84,39.964),Pull (-32.42,41.813) (-30.00,43.662),Pull (-32.28,42.297) (-34.56,41.813),Pull (-30.99,48.924) (-30.15,56.035),Pull (-31.66,48.924) (-35.41,41.813),Pull (-35.63,43.662) (-36.26,45.511),Pull (-35.69,42.453) (-35.84,39.395),Pull (-38.04,35.768) (-40.24,32.142),Pull (-41.25,35.697) (-43.94,39.253),Pull (-41.71,35.600) (-40.67,31.146),Pull (-38.59,28.515) (-39.96,25.884),Pull (-42.01,29.375) (-45.79,31.146),Pull (-41.58,28.373) (-40.24,23.04),Pull (-40.40,15.573) (-43.52,8.1066),Pull (-43.23,5.6177) (-42.95,3.1288),Pull (-41.6,4.8355) (-39.39,6.4)]
      |> filled (rgb 190 228 82)      
  , curve (-35.91,5.9424) [Pull (-33.23,10.462) (-28.02,12.463),Pull (-22.82,13.329) (-17.61,13.515),Pull (-12.36,14.508) (-11.51,20.141),Pull (-12.01,23.956) (-8.361,23.612),Pull (-1.661,22.972) (0.1577,27.293),Pull (2.3265,29.594) (1.7354,34.655),Pull (0.7932,36.375) (-0.788,37.495),Pull (-2.631,39.178) (-0.473,40.861),Pull (4.4554,44.719) (3.9441,51.378),Pull (2.6043,55.945) (-1.735,56.953),Pull (-6.836,58.919) (-11.93,56.006),Pull (-15.06,54.808) (-16.67,52.009),Pull (-17.56,47.517) (-20.77,49.064),Pull (-23.65,49.942) (-26.97,49.380),Pull (-30.47,47.715) (-30.13,43.490),Pull (-29.75,39.619) (-32.97,39.388),Pull (-37.94,38.945) (-39.59,35.181),Pull (-41.78,28.713) (-38.65,22.244),Pull (-36.29,17.180) (-35.81,14.356),Pull (-37.60,10.198) (-39.38,7.5201),Pull (-39.38,6.2580) (-39.38,4.9958),Pull (-38.12,4.6803) (-35.91,5.9424)]
      |> filled (rgb 146 225 72)
  , curve (-36.69,4.9777) [Pull (-31.87,14.993) (-27.02,19.768),Pull (-22.74,21.888) (-16.78,22.328),Pull (-21.44,23.457) (-27.30,20.906),Pull (-24.88,25.382) (-20.62,28.017),Pull (-14.32,32.235) (-4.551,31.573),Pull (-13.30,33.526) (-20.90,29.44),Pull (-18.11,33.773) (-14.64,37.546),Pull (-12.03,40.328) (-7.822,41.671),Pull (-8.622,42.037) (-11.66,41.244),Pull (-4.371,48.193) (-1.28,53.902),Pull (-6.215,47.775) (-12.23,42.808),Pull (-12.37,45.084) (-12.8,47.36),Pull (-12.66,44.586) (-13.08,41.813),Pull (-17.12,38.315) (-20.76,34.417),Pull (-19.08,40.746) (-22.04,45.795),Pull (-19.76,40.113) (-21.47,33.991),Pull (-23.58,29.937) (-27.73,25.884),Pull (-27.24,30.177) (-29.86,33.991),Pull (-27.99,30.159) (-28.44,24.888),Pull (-30.02,22.115) (-32,19.342),Pull (-33.65,16.924) (-34.98,14.506),Pull (-36.59,10.808) (-38.68,7.1111),Pull (-39.04,5.3333) (-39.39,3.5555),Pull (-38.18,3.9822) (-36.69,4.9777)]
      |> filled (rgb 242 242 202)
  , curve (-26.59,-2.844) [Pull (-20.57,3.4400) (-12.8,7.9644),Pull (-6.768,8.6288) (0.1422,5.9733),Pull (-4.275,9.3666) (-12.37,8.96),Pull (-8.137,11.957) (-2.702,13.795),Pull (1.5644,13.795) (5.8311,13.795),Pull (2.3555,14.715) (-1.28,15.075),Pull (8.1088,18.142) (15.217,23.608),Pull (8.2266,19.086) (-0.284,16.924),Pull (0.7822,18.488) (1.8488,20.053),Pull (0.3333,18.133) (-1.422,16.213),Pull (-7.659,14.059) (-12.65,10.666),Pull (-15.18,9.8911) (-17.35,8.6755),Pull (-11.11,14.706) (-7.111,22.897),Pull (-12.14,14.864) (-18.77,8.3911),Pull (-24.08,4.5977) (-28.87,0.2844),Pull (-31.28,-0.924) (-33.70,-2.133),Pull (-31.07,-2.844) (-26.59,-2.844)]
      |> filled (rgb 242 242 202)
  
  -- turnip   
  , curve (-64.11,8.5296) [Pull (-56.07,10.179) (-48.04,9.1900),Pull (-36.43,7.3827) (-29.55,0.9355),Pull (-21.93,-4.518) (-17.88,-13.37),Pull (-13.32,-21.59) (-16.89,-31.97),Pull (-21.04,-41.34) (-30.43,-46.39),Pull (-38.94,-50.74) (-51.01,-49.14),Pull (-55.54,-48.51) (-60.91,-48.04),Pull (-65.35,-48.77) (-67.30,-51.78),Pull (-69.84,-54.78) (-73.90,-55.74),Pull (-75.82,-55.77) (-76.65,-54.75),Pull (-72.00,-55.64) (-69.39,-49.69),Pull (-67.70,-46.10) (-70.49,-41.87),Pull (-76.37,-35.43) (-80.17,-28.56),Pull (-85.29,-18.21) (-82.93,-9.630),Pull (-80.52,-1.986) (-75.00,2.6964),Pull (-70.27,6.7977) (-64.11,8.5296)]
      |> filled (rgb 124 26 79)
  , curve (-57.89,7.9357) [Pull (-53.20,2.0553) (-48.52,-3.825),Pull (-40.42,-5.823) (-32.31,-7.821),Pull (-28.16,-7.073) (-24.01,-6.324),Pull (-27.24,-1.884) (-32.80,2.0368),Pull (-38.45,5.7313) (-45.66,7.8257),Pull (-51.02,8.5202) (-57.89,7.9357)]
      |> filled (rgb 193 28 135)
  , curve (-79.43,-26.71) [Pull (-64.94,-31.58) (-50.46,-36.45),Pull (-51.29,-39.89) (-52.12,-43.33),Pull (-56.63,-43.05) (-61.15,-44.52),Pull (-65.07,-46.18) (-67.32,-49.51),Pull (-68.78,-52.94) (-71.83,-54.73),Pull (-75.11,-56.09) (-76.58,-54.50),Pull (-70.29,-56.29) (-68.03,-47.37),Pull (-68.73,-41.86) (-71.36,-38.35),Pull (-77.25,-32.53) (-79.43,-26.71)]
      |> filled (rgb 193 28 135)
  , curve (-43.74,-1.705) [Pull (-36.01,-5.027) (-27.57,-6.108),Pull (-25.81,-11.83) (-25.58,-17.55),Pull (-26.45,-27.99) (-31.75,-33.84),Pull (-37.48,-40.47) (-46.50,-42.86),Pull (-49.19,-43.59) (-51.89,-43.52),Pull (-59.97,-42.12) (-67.30,-37.36),Pull (-73.93,-33.70) (-77.97,-28.89),Pull (-82.38,-22.53) (-82.60,-15.13),Pull (-70.10,-15.07) (-57.61,-15.02),Pull (-50.73,-8.419) (-43.74,-1.705)]
      |> filled (rgb 209 71 148)
  , curve (-57.28,8.0894) [Pull (-51.42,2.7967) (-43.52,-1.815),Pull (-49.25,-9.899) (-57.50,-15.46),Pull (-64.02,-18.85) (-71.26,-18.76),Pull (-78.08,-18.21) (-82.26,-15.35),Pull (-81.29,-7.294) (-77.75,-2.476),Pull (-73.84,2.4458) (-67.85,5.4479),Pull (-63.47,7.4336) (-57.28,8.0894)]
      |> filled (rgb 226 127 182) 
  , curve (-60.51,-3.025) [Pull (-50.28,-9.801) (-39.16,-12.61),Pull (-53.21,-14.27) (-60.51,-3.025)]
      |> filled (rgb 196 27 132)
  , curve (-76.16,-0.628) [Pull (-71.95,-5.595) (-65.54,-10.56),Pull (-76.01,-9.200) (-76.16,-0.628)]
      |> filled (rgb 196 27 132)
  , curve (-43.38,-19.58) [Pull (-30.04,-22.91) (-19.86,-19.01),Pull (-19.35,-21.12) (-19.75,-23.23),Pull (-35.60,-27.05) (-43.38,-19.58)]
      |> filled (rgb 196 27 132)
  , curve (-66.22,-15.01) [Pull (-56.07,-20.17) (-45.33,-24.60),Pull (-56.73,-25.60) (-66.22,-15.01)]
      |> filled (rgb 196 27 132)
  , curve (-80.38,-15.47) [Pull (-71.47,-20.96) (-62.57,-27.46),Pull (-78.90,-23.46) (-80.38,-15.47)]
      |> filled (rgb 196 27 132)
  , curve (-52.75,-33.96) [Pull (-40.78,-40.29) (-31.74,-40.93),Pull (-33.06,-42.69) (-35.62,-43.21),Pull (-46.69,-41.67) (-52.75,-33.96)]
      |> filled (rgb 196 27 132)
      |> move (1, 0)    
  , curve (-31.09,0.8254) [Pull (-31.12,-2.201) (-32.19,-5.227),Pull (-29.93,-6.128) (-27.68,-6.108),Pull (-24.69,-13.59) (-25.91,-21.07),Pull (-26.82,-27.07) (-29.44,-30.76),Pull (-33.07,-36.53) (-38.79,-39.78),Pull (-43.96,-42.73) (-50.13,-43.52),Pull (-56.95,-43.39) (-61.68,-45.06),Pull (-64.94,-46.24) (-66.75,-48.70),Pull (-57.61,-45.73) (-48.48,-46.72),Pull (-39.51,-44.79) (-30.54,-42.86),Pull (-24.92,-35.05) (-19.31,-27.23),Pull (-18.93,-22.28) (-18.54,-17.33),Pull (-21.29,-11.94) (-24.04,-6.548),Pull (-27.01,-2.286) (-31.09,0.8254)]
      |> filled (rgb 124 26 79)
      |> makeTransparent 0.5
  , curve (-48.52,-46.86) [Pull (-42.00,-48.46) (-34.56,-46.37),Pull (-28.98,-44.57) (-23.92,-39.89),Pull (-19.98,-35.89) (-17.68,-29.73),Pull (-15.90,-23.50) (-18.29,-16.39),Pull (-19.99,-11.16) (-24.04,-6.485),Pull (-19.60,-13.70) (-19.76,-20.92),Pull (-19.87,-26.60) (-22.69,-31.57),Pull (-25.22,-36.02) (-28.94,-39.28),Pull (-34.07,-43.58) (-41.05,-46.01),Pull (-44.78,-46.71) (-48.52,-46.86)]
      |> filled (rgb 227 128 185)

  ]

rainbowPretzel = group [
 curve (-4.562,34.598) [Pull (-10.74,41.467) (-19.77,45.497),Pull (-30.44,49.929) (-40.04,42.962),Pull (-51.96,34.014) (-48.91,13.306),Pull (-47.14,0.0277) (-42.32,-9.251),Pull (-33.79,-2.929) (-23.82,-3.168),Pull (-31.24,6.5706) (-32.19,18.629),Pull (-33.33,27.719) (-27.88,29.528),Pull (-21.09,31.705) (-14.70,18.122),Pull (-4.488,4.0841) (6.8435,-2.154),Pull (12.403,8.6314) (5.3227,20.657),Pull (-2.459,32.767) (-4.562,33.837) ]
 |> filled (gradient [ stop red 0, stop green 50, stop blue 100])
 
 ,
 
 curve (-13.98,16.881) [Pull (-18.93,4.2474) (-10.96,-7.307),Pull (0.3496,-14.61) (17.259,-22.67),Pull (23.351,-25.74) (25.322,-29.73),Pull (26.388,-32.34) (28.094,-33.51),Pull (32.162,-34.75) (35.149,-33.00),Pull (39.243,-30.70) (37.417,-25.44),Pull (31.908,-9.420) (16,-6.551),Pull (7.1251,-4.221) (-3.149,4.7874),Pull (-8.186,10.862) (-13.98,16.377)]
 |> filled (radialGradient [ stop red 0, stop green 50, stop blue 100])
 |> move (0,1)
 ,
 
 curve (-14.42,-1.983) [Pull (-17.16,-4.404) (-21.27,-3.785),Pull (-40.67,-2.735) (-46.15,-15.68),Pull (-47.51,-17.78) (-47.23,-21.45),Pull (-43.98,-24.15) (-40.74,-26.86),Pull (-29.90,-17.49) (-17.30,-16.40),Pull (-6.995,-14.26) (-2.523,-12.43),Pull (-11.41,-8.771) (-14.42,-2.343)]
 |> filled (gradient [ stop red 0, stop green 50, stop blue 100])
 |> scale 1.2
 |> move (3,2.5)
 
 ,
  
 curve (-5.408,34.794) [Pull (0.0005,26.381) (6.1295,18.929),Pull (11.382,33.038) (22.715,30.467),Pull (30.099,27.738) (28.484,18.929),Pull (23.533,4.5304) (14.422,-5.588),Pull (27.456,-7.177) (32.811,-16.40),Pull (42.001,-0.116) (46.512,20.732),Pull (45.360,40.011) (30.647,45.611),Pull (19.530,51.551) (8.2929,46.332),Pull (0.0022,41.662) (-5.408,34.073)]
 |> filled (gradient [ stop red 0, stop green 50, stop blue 100])
 
 ,
 curve (-36.05,-23.61) [Pull (-29.10,-17.49) (-17.30,-16.40),Pull (-14.23,-21.63) (-7.571,-22.89),Pull (1.9605,-23.53) (8.2929,-18.56),Pull (20.885,-19.99) (24.157,-27.94),Pull (13.838,-38.99) (0,-41.64),Pull (-11.23,-42.70) (-23.07,-36.95),Pull (-31.00,-31.44) (-35.69,-23.97)]
 |> filled (gradient [ stop red 0, stop green 50, stop blue 100])
 |> move (0,2) 
 ]


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
   curve (-4.796,3.4473) [Pull (-34.17,-0.665) (-63.55,-13.93),Pull (-74.30,-16.02) (-74.34,-7.943),Pull (-78.19,13.253) (-72.84,24.730),Pull (-72.55,36.543) (-67.14,43.316),Pull (-63.10,44.416) (-62.35,41.517),Pull (-31.77,28.638) (-4.796,3.4473)]
  |> filled lightBrown
  |> addOutline (solid 1) black -- crust
  ,
  curve (-6.295,3.7470) [Pull (0.4496,5.6955) (7.1943,7.6440),Pull (-9.892,11.840) (-26.97,16.037),Pull (-16.48,9.7423) (-6.295,3.7470)]
  |> filled lightBrown -- crust
  ,
  curve (-5.395,3.4473) [Pull (-4.346,3.8969) (-3.297,4.3466)]
  |> outlined (solid 1) black
  ,
  curve (-60.55,40.318) [Pull (-71.30,19.146) (-66.24,-5.545),Pull (-64,-5.235) (-61.75,-5.845),Pull (-62.04,-13.18) (-61.45,-20.53),Pull (-58.99,-25.33) (-58.45,-18.73),Pull (-59.71,-11.65) (-59.05,-5.845),Pull (-56.92,-4.086) (-52.75,-4.046),Pull (-46.53,-0.479) (-39.26,2.2482),Pull (-32.59,2.8574) (-26.67,4.3466),Pull (-22.42,6.1355) (-17.08,7.0444),Pull (-10.03,6.6640) (-3.896,8.2435),Pull (-2.487,3.9691) (-2.997,-6.145),Pull (-2.568,-7.584) (-0.899,-7.344),Pull (1.5807,-3.868) (-0.899,3.4473),Pull (0.3195,4.3576) (2.0983,2.5480),Pull (4.0675,2.5567) (4.1967,5.8454),Pull (7.8447,4.9748) (9.2927,7.3442),Pull (-13.38,32.772) (-42.86,37.920),Pull (-52.00,40.339) (-60.55,40.318)]
  |> filled lightYellow
  |> addOutline (solid 1) black -- cheese
  ,
  curve (-56.35,12.140) [Pull (-48.37,13.208) (-48.56,17.836),Pull (-51.15,22.705) (-60.55,20.533),Pull (-66.86,14.297) (-56.35,12.140)]
  |> filled lightRed
  |> addOutline (solid 1) red -- p
  ,
  curve (-56.35,12.140) [Pull (-48.37,13.208) (-48.56,17.836),Pull (-51.15,22.705) (-60.55,20.533),Pull (-66.86,14.297) (-56.35,12.140)]
  |> filled lightRed
  |> addOutline (solid 1) red -- p
  |> move (23,-5)
  ,
  curve (-18.58,16.337) [Pull (-17.73,19.825) (-13.48,20.234),Pull (-7.701,20.755) (-7.194,16.037),Pull (-13.08,9.6673) (-18.58,16.337)]
  |> filled lightRed
  |> addOutline (solid 1) red -- p
  ,
  curve (-18.58,16.337) [Pull (-17.73,19.825) (-13.48,20.234),Pull (-7.701,20.755) (-7.194,16.037),Pull (-13.08,9.6673) (-18.58,16.337)]
  |> filled lightRed
  |> addOutline (solid 1) red -- p
  |> move (-15,7.6)
  ,
  curve (-18.58,16.337) [Pull (-17.73,19.825) (-13.48,20.234),Pull (-7.701,20.755) (-7.194,16.037),Pull (-13.08,9.6673) (-18.58,16.337)]
  |> filled lightRed
  |> addOutline (solid 1) red -- p
  |> move (-35,10)

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


carrott = group [carrot_top
    |> scale 0.7
    |> move (0,12)
    ,
    carrot2]

carrot_top = group [carrotTop 
 |> move (-13,15)
 |> rotate (degrees 14)
 ,
 carrotTop 
 ,
 carrotTop 
 |> move (-2,15)
 |> rotate (degrees 14)]
 
carrotTop = group [
 curve (-47.58,14.129) [Pull (-48.88,20.353) (-53.81,22.857),Pull (-55.52,30.434) (-45.50,29.090),Pull (-40.64,32.557) (-44.25,39.064),Pull (-45.29,47.149) (-37.81,44.113),Pull (-34.39,43.994) (-33.61,47.474),Pull (-31.98,53.455) (-24.92,53.916),Pull (-17.52,51.534) (-23.24,38.512),Pull (-17.20,37.831) (-16.80,34.030),Pull (-17.70,29.629) (-25.48,25.067),Pull (-26.52,21.626) (-23.80,18.905),Pull (-19.22,12.664) (-26.88,10.223),Pull (-31.10,12.003) (-33.61,9.1028),Pull (-40.09,15.603) (-47.89,13.584)]
  |> filled green -- top body 
  |> addOutline (solid 2) black 
  ,
  curve (-42.85,13.304) [Pull (-42.01,14.984) (-41.17,16.665),Pull (-44.11,19.606) (-47.05,22.547),Pull (-43.13,21.006) (-39.21,19.466),Pull (-36.97,24.787) (-34.73,30.109),Pull (-36.83,34.590) (-38.93,39.072),Pull (-36.41,35.150) (-33.89,31.229),Pull (-31.64,36.971) (-29.40,42.713),Pull (-31.08,37.251) (-32.77,31.789),Pull (-29.12,32.490) (-25.48,33.750),Pull (-29.54,31.509) (-33.61,29.269),Pull (-35.15,25.347) (-36.69,21.426),Pull (-32.49,22.126) (-28.28,20.306),Pull (-33.19,20.886) (-36.97,19.466),Pull (-38.51,15.404) (-40.05,11.343),Pull (-41.73,11.763) (-43.41,12.183),Pull (-43.41,12.323) (-43.41,12.463)]
  |> filled darkGreen
  |> move (1,1)
 ,
 -- shadow dark 
 curve (-51.81,21.706) [Pull (-50.81,26.407) (-44.53,25.067),Pull (-41.37,25.248) (-41.73,27.308),Pull (-40.71,28.169) (-42.57,32.350),Pull (-45.53,29.149) (-50.69,28.428),Pull (-57.19,25.887) (-51.81,21.706)]
 |> filled darkGreen
 , 
 curve (-42.85,35.991) [Pull (-43.23,41.012) (-39.21,41.592),Pull (-35.87,41.192) (-33.89,40.192),Pull (-32.68,45.873) (-28.28,48.315),Pull (-25.76,50.515) (-22.40,49.155),Pull (-24.60,57.495) (-32.49,50.835),Pull (-33.89,46.954) (-36.13,43.833),Pull (-41.51,46.333) (-42.85,44.673),Pull (-45.75,43.092) (-42.85,35.150)]
 |> filled darkGreen 
 |> move (1,1)
 ,
 curve (-42.29,26.748) [Pull (-39.87,31.050) (-42.29,40.192),Pull (-42.03,33.930) (-43.97,29.269),Pull (-43.27,27.728) (-42.57,26.188)]
 |> filled darkGreen
 |> scale 1.2
 |> move (15,  3)
 |> rotate (degrees 10)
 ,
 -- shadow light 
 curve (-20.16,37.111) [Pull (-19.86,31.330) (-26.60,30.109),Pull (-28.52,24.928) (-26.88,23.387),Pull (-25.62,25.347) (-24.36,27.308),Pull (-15.28,32.290) (-19.32,37.111)]
 |> filled lightGreen
  ,
 curve (-48.45,15.544) [Pull (-44.09,16.344) (-35.01,12.463),Pull (-33.61,13.584) (-32.21,14.704),Pull (-26.76,12.865) (-23.52,17.785),Pull (-21.70,15.364) (-24.64,11.063),Pull (-30.02,12.143) (-35.01,8.8227),Pull (-42.61,14.243) (-48.45,12.463),Pull (-48.73,14.004) (-49.01,15.544)]
 |> filled lightGreen
 |> move (-3,1)
 |> scale 0.9
 ,
 curve (-43.55,12.463) [Pull (-45.37,9.1028) (-47.19,5.7417),Pull (-44.95,4.6214) (-42.71,3.5010),Pull (-40.75,8.5426) (-38.79,13.584),Pull (-40.19,14.284) (-41.59,14.984),Pull (-42.57,13.584) (-43.55,12.183)]
 |> filled lightGreen 
 ]

carrot2 = group [  curve (-40.16,20.833) [Pull (-33.72,22.273) (-27.27,20.833),Pull (-15.98,15.816) (-20.68,-10.64),Pull (-22.91,-31.25) (-28.17,-40.01),Pull (-31.77,-44.66) (-35.37,-39.71),Pull (-44.20,-25.48) (-48.56,-11.24),Pull (-54.34,17.256) (-40.16,20.833)]
  |> filled orange
  ,
  curve (-36.57,-34.02) [Pull (-35.07,-32.67) (-33.57,-33.72)]
  |> outlined (solid 0.5) black
  ,
  curve (-30.27,-28.62) [Pull (-28.02,-27.74) (-25.77,-28.62)]
  |> outlined (solid 0.5) black
  ,
  curve (-46.16,-15.73) [Pull (-44.48,-21.73) (-41.36,-27.72),Pull (-42.20,-21.58) (-44.96,-15.43),Pull (-51.37,12.639) (-39.86,17.836),Pull (-37.91,20.175) (-40.76,19.634),Pull (-54.18,15.238) (-46.16,-15.73)]
  |> filled lightOrange
  ,
  curve (-42.26,-23.83) [Pull (-38.07,-22.11) (-33.87,-22.63)]
  |> outlined (solid 0.5) black
  ,
  curve (-27.87,-15.43) [Pull (-25.77,-14.39) (-23.68,-15.43)]
  |> outlined (solid 0.5) black  
  ,
  curve (-45.56,-13.93) [Pull (-43.16,-12.29) (-40.76,-12.74)]
  |> outlined (solid 0.5) black 
  ,
  curve (-34.77,-7.644) [Pull (-31.92,-5.974) (-29.07,-7.344)]
  |> outlined (solid 0.5) black  
  ,
  curve (-44.36,-0.749) [Pull (-42.41,0.1204) (-40.46,-0.449)]
  |> outlined (solid 0.5) black 
  ,
  curve (-30.57,0.7494) [Pull (-26.37,2.0091) (-22.18,1.3489)]
  |> outlined (solid 0.5) black 
  ,
  curve (-35.37,7.6440) [Pull (-31.77,9.5437) (-28.17,8.2435)]
  |> outlined (solid 0.5) black 
  ,
  curve (-40.46,12.740) [Pull (-43.31,13.710) (-46.16,12.440)]
  |> outlined (solid 0.5) black 
  ,
  curve (-32.37,17.236) [Pull (-29.52,18.556) (-26.67,18.435)]
  |> outlined (solid 0.5) black ]

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
 
apple = 
  group 
  [
  curve (-39.56,25.929) [Pull (-17.23,33.030) (-6.295,24.730),Pull (11.649,9.0941) (8.3934,-9.742),Pull (5.8498,-29.77) (-8.093,-42.41),Pull (-14.98,-49.21) (-21.88,-49.61),Pull (-29.37,-49.86) (-36.87,-48.71),Pull (-40.31,-48.26) (-43.76,-49.01),Pull (-48.11,-50.11) (-52.45,-49.01),Pull (-55.90,-47.81) (-59.35,-45.41),Pull (-71.84,-34.57) (-76.74,-20.53),Pull (-82.99,-2.497) (-75.84,13.939),Pull (-70.64,25.083) (-59.05,28.627),Pull (-54.85,29.728) (-46.46,26.829),Pull (-43.01,25.829) (-39.56,25.929)]
  |> filled (gradient [stop (rgb 201 52 50) -120 , stop (rgb 184 91 91) -80, stop (rgb 242 5 5) -40 , stop (rgb 163 45 45) 30 , stop (rgb 133 11 11) 40]) 
  
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