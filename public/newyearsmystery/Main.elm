import Types exposing (Msg(..), State(..), stateBit)
import Ravine
import Kitchen
import Lib
import Bookstore
import Park
import SamosaEmporium
import WisdomTree
import HoneybeeBoutiqueFINAL
import Snowman
import MapleWay
import Pool
import AddysNoteToLily
import Bridge
import ChildrensBedroom
import ConvenienceStr
import FriendsHouseFINAL
import MainSt
import PetStore
import BirchGrove
import Garage
import JennasMart
import EndScene

import Bitwise

myShapes model =
    case model.state of
        MainKitchen  ->
            [ Kitchen.kitchenYay model
            , button "Exit to" "backyard" Kitchen2Backyard
                     |> move (75, 30)
            , button "Exit to" "bedroom" Kitchen2Bedroom
                     |> move (75, 10)
            , button "Exit to" "garage" Kitchen2Garage
                     |> move (75, -10)
            , button "Exit to" "Main St." Kitchen2Street
                     |> move (75, -30)
            ]
        MainBackyard  ->
            [ Snowman.snowman model
            , button "Exit to" "ravine" Backyard2Ravine
                     |> move (75, -10)
            , button "Exit to" "kitchen" Backyard2Kitchen
                     |> move (75, 10)
            ]
        Ravine  ->
            [ Ravine.ravine model
            , button "Exit to" "pond" Ravine2Pond
                     |> move (75, 30)
            , button "Exit to" "Birch Grove" Ravine2BirchGroveCres
                     |> move (75, 10)
            , button "Exit to" "Maple Way" Ravine2MapleWay
                     |> move (75, -10)
            , button "Exit to" "backyard" Ravine2Backyard
                     |> move (75, -30)
            ]
        Pond  ->
            [ Bridge.bridgeYay model
            , button "Exit to" "ravine" Pond2Ravine
                     |> move (75, 30)
            , button "Exit to" "Wisdom Tree" Pond2WisdomTree
                     |> move (75, 10)
            ]
        MapleWay  ->
            [ MapleWay.mapleway model
            , button "Exit to" "ravine" MapleWay2Ravine
                     |> move (75, 10)
            ]
        BirchGroveCres  ->
            [ BirchGrove.scene model.time 
                |> group
            , button "Exit to" "ravine" BirchGroveCres2Ravine
                     |> move (75, 10)
            ]
        SwimmingPool  ->
            [ Pool.pool model
            , button "Exit to" "Main St." Pool2Street
                     |> move (75, 10)
            ]
        Garage  ->
            [ Garage.garage model
            , button "Exit to" "kitchen" Kitchen2Garage
                     |> move (75, 10)
                    
            ]
        ChildrensBedroom  ->
            [ ChildrensBedroom.bedroom model
           , button "Exit to" "kitchen" Bedroom2Kitchen
                     |> move (75, 10)
            ]
        MainStreet  ->
          if model.visited == 262143 then
            [ EndScene.endScene model ]
          else
            [ MainSt.road model
            ]
        PetStore  ->
            [ PetStore.petstore model
            
            , button "Exit to" "Main St." PetStore2Street
                     |> move (75, 10)
            ]
        SamosaEmporium  ->
            [ SamosaEmporium.samosaEmporium model
            , button "Exit to" "Main St." Samosa2Street
                     |> move (75, 10)
            ]
        Park  ->
            [ Park.park model.time
            , button "Exit to" "Main St." Park2Street
                     |> move (75, 10)
            ]
        Library  ->
            [ Lib.library model
            , button "Exit to" "Main St." Library2Street
                     |> move (75, 10)
            ]
        Bookstore  ->
            [ Bookstore.bookstore model
            , button "Exit to" "Main St." Bookstore2Street
                     |> move (75, 10)
            ]
        JennasSuperMart  ->
            [ JennasMart.jennasmart model
            , button "Exit to" "Main St." SuperMart2Street
                     |> move (75, 10)
            ]
        ConvenienceStore  ->
            [ ConvenienceStr.conveniencestore model
            , button "Exit to" "Main St." Convenience2Street
                     |> move (75, 10)
            ]
        HoneyBeeBoutique  ->
            [ HoneybeeBoutiqueFINAL.honeybee model
            , button "Exit to" "Main St." HoneyBee2Street
                     |> move (75, 10)
            ]
        FriendsHouse  ->
            [ FriendsHouseFINAL.friendsHouse model
            , button "Open" "note!" FriendsHouse2Note
                     |> move (75, 10)
            ]
        FriendsReadNote  ->
            [ AddysNoteToLily.note
            , button "Exit to" "Main St." Note2Street
                     |> move (75, 10)
            ]
        WisdomTree  ->
            [ WisdomTree.wisdomTree model
            , button "Exit to" "pond" WisdomTree2Pond
                     |> move (75, 10)
            ]

