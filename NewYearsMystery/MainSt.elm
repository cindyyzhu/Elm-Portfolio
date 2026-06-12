module MainSt exposing (..)

import Types exposing (State(..), Msg(..))
import Park

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
    road model
  ]
  
road model =
  [
    curve (58.6, -35.3) [Pull (64.1, -42.2) (69.5, -49.1), Pull (61.1, -49.8) (52.7, -50.4), Pull (30.5, -26.9) (8.2, -3.4), Pull (2.8, 5.9) (-31.4, 6.1), Pull (-62.7, 5.4) (-93.9, 4.7), Pull (-94.0, 11.5) (-94.2, 18.2), Pull (-51.1, 18.6) (-31.9, 20.0), Pull (9.0, 21.0) (18.2, 8.3), Pull (30.4, -2.3) (47.1, -22.1), Pull (53.2, -28.2) (58.5, -35.7)]
      |> filled darkCharcoal
  , curve (-94.2, 10.9) [Pull (-59.2, 11.7) (-24.2, 12.5), Pull (-3.6, 14.7) (12.6, 3.4), Pull (29.6, -12.8) (60.6, -49.0)]
      |> outlined (dashed 1) yellow
  , topSidewalk
      |> outlined (solid 5) darkGrey
  , topSidewalk
      |> outlined (custom [(0.5,5)] 5) charcoal
  , botSidewalk
      |> outlined (solid 5) darkGrey
  , botSidewalk
      |> outlined (custom [(0.5,5)] 5) charcoal
  , rect 192 128 |> ghost
      |> notifyMouseMoveAt ( \ _ -> NoHighlight )
  , building model.highlight "Pet Store" PetStore white -95
  , building model.highlight "Stanley's Stationary" MainStreet white -85
  , building model.highlight "Samosa Emporium" SamosaEmporium white -75
  , building model.highlight "Honey Bee Boutique" HoneyBeeBoutique white -65
  , jennas model.highlight white JennasSuperMart -55
  , building model.highlight "Mystery" MainStreet white 0 |> rotate (degrees 180) |> move (-90,24)
  , building model.highlight "Convenience Store" ConvenienceStore white 0 |> rotate (degrees 180) |> move (-80,24)
  , building model.highlight "Shlomo's Shoes" MainStreet white 0 |> rotate (degrees 180) |> move (-70,24)
  , building model.highlight "William's Books" Bookstore white 0 |> rotate (degrees 180) |> move (-60,24)
  , building model.highlight "Gabby's Games" MainStreet white 0 |> rotate (degrees 180) |> move (-50,24)
  , pool model.highlight white SwimmingPool
  , friends model.highlight white FriendsHouse
  , mainHouse model.highlight white MainKitchen
  , library model.highlight white Library
  , park model.highlight white Park 
  ]
    |> group

building maybeHighlight name state clr x =
  [ polygon [(x,23),(x,53),(x+10,53),(x+10,23)]
      |> filled ( case maybeHighlight of 
                    Nothing -> clr
                    Just hlState -> 
                      if hlState == state && state /= MainStreet then
                        yellow
                      else
                        clr
                )
      |> addOutline (solid 0.5) (rgb 113 38 0)
  , text name
      |> size 3
      |> filled darkBrown
      |> rotate (degrees 90)
      |> move (x+5,25)
  , rect 3 5 |> filled grey
      |> move (x+1.5,30)
  , circle 0.75 |> filled black
      |> move (x + 1.5,31)
  , circle 0.75 |> filled black
      |> move (x + 1.5,29)
  ]
    |> group
    |> ( case maybeHighlight of 
           Nothing -> notifyEnter (Highlight state)
           Just hlState -> 
             if hlState == state then
               notifyLeave NoHighlight
             else
               identity
       )
    |> notifyTap (GoTo state)

jennas maybeHighlight clr state x =
  [ polygon [(x,23),(x,53),(x+25,53),(x+25,23)]
      |> filled ( case maybeHighlight of 
                    Nothing -> clr
                    Just hlState -> 
                      if hlState == state then
                        yellow
                      else
                        clr
                )
      |> addOutline (solid 0.5) (rgb 113 38 0)
  , text "Jenna's"
      |> size 3
      |> filled darkBrown
      |> move (x+8,30)
  , rect 3 5 |> filled grey
      |> move (x+1.5,30)
  , circle 0.75 |> filled black
      |> move (x + 1.5,31)
  , circle 0.75 |> filled black
      |> move (x + 1.5,29)
  , rect 3 5 |> filled grey
      |> move (x+25-1.5,30)
  , circle 0.75 |> filled black
      |> move (x +25- 1.5,31)
  , circle 0.75 |> filled black
      |> move (x +25- 1.5,29)
  ]
    |> group
    |> ( case maybeHighlight of 
           Nothing -> notifyEnter (Highlight state)
           Just hlState -> 
             if hlState == state then
               notifyLeave NoHighlight
             else
               identity
       )
    |> notifyTap (GoTo state)
       
