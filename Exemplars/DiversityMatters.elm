module DiversityMatters exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

height x = 20 * ( sin (0.2*x) + 2 * cos (0.03*x) )
snowHeight x = 5 + 20 * ( 0.1 * sin (x) + 2 * cos (0.03*x) )
outline = List.range -100 100
     |> List.map ( \ idx -> (toFloat idx, height (toFloat idx)) )
snowLine = List.range -100 100
     |> List.map ( \ idx -> (toFloat idx, snowHeight (toFloat idx)) )
myShapes model =
  [ rect 192 128 |> filled (rgb 106 203 247)
    , outline ++ [(96,-64),(-96,-64)] 
        |> polygon |> filled white
    , outline ++ [(96,-64),(-96,-64)] 
        |> polygon |> filled charcoal
        |> clip 
          ( snowLine ++ [(96, -64), (-96, -64)]
            |> polygon |> filled charcoal
          )
    , outline
       |> openPolygon |> outlined (solid 0.5) black
    --, snowLine
       --|> openPolygon |> outlined (solid 0.5) black
    ]
  ++ ( List.map drawPoint model.points )
      
   
drawPoint x = circle 2 |> filled red |> move (x, height x)
type Msg = Tick Float GetKeyState
type alias Model = 
  { time : Float
  , points : List Float
  }
evolvePoint oldX =
  let
    currentHeight = height oldX
    heightToRight = height (oldX + 0.01)
    deltaHeight = heightToRight - currentHeight
  in
    oldX + deltaHeight
update msg model = case msg of
                     Tick t _ -> { time = t
                                 , points = List.map evolvePoint model.points}
init = { time = 0, points = [ -50, -25, -5, 25, 50 ] }
main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }
view model = collage 192 128 (myShapes model)
