module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import Array
import Debug

import Color

type alias Color = GraphicSVG.Color
type alias Shape msg = GraphicSVG.Shape msg


defaultColor = black


{-| This is a list of numbers, not colors.
    The program extracts r-g-b values of colors by referencing
      this list by position. This is done because GraphicSVG
      doesn not expose Solid, preventing the extraction
      of the underlying Color.Color object. -}
gColorReference = 
         Array.fromList [(100, 200, 10)
                      , (110, 200, 20)
                      , (120, 200, 30)
                      , (130, 200, 40)
                      , (140, 200, 50)
                      , (150, 200, 60)
                      , (160, 200, 70)
                      , (170, 200, 80)
                      , (180, 200, 90)
                      , (190, 200, 100)]

tuple2Color : (Float, Float, Float) -> Color
tuple2Color (a, b, c) = rgb a b c

{-| Values in this array are taken to form three variables:
      gSelectablePalette, leftBoudnary, and rightBoudnary.-}
gColorPalette = 
        Array.map tuple2Color gColorReference

{-| This array contains the "draggable-and-scorable" colors. -}
gSelectablePalette =
        Array.fromList [ rgb 110 200 20
                      , rgb 160 200 70
                      , rgb 180 200 90
                      , rgb 140 200 50
                      , rgb 120 200 30
                      , rgb 170 200 80
                      , rgb 150 200 60
                      , rgb 130 200 40]
-- This array is manually randimized. It needs to contain all colors
--    beside the bondary colors; the list of possible values are from
     -- Array.slice 1 (Array.length gColorPalette - 1) gColorPalette

leftBoundary = Array.get 0 gColorPalette |> Maybe.withDefault purple          
rightBoundary = Array.get (Array.length gColorPalette - 1) gColorPalette
                |> Maybe.withDefault purple

gPalatteLength = 8

gCheckColorOrder : Array.Array Color -> Array.Array Color -> Int
gCheckColorOrder check against =
        let
          checkList = Array.toList check
          againstList = Array.toList against
        in
          gCheckColorOrderList checkList againstList
          
gCheckColorOrderList : List Color -> List Color -> Int
gCheckColorOrderList check against = 
        List.sum(List.map(\col -> scoreColor (colorNeighbors col check) against) check)
        
{-| This function attempts to access elements of a list by position.
    It is necessary due to gCheckColorOrder, which converts arrays
      to lists. -}
      
indexOf : a -> List a -> Int
indexOf item list = Array.toIndexedList (Array.fromList list) |> List.foldr (\(i, v) k  -> if (v == item) then i else k) -10000

scoreColor: (Color, Color, Color) -> List Color -> Int
scoreColor (leftcol, col, rightcol) clist = distCol leftcol col clist
                                           + distCol rightcol col clist
                                           - perfectScore col clist
perfectScore: Color -> List Color -> Int
perfectScore c clist = distCol c (Array.get (indexOf c clist - 1) gColorPalette |> Maybe.withDefault red) clist
                     + distCol c (Array.get (indexOf c clist+ 1) gColorPalette |> Maybe.withDefault red) clist

getR: Color -> List Color -> Int
getR c clist = Array.get (indexOf c clist) gColorReference |> Maybe.withDefault (0,0,0) |> getFirst |> Basics.round

getFirst: (t, t, t) -> t
getFirst (a, b, c) = a 

getG: Color -> List Color -> Int
getG c clist = Array.get (indexOf c clist) gColorReference |> Maybe.withDefault (0,0,0) |> getSecond |> Basics.round

getSecond: (t, t, t) -> t
getSecond (a, b, c) = b 

getB: Color -> List Color -> Int
getB c clist = Array.get (indexOf c clist) gColorReference |> Maybe.withDefault (0,0,0) |> getThird |> Basics.round

getThird: (t, t, t) -> t
getThird (a, b, c) = c 

distCol: Color -> Color -> List Color -> Int
distCol c1 c2 clist = sqrt(((getB c1 clist - getB c2 clist)^2 |> toFloat)
                         + ((getR c1 clist - getR c2 clist)^2 |> toFloat)
                         + ((getG c1 clist - getG c2 clist)^2 |> toFloat))|> round
--abs(Array.get (indexOf c1 clist) gColorReference - indexOf c2 clist)
-- abs(indexOf c1 clist - indexOf c2 clist)



