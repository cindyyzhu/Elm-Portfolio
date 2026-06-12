module BlowTorch exposing (..)

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
    -- often helpful to start with a circle centered at (0,0) to position you image before tracing
     blowtorch
    ]

blowtorch = group
 [
  outerRect --body
 |>addOutline (solid 4 ) black
 ,
 rect 31 42 --inside rect
 |>filled white
 |>addOutline (solid 1 ) black
 |>move(11,-26)
 ,
 curve (25.5, -18.2) [Pull (13.1, -7.5) (19.7, -20.6), Pull (8.3, -39.9) (25.4, -39.2)]
 |>filled (gradient [ stop red 10 , stop (hsl (degrees 31) 0.941 0.574) 100])
 |>addOutline (solid 1 ) black --fire
 |>move(0.5,0)
 ,
 rect 22 7 --neck
 |>filled black
 |>addOutline (solid 1 ) black
 |>move(7,18)
 ,
 rect 12 7--neck2
 |>filled (hsl (degrees 0) 0.002 0.528)
 |>addOutline (solid 1 ) black
 |>move(7,25)
 ,
  rect 8 9
 |>filled (hsl (degrees 0) 0.002 0.528)
 |>addOutline (solid 1 ) black
 |>move(-16,37)
 ,
  rect 26 11
 |>filled (hsl (degrees 0) 0.002 0.528)
 |>addOutline (solid 1 ) black
 |>move(40,37)
 ,
  rect 4 11
 |>filled black
 |>move(51,37)
 ,
 
 outerRect --top
  |>scaleX 0.4
  |>scaleY 0.6
 |>rotate (degrees 90)
 |>addOutline (solid 4 ) black
 |>move(-5,34)
 

 
 
 ]
outerRect = group 
 [
 rect 39 55
 |>filled red
  |>move(7,-26)
 ,
 wedge 15 0.5
 |>filled red
 |>rotate (degrees 90)
 |>scaleX 1.3
 |>move(7,-1)
 
 ] 