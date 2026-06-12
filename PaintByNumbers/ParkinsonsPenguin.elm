module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import Set exposing (Set)
import Dict exposing (Dict)

type alias RGB = (Float,Float,Float)
type alias ClrIdx = Int
type alias ShapeIdx = Int
type alias ColouredShape msg = (GraphicSVG.Stencil, GraphicSVG.Shape msg -> GraphicSVG.Shape msg, RGB)

redBrush = (255,0,0)
yellowBrush = (252, 248, 10)
blackBrush = (10, 10, 10)
whiteBrush = (255, 255, 255)
orangeBrush = (255, 179, 0)
greyBrush = (119, 120, 119)

sandBrush = (201,104,6)
brownBrush = (43,19,0)
greenBrush = (0,128,6)
blueBrush = (0,0,255)
brown2Brush = (80, 30, 32)

stencilsToColour : List (ColouredShape anyMsg)
stencilsToColour =
  [ 
  (oval 8 10, move (-40, -15) << rotate (degrees 90), yellowBrush)
  , (oval 8 10, move(-59, -15) << rotate (degrees 90), yellowBrush)
  , (triangle 10, move (-70, 5) << rotate (degrees -45), greyBrush)
  , (triangle 10, move (-30, 5) << rotate (degrees 100), greyBrush)
  , (roundedRect 40 50 20, move (-50, 10), greyBrush)
  , (roundedRect 30 33 20, move (-50, 5), whiteBrush)
  , (circle 3, move (-58, 25), whiteBrush)
  , (circle 3, move (-43, 25), whiteBrush)
  , (circle 1, move (-58, 25), blackBrush)
  , (circle 1, move (-43, 25), blackBrush)
  , (triangle 5, move (-50, 18) << rotate (degrees 30), yellowBrush)
  , (circle 2, makeTransparent 0, blueBrush)
  , (circle 2, makeTransparent 0, orangeBrush)
  , (circle 2, makeTransparent 0, redBrush)
  , (circle 2, makeTransparent 0, brown2Brush)
  , (circle 2, makeTransparent 0, sandBrush)
  , (circle 2, makeTransparent 0, brownBrush)
  ]
  
type alias Model anyMsg
  = { time : Float
    , shapesToColour : Dict Int ((ColouredShape anyMsg),Int)
    , brushes : Dict Int RGB
    , isColoured : Dict Int Int
    -- Usually painting apps have a colour selected, so we will start with the first one.
    , paintBrush : (Int, (Float,Float,Float) ) 
    , score : Int             -- not yet used
    , startTime : Float       -- not yet used
    }

-- We don't have a way of knowing when the drag is over a shape.
-- But we do know if they tap/click on a shape, so we will use taps for colours.


init = 
  let 
    brushes = stencilsToColour
                |> List.map getClr
                |> Set.fromList -- turn it into a set so we remove duplicates
                |> Set.toList
    allBrushes = brushes 
                  |> List.indexedMap ( \ idx clr -> (idx,clr) )
                  |> Dict.fromList
    clrLookup = brushes
                  |> List.indexedMap ( \ idx clr -> (clr,idx) )
                  |> Dict.fromList
  in
  { time = 0
  , shapesToColour = 
      List.indexedMap 
        (\ idx shape -> (idx,(shape,Dict.get (getClr shape) clrLookup |> Maybe.withDefault clridx)) ) 
          stencilsToColour 
              |> Dict.fromList 
  , brushes = allBrushes
  , isColoured = Dict.empty
  , paintBrush = List.head (Dict.toList allBrushes) |> Maybe.withDefault (0,blackBrush) -- default to black
  , score = 0
  , startTime = 0
  }

type Msg 
  = Tick Float GetKeyState
  | ChangeBrush ClrIdx RGB
  | AttemptPaint ShapeIdx

-- Position to start drawing the paint pots at.
startColours = (-60,-60)
-- Space between paint pots.
spacing = 12

clridx : ClrIdx
clridx = 0

getClr (_,_,clr) = clr

