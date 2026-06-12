module WinterHolidayCodeFest.Main exposing (..)

import WinterHolidayCodeFest.Bee as Bee
import WinterHolidayCodeFest.Squirrel as Squirrel
import WinterHolidayCodeFest.Butterfly as Butterfly
import WinterHolidayCodeFest.Dragonfly as Dragonfly
import WinterHolidayCodeFest.Ladybug as Ladybug
import WinterHolidayCodeFest.Car as Car
import WinterHolidayCodeFest.Eye as Eye
import WinterHolidayCodeFest.Clock as Clock
import WinterHolidayCodeFest.Addition as Addition
import WinterHolidayCodeFest.Bridge as Bridge
import WinterHolidayCodeFest.Exponents as Exponents
import WinterHolidayCodeFest.Water as Water
import WinterHolidayCodeFest.Mountain as Mountain
import WinterHolidayCodeFest.Ball as Ball
import WinterHolidayCodeFest.Thermometer as Thermometer
import WinterHolidayCodeFest.Carrot as Carrot
import WinterHolidayCodeFest.Erosion as Erosion
import WinterHolidayCodeFest.Can as Can
import WinterHolidayCodeFest.FinalCat as FinalCat
import WinterHolidayCodeFest.Rainbow as Rainbow
import WinterHolidayCodeFest.Anger as Anger
import WinterHolidayCodeFest.Baby as Baby
import WinterHolidayCodeFest.Penguiny as Penguiny
import WinterHolidayCodeFest.Cherries as Cherries
import WinterHolidayCodeFest.Toothbrush as Toothbrush
import WinterHolidayCodeFest.Crabby as Crabby
import WinterHolidayCodeFest.Constellation as Constellation
import WinterHolidayCodeFest.Orange as Orange
import WinterHolidayCodeFest.Basketball as Basketball
import WinterHolidayCodeFest.Blink as Blink
import WinterHolidayCodeFest.North as North
import WinterHolidayCodeFest.Snowman as Snowman
import WinterHolidayCodeFest.Lock as Lock
import WinterHolidayCodeFest.Bubble as Bubble
import WinterHolidayCodeFest.Cactus as Cactus
import WinterHolidayCodeFest.Fear as Fear
import WinterHolidayCodeFest.Notebook as Notebook
import WinterHolidayCodeFest.Flower as Flower
import WinterHolidayCodeFest.BasketballCourt as BasketballCourt
import WinterHolidayCodeFest.Grass as Grass
import WinterHolidayCodeFest.Snail as Snail
import WinterHolidayCodeFest.Zebra as Zebra
import WinterHolidayCodeFest.Snake as Snake
import WinterHolidayCodeFest.Fairytale as Fairytale
import WinterHolidayCodeFest.Juice as Juice
import WinterHolidayCodeFest.Twig as Twig
import WinterHolidayCodeFest.Candle as Candle
import WinterHolidayCodeFest.HappyOrange as HappyOrange
import WinterHolidayCodeFest.Light as Light
import WinterHolidayCodeFest.FlickeringCandle as FlickeringCandle
import WinterHolidayCodeFest.Home as Home
import WinterHolidayCodeFest.Sunset as Sunset
import WinterHolidayCodeFest.Heart as Heart
import WinterHolidayCodeFest.CD as CD
import WinterHolidayCodeFest.Castle as Castle
import WinterHolidayCodeFest.Ghosts as Ghosts
import WinterHolidayCodeFest.Up as Up
import WinterHolidayCodeFest.Boots as Boots
import WinterHolidayCodeFest.Sun as Sun
import WinterHolidayCodeFest.Snowflake as Snowflake
import WinterHolidayCodeFest.Down as Down
import WinterHolidayCodeFest.Snowball as Snowball
import WinterHolidayCodeFest.Pencil as Pencil
import WinterHolidayCodeFest.Popcorn as Popcorn
import WinterHolidayCodeFest.Door as Door
import WinterHolidayCodeFest.Santa as Santa
import WinterHolidayCodeFest.Tree as Tree
import WinterHolidayCodeFest.Goldfish as Goldfish
import WinterHolidayCodeFest.Head1 as Head1
import WinterHolidayCodeFest.Moon as Moon
import WinterHolidayCodeFest.Mermaid as Mermaid
import WinterHolidayCodeFest.PartyHat as PartyHat
import WinterHolidayCodeFest.Jellyfish as Jellyfish
import WinterHolidayCodeFest.Bear as Bear
import WinterHolidayCodeFest.Compass as Compass
import WinterHolidayCodeFest.Division as Division
import WinterHolidayCodeFest.Fish as Fish
import WinterHolidayCodeFest.Frog as Frog
import WinterHolidayCodeFest.Gift as Gift
import WinterHolidayCodeFest.Ghosts as Ghost
import WinterHolidayCodeFest.Llama as Llama
import WinterHolidayCodeFest.Lipstick as Lipstick
import WinterHolidayCodeFest.Mug as Mug
import WinterHolidayCodeFest.Ostrich as Ostrich
import WinterHolidayCodeFest.Penguin as Penguin
import WinterHolidayCodeFest.Trefoil as Trefoil
import WinterHolidayCodeFest.Turtle as Turtle
import WinterHolidayCodeFest.Umbrella as Umbrella
import WinterHolidayCodeFest.Volleyball as Volleyball
import WinterHolidayCodeFest.Watermelon as Watermelon


