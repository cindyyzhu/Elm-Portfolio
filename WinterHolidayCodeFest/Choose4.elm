module Choose4 exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import Array
import Random
import String

import Bee
import Squirrel
import Butterfly
import Dragonfly
import Ladybug
import Car
import Eye
import Clock
import Addition
import Bridge
import Exponents
import Water
import Mountain
import Ball
import Thermometer
import Carrot
import Erosion
import Can
import FinalCat
import Rainbow
import Anger
import Baby
import Penguiny
import Cherries
import Toothbrush
import Crabby
import Constellation
import Orange
import Basketball
import Blink
import North
import Snowman
import Lock
import Bubble
import Cactus
import Fear
import Notebook
import Flower
import BasketballCourt
import Grass
import Snail
import Zebra
import Snake
import Fairytale
import Juice
import Twig
import Candle
import HappyOrange
import Light
import FlickeringCandle
import Home
import Sunset
import Heart
import CD
import Castle
import Ghosts
import Up
import Boots
import Sun
import Snowflake
import Down
import Snowball
import Pencil
import Popcorn
import Door
import Santa
import Tree
import Goldfish
import Head1
import Moon
import Mermaid
import PartyHat
import Jellyfish
import Bear
import Compass
import Division
import Fish
import Frog
import Gift
import Ghosts
import Llama
import Lipstick
import Mug
import Ostrich
import Penguin
import Trefoil
import Turtle
import Umbrella
import Volleyball
import Watermelon

arrayLength = Array.length wordArray

getWord idx = case Array.get idx wordArray of
    Just w -> w
    Nothing -> (\ _ -> [], "")

stringToChars s = String.toList s

oneLetter tLeft badTime i c =
    let
        x = toFloat i * letterWidth - 40
        fade = if badTime == 0 then 1 else min 1 (tLeft / badTime)
    in
        text (String.fromChar c)
            |> fixedwidth
            |> filled (rgba 0 0 0 fade)
            |> move (x, -55)
wordArray = Array.fromList 
  [
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
  , Compass.pair
  , Division.pair
  , Fish.pair
  , Frog.pair
  , Gift.pair
  , Ghosts.pair
  , Llama.pair
  , Lipstick.pair
  , Mug.pair
  , Ostrich.pair
  , Penguin.pair
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

main = gameApp Tick { model = init, view = view, update = update, title = "Choose4" }


type alias Model = { time : Float
                   , animation : GuessState
                   , score : Int
                   , pics : List ( Float -> List (GraphicSVG.Shape Msg) )
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
       , badTime = pi
       , debug = ""
       }
type GuessState = Waiting
                | BadPick Pick Float
                | GoodPick Float
                | Startup
type Msg = Tick Float GetKeyState
         | RandIdx (List Int, Int)
         | Choice Pick
type Pick = Pick0 | Pick1 | Pick2 | Pick3
toString msg = case msg of
                  Tick t _ -> "Tick "++String.fromFloat t
                  RandIdx (idxs,idx) -> "RandIdx["++String.fromInt idx++"] "++(String.concat <| List.intersperse "," <| List.map String.fromInt idxs)
                  Choice Pick0 -> "Choice 0"
                  Choice Pick1 -> "Choice 1"
                  Choice Pick2 -> "Choice 2"
                  Choice Pick3 -> "Choice 3"
int2Pick i = case i of
               1 -> Pick1
               2 -> Pick2
               3 -> Pick3
               _ -> Pick0
listPick idx lst = case (idx,lst) of
                     (0, x :: _ ) -> x
                     (1, _ :: x :: _ ) -> x
                     (2, _ :: _ :: x :: _ ) -> x
                     (3, _ :: _ :: _ :: x :: _ ) -> x
                     (_, _) -> (\ _ -> [], "")
pickPositions = [ (Pick0, (-42, 36))
                , (Pick1, ( 42, 36))
                , (Pick2, (-42,-36))
                , (Pick3, ( 42,-36))
                ]
update : Msg -> Model -> Model
update msg m =
 let model = case msg of
               Tick _ _ -> m
               _ -> { m | debug = toString msg }
 in
  case msg of
    RandIdx (idxsBad,correct) ->
      let
          idxs = removeDups [] idxsBad
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
                   { model | animation = Waiting
                           , correct = int2Pick correct
                           , pics = List.map Tuple.first fourWords
                           , letters = stringToChars w
                   }
            else { model | nextRand = (idxs,correct) }

    Tick t _ ->
      let lastTime = if model.time > 0 then model.time else t
      in case model.animation of
           Startup ->  { model | time = t, animation = Startup }
           Waiting ->  { model | time = t, animation = Waiting }
           BadPick pick tLeft
             -> if tLeft < t - lastTime
                  then { model | time = t, animation = Waiting }
                  else { model | time = t, animation = BadPick pick (tLeft - (t - lastTime)) }
           GoodPick tLeft
             -> if tLeft < t - lastTime
                  then let
                         (idxs,correct) = model.nextRand
                         fourWords = List.map getWord idxs
                         w = Tuple.second <| listPick correct fourWords
                       in
                         { model | animation = Waiting
                                 , correct = int2Pick correct
                                 , pics = List.map Tuple.first fourWords
                                 , letters = stringToChars w
                                 , badTime = model.badTime * 0.9
                                 , time = t
                         }
                  else { model | time = t, animation = GoodPick (tLeft - (t - lastTime)) }

    Choice pick
      -> case model.animation of
           Waiting
             -> if pick == model.correct
                  then { model | animation = GoodPick model.badTime, score = model.score + 1 }
                  else { model | animation = BadPick pick model.badTime }
           other -> model

view : Model -> Collage Msg
view model = collage 192 128
  <| ( case model.animation of
           Startup ->  [ text "Read the word and tap on the picture!" |> size 20 |> filled (rgb 255 0 255) ]
           Waiting ->  ( List.map2 (drawPic model.time) model.pics pickPositions )
                       ++ ( List.indexedMap (oneLetter 0 1) model.letters)
                       ++ ( List.map2 (drawMsg model.time) model.pics pickPositions )
           BadPick pick tLeft
                   ->  ( List.map2 (drawBad pick tLeft) model.pics pickPositions )
                       ++ ( List.indexedMap (oneLetter 0 1) model.letters)
           GoodPick tLeft
                   ->  ( List.map2 (drawGood model.correct (max 0 (2 * (model.badTime - tLeft) / model.badTime)) model.time)
                                   model.pics
                                   pickPositions )
                       ++ ( List.indexedMap (oneLetter tLeft model.badTime) model.letters)
                       ++ [ "Score: " ++ String.fromInt model.score |> text |> bold |> fixedwidth |> filled (rgb (125 + 125 * sin (20 * model.time)) 0 0) |> move (10,-4) ]
     ) ++[ "Score: " ++ String.fromInt model.score |> text |> fixedwidth |> filled black |> move (10,-4)
         ]
drawMsg t pic (msg, pos) = group [ rect 80 55 |> filled (rgba 0 0 0 0) |> move pos |> notifyTap (Choice msg) ]
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