mkClr (r,g,b) = rgb r g b
      
myShapes model =
  [ 
  
  oval 8 10
  |> filled yellow
  |> addOutline (solid 0.5) black
  |> rotate (degrees 90)
  |> move (40, -15)
  
  , oval 8 10
  |> filled yellow
  |> addOutline (solid 0.5) black
  |> rotate (degrees 90)
  |> move (59, -15)
  
  , triangle 10
  |> filled (rgb 119 120 119)
  |> addOutline (solid 0.5) black
  |> rotate (degrees -135)
  |> move (70, 5)
  
  , triangle 10
  |> filled (rgb 119 120 119)
  |> addOutline (solid 0.5) black
  |> rotate (degrees 80)
  |> move (30, 5)
  
  , roundedRect 40 50 20
  |> filled (rgb 119 120 119)
  |> addOutline (solid 1) black
  |> move (50, 10)
  
  , roundedRect 30 33 20
  |> filled white
  |> move (50, 5)
  
  , circle 3
  |> filled white
  |> addOutline (solid 0.5) black
  |> move (58, 25)
  
  , circle 3
  |> filled white
  |> addOutline (solid 0.5) black
  |> move (43, 25)
  
  , circle 1
  |> filled black
  |> move (58, 25)
  
  , circle 1
  |> filled black
  |> move (43, 25)
  
  , triangle 5
  |> filled yellow
  |> rotate (degrees 30)
  |> move (50, 18)
  
  -- draw the paint pots, making the selected pot bigger
  , List.map
      ( \ (idx,clr) -> circle (if model.paintBrush == (idx,clr) then 6 else 5)
                         |> filled (mkClr clr)
                         |> move (-90 + spacing * toFloat idx, -60)
                         |> notifyTap (ChangeBrush idx clr)
                        
                         
                    
                         

      )
      (Dict.toList model.brushes)
      |> group
  -- draw colourable version
  , Dict.toList model.shapesToColour
      |> List.map ( \ (idx,((stencil,mv,rgb),clrIdx)) ->
                    let 
                      (colouredIn,clr) = 
                        case Dict.get idx model.isColoured of
                          Just i -> 
                            (True,model.brushes |> Dict.get i |> Maybe.withDefault blackBrush)
                          Nothing -> (False,blackBrush)
                    in
                        [ stencil
                          |> ( if colouredIn then
                                  filled (mkClr clr)
                               else
                                  filled white
                                    >> addOutline (solid 0.5) black
                             )
                        , text (Debug.toString clrIdx) 
                          |> size 8 >> sansserif >> 
                             ( if not colouredIn then
                                 ghost
                               else
                                 ghost
                             )
                          |> move (-2,-3)
                        ] |> group |> mv |> notifyTap (AttemptPaint idx)
                                 
                  )
      |> group
  -- draw coloured version
  {-, Dict.toList model.shapesToColour
      |> List.map ( \ (idx,(stencil,mv,clr)) -> 
                          stencil 
                           |> filled (mkClr clr)
                           |> mv
                                 
                  )
       |> group
       |> move (96,0)
  , Debug.toString model |> text |> size 3 |> filled black |> move (-96,60) -}
  ] 

-- Helpful functions for adding and subtracting coordinates.
sub (x,y) (u,v) = (x-u,y-v)
add (x,y) (u,v) = (x+u,y+v)

-- Everything happens in the update function! it is so exciting.
update msg model 
  = case msg of
      -- We keep track of time.
      Tick t _ -> { model | time = t }
      -- When the mouse button is pressed, we get NewPos with the coordinates 
      -- of the mouse pointer.
      ChangeBrush num clr -> 
        { model | paintBrush = (num,clr) }
      -- Paints the clicked shape with the selected brush. Will work for any 
      -- colour.  
      AttemptPaint shapeIdx -> 
        case model.paintBrush of
          (brushIdx,brushClr) ->
            { model | isColoured = Dict.insert shapeIdx brushIdx model.isColoured }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)