wordArray = Array.fromList 
  [
  -- put your (word,animation)s imported from Wordathon modules here
    Bee.pair
  , Squirrel.pair
  , Butterfly.pair
  , Dragonfly.pair
  , Ladybug.pair
  , Car.pair
  , Eye.pair
  , Ghosts.pair
  , Clock.pair
  , Addition.pair
  , Bridge.pair
  , Exponents.pair
  , Water.pair
  , Mountain.pair
  , Ball.pair
  , Thermometer.pair
  , Carrot.pair
  , Erosion.pair
  , Can.pair
  , FinalCat.pair
  , Rainbow.pair
  , Anger.pair
  , Baby.pair
  , Penguiny.pair
  , Cherries.pair
  , Toothbrush.pair
  , Crabby.pair
  , Constellation.pair
  , Orange.pair
  , Basketball.pair
  , Blink.pair
  , North.pair
  , Snowman.pair
  , Lock.pair
  , Bubble.pair
  , Cactus.pair
  , Fear.pair
  , Notebook.pair
  , Flower.pair
  , BasketballCourt.pair
  , Grass.pair
  , Snail.pair
  , Zebra.pair
  , Snake.pair
  , Fairytale.pair
  , Juice.pair
  , Twig.pair
  , Candle.pair
  , HappyOrange.pair
  , Light.pair
  , FlickeringCandle.pair
  , Home.pair
  , Sunset.pair
  , Ball.pair
  , Heart.pair
  , CD.pair
  , Castle.pair
  , Up.pair
  , Boots.pair
  , Sun.pair
  , Snowflake.pair 
  , Down.pair
  , Snowball.pair
  , Pencil.pair
  , Popcorn.pair
  , Door.pair
  , Santa.pair
  , Tree.pair
  , Goldfish.pair
  , Head1.pair
  , Moon.pair
  , Mermaid.pair
  , PartyHat.pair
  , Jellyfish.pair
  , Bear.pair
  , Blink.pair
  , Bridge.pair
  , Clock.pair
  , Compass.pair
  , Division.pair
  , Door.pair
  , Fish.pair
  , Frog.pair
  , Gift.pair
  , Ghost.pair
  , Head1.pair
  , Llama.pair
  , Lipstick.pair
  , Mug.pair
  , Ostrich.pair
  , Penguin.pair
  , Snowman.pair
  , Squirrel.pair
  , Thermometer.pair
  , Trefoil.pair
  , Turtle.pair
  , Umbrella.pair
  , Volleyball.pair
  , Watermelon.pair

  ]

myTitle = "Choose4"
timeToDrop = 1
halfToAppear = 5
timeToAppear = 2 * halfToAppear
letterWidth = 7
dScale = 0.4375 -- 7/16 < 1/2

