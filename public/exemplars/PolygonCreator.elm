-- make a polygon editor
-- step 1, edit and move around a list of points
-- step 2, make it into a polygon
-- generate all combinations of (before,oneSelected,after) from a list

module Main exposing (..)

import GraphicSVG.App exposing (..)
import GraphicSVG exposing (..)
import GraphicSVG.Secret as Secret

singleOut : List a -> List (SingledOut a)
singleOut xs =
  case xs of
    [] -> []
    x1 :: x2plus ->
      let 
        x1WillBeInBefore = singleOut x2plus
      in
        (SO [] x1 x2plus)
        ::
        (List.map (prependToBefore x1) x1WillBeInBefore)
        
prependToBefore x1 (SO before selectedOne after) =
  SO (x1::before) selectedOne after

polyPoints state =
  case state of
    Waiting points -> points
    Dragging (SO before selected after) _ -> 
      before ++ selected :: after
    Deleting points (x,y)->
       List.filter (\a -> a /= (x,y)) points

myShapes : Model -> List (Shape Msg)
myShapes model =
  [ graphPaperCustom 10 0.2 normalColour |> makeTransparent (if (model.flag) then 0 else 0.8)
  ,
    graphPaperCustom 100 0.7 black |> makeTransparent (if (model.flag) then 0 else 0.8)
  ,
    button2 (if (model.flag) then "Show Graph" else "Hide Graph") (Just (Toggle model.flag)) |> move (80,-50)
  ,
    (case model.state of
      Dragging _ lastMousePos ->
        text ("mouse pos = " ++ Debug.toString lastMousePos)
      _ ->
        text (Debug.toString model.state)
    )
        |> size 4
        |> filled brown
        |> move (-93,-60)
  , openPolygon (polyPoints model.state) |> outlined (solid 0.5) (rgb 0 0 100)
  ]
  ++
  ( case model.state of
      Waiting points ->
        let 
          pointsSingledOut = singleOut points
        in
          [ button "+" (Just NewPoint) 
              |> move (85,58),
            button "-" (Just SwitchTo) 
              |> move (-85,58),
            rect 150 7
              |> filled graphColour
              |> makeTransparent 0.8
              |> move (0,58),
            text "All points added stack at (50,50). Click on that point to drag around"
              |> centered
              |> filled black 
              |> move (0,125)
              |> scale 0.45
          ]
          ++
          List.map 
            drawPointFromSingledOut
            pointsSingledOut
            
      Dragging (SO before selected after) _ ->
        [ button "+" Nothing 
        |> move (85,58)
        ]
        ++
        (List.map (drawPoint normalColour) before)
        ++
        [ drawPoint red selected ]  
        ++
        (List.map (drawPoint normalColour) after)
        ++
        [ -- secret way of making dragging reliable
           rect 190 126 |> filled (rgba 10 10 10 0.005)
             |> notifyMouseMoveAt DragMove
             |> notifyMouseUpAt DragEnd
             |> notifyLeaveAt DragEnd
        ]
      
      Deleting points (x,y) ->
        let 
          pointsSingledOut = singleOut (List.filter (\a -> a /= (x,y)) points) 
        in
          [ button "-" (Just SwitchTo)
              |> move (-85,58),
            rect 150 7
              |> filled graphColour
              |> makeTransparent 0.8
              |> move (0,58),
            text "Select the point you want to delete. Click on ' - ' button to go back"
              |> centered
              |> filled black
              |> move (0, 125)
              |> scale 0.45              
          ]
          ++
          List.map 
            drawPointFromSingledOut
            pointsSingledOut     
            
  )
  ++
  [ yourCode model 
      |> move (-50,-35)
  ]

-- make a button
-- if passed Nothing, it is inactive
-- if passed Just msg, it is active
button txt maybeMsg =
  let 
    b =
      group 
        [ roundedRect 15 10 2
           |> filled (case maybeMsg of 
                         Just SwitchTo -> red
                         Just (Toggle _) -> charcoal
                         Just _ -> rgb 0 0 225
                         Nothing -> gray
                     )
        , text txt
           |> centered
           |> filled white
           |> move (0,-3)
        ]
  in
    case maybeMsg of
      Just msg -> 
        b |> notifyTap msg
      Nothing ->
        b
        
button2 txt maybeMsg =
  let 
    b =
      group 
        [ roundedRect 32 10 2
           |> filled (case maybeMsg of 
                         Just (Toggle _) -> charcoal
                         Just _ -> rgb 0 0 225
                         Nothing -> gray
                     )
        , text txt
           |> centered
           |> filled white
           |> move (0,-3)
           |> scale 0.5
        ]
  in
    case maybeMsg of
      Just msg -> 
        b |> notifyTap msg
      Nothing ->
        b        
    
normalColour = rgb 0 0 150

drawPoint : Color -> (Float,Float) -> Shape Msg
drawPoint clr pos =
  circle 3 |> filled clr |> move pos

drawPointFromSingledOut : (SingledOut (Float,Float)) -> Shape Msg
drawPointFromSingledOut (SO before thisPoint after) =
  circle 3 |> filled normalColour |> move thisPoint
    |> notifyMouseDownAt (ClickOnPoint (SO before thisPoint after))
  
graphColour = (hsl 3.371 1 0.562)
graphDark = (hsl 3.371 1 0.4)
highlight = (hsla 0.406 1 0.562 0.8)
transSep = 4
codeFont = customFont "Source Code Pro"
headlineFont = customFont "Raleway"
serifFont = customFont "Gentium Plus"