colorNeighbors : Color -> List Color -> (Color, Color, Color)
colorNeighbors cl clst = 
        let
          carr = Array.fromList clst
          c = indexOf cl clst
          leftcol  = case Array.get (c-1) carr of
                        Just a -> a
                        Nothing -> leftBoundary
          col      = case Array.get c carr of
                        Just aa -> aa
                        Nothing -> purple
          rightcol = case Array.get (c+1) carr of
                        Just aaa -> aaa
                        Nothing -> rightBoundary
        in
          (leftcol, col, rightcol)

colorAtIndex: Int -> Array.Array Color -> Color
colorAtIndex i arr = case Array.get i arr of
        Just col -> col
        Nothing -> defaultColor

type alias Pos = Int

type Msg = Tick Float GetKeyState
        | AssignColor Pos
        | SelectCell Pos
        | ClearSelection
        | CursorLoc Float Float
        | SelectCellAbove Pos
        | ToggleScore

type alias Model = {
      time : Float
      , overlayPosition : Maybe Pos
      , cellStates :  Array.Array GraphicSVG.Color
      , colorPalette : Array.Array GraphicSVG.Color
      , selectedColor : GraphicSVG.Color
      , cursorPos : (Float, Float)
      , scoreDisplayed : Bool
    }
    
init : Model
init = { time = 0
    , overlayPosition = Nothing
    , cellStates = gSelectablePalette
    , colorPalette = gSelectablePalette
    , selectedColor = (rgba 0 0 0 0)
    , cursorPos = (-100,-100) 
    , scoreDisplayed = False}
    
update: Msg -> Model -> Model
update msg model = case msg of
        Tick t _ -> { model | time = t }
        AssignColor pos -> if (model.selectedColor /= (rgba 0 0 0 0)) then { model | 
                cellStates = model.cellStates
                |> whiteOut model.selectedColor
                |> Array.set (indexOf model.selectedColor (Array.toList model.cellStates)) (colorAtIndex (Array.length model.colorPalette - pos) model.cellStates)
                |> Array.set (Array.length model.colorPalette - pos) model.selectedColor
                , selectedColor = (rgba 0 0 0 0)
                , overlayPosition = Nothing} else model
        SelectCell i -> { model |
                overlayPosition = Just (Array.length model.colorPalette - i)
              , selectedColor = case Array.get (Array.length model.colorPalette - i) model.colorPalette of
                  Nothing -> purple -- should happen in index out of bound
                  Just col -> col}
        ClearSelection -> { model | overlayPosition = Nothing
              , selectedColor = (rgba 0 0 0 0)}
        CursorLoc a b -> { model |
                cursorPos = (a,b)}
        SelectCellAbove i -> { model | selectedColor = case Array.get (Array.length model.cellStates - i) model.cellStates of
                  Nothing -> purple -- should happen in index out of bound
                  Just col -> col}
        ToggleScore -> { model | scoreDisplayed = not model.scoreDisplayed }



ft: Color -> Color -> Array.Array Color -> Array.Array Color
ft repaceme col lic = if (col == repaceme) then (Array.push (rgba 0 0 0 0) lic) else (Array.push col lic)

whiteOut: Color -> Array.Array Color -> Array.Array Color
whiteOut col lic = Array.foldl (ft col) (Array.empty) (lic)

main = gameApp Tick { model = init,
    view = view,
    update = update,
    title = "Game Slot"}

view : Model -> Collage Msg
view model = collage 192 128 (createUpdatedModel model)