type alias Model = { time : Float
                   , animation : GuessState
                   , score : Int
                   , pics : List ( Float -> List (Shape Msg) )
                   , correct : Pick
                   , letters : List Char
                   , nextRand : (List Int, Int)
                   , badTime : Float
                   , debug : String
                   }
init : Model
init = { time = 0
       , animation = Startup
       , score = 0
       , pics = [ \ _ -> [],  \ _ -> [],  \ _ -> [],  \ _ -> []]
       , correct = Pick1
       , letters = ['n','o','t',' ','r','e','a','d','y']
       , nextRand = ([-1,-1,-1,-1],0)
       , badTime = pi -- time for the bad-pick animation
       , debug = ""
       }
-- phase of the game
type GuessState = Waiting              -- waiting for click
                | BadPick Pick Float   -- animating bad pick, with time in seconds left
                | GoodPick Float       -- animating good pick, with time in seconds left
                | Startup              -- waiting for the first random numbers
type Msg = Tick Float GetKeyState
         | RandIdx (List Int, Int)  -- four pics to display and 0..3 for the one which will be correct
         | Choice Pick              -- message for button
-- type allowing 4 "picks"
type Pick = Pick0 | Pick1 | Pick2 | Pick3
-- function to show the message to help us understand our program
toString msg = case msg of
                  Tick t _ -> "Tick "++String.fromFloat t
                  RandIdx (idxs,idx) -> "RandIdx["++String.fromInt idx++"] "++(String.concat <| List.intersperse "," <| List.map String.fromInt idxs)
                  Choice Pick0 -> "Choice 0"
                  Choice Pick1 -> "Choice 1"
                  Choice Pick2 -> "Choice 2"
                  Choice Pick3 -> "Choice 3"
-- convert a (random) Int to a Pick
int2Pick i = case i of
               1 -> Pick1
               2 -> Pick2
               3 -> Pick3
               _ -> Pick0
-- get one of the first 4 things from the word list, otherwise make it blank
listPick idx lst = case (idx,lst) of
                     (0, x :: _ ) -> x
                     (1, _ :: x :: _ ) -> x
                     (2, _ :: _ :: x :: _ ) -> x
                     (3, _ :: _ :: _ :: x :: _ ) -> x
                     (_, _) -> (\ _ -> [], "")
-- where the different picks will show up on the screen
pickPositions = [ (Pick0, (-42, 36))
                , (Pick1, ( 42, 36))
                , (Pick2, (-42,-36))
                , (Pick3, ( 42,-36))
                ]
update : Msg -> Model -> ( Model, Cmd Msg )
update msg m =
 let model = case msg of
               Tick _ _ -> m
               _ -> { m | debug = toString msg }
 in
  case msg of
    RandIdx (idxsBad,correct) ->
      let
          idxs = removeDups [] idxsBad

          -- WARNING will recurse infinitely if arrayLength < 4
          removeDups uniques next =
            case next of
              [] -> uniques
              n :: ns -> removeDups ((fix uniques n)::uniques) ns

          fix uniques n = if List.member n uniques
                          then if n+1 == arrayLength then fix uniques 0 else fix uniques (n+1)
                          else n

      in
          if model.animation == Startup
                                then let
                                       fourWords = List.map getWord idxs
                                       w = Tuple.second <| listPick correct fourWords
                                     in
                                       ( { model | animation = Waiting
                                                 , correct = int2Pick correct
                                                 , pics = List.map Tuple.first fourWords
                                                 , letters = stringToChars w
                                         }
                                       , getRandChoices )

                                else ( { model | nextRand = (idxs,correct) }, Cmd.none )

    Tick t _ ->
      let lastTime = if model.time > 0 then model.time else t
      in case model.animation of
           Startup ->  ( { model | time = t
                                 , animation = Startup
                         }
                       , Cmd.none )
           Waiting ->  ( { model | time = t
                               , animation = Waiting
                         }
                       , Cmd.none )
           BadPick pick tLeft
             -> if tLeft < t - lastTime
                  then ( { model | time = t
                               , animation = Waiting
                         }
                       , Cmd.none )
                  else ( { model | time = t
                               , animation = BadPick pick (tLeft - (t - lastTime))
                         }
                       , Cmd.none )
           GoodPick tLeft
             -> if tLeft < t - lastTime
                  then let
                         (idxs,correct) = model.nextRand
                         fourWords = List.map getWord idxs
                         w = Tuple.second <| listPick correct fourWords
                       in
                         ( { model | animation = Waiting
                                   , correct = int2Pick correct
                                   , pics = List.map Tuple.first fourWords
                                   , letters = stringToChars w
                                   , badTime = model.badTime * 0.9
                                   , time = t
                           }
                         , getRandChoices )
                  else ( { model | time = t
                               , animation = GoodPick (tLeft - (t - lastTime))
                         }
                       , Cmd.none )

    Choice pick
      -> case model.animation of
           Waiting
             -> if pick == model.correct
                  then
                    ( { model | animation = GoodPick <| model.badTime, score = model.score + 1 }, getRandChoices )
                  else
                    ( { model | animation = BadPick pick model.badTime }, Cmd.none )
           other -> ( model , Cmd.none )