button line1 line2 msg =
  [ rect 95 46 |> filled exitGreen
  , text line1 |> centered|> size 12
      |> filled white
      |> move (-16,6)
  , text line2 |> centered |> size 12
      |> filled white
      |> move (-16,-11)
  , polygon [ (21.2, 18.9), (44.8, 18.9), (44.9, -14.3), (42.5, -16.8), (38.7, -16.9), (40.8, -14.3), (37.8, -14.2), (35.2, -17.0), (18.9, -17.0), (21.0, -14.4), (21.0, 18.6)]
      |> filled white
  , curve (27.5, 6.3) [Pull (29.0, 6.3) (30.5, 6.3), Pull (29.2, 3.7) (28.0, 1.1), Pull (28.0, -2.1) (28.1, -5.4), Pull (24.4, -5.4) (20.6, -5.5), Pull (17.6, -5.6) (17.7, -8.3), Pull (24.0, -8.3) (30.4, -8.4), Pull (31.3, -8.2) (31.3, -7.2), Pull (31.2, -4.1) (31.2, -1.1), Pull (34.5, -7.0) (37.8, -12.8), Pull (39.4, -12.8) (41.1, -12.7), Pull (37.8, -6.0) (34.6, 0.6), Pull (35.6, 2.7) (36.7, 4.7), Pull (37.6, 3.3) (38.5, 2.0), Pull (41.6, 2.0) (44.7, 2.0), Pull (45.5, 2.0) (45.7, 2.9), Pull (45.6, 4.1) (44.6, 4.0), Pull (42.4, 4.0) (40.2, 4.0), Pull (38.8, 6.2) (37.4, 8.4), Pull (37.2, 8.9) (36.6, 9.0), Pull (31.8, 9.0) (26.9, 9.0), Pull (26.2, 9.1) (25.8, 8.6), Pull (24.4, 6.3) (23.0, 4.0), Pull (22.8, 3.3) (23.5, 2.6), Pull (24.5, 2.0) (25.3, 3.0), Pull (26.4, 4.7) (27.5, 6.4)]
      |> filled exitGreen
  , circle 3 |> filled exitGreen
      |> move (36.5,12.3)
  ]
    |> group
    |> scale 0.3
    |> notifyTap msg

exitGreen = rgb 50 150 90