yourCode model = 
    let
        points = case model.state of
                      Waiting ps -> ps
                      Dragging (SO before (xP,yP) after) _ ->
                        before ++ [(xP,yP)] ++ after
                      Deleting ps (x,y)->
                        List.filter (\a -> a /= (x,y)) ps

        mkToolbox st = 
            st 
                |> filled (rgba 255 255 255 0.85) 
                |> addOutline (solid 0.5) graphColour
    in
        group [
                 roundedRect 90 40 3 
                    |> mkToolbox
                 ,text "Copiable Code" |> headlineFont |> size 4 |> bold  |> filled graphColour 
                    |> move (-43,15)
                 , keyCap KeyCmdCtrl |> scale 0.7
                    |> move (30,-7)
                 , text "+" |> size 3 |> centered |> bold |> filled charcoal
                    |> move (35,-8)
                 , keyCap (KeyLetter "A") |> scale 0.7
                    |> move (40,-7)
                 , keyCap KeyCmdCtrl |> scale 0.7
                    |> move (30,-15)
                 , text "+" |> size 3 |> centered |> bold |> filled charcoal
                    |> move (35,-16)
                 , keyCap (KeyLetter "C") |> scale 0.7
                    |> move (40,-15)
                  ,"  openPolygon " |> text |> size 3 |> codeFont |> selectable |> filled charcoal 
                            |> move (-42,11)
                 , group <|
                          List.indexedMap (\idx (x,y) -> 
                                            text ((if idx==0 then "    [(" else "   ,(")
                                                  ++String.fromFloat x++","++String.fromFloat y++")") 
                                                    |> size 3 |> codeFont |> selectable |> filled charcoal 
                                                    |> move (-42,toFloat (8 - 3 * idx))) 
                                                points
                
                 ]
   
type SingledOut a = SO (List a)   -- before
                       a        -- singled out
                       (List a)   -- after
                    
type Msg = Tick Float GetKeyState
         | NewPoint
         | ClickOnPoint (SingledOut (Float,Float)) (Float,Float)
         | DragMove (Float,Float)
         | DragEnd (Float,Float)
         | SwitchTo
         | Toggle Bool

type State = Waiting (List (Float,Float))
           | Dragging (SingledOut (Float,Float)) 
               (Float,Float) -- last recorded mouse position
           | Deleting (List (Float,Float))
               (Float,Float)
               
update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick t _ ->
            { model | time = t }
        NewPoint ->
            { model | state = 
                        case model.state of
                          Waiting points ->
                            Waiting <| (50,50) :: points
                          _ -> model.state -- shouldn't be allowed
            }
        ClickOnPoint (SO before (xP,yP) after) (x,y) -> 
            { model | state = case model.state of
                                Waiting points ->
                                    Dragging (SO before (xP,yP) after) (x,y)
                                Deleting points _ ->
                                    Deleting (List.filter (\a -> a /= (xP,yP)) points) (x,y)
                                _ -> model.state -- impossible
            }

        DragMove (x,y) -> 
            { model | state = case model.state of
                                Dragging (SO before (xP,yP) after) (xLast,yLast) ->
                                    Dragging (SO before (xP+x-xLast, yP+y-yLast) after) (x,y)
                                _ -> model.state -- impossible
            }

        DragEnd (x,y) -> 
            { model | state = case model.state of
                                Dragging (SO before (xP,yP) after) (xLast,yLast) ->
                                    Waiting (before ++ (xP+x-xLast, yP+y-yLast) :: after)
                                _ -> model.state -- impossible
            }
        
        SwitchTo -> 
            { model | state = case model.state of
                                Waiting points->
                                  Deleting points (10000,10000)
                                  
                                Deleting points (x,y) ->
                                  Waiting (List.filter (\a -> a /= (x,y)) points)
                                _ -> model.state -- impossible
            }
            
        Toggle x->
          { model | flag = not x}


type alias Model =
    { time : Float
    , state : State
    , flag : Bool
    }

init : Model
init = { time = 0 
       , state = Waiting [(0,0), (10,10)]
       , flag = True
       }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

---

type KeyCap 
    = KeyLetter String
    | KeyU
    | KeyD
    | KeyRight
    | KeyLeft
    | KeyCmd
    | KeyCtrl
    | KeyCmdCtrl
    | KeyShift
    | KeyEsc
    | KeyReturn

keyCap : KeyCap -> Shape a 
keyCap key =
    [ roundedRect 10 10 2 |> filled charcoal
    , case key of
        KeyLetter l ->
            text l |> centered |> size 5 |> filled white |> move (0,-1.5)
        KeyU ->
            ngon 3 1.5 |> filled white |> rotate (degrees  90)
        KeyD ->
            ngon 3 1.5 |> filled white |> rotate (degrees -90)
        KeyRight->
            ngon 3 1.5 |> filled white |> rotate (degrees 0)
        KeyLeft->
            ngon 3 1.5 |> filled white |> rotate (degrees -180)
        KeyCmd ->
            text "⌘" |> centered |> size 5 |> filled white |> move (0,-1.5)
        KeyCtrl ->
            [ text "⌃" |> centered |> size 4 |> filled white |> move (0,0.5)
            , text "ctrl" |> centered |> size 4 |> filled white |> move (0,-2.5)
            ] |> group
        KeyCmdCtrl ->
            [ text "⌘" |> centered |> size 3 |> filled white |> move (0,1)
            , text "ctrl" |> centered |> size 4 |> filled white |> move (0,-2.5)
            ] |> group
        KeyShift ->
            text "⇧" |> centered |> size 5 |> filled white |> move (0,-1.5)
        KeyEsc ->
            text "esc" |> centered |> size 5 |> filled white |> move (0,-1.5)
        KeyReturn ->
            [ text "enter" |> centered |> size 3 |> filled white |> move (0,1)
            , text "return" |> centered |> size 2.8 |> filled white |> move (0,-2.5)
            ] |> group
    ]
        |> group


