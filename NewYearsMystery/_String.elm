module String exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

update msg model = case msg of
                     Tick t _ -> { time = t }

init = { time = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

fractionalModBy m x = x - m * toFloat (floor (x / m))

repeatDistance speed start end t =
  start + fractionalModBy (end - start) (speed * t)
  
  -- Your shapes go here!
myShapes model =
  [
    curve (-53.3, -13.4) [Pull (-69.3, 6.5) (-49.1, 23.2), Pull (-32.6, 33.4) (-16.0, 21.4), Pull (-10.6, -1.3) (-28.2, -1.1), Pull (-45.6, 4.4) (-36.9, 19.3), Pull (-14.5, 42.6) (15.0, 17.0), Pull (18.9, 0.5) (30.9, -9.9), Pull (54.1, -15.3) (48.0, 7.9), Pull (28.5, 31.2) (14.4, 5.3), Pull (9.2, -18.5) (-7.3, -19.3), Pull (-19.0, -13.9) (-12.1, -0.4), Pull (10.3, 14.0) (9.7, -27.7)]
  |> outlined (solid 1) black
  ]
