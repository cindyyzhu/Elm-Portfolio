module Main exposing (..)

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

myShapes model =
  [
  -- background color
    rect 500 500 
      |> filled (rgb 14 184 227)
      
      --arms
      , rect 33 1
      |> filled darkBrown
      |> rotate (degrees 30)
      |> move (20, 10)
      
      , rect 33 1
      |> filled darkBrown
      |> rotate (degrees -30)
      |> move (-20, 10)
      
      , rect 5 1
      |> filled darkBrown
      |> rotate (degrees -10)
      |> move (32, 15)
      
      , rect 5 1
      |> filled darkBrown
      |> rotate (degrees 10)
      |> move (-32, 15)
      
      , rect 5 1
      |> filled darkBrown
      |> rotate (degrees 290)
      |> move (-30, 18)
      
      , rect 5 1
      |> filled darkBrown
      |> rotate (degrees -290)
      |> move (30, 18)
      
      -- snowman body
    , circle 20 --second circle
      |> filled white
      |> scale 0.75
      |> move (0, 5)
      
    , circle 20 --bottom circle
      |> filled white
      |> scale 1
      |> move (0, -21)
      
      -- scarf
      ,oval 45 15
      |> filled green
      |> scale 0.5
      |> move (0, 15)
      
      --snowman head
    ,circle 20
      |> filled white
      |> scale 0.5
      |> move (0, 25)
      
      
      
      --scarf sleeve
     , roundedRect 12 6 0.5
       |> filled green
       |> rotate (degrees 50)
       |> move (-12, 10)
       
       --scarf sleeve on right
     , roundedRect 12 6 0.5
       |> filled green 
       |> rotate (degrees 70)
       |> move (-6, 8)
      
    
       
       --top hat top oval
      , oval 16 5.5
      |> filled black
      |> rotate (degrees 21)
      |> move (-7, 42)
      
      
      
      --bottom rim 
      , oval 19 4
      |> filled black 
      |> rotate (degrees 21)
      |> move (-3, 33)
      
      
      --top hat body
     , rect 16 10
       |> filled black
       |> rotate (degrees 21)
       |> move (-5, 37) 
       
     --red ribbon on hat
      , oval 16 5
      |> filled red
      |> rotate (degrees 21)
      |> move (-4, 35)
      
      -- top hat body continued to cover ribbon
      , rect 16 5
       |> filled black
       |> rotate (degrees 21)
       |> move (-5, 37)
       
       --roundedrect to add on to ribbon
       , roundedRect 16 1.5 2
       |> filled red
       |> rotate (degrees 21)
       |> move (-4, 35)
      
      --top hat top outline
      , oval 16 5.5
      |> outlined (solid 0.5) white
      |> rotate (degrees 21)
      |> move (-7, 42)
      
      --scarf
     , roundedRect 45 13 6
      |> filled green 
      |> scale 0.5
      |> move (0, 17)
         
      --scarf strips on left sleeve
      , rect 6 2
      |> filled red
      |> rotate (degrees 146)
      |> move (-12, 10)
      
      , rect 6 2
      |> filled red
      |> rotate (degrees 146)
      |> move (-14.5, 7)
      
      , rect 6 2
      |> filled red
      |> rotate (degrees 146)
      |> move (-9.5, 14)
      
      
      --scarf strips on right sleeve
      , rect 6 2
      |> filled red
      |> rotate (degrees 162)
      |> move (-6, 8)
         
      , rect 6 2
      |> filled red
      |> rotate (degrees 162)
      |> move (-4.5, 12)
      
      , rect 6 2
      |> filled red
      |> rotate (degrees 162)
      |> move (-7.5, 4)
      
      --scarf strips on main scarf
      , roundedRect 2 8.7 0.3
      |> filled red 
      |> move (0, 15.9)
      
      , roundedRect 2 8.3 0.3
      |> filled red 
      |> move (4, 16)
      
      , roundedRect 2 7.4 0.4
      |> filled red 
      |> move (8, 16.2)
      
      , roundedRect 2 7.3 0.3
      |> filled red 
      |> move (-8, 16.4)
      
      , roundedRect 2 7.9 0.3
      |> filled red 
      |> move (-4, 15.9)
      
      --scarf tassles
      , roundedRect 1 2.5 0.1
      |> filled yellow
      |> rotate (degrees 146)
      |> move (-14.5, 3)
      
      , roundedRect 1 2.5 0.1
      |> filled yellow
      |> rotate (degrees 146)
      |> move (-15.8, 3.7)
      
      , roundedRect 1 2.5 0.1
      |> filled yellow
      |> rotate (degrees 146)
      |> move (-17.1, 4.5)
      
      , roundedRect 1 2.5 0.1
      |> filled yellow
      |> rotate (degrees 146)
      |> move (-18.5, 5.4)
      
      --tassles on right sleeve of scarf
      , roundedRect 1 2.5 0.1
      |> filled yellow
      |> rotate (degrees 162)
      |> move (-10.5, 1.8)
      
      , roundedRect 1 2.5 0.1
      |> filled yellow
      |> rotate (degrees 162)
      |> move (-9, 1.4)
      
      , roundedRect 1 2.5 0.1
      |> filled yellow
      |> rotate (degrees 162)
      |> move (-7.4, 1)
      
      , roundedRect 1 2.5 0.1
      |> filled yellow
      |> rotate (degrees 162)
      |> move (-6, 0.7)
      
      --oval to cover un the ribbon
      , oval 16 5
      |> filled black
      |> rotate (degrees 21)
      |> move (-4.5, 36)
      
   --eyes
   , circle 1
      |> filled black
      |> move (4, 28)
      
   , circle 1
      |> filled black 
      |> move (-4, 28)
    
    --nose
    , triangle 9
      |> filled orange
      |> scaleY 0.25
      |> move (4, 24)
      
    --buttons
    , circle 2
      |> filled black
      |> move (0, -25)
      
      , circle 2
      |> filled black
      |> move (0, -11)
      
      , circle 2
      |> filled black
      |> move (0, 4)
      
      --bottom
    , oval 500 50
      |> filled white
      |> move (0, -60)
      
     --snow falling
     ,snow 
    |> move (0, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (23, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (40, repeatDistance -90 200 100 model.time)
  ,snow
    |> move (90, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-23, repeatDistance -93 200 100 model.time)
  ,snow
    |> move (-90, repeatDistance -60 200 100 model.time)
  ,snow
    |> move (-70, repeatDistance -70 200 100 model.time)
   ,snow
    |> move (67, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (81, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (13, repeatDistance -90 200 100 model.time)
  ,snow
    |> move (52, repeatDistance -83 200 100 model.time)
  ,snow
    |> move (74, repeatDistance -60 200 100 model.time)
  ,snow
    |> move (19, repeatDistance -57 200 100 model.time)
  ,snow
    |> move (-11, repeatDistance -60 200 100 model.time)
  ,snow
    |> move (-89, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-3, repeatDistance -65 200 100 model.time)
  ,snow
    |> move (26, repeatDistance -57 200 100 model.time)
  ,snow
    |> move (55, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-16, repeatDistance -60 200 100 model.time)
  ,snow
    |> move (-88, repeatDistance -70 200 100 model.time)
  ,snow
    |> move (-15, repeatDistance -59 200 100 model.time)
  ,snow
    |> move (0, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (23, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (40, repeatDistance -65 200 100 model.time)
  ,snow
    |> move (90, repeatDistance -79 200 100 model.time)
  ,snow
    |> move (-23, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (-90, repeatDistance -60 200 100 model.time)
  ,snow
    |> move (-92, repeatDistance -70 200 100 model.time)
   ,snow
    |> move (24, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (86, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (37, repeatDistance -90 200 100 model.time)
  ,snow
    |> move (46, repeatDistance -83 200 100 model.time)
  ,snow
    |> move (-46, repeatDistance -80 200 100 model.time)
  ,snow
    |> move (-29, repeatDistance -57 200 100 model.time)
  ,snow
    |> move (-18, repeatDistance -60 200 100 model.time)
  ,snow 
    |> move (-53, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-16, repeatDistance -65 200 100 model.time)
  ,snow
    |> move (47, repeatDistance -57 200 100 model.time)
  ,snow
    |> move (28, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-18, repeatDistance -80 200 100 model.time)
  ,snow
    |> move (-35, repeatDistance -77 200 100 model.time)
  ,snow
    |> move (-68, repeatDistance -59 200 100 model.time)
    
  ,snow
    |> move (-67, repeatDistance -93 200 100 model.time)
  ,snow
    |> move (-92, repeatDistance -97 200 100 model.time)
  ,snow
    |> move (-27, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (68, repeatDistance -103 200 100 model.time)
  ,snow
    |> move (88, repeatDistance -103 200 100 model.time)
  ,snow
    |> move (-24, repeatDistance -69 200 100 model.time)
  ,snow
    |> move (-59, repeatDistance -88 200 100 model.time)
  ,snow
    |> move (-93, repeatDistance -80 200 100 model.time)
    
         ,snow 
    |> move (0, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (23, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (40, repeatDistance -90 200 100 model.time)
  ,snow
    |> move (90, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-23, repeatDistance -93 200 100 model.time)
  ,snow
    |> move (-90, repeatDistance -60 200 100 model.time)
  ,snow
    |> move (-70, repeatDistance -70 200 100 model.time)
   ,snow
    |> move (67, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (81, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (13, repeatDistance -90 200 100 model.time)
  ,snow
    |> move (52, repeatDistance -83 200 100 model.time)
  ,snow
    |> move (74, repeatDistance -60 500 100 model.time)
  ,snow
    |> move (19, repeatDistance -57 600 100 model.time)
  ,snow
    |> move (-11, repeatDistance -60 900 100 model.time)
  ,snow
    |> move (-89, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-3, repeatDistance -65 200 100 model.time)
  ,snow
    |> move (26, repeatDistance -57 200 100 model.time)
  ,snow
    |> move (55, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-16, repeatDistance -60 200 100 model.time)
  ,snow
    |> move (-88, repeatDistance -70 200 100 model.time)
  ,snow
    |> move (-15, repeatDistance -59 200 100 model.time)
  ,snow
    |> move (0, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (23, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (40, repeatDistance -65 200 100 model.time)
  ,snow
    |> move (90, repeatDistance -79 200 100 model.time)
  ,snow
    |> move (-23, repeatDistance -89 200 100 model.time)
  ,snow
    |> move (-90, repeatDistance -60 200 100 model.time)
  ,snow
    |> move (-92, repeatDistance -70 200 100 model.time)
   ,snow
    |> move (24, repeatDistance -100 200 100 model.time*1.19)
  ,snow
    |> move (86, repeatDistance -89 200 100 model.time*1.1)
  ,snow
    |> move (37, repeatDistance -90 200 100 model.time*1.02)
  ,snow
    |> move (46, repeatDistance -83 200 100 model.time)
  ,snow
    |> move (-46, repeatDistance -80 200 100 model.time)
  ,snow
    |> move (-29, repeatDistance -57 200 100 model.time)
  ,snow
    |> move (-18, repeatDistance -60 200 100 model.time)
  ,snow 
    |> move (-53, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-16, repeatDistance -65 200 100 model.time)
  ,snow
    |> move (47, repeatDistance -57 200 100 model.time)
  ,snow
    |> move (28, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-18, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-35, repeatDistance -77 200 100 model.time)
  ,snow
    |> move (-68, repeatDistance -59 200 100 model.time)
    
  ,snow
    |> move (-10, repeatDistance -93 200 100 model.time)
  ,snow
    |> move (-20, repeatDistance -97 200 100 model.time)
  ,snow
    |> move (-30, repeatDistance -100 200 100 model.time)
  ,snow
    |> move (-40, repeatDistance -103 200 100 model.time)
  ,snow
    |> move (-50, repeatDistance -103 200 100 model.time)
  ,snow
    |> move (-60, repeatDistance -88 200 100 model.time)
  ,snow
    |> move (-70, repeatDistance -88 200 100 model.time)
  ,snow
    |> move (-80, repeatDistance -80 200 100 model.time)
  
  ]
  
snow = group
  [
    circle 1.5
      |> filled white
  ]
  