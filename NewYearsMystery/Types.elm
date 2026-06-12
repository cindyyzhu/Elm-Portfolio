type Msg = Tick Float GetKeyState
         | Kitchen2Backyard 
         | Kitchen2Bedroom 
         | Kitchen2Garage 
         | Backyard2Ravine 
         | Ravine2Pond 
         | Pond2Ravine 
         | Ravine2BirchGroveCres 
         | BirchGroveCres2Ravine 
         | MapleWay2Ravine 
         | Ravine2MapleWay 
         | Ravine2Backyard 
         | Backyard2Kitchen 
         | Bedroom2Kitchen 
         | Kitchen2Street 
         | Street2Kitchen 
         | Street2FriendsHouse 
         | FriendsHouse2Note 
         | Note2Street 
         | Street2Pool 
         | Street2PetStore 
         | Street2Park 
         | Street2Samosa 
         | Street2Bookstore 
         | Street2Library 
         | Street2HoneyBee 
         | Street2Convenience 
         | Street2SuperMart 
         | Pool2Street 
         | PetStore2Street 
         | Park2Street 
         | Samosa2Street 
         | Bookstore2Street 
         | Library2Street 
         | HoneyBee2Street 
         | Convenience2Street 
         | SuperMart2Street 
         | Pond2WisdomTree 
         | WisdomTree2Pond 
         -- for highlighting
         | Highlight State
         | NoHighlight
         | GoTo State

type State = MainKitchen 
           | MainBackyard 
           | Ravine 
           | Pond 
           | MapleWay 
           | BirchGroveCres 
           | SwimmingPool 
           | Garage 
           | ChildrensBedroom 
           | MainStreet 
           | PetStore 
           | SamosaEmporium 
           | Park 
           | Library 
           | Bookstore 
           | JennasSuperMart 
           | ConvenienceStore 
           | HoneyBeeBoutique 
           | FriendsHouse 
           | FriendsReadNote 
           | WisdomTree 

stateBit state = 
  case state of
    MainKitchen -> 1
    MainBackyard -> 2
    Ravine  -> 0
    Pond  -> 8
    MapleWay  -> 16
    BirchGroveCres  -> 32
    SwimmingPool  -> 64
    Garage  -> 128
    ChildrensBedroom  -> 256
    MainStreet  -> 0
    PetStore -> 512
    SamosaEmporium  -> 1024
    Park  -> 2048
    Library  -> 4096
    Bookstore  -> 8192
    JennasSuperMart  -> 16384
    ConvenienceStore -> 32768
    HoneyBeeBoutique -> 65536
    FriendsHouse  -> 131072
    FriendsReadNote  -> 0 -- 262144
    WisdomTree -> 4


myShapes model =
  [
    circle 5 |> filled red
      |> move (20 * sin model.time, 0)
  ]

type alias Model = { time : Float }

update msg model = case msg of
                     Tick t _ -> { time = t }
                     _ -> model

init = { time = 0 }

main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)



