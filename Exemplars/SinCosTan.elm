module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- Your shapes go here!
myShapes model =
  [
    plotGraph sine (model.time*1) |> move (0, 30) 
    , plotGraph cosine (model.time*1) |> move (0, 0) 
    , plotGraph tangent (model.time*3) |> move (0, -30) |> scale 0.5
    
  ]

sine t = (sin t*15)
cosine t = (cos t*15)
tangent t = (tan t*15)

plotGraph : (Float -> Float) -> Float -> Shape a
plotGraph f time =
  group
    [ openPolygon (List.map (\ t -> (-96+(toFloat t)/2.5 - 200 * toFloat (floor (time / 10)),f (toFloat t / 50))) <| List.range (500 * floor (time / 10)) (500 * ceiling (time / 10))) |> outlined (solid 1) (rgb 0 0 200)
    , group [
              circle 3 |> filled red
            , text ("(" ++ String.fromFloat time ++ ", " ++ String.fromFloat (toFloat (round <| (f time) * 100) / 100)  ++ ")")
                |> size 6
                |> filled black
                |> move (5, 5)
            ]

        |> move (-96+20* time - 200 * toFloat (floor (time / 10)),f (time))
    ]


type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

init = { time = 0 }

update msg model =
  case msg of
    Tick t _ -> { model | time = t }

view model = collage 192 128 (myShapes model)

main = gameApp Tick { model = init, view = view, update = update, title = "SinCosTan" }