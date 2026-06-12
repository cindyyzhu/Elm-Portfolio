-- Your shapes go here!
import BubblesTheFloatingTube

import SpeechBubbles exposing (speechBubbleLeft, shantellSansFont) -- Your shapes go here!
type Actor = Robot

script = 
  [ (Robot," HEY! Long time no see haha. It gets really lonely")
  , (Robot, "at the pool especially since it's winter. Are you")
  , (Robot, "here to find something as well? That is why Addy")
  , (Robot, "was here this morning. She was here to find her")
  , (Robot, "shovel, very precarious of her forgetting such an ")
  , (Robot, "important object. What is she using the shovel for? ")
  , (Robot, "I am not really sure but I hope you find out soon.")
  , (Robot, "I hope it's not another pool!")
  , (Robot, "This town ain't big enough for two pools.")
  
  ] 
  
myShapes model =
  [
     pool model
  ]

pool model = group [
  curve (9.5925,-10.94) [Pull (60.124,-14.23) (54.857,-28.92),Pull (52.516,-39.56) (29.976,-49.01),Pull (10.808,-55.11) (-51.55,-43.01),Pull (-71.00,-35.62) (-53.65,-22.03),Pull (-37.12,-10.78) (-14.38,-11.54),Pull (-1.798,-11.24) (9.5925,-10.94)]
  |> filled (rgb 217 237 236)
  
  , 
  curve (-96.22,63.700) [Pull (-96.07,30.276) (-95.92,-3.147),Pull (-62.85,2.7023) (-25.77,-2.847),Pull (10.645,-10.54) (37.470,-2.248),Pull (67.501,13.099) (87.531,4.0468),Pull (90.679,0.5983) (93.826,0.1498),Pull (94.725,27.878) (95.625,55.606),Pull (0,59.653) (-96.22,63.700)]
  |> filled (rgb 217 237 236)
  , 
  curve (-95.92,-3.147) [Pull (-65.95,3.6032) (-10.79,-5.245),Pull (11.139,-8.646) (36.871,-2.847),Pull (68.201,12.299) (86.332,4.6463),Pull (88.730,2.5480) (91.128,0.4496)]
  |> outlined (solid 0.5) black
  
  , rect 1000 20
  |> filled (rgb 217 237 236)
  |> move (0, 60)
  , BubblesTheFloatingTube.floatee
  |> scale 0.4
 ,  speechBubbleLeft (solid 0.5) black (shantellSansFont) script 50 Robot (0.8*model.time)
      |> scale 0.9
      |> move (40,20) 

 ]