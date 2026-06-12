module Park exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import Skittles
import SashaHoney
import MrTam

import SpeechBubbles exposing (speechBubbleRight, speechBubbleLeft, shantellSansFont) -- Your shapes go here!
type Actor = Robot


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
  

script = 
  [ (Robot,"Oh hey! Looks like you are following Addy.")
  , (Robot, "She was here not too long ago. What did she")
  , (Robot, "do? She played with my dog Skittles and mentioned")
  , (Robot, "that she is working on something for the new year.")
  , (Robot, "No idea what it could be but all I know is that")
  , (Robot, "it is big! She said something about it being")
  , (Robot, "watertight but who knows. She’s definitely an")
  , (Robot, "interesting one. Good luck!")

  ] 

-- Your shapes go here!
myShapes model =
  [
    park model.time
  ]

park t =
  [
    swing t
      |> scale 1.5
      |> move (-50,0)
  , rainbow
      |> scale 3
      |> move (20,30)
  , Skittles.bodyOutline
      |> scale 0.25
      |> move (-30,-20)
  , bench
      |> scale 0.5
      |> move (40,10)
   , MrTam.mrtam
   |> scale 0.75
   |> move (0, 0)
   ,  speechBubbleLeft (solid 0.5) black (shantellSansFont) script 50 Robot (0.8*t)
      |> scale 0.9
      |> move (50,44) 
      
  ]
    |> group

bench =
  [ plankFeet brown
  , plankFeet brown
      |> move (-45, 14)
  , plankFeet brown
      |> move (19, 15)
  , plankFeet brown
      |> move (18.5, 7)
  , plankFeet brown
      |> move (-33.5, 23)
  , plankFeet brown
      |> move (-33, 32)
  , List.range 0 2
      |> List.map 
           ( \ idx -> plank brown |> move (0, 6.5 * toFloat idx) )
      |> group
  , List.range 0 2
      |> List.map 
           ( \ idx -> plank brown |> move ( -3 - 5 * toFloat idx
                                    , -13.5 - 1.9 * toFloat idx) 
           )
      |> group
  ]
    |> group

plank clr =
  [ polygon [(38.7, 2.2), (42.3, 3.9), (41.9, -2.3), (38.0, -3.7), (38.4, 2.6)]
      |> filled (rgb 150 105 0)
  , polygon [(-25.8, 16.3), (-25.8, 21.1), (38.3, 2.1), (38.0, -3.7), (-25.9, 16.3)]
     |> filled (rgb 170 105 0)
  , polygon [(41.8, 3.9), (-21.7, 22.8), (-25.4, 21.1), (38.6, 2.1), (41.9, 3.6)]
     |> filled clr
  ] 
    |> group
   
plankFeet clr =
  [ curve (15.3, -17.8) [Pull (13.4, -17.2) (11.4, -16.7), Pull (10.8, -28.2) (10.2, -39.6), Pull (12.0, -40.4) (13.7, -41.2), Pull (14.4, -29.6) (15.1, -18.0)]
      |> filled (rgb 170 105 0)
  , curve (15.0, -17.7) [Pull (16.6, -18.0) (18.1, -18.3), Pull (17.6, -28.7) (17.1, -39.1), Pull (15.5, -40.0) (13.9, -40.9)]
      |> filled (rgb 150 105 0)
  ] 
    |> group


bar = 1

swing t =
  let
    theta1 = 0.5 * sin t
    chainLength = 15
    chain (x,y) theta = 
      line (x,y) ( x + chainLength*sin theta
                 , y - chainLength*cos theta)
        |> outlined (solid (0.5*bar)) blue      
    oneSwing (x,y) theta character = 
      [ chain (x+1.5,y+4.5) theta
      , line ( x + chainLength*sin theta
             , y - chainLength*cos theta)
             ( x+1.5 + chainLength*sin theta
             , y+4.5 - chainLength*cos theta)
          |> outlined (solid (bar*3)) yellow
      , character
          |> move (0,-chainLength)
          |> rotate theta1
          |> move (x+0.75,y+2.25)
      , chain (x,y) theta
      ]
        |> group
  in
    [
    -- back "A"
    openPolygon [(-10,1),(0,20),(10,-1)]
        |> outlined (solid bar) red
    -- front "A"
    , openPolygon [(-10+5,1+15),(0+5,20+15),(10+5,-1+15)]
        |> outlined (solid bar) red
    -- top bar
    , line (0,20) (0+5,20+15) |> outlined (solid bar) red
    --swings
    , oneSwing (3.5,20+10.5) theta1 
        ( SashaHoney.molly 
            True 
            (rgb 101 247 243)
           |> scale 0.1
           |> move (5,5)
        )
    , oneSwing (0.5,20+1.5) theta1 
        ( SashaHoney.molly 
            True 
            red
           |> scale 0.1
           |> move (5,5)
        )
    ]
    |> group
    
pointsOnCircle = 
  List.range 0 10
    |> List.map ( \ idx -> 
                     let 
                       theta = pi * ( -0.5 + 0.1 * toFloat idx ) 
                     in
                       (10 * sin theta, 10 * cos theta)
                )
    
rainbow =
  [
    openPolygon pointsOnCircle 
      |> outlined (solid 0.5) red
      |> move (4,1)
  , pointsOnCircle 
      |> List.map
          (\ (x,y) -> line (x,y) (x+4,y+1) |> outlined (solid 0.5) green )
      |> group
  ,  openPolygon pointsOnCircle 
      |> outlined (solid 0.5) red
  ]
    |> group
    
    