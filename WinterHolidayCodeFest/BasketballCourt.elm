module WinterHolidayCodeFest.BasketballCourt exposing (..)
import GraphicSVG exposing (..)
pair = (myShapes, word)
-- 1. type your word in between the ""s
word = "basketball"

-- 2. draw your word using Shapes
myShapes t = 
  [
   rect 100 100 --Wall
    |> filled gray
  , rect 100 35 --Floor/Court
    |> filled (hsl (degrees 50) 0.771 0.693)
    |> move (0, -32)
  ,   rect 3 40 -- backboard
    |> filled (rgb 255 255 255)
    |> move (48, 20)
  , ball
     |> move (parabola (repeat t))
  , roundedRect 28 2 1
    |> filled orange
    |> move (33, 8)
  , roundedRect 28 2 1
    |> filled white
    |> move (2, -43)
    |> rotate (degrees 80)
  , roundedRect 28 2 1
    |> filled white
    |> move (-11, -22)
    |> rotate (degrees 105)
  , roundedRect 28 2 1
    |> filled white
    |> move (0, -31)
    |> rotate (degrees 80)
  , roundedRect 28 2 1
    |> filled white
    |> move (-15.5, -33.5)
    |> rotate (degrees 105)
  , roundedRect 28 2 1
    |> filled white
    |> move (-13, -27)
    |> rotate (degrees 105)
  , roundedRect 28 2 1
    |> filled white
    |> move (0.5, -37.5)
    |> rotate (degrees 80)
  , roundedRect 17 2 1
    |> filled white
    |> move (34, -18)
  ]

repeat t = t -- input time
         - 14 * toFloat (floor (t / 14))
         -- highest multiple of 15 < t

parabola t = ( vX * t
             , initialY + initialVy * t + gravity * t*t
             )

gravity   = -1.3
initialVy = 17.8
initialY  = 0
vX = 5


ball =
  [ circle 10 --Ball
    |> filled orange
    |> move (-30, -10)
  ,   rect 1 20
    |> filled black
    |> move (-30, -10)
  , rect 1 20
    |> filled black
    |> move (-10, 30)
    |> rotate (degrees 90)
  , rect 1 20
    |> filled black
    |> move (-28, 14)
    |> rotate (degrees 45)
  , rect 1 20
    |> filled black
    |> move (14, 28.5)
    |> rotate (degrees 135)
  ]
    |> group

pair = (myShapes, word)

