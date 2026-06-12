module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

-- Your shapes go here!
myShapes model =
  [
    {-[ arm
    , [arm
      , arm
        |> rotate (sin (2*model.time))
        -- rotate the last arm
        |> move (-20, 0)
        -- move to the middle arm
      ]
      |> group
      |> rotate (sin (2* model.time))
      -- rotate the middle arm
      |> move (-20, 0)
      -- move to the end of the first arm
    ]
      |> group
      |> rotate (sin model.time) -}
    
    --, 
    -- 360 / # of sides for degrees in order to make different shapes.
    -- degrees 120 for triangle
    -- degrees 90 for square
    -- degrees 72 for pentagon
    -- degrees 60 for hextagon
    -- 0.6 * sin for circle
    
    
    recursiveArm
    [ {-\ t -> (degrees 18)* sin (2*t)
    , \ t -> (degrees 18)* sin (2*t)
    , \ t -> (degrees 18)* sin (2*t)
    , \ t -> (degrees 18)* sin (2*t)
    , \ t -> (degrees 18)* sin (2*t)
    , \ t -> (degrees 18)* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t)
    , \ t -> 0.6* sin (2*t) -}
    
    {--- star code
     \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> sin (2*t)
    , \ t -> -2 * sin (2*t) -}
    
    {--- accordian
      \ t -> 1 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t)
    , \ t -> 2 * sin (2*t)
    , \ t -> -2 * sin (2*t) -}
    
    -- squarish (allows for more sudden movements)
      squarish 
    , squarish 
    , squarish
    , squarish
    , squarish
    , squarish
    , squarish
    , squarish
    , squarish
    , squarish
    {-, squarish
    , squarish
    , squarish
    , squarish -}
    ]
    (model.time * 0.5)
    |> move (10, 0)
    |> scale 0.5
    
    --, plotGraph ( \ t -> sin (2*t)) model.time |> move (0, 50)-- frequency / 2pi --> number being multipled is frequency
    --, plotGraph ( \ t -> sin (4*t)) model.time |> move (0, 30) -- wave length of smth divided by 4
    --, plotGraph ( \ t -> 4 * (sin t + 0.5 * sin (2*t))) model.time |> move (0, 10) -- adding both wavelengths together
    {-, plotGraph ( \ t -> 4 * (sin (2*t) + 0.125 * cos (4*t) + 0.0625 * sin (6*t))) model.time |> move (0, -10) 
    , plotGraph ( \ t -> 4 * (sin (2*t) + 0.125 * cos (4*t) + 0.0625 * sin (6*t) + 0.03125 * sin (8*t))) model.time |> move (0, -30) -}
    --, plotGraph ( \ t -> 4 * (sin t + (1/3) * sin (3*t) + 0.2 * sin (5*t)+ (1/7) * sin (7*t) + (1/9) * sin (9*t) + (1/11) * sin (11*t))) model.time |> move (0, -30) -- based on the fourier series
    , plotGraph squarish model.time |> move (0, -30)
    , heart 
    |> scale 0.25
    |> scale (-0.05*squarish model.time + 1)
    --|> scaleX (0.25 * squarish model.time + 1)
    |> move (50, 30)
  ]

heart = group [
  triangle 40
  |> filled red
  |> rotate (degrees 30)
  |> scaleY 0.66
  
  ,circle 20
  |> filled red
  |> move (17, 23.5)
  
  , circle 20
  |> filled red
  |> move (-17, 23.5)
  ]
  
squarish t = (((sin t)^8 * sin (8*t)*8 + (sin t)^8 * sin (8*t) * 8))

-- slightly odd heartbeat (((sin t)^63 * sin (t + 1.5) * 8))
-- for other more sudden movement of squarish 
--(sin t + (1/3) * sin (3*t) + 0.2 * sin (5*t)+ (1/7) * sin (7*t) + (1/9) * sin (9*t) + (1/11) * sin (11*t)) 
  
-- lesson 1
-- move the rotation point to (0, 0) before rotating

arm = [
  oval 20 4 
  |> filled charcoal
  , circle 2
  |> filled charcoal
  |> move (10, 0)
  ] 
    |> group
    |> move (-10, 0)

recursiveArm linkFunctions = 
  case linkFunctions of -- case says "I have a variable "linkFunctions" and I can break it down"
  -- case says --> I know it's a list because choices are empty list or a list
  -- double colons "::" takes something and adds it to a list
      funl :: moreFuns -> -- 1 thing at the beginning of the list, and then at which point there's going to be an empty list
        \ t -> [ (recursiveArm moreFuns t) -- this draws rest of the arm
                  |> rotate (funl t) -- each time we get a function, we just that function to rotate the rest of the arm
                  |> move (-20, 0) -- put the next arm segment into the right position
                , arm
                ] |> group -- and then group together
      [] ->
        \ t -> arm    -- when there's an empty arm, then you'd draw the arm
        
        -- recursiveArm will keep calling itself until it runs out of arm segments, in which case, it will then start drawing the arm

type Msg = Tick Float GetKeyState

type alias Model = { time : Float }

init = { time = 0 }

update msg model =
  case msg of
    Tick t _ -> { model | time = t }

view model = collage 192 128 (myShapes model)

main = gameApp Tick { model = init, view = view, update = update, title = "Starfish" }

plotGraph f t =
  List.range 0 200
    |> List.map (\i -> 
        let x = toFloat i * 0.1 - 10
        in (x * 10, f (x + t)))
    |> openPolygon
    |> outlined (solid 0.5) black