view : Model -> Collage Msg
view model = collage 192 128
  <| ( case model.animation of
           Startup ->  [ text "Read the word and tap on the picture!" |> size 20 |> filled (rgb 255 0 255) ]
           Waiting ->  ( List.map2 (drawPic model.time) model.pics pickPositions )
                       ++
                       ( List.indexedMap (oneLetter 0 1) model.letters)
                       ++ ( List.map2 (drawMsg model.time) model.pics pickPositions )

           BadPick pick tLeft
                   ->  ( List.map2 (drawBad pick tLeft) model.pics pickPositions )
                       ++
                       ( List.indexedMap (oneLetter 0 1) model.letters)
           GoodPick tLeft
                   ->  ( List.map2 (drawGood model.correct (max 0 (2 * (model.badTime - tLeft) / model.badTime)) model.time)
                                   model.pics
                                   pickPositions )
                       ++
                       ( List.indexedMap (oneLetter tLeft model.badTime) model.letters)
                       ++
                       [ "Score: " ++ String.fromInt model.score |> text |> bold |> fixedwidth |> filled (rgb (125 + 125 * sin (20 * model.time)) 0 0) |> move (10,-4) ]
     ) ++[ "Score: " ++ String.fromInt model.score |> text |> fixedwidth |> filled black |> move (10,-4)
         -- when you make your own game, you can use this to display debug information
         --, model.debug |> text |> filled blue |> move (-86,-20)
         ]
drawMsg t pic (msg, pos) = group [ rect 80 55 |> filled (rgba 0 0 0 0) |> move pos |> notifyTap (Choice msg)                                    ]
drawPic t pic (msg, pos) = (group <| pic t) |> clip (rect 192 128 |> ghost) |> scale dScale |> move pos
drawBad pick t pic (msg, pos) = if pick == msg
                                  then ((group <| pic t) |> move (10 * cos (30*t),0)) |> clip (rect 192 128 |> ghost) |> scale dScale |> move pos
                                  else (group <| pic t) |> clip (rect 192 128 |> ghost) |> scale dScale |> move pos
drawGood pick frac t pic (msg, pos) = if pick == msg
                                  then ((group <| pic t)) |> clip (rect 192 128 |> ghost) |> scale dScale |> move pos
                                  else (group <| pic t ++ [rect 192 128 |> filled (rgba 255 255 255 frac)] ) |> clip (rect 192 128 |> ghost) |> scale dScale |> move pos
getRandChoices = Random.generate RandIdx (Random.map5 ( \ i j k l c -> ([i,j,k,l],c) ) oneRandIdx oneRandIdx oneRandIdx oneRandIdx rand0to3)
oneRandIdx = Random.int 0 (arrayLength - 1)
rand0to3   = Random.int 0 3

pair = (myShapes, word)