trackCursor = notifyMouseMoveAt (\(x, y) -> CursorLoc x y) 
createUpdatedModel : Model -> List (Shape Msg)
createUpdatedModel model =
      -- So that all elements participate in tracking the cursor
      List.map (\a -> a |> trackCursor) (
          -- This is the background
          [ rect 80 120 |> filled ((rgba 0 0 0 0)) |> addOutline  (solid 1) black
            , rect 70 1    |> filled gray |> move (0, 20)
            , createWrapText "Now we need you to put    its letters based on the  correct colour order      according to start and    ending colours" 26
              |> scale 0.5 |> move(-35,50)]
          -- These are interactive elements
          ++ List.map (move (-25,-25)) (List.map (scale 0.6) [
             drawCellTexts(
             List.map2 Tuple.pair ["M", "A", "C", "A", "R", "O", "N", "I"] (List.reverse (Array.toList model.colorPalette))) |> move (-2.5, 16.5)
          , drawCellTexts(
             List.map2 Tuple.pair ["M", "A", "C", "A", "R", "O", "N", "I"] (List.reverse (Array.toList model.colorPalette))) |> move (-2.5, 31)
          , drawCellBackgrounds (model.cellStates) |> move(0,20)
          , createWhiteCells (Array.length model.cellStates) |> move(0,20)
          , createOverlay (model.overlayPosition)
          , createSelectedColorIndicator (model.selectedColor) |> move (-5, -30)
          
          , rect 10 10 |> filled leftBoundary |> move (-14, 20)
          , rect 10 10 |> filled rightBoundary |> move (98, 20)
          ])
          
          -- This is the "dragged" color, scaled separately.
          ++ if (model.selectedColor /= (rgba 0 0 0 0)) then [
          circle 5 |> outlined (solid 5) model.selectedColor 
          |> scale (0.5)
          |> move (model.cursorPos)] else []
          ++ [text "score" |> sansserif |> filled black |> move(-15, -3) |> scale (0.8)
          |> union (rect 30 10 |> filled grey) |> move (-20, -25) |> notifyMouseUp ToggleScore
              ]
          ++ if (model.scoreDisplayed) then [
            text (String.fromInt (gCheckColorOrder model.cellStates gColorPalette))
            |> sansserif |> filled red
            |> move (-3, -36) |> scale (0.8)
            ] else []
      )

drawColors : Array.Array Color -> Shape Msg
drawColors cols = case Array.get 0 cols of
      Just col -> rect 10 10 |> filled (col) 
            |> notifyMouseDown (SelectCell (Array.length cols))
              |> union ((drawColors (Array.slice 1 (Array.length cols) cols)) |> move(12, 0))
      Nothing -> rect 0 0 |> filled black
      
drawCellBackgrounds : Array.Array Color -> Shape Msg
drawCellBackgrounds cols = case Array.get 0 cols of
      Just col -> rect 10 10 |> filled (col)
              |> union ((drawCellBackgrounds (Array.slice 1 (Array.length cols) cols)) |> move(12, 0))
      Nothing -> rect 0 0 |> filled black
      
drawCellTexts : List (String, Color) -> Shape Msg
drawCellTexts lis = case lis of
      [] -> rect 0 10 |> filled black 
      a::bbbbv -> makeColouredText a |> scale (0.8)
          |> union (drawCellTexts bbbbv   |> move(12,0))
          
makeColouredText : (String, Color) -> Shape Msg
makeColouredText (txt, col) = (text txt) |> fixedwidth |> bold |> filled black

createSelectedColorIndicator : Color -> Shape Msg
createSelectedColorIndicator col = text "Selected: " |> filled (black)
        |> union (rect 10 10 |> filled (col) |> move (50, 3))

-- The pos compromise is made
createEmptyCell : Int -> Shape Msg
createEmptyCell pos = rect 10 10 |> filled (rgba 0.1 0.1 0.1 0.1)
      |> notifyMouseUp (AssignColor pos)
      |> notifyMouseDown (SelectCellAbove pos)
      
      
createWhiteCells : Int -> Shape Msg
createWhiteCells rem = case (rem < 1) of
      False -> union (createEmptyCell rem) (rect 10 10 |> outlined (solid 1) blue)
              |> (union (createWhiteCells (rem-1) |> move(12, 0)))
      True -> rect 0 0 |> filled black
      
createDiscardButton : () -> Shape Msg
createDiscardButton () = (text "X" |> fixedwidth|> filled (black)
        |> union (rect 11 11 |> filled (lightGrey) |> move (4, 4))
        |> notifyMouseUp (ClearSelection))
        
createOverlay : Maybe Int -> Shape Msg
createOverlay posq = case posq of
      Just pos -> circle 5 |> outlined (solid 5) white |> move(toFloat (pos*12), 0)
      Nothing -> rect 0 0 |> filled blue |> move(0, 0)
      
createWrapText : String -> Int -> Shape Msg
createWrapText chars bound = if (String.length chars < bound ) then
                  text chars |> sansserif  |> filled black 
                  else
                text (String.left bound chars) |> sansserif  |> filled black 
                 |> union (createWrapText(String.dropLeft bound chars) bound
                 |> move(0, -10))
        