update msg model =
    case msg of
        Tick t _ ->
            { model | time = t - model.startTime
                    , absoluteTime = t
                    }
        Kitchen2Backyard  ->
            case model.state of
                MainKitchen  ->
                    { model | state = MainBackyard
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit MainBackyard)
                            }

                otherwise ->
                    model
        Kitchen2Bedroom  ->
            case model.state of
                MainKitchen  ->
                    { model | state = ChildrensBedroom 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit ChildrensBedroom)
                            }

                otherwise ->
                    model
        Kitchen2Garage  ->
            case model.state of
                MainKitchen  ->
                    { model | state = Garage 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit Garage)
                            }

                Garage  ->
                    { model | state = MainKitchen 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit MainKitchen)
                            }

                otherwise ->
                    model
        Backyard2Ravine  ->
            case model.state of
                MainBackyard  ->
                    { model | state = Ravine 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Ravine2Pond  ->
            case model.state of
                Ravine  ->
                    { model | state = Pond 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit Pond)
                            }

                otherwise ->
                    model
        Pond2Ravine  ->
            case model.state of
                Pond  ->
                    { model | state = Ravine 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Ravine2BirchGroveCres  ->
            case model.state of
                Ravine  ->
                    { model | state = BirchGroveCres 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit BirchGroveCres)
                            }

                otherwise ->
                    model
        BirchGroveCres2Ravine  ->
            case model.state of
                BirchGroveCres  ->
                    { model | state = Ravine 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        MapleWay2Ravine  ->
            case model.state of
                MapleWay  ->
                    { model | state = Ravine 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Ravine2MapleWay  ->
            case model.state of
                Ravine  ->
                    { model | state = MapleWay 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit MapleWay)
                            }

                otherwise ->
                    model
        Ravine2Backyard  ->
            case model.state of
                Ravine  ->
                    { model | state = MainBackyard 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit MainBackyard)
                            }

                otherwise ->
                    model
        Backyard2Kitchen  ->
            case model.state of
                MainBackyard  ->
                    { model | state = MainKitchen 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit MainKitchen)
                            }

                otherwise ->
                    model
        Bedroom2Kitchen  ->
            case model.state of
                ChildrensBedroom  ->
                    { model | state = MainKitchen 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit MainKitchen)
                            }

                otherwise ->
                    model
        Kitchen2Street  ->
            case model.state of
                MainKitchen  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Street2Kitchen  ->
            case model.state of
                MainStreet  ->
                    { model | state = MainKitchen 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit MainKitchen)
                            }

                otherwise ->
                    model
        Street2FriendsHouse  ->
            case model.state of
                MainStreet  ->
                    { model | state = FriendsHouse 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit FriendsHouse)
                            }

                otherwise ->
                    model
        FriendsHouse2Note  ->
            case model.state of
                FriendsHouse  ->
                    { model | state = FriendsReadNote 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit FriendsReadNote)
                            }

                otherwise ->
                    model
        Note2Street  ->
            case model.state of
                FriendsReadNote  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit MainStreet)
                            }

                otherwise ->
                    model
        Street2Pool  ->
            case model.state of
                MainStreet  ->
                    { model | state = SwimmingPool 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit SwimmingPool)
                            }

                otherwise ->
                    model
        Street2PetStore  ->
            case model.state of
                MainStreet  ->
                    { model | state = PetStore 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit PetStore)
                            }

                otherwise ->
                    model
        Street2Park  ->
            case model.state of
                MainStreet  ->
                    { model | state = Park 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit Park)
                            }

                otherwise ->
                    model
        Street2Samosa  ->
            case model.state of
                MainStreet  ->
                    { model | state = SamosaEmporium 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit SamosaEmporium)
                            }

                otherwise ->
                    model
        Street2Bookstore  ->
            case model.state of
                MainStreet  ->
                    { model | state = Bookstore 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit Bookstore)
                            }

                otherwise ->
                    model
        Street2Library  ->
            case model.state of
                MainStreet  ->
                    { model | state = Library 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit Library)
                            }

                otherwise ->
                    model
        Street2HoneyBee  ->
            case model.state of
                MainStreet  ->
                    { model | state = HoneyBeeBoutique 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit HoneyBeeBoutique)
                            }

                otherwise ->
                    model
        Street2Convenience  ->
            case model.state of
                MainStreet  ->
                    { model | state = ConvenienceStore 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit ConvenienceStore)
                            }

                otherwise ->
                    model
        Street2SuperMart  ->
            case model.state of
                MainStreet  ->
                    { model | state = JennasSuperMart 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit JennasSuperMart)
                            }

                otherwise ->
                    model
        Pool2Street  ->
            case model.state of
                SwimmingPool  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        PetStore2Street  ->
            case model.state of
                PetStore  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Park2Street  ->
            case model.state of
                Park  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Samosa2Street  ->
            case model.state of
                SamosaEmporium  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Bookstore2Street  ->
            case model.state of
                Bookstore  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Library2Street  ->
            case model.state of
                Library  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        HoneyBee2Street  ->
            case model.state of
                HoneyBeeBoutique  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Convenience2Street  ->
            case model.state of
                ConvenienceStore  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        SuperMart2Street  ->
            case model.state of
                JennasSuperMart  ->
                    { model | state = MainStreet 
                            , startTime = model.absoluteTime
                            , time = 0
                            }

                otherwise ->
                    model
        Pond2WisdomTree  ->
            case model.state of
                Pond  ->
                    { model | state = WisdomTree 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit WisdomTree)
                            }

                otherwise ->
                    model
        WisdomTree2Pond  ->
            case model.state of
                WisdomTree  ->
                    { model | state = Pond 
                            , startTime = model.absoluteTime
                            , time = 0
                            , visited = Bitwise.or model.visited (stateBit Pond)
                            }

                otherwise ->
                    model
        
        Highlight hl -> { model | highlight = Just hl }
        
        NoHighlight -> { model | highlight = Nothing }
        
        GoTo state -> { model | state = state
                              , startTime = model.absoluteTime
                              , time = 0
                              , visited = Bitwise.or model.visited (stateBit state)
                              }

type alias Model =
    { time : Float
    , absoluteTime : Float
    , startTime : Float
    , state : State
    , highlight : Maybe State
    , visited : Int
    }

type alias Point = (Float, Float)

init : Model
init = { time = 0 
       , absoluteTime = 0
       , startTime = 0
       , state = MainKitchen 
       , highlight = Nothing
       , visited = 0
       }

    
main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)

    
    