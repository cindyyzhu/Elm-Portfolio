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

plotGraph f t =
  List.range 0 100
    |> List.map (\i -> 
        let x = toFloat i * 0.1 - 5
        in (x * 10, f (x + t) * 10))
    |> openPolygon
    |> outlined (solid 0.5) black


type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

init = { time = 0 }

update msg model =
  case msg of
    Tick t _ -> { model | time = t }

view model = collage 192 128 (myShapes model)

main = gameApp Tick { model = init, view = view, update = update, title = "SinCosTan" }