import Addy
import BlowTorch
import Shovel
import SpeechBubbles exposing (speechBubbleLeft, narrationBubble, shantellSansFont) -- Your shapes go here!
type Actor = Robot

myShapes model =
  [
  endScene model
  
  ]
  
script = [
  (Robot, "After they visit all the places and then they go back home, they see Addy in the backyard")
  , (Robot, "")
  , (Robot, "YOU: There you are! I was looking for you all around town. Phewww, at least I know you")
  , (Robot, "are safe now.")
  , (Robot, "")
  , (Robot, "Addy: I’m sorry, I didn't mean to scare you. I have just been working on my new year’s")
  , (Robot, "resolution.")
  , (Robot, "")
  , (Robot, "YOU: Making a submarine to explore the ocean?")
  , (Robot, "")
  , (Robot, "Addy: NO! Haha, why would I do that, Mom, that is really dangerous. I am making a")
  , (Robot, "vegetable garden for our home.")
  , (Robot, "")
  , (Robot, "YOU: OHH. But every place I went, it just seemed like you were doing something")
  , (Robot, "dangerous which is why I was so worried. Weren’t you looking at a book on exploring")
  , (Robot, "the sea at the library?")
  , (Robot, "")
  , (Robot, "Addy: Oh Mom, I think this has been a really big misunderstanding! I was at the library")
  , (Robot, "reading how to plant a garden effectively.")
  , (Robot, "")
  , (Robot, "YOU: Weren’t you trying on a deep sea diver’s helmet at HoneyBee Boutique?")
  , (Robot, "")
  , (Robot, "Addy: Haha, I got distracted there! I was actually there to buy gardening gloves and")
  , (Robot, "an apron for myself.")
  , (Robot, "")
  , (Robot, "YOU: What about the metal sheet from the garage, buying a book on preserving")
  , (Robot, "vegetables, a blowtorch, string, buckets, shovel, borrowing Lily’s wagon?")
  , (Robot, "Were they all for the garden too?")
  , (Robot, "")
  , (Robot, "Addy: Yes! I wanted to make sure I knew what to do with the vegetables after they grew.")
  , (Robot, "Everything else is a tool to build the garden. As for the blow torch…well the book at the")
  , (Robot, "library told me that fall is the best time to plant seeds but since the ground is frozen")
  , (Robot, "in the winter, it needs to be warmed up. That is why I bought a blowtorch. I noticed")
  , (Robot, "that I didn’t have enough money to buy seeds so I also used the shovel to dig up some")
  , (Robot, "wild garlic and asparagus from the forest.")
  , (Robot, "")
  , (Robot, "YOU: That is why you took money from your piggy bank this morning!")
  , (Robot, "It all makes sense now. Gosh Addy, you really gave me a scare today.")
  , (Robot, "")
  , (Robot, "Addy: I’m sorry Mom, I didn’t tell you because I wanted to surprise everyone.")
  , (Robot, "")
  , (Robot, "YOU: I’m glad that you chose to follow through with this resolution. I think it is a")
  , (Robot, "really good one and by the end of the year our house will have a beautiful garden with")
  , (Robot, "delicious vegetables for us to eat.")
  
 ]

endScene model = group [
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
      
  , snowFalling model.time
 
 , BlowTorch.blowtorch
 |> scale 0.25
 |> move (80, -30)
 , Shovel.shovel
 |> scale 0.5
 |> move (50, -30)
      
   , Addy.addy
   |> scale 0.75
   |> move (-20, -10)
   
    , narrationBubble black (shantellSansFont) script 70 Robot (0.7*model.time)
      |> scale 1
      |> move (0,50)
      
   
 ]
snowFalling t = List.map ( \ idx -> snow
                |> move (10 * toFloat idx, repeatDistance -15 150 70 (t + 5 * sin (toFloat idx))))
             (List.range -15 50) |> group
             
snow = group
  [
    circle 1.5
      |> filled white
  ]
  