pool maybeHighlight clr state =
  [ curve (-57.0, 1.6) [Pull (-43.8, -10.4) (-38.8, 1.5), Pull (-36.0, 12.8) (-27.7, 17.8), Pull (3.1, 40.5) (-39.1, 38.9), Pull (-69.1, 34.7) (-70.0, 25.1), Pull (-77.5, 10.5) (-57.0, 1.3)]
      |> filled ( case maybeHighlight of 
                    Nothing -> clr
                    Just hlState -> 
                      if hlState == state then
                        yellow
                      else
                        clr
                )
      |> addOutline (solid 0.5) (rgb 108 236 251)
      |> scale 0.5
      |> move (-5,-30)
  , text "Pool"
      |> size 3
      |> filled darkBrown
      |> move (-33,-22)
  ]
    |> group
    |> ( case maybeHighlight of 
           Nothing -> notifyEnter (Highlight state)
           Just hlState -> 
             if hlState == state then
               notifyLeave NoHighlight
             else
               identity
       )
    |> notifyTap (GoTo state)
   
friends maybeHighlight clr state =
  [ square 20 
      |> filled ( case maybeHighlight of 
                    Nothing -> clr
                    Just hlState -> 
                      if hlState == state then
                        yellow
                      else
                        clr
                )
      |> addOutline (solid 0.5) grey
      |> scale 0.5
  , text "Lily's"
      |> centered 
      |> size 3
      |> filled darkBrown
      |> move (0,1)
  , text "House"
      |> centered 
      |> size 3
      |> filled darkBrown
      |> move (0,-2)
  ]
    |> group
    |> rotate (degrees 45)
    |> move (22,-42)
    |> ( case maybeHighlight of 
           Nothing -> notifyEnter (Highlight state)
           Just hlState -> 
             if hlState == state then
               notifyLeave NoHighlight
             else
               identity
       )
    |> notifyTap (GoTo state)
   
mainHouse maybeHighlight clr state =
  [ square 20 
      |> filled ( case maybeHighlight of 
                    Nothing -> clr
                    Just hlState -> 
                      if hlState == state then
                        yellow
                      else
                        clr
                )
      |> addOutline (solid 0.5) grey
      |> scale 0.5
  , text "Your"
      |> centered 
      |> size 3
      |> filled darkBrown
      |> move (0,1)
  , text "House"
      |> centered 
      |> size 3
      |> filled darkBrown
      |> move (0,-2)
  ]
    |> group
    |> rotate (degrees 45)
    |> move (78,-38)
    |> ( case maybeHighlight of 
           Nothing -> notifyEnter (Highlight state)
           Just hlState -> 
             if hlState == state then
               notifyLeave NoHighlight
             else
               identity
       )
    |> notifyTap (GoTo state)

park maybeHighlight clr state =
  [ oval 30 25 
      |> filled ( case maybeHighlight of 
                    Nothing -> clr
                    Just hlState -> 
                      if hlState == state then
                        yellow
                      else
                        clr
                )
      |> addOutline (solid 0.5) grey
    , Park.rainbow |> move (-2,-4)
    ]
      |> group
      |> move (2,-30)
    |> ( case maybeHighlight of 
           Nothing -> notifyEnter (Highlight state)
           Just hlState -> 
             if hlState == state then
               notifyLeave NoHighlight
             else
               identity
       )
    |> notifyTap (GoTo state)

library maybeHighlight clr state =
  [ ngon 5 30 
      |> filled ( case maybeHighlight of 
                    Nothing -> clr
                    Just hlState -> 
                      if hlState == state then
                        yellow
                      else
                        clr
                )
      |> addOutline (solid 0.5) grey
      |> scale 0.5
  , text "The Five"
      |> centered 
      |> size 3
      |> filled darkBrown
      |> move (0,1)
  , text "Library"
      |> centered 
      |> size 3
      |> filled darkBrown
      |> move (0,-2)
  ]
    |> group
    |> rotate (degrees 5)
    |> move (0,38)
    |> ( case maybeHighlight of 
           Nothing -> notifyEnter (Highlight state)
           Just hlState -> 
             if hlState == state then
               notifyLeave NoHighlight
             else
               identity
       )
    |> notifyTap (GoTo state)
   
topSidewalk =
  curve (-92.9, 20.5) [Pull (-62.4, 20.9) (-31.9, 20.5), Pull (0.5, 25.4) (19.6, 9.6), Pull (47.0, -18.2) (71.3, -47.0)]
botSidewalk =
  curve (-92.5, 3.4) [Pull (-52.4, 3.9) (-12.2, 4.5), Pull (-0.2, 4.2) (14.4, -9.6), Pull (32.3, -29.1) (50.2, -48.6)]


type alias Model = { time : Float 
                   , highlight : Maybe State
                   }

update msg model = case msg of
                     Tick t _ -> { model | time = t }
                     Highlight hl -> { model | highlight = Just hl }
                     NoHighlight -> { model | highlight = Nothing }
                     _ -> model

init = { time = 0, highlight = Nothing }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)



