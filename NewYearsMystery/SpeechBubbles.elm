module SpeechBubbles exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (Pull(..))



-- Your shapes go here!
myShapes model =
  [
    
  ]


type alias Script actor = List (actor,String)

-- things for comics frames

scalePoint s (x,y) = (s*x,s*y)

frame1poly =  [(-94,62), (-28,62),(-30,24),(-94,22)]
frame2poly =  [(-26,62), (24,62),(35,27),(-28,24)]
frame3poly =  [( 26,62), (94,62),(94,30),(37,27)]
frame4poly =  [(-94,20), (8,24),(8,-22),(-94,-18)]
frame5poly =  [(10,24), (94,28),(94,-24),(10,-22)]
frame6poly =  [(-94,-20), (-30,-22),(-32,-62),(-94,-62)]
frame7poly =  [(-28,-22),(26,-24),(35,-62),(-30,-62)]
frame8poly =  [(28,-24), (94,-26),(94,-62),(37,-62)]

thisPoly frameNumber = case modBy 8 frameNumber of
             1 -> frame1poly
             2 -> frame2poly
             3 -> frame3poly
             4 -> frame4poly
             5 -> frame5poly
             6 -> frame6poly
             7 -> frame7poly
             _ -> frame8poly
             
centroid ps =
  let
      addOne num (sumx,sumy) xys =
        case xys of
          ((x,y)::rest) -> addOne (num+1) (sumx+x,sumy+y) rest
          [] -> (sumx / num, sumy / num)
  in
    addOne 0 (0,0) ps

drawFrame thisFrame freezeTime poly =
    group [ group (thisFrame freezeTime)
              |> move (scalePoint 1 <| centroid poly)
          ]
      |> clip (polygon poly |> ghost)

drawAnimFrame animationFrac thisFrame t poly =
  group [
   rect 192 128 |> filled (rgba 0 0 0 (0.5*(1-animationFrac)))
   ,group [ group (thisFrame t)
              |> move (scalePoint animationFrac <| centroid poly)
          ]
      |> clip (polygon poly |> ghost |> move (scalePoint (animationFrac-1) <| centroid poly))
      |> scale (1.75 - 0.75 * animationFrac)
    ]

--fixes all text bubbles
textSpeed = 2 --overall speed
bubbleClr = white
hBubbleClr = (rgb 255 194 205)
textHeight = 4
scriptSpeed = textHeight

ralewayFont = customFont "Raleway"
architectsDaughterFont = customFont "Architects Daughter"
gentiumBookFont = customFont "Gentium Book Basic"
poppinsFont = customFont "Poppins"
quicksandFont = customFont "Quicksand"
satisfyFont = customFont "Satisfy"
shantellSansFont = customFont "Shantell Sans"
splineSansMonoFont = customFont "Spline Sans Mono"
blackAndWhiteFont = customFont "Black And White Picture"
indieFlowerFont = customFont "Indie Flower"
lailaFont = customFont "Laila"
novaMonoFont = customFont "Nova Mono"
sourceCodeProFont = customFont "Source Code Pro"


speechBubbleLeft : LineType -> Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
speechBubbleLeft line textClr fontStyle script width actor t =
  let
    bubble = curve (-width*0.5,-8)  [ Pull (-width*0.5 + 5,-8) (-width*0.5 + 7,-4)
                                     , Pull ( width*0.5 + 2    , -8) ( width*0.5    ,1)
                                     , Pull ( width*0.5    ,  8) ( 0            ,7)
                                     , Pull (-width*0.5    ,  8) (-width*0.5    ,2)
                                     , Pull (-width*0.5    , -2) (-width*0.5 + 3,-3)
                                     , Pull (-width*0.5 + 5,-6) (-width*0.5 + 0,-8)
                                     ]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script (width/15)
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr
      , contents |> move (1.5 - 0.5*width,textSpeed *t) --moves position of text
          |> clip (bubble |> ghost)
      , bubble |> outlined line textClr
      ]
    else
      []

speechBubbleRight : LineType -> Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
speechBubbleRight line textClr fontStyle script width actor t =
  let
    bubble = curve (-width*0.5,-8)  [ Pull (-width*0.5 + 5,-8) (-width*0.5 + 7,-4)
                                     , Pull ( width*0.5 + 2    , -8) ( width*0.5    ,1)
                                     , Pull ( width*0.5    ,  8) ( 0            ,7)
                                     , Pull (-width*0.5    ,  8) (-width*0.5    ,2)
                                     , Pull (-width*0.5    , -2) (-width*0.5 + 3,-3)
                                     , Pull (-width*0.5 + 5,-6) (-width*0.5 + 0,-8)
                                     ]
    --bubble = curve (-40,-8) [Pull (-35,-8) (-33,-4), Pull (42,-8) (40,1), Pull (40,8) (0, 7), Pull (-40,8) (-40,2), Pull (-40,-2) (-37,-3), Pull (-35,-6) (-40,-8) ]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script (width/15)
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
    scale 2 <| group <|
      if isVisible then
        [ bubble |> filled bubbleClr |> mirrorX
        , contents |> move (1.5 - 0.5*width,textSpeed * t)
            |> clip (bubble |> ghost |> mirrorX )
        , bubble |> outlined line textClr |> mirrorX
        ]
      else
        []

mkScriptFor fontStyle textClr actor theScript offset =
  let
      mkTxt idx txt = text txt |> size 2 |> fontStyle |> filled textClr |> move (offset,-textHeight * idx)
      getNext thisActor (lastActor,idx) moreScript =
        case moreScript of
          ((newActor,newTxt) :: rest) ->
            let
                newIdx = if newActor == lastActor then idx + 1 else idx + 1.75
            in
              if newActor == thisActor then
                (mkTxt newIdx newTxt,newIdx) :: (getNext thisActor (newActor,newIdx) rest)
              else
                getNext thisActor (newActor,newIdx) rest
          [] ->
            []
      shapesAndVisibility =
        case theScript of
              ((newActor,newTxt) :: rest) -> getNext actor (newActor,0.5) theScript
              [] -> []

  in
    ( group <| List.map Tuple.first shapesAndVisibility
    , List.map Tuple.second shapesAndVisibility
    )

thoughtBubbleLeft : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
thoughtBubbleLeft textClr fontStyle script width actor t =
  let
    bubble = 
      let w = (width+5)/40
      in curve (-19.63*w,2.8477*0.5) [Pull (-18.73*w,8.7951*0.5) (-13.03*w,9.4426*0.5)
                                     ,Pull (-8.993*w,15.691*0.5) (-3.147*w,11.540*0.5)
                                     ,Pull (0.8490*w,15.589*0.5) (5.5456*w,14.838*0.5)
                                     ,Pull (11.542*w,14.041*0.5) (12.440*w,7.9437*0.5)
                                     ,Pull (19.737*w,6.1973*0.5) (19.634*w,-1.049*0.5)
                                     ,Pull (18.738*w,-9.246*0.5) (9.1428*w,-7.943*0.5)
                                     ,Pull (6.5960*w,-13.14*0.5) (1.0491*w,-13.03*0.5)
                                     ,Pull (-2.748*w,-13.39*0.5) (-5.845*w,-9.742*0.5)
                                     ,Pull (-15.79*w,-11.89*0.5) (-15.43*w,-2.847*0.5)
                                     ,Pull (-20.03*w,-1.600*0.5) (-19.63*w,2.8477*0.5)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script 0
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr
      , contents |> move (-0.4*width,textSpeed *t) --moves position of text 1.5 - 0.5*width,textSpeed *t
          |> clip (bubble |> ghost )
      , bubble |> outlined (solid 0.25) textClr
      , circle 1.5 |> filled bubbleClr |> move (1-width/2,-7)
      , circle 1.5 |> outlined (solid 0.25) textClr |> move (1-width/2,-7)
      , circle 1 |> filled bubbleClr |> move (-1-width/2,-10)
      , circle 1 |> outlined (solid 0.25) textClr |> move (-1-width/2,-10)
      ]
    else
      []

thoughtBubbleRight : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
thoughtBubbleRight textClr fontStyle script width actor t =
  let
    bubble = 
      let w = (width+5)/40
      in curve (-19.63*w,2.8477*0.5) [Pull (-18.73*w,8.7951*0.5) (-13.03*w,9.4426*0.5)
                                     ,Pull (-8.993*w,15.691*0.5) (-3.147*w,11.540*0.5)
                                     ,Pull (0.8490*w,15.589*0.5) (5.5456*w,14.838*0.5)
                                     ,Pull (11.542*w,14.041*0.5) (12.440*w,7.9437*0.5)
                                     ,Pull (19.737*w,6.1973*0.5) (19.634*w,-1.049*0.5)
                                     ,Pull (18.738*w,-9.246*0.5) (9.1428*w,-7.943*0.5)
                                     ,Pull (6.5960*w,-13.14*0.5) (1.0491*w,-13.03*0.5)
                                     ,Pull (-2.748*w,-13.39*0.5) (-5.845*w,-9.742*0.5)
                                     ,Pull (-15.79*w,-11.89*0.5) (-15.43*w,-2.847*0.5)
                                     ,Pull (-20.03*w,-1.600*0.5) (-19.63*w,2.8477*0.5)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script 0
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr
      , contents |> move (-0.4*width,textSpeed *t) --moves position of text 1.5 - 0.5*width,textSpeed *t
          |> clip (bubble |> ghost )
      , bubble |> outlined (solid 0.25) textClr
      , circle 1.5 |> filled bubbleClr |> move (-5+width/2,-8)
      , circle 1.5 |> outlined (solid 0.25) textClr |> move (-5+width/2,-8)
      , circle 1 |> filled bubbleClr |> move (-2+width/2,-10)
      , circle 1 |> outlined (solid 0.25) textClr |> move (-2+width/2,-10)
      ]
    else
      []

shoutBubbleLeft : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
shoutBubbleLeft textClr fontStyle script width actor t =
  let
    bubble = 
      let w = (width+5)/40
      in 
        curve (-11.84*w,-24.13*0.5) [Pull (-7.644*w,-16.93*0.5) (-3.447*w,-9.742*0.5)
                                    ,Pull (-6.295*w,-11.24*0.5) (-9.142*w,-12.74*0.5)
                                    ,Pull (-9.742*w,-10.64*0.5) (-10.34*w,-8.543*0.5)
                                    ,Pull (-13.93*w,-9.592*0.5) (-17.53*w,-10.64*0.5)
                                    ,Pull (-17.23*w,-7.943*0.5) (-16.93*w,-5.245*0.5)
                                    ,Pull (-19.93*w,-4.646*0.5) (-22.93*w,-4.046*0.5)
                                    ,Pull (-20.53*w,-1.648*0.5) (-18.13*w,0.7494*0.5)
                                    ,Pull (-20.83*w,2.2482*0.5) (-23.53*w,3.7470*0.5)
                                    ,Pull (-20.53*w,5.0960*0.5) (-17.53*w,6.4449*0.5)
                                    ,Pull (-18.88*w,9.2927*0.5) (-20.23*w,12.140*0.5)
                                    ,Pull (-17.08*w,11.091*0.5) (-13.93*w,10.042*0.5)
                                    ,Pull (-13.78*w,12.740*0.5) (-13.63*w,15.437*0.5)
                                    ,Pull (-11.39*w,13.339*0.5) (-9.142*w,11.241*0.5)
                                    ,Pull (-8.093*w,13.189*0.5) (-7.044*w,15.138*0.5)
                                    ,Pull (-4.796*w,13.189*0.5) (-2.548*w,11.241*0.5)
                                    ,Pull (-0.899*w,13.639*0.5) (0.7494*w,16.037*0.5)
                                    ,Pull (2.3981*w,13.189*0.5) (4.0468*w,10.341*0.5)
                                    ,Pull (7.0444*w,12.889*0.5) (10.042*w,15.437*0.5)
                                    ,Pull (10.491*w,12.290*0.5) (10.941*w,9.1428*0.5)
                                    ,Pull (14.238*w,9.7423*0.5) (17.536*w,10.341*0.5)
                                    ,Pull (16.337*w,7.7939*0.5) (15.138*w,5.2459*0.5)
                                    ,Pull (18.885*w,4.3466*0.5) (22.632*w,3.4473*0.5)
                                    ,Pull (19.484*w,1.4988*0.5) (16.337*w,-0.449*0.5)
                                    ,Pull (19.634*w,-3.447*0.5) (22.932*w,-6.444*0.5)
                                    ,Pull (18.285*w,-6.295*0.5) (13.639*w,-6.145*0.5)
                                    ,Pull (14.538*w,-8.543*0.5) (15.437*w,-10.94*0.5)
                                    ,Pull (11.690*w,-10.04*0.5) (7.9437*w,-9.142*0.5)
                                    ,Pull (7.1943*w,-11.54*0.5) (6.4449*w,-13.93*0.5)
                                    ,Pull (4.0468*w,-11.99*0.5) (1.6487*w,-10.04*0.5)
                                    ,Pull (-5.096*w,-16.93*0.5) (-11.84*w,-24.13*0.5)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script 0
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr
      , contents |> move (-0.4*width,textSpeed *t) --moves position of text 1.5 - 0.5*width,textSpeed *t
          |> clip (bubble |> ghost )
      , bubble |> outlined (solid 0.25) textClr
      ]
    else
      []

shoutBubbleRight : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
shoutBubbleRight textClr fontStyle script width actor t =
  let
    bubble = 
      let w = (width+5)/40
      in 
        curve (-11.84*w,-24.13*0.5) [Pull (-7.644*w,-16.93*0.5) (-3.447*w,-9.742*0.5)
                                    ,Pull (-6.295*w,-11.24*0.5) (-9.142*w,-12.74*0.5)
                                    ,Pull (-9.742*w,-10.64*0.5) (-10.34*w,-8.543*0.5)
                                    ,Pull (-13.93*w,-9.592*0.5) (-17.53*w,-10.64*0.5)
                                    ,Pull (-17.23*w,-7.943*0.5) (-16.93*w,-5.245*0.5)
                                    ,Pull (-19.93*w,-4.646*0.5) (-22.93*w,-4.046*0.5)
                                    ,Pull (-20.53*w,-1.648*0.5) (-18.13*w,0.7494*0.5)
                                    ,Pull (-20.83*w,2.2482*0.5) (-23.53*w,3.7470*0.5)
                                    ,Pull (-20.53*w,5.0960*0.5) (-17.53*w,6.4449*0.5)
                                    ,Pull (-18.88*w,9.2927*0.5) (-20.23*w,12.140*0.5)
                                    ,Pull (-17.08*w,11.091*0.5) (-13.93*w,10.042*0.5)
                                    ,Pull (-13.78*w,12.740*0.5) (-13.63*w,15.437*0.5)
                                    ,Pull (-11.39*w,13.339*0.5) (-9.142*w,11.241*0.5)
                                    ,Pull (-8.093*w,13.189*0.5) (-7.044*w,15.138*0.5)
                                    ,Pull (-4.796*w,13.189*0.5) (-2.548*w,11.241*0.5)
                                    ,Pull (-0.899*w,13.639*0.5) (0.7494*w,16.037*0.5)
                                    ,Pull (2.3981*w,13.189*0.5) (4.0468*w,10.341*0.5)
                                    ,Pull (7.0444*w,12.889*0.5) (10.042*w,15.437*0.5)
                                    ,Pull (10.491*w,12.290*0.5) (10.941*w,9.1428*0.5)
                                    ,Pull (14.238*w,9.7423*0.5) (17.536*w,10.341*0.5)
                                    ,Pull (16.337*w,7.7939*0.5) (15.138*w,5.2459*0.5)
                                    ,Pull (18.885*w,4.3466*0.5) (22.632*w,3.4473*0.5)
                                    ,Pull (19.484*w,1.4988*0.5) (16.337*w,-0.449*0.5)
                                    ,Pull (19.634*w,-3.447*0.5) (22.932*w,-6.444*0.5)
                                    ,Pull (18.285*w,-6.295*0.5) (13.639*w,-6.145*0.5)
                                    ,Pull (14.538*w,-8.543*0.5) (15.437*w,-10.94*0.5)
                                    ,Pull (11.690*w,-10.04*0.5) (7.9437*w,-9.142*0.5)
                                    ,Pull (7.1943*w,-11.54*0.5) (6.4449*w,-13.93*0.5)
                                    ,Pull (4.0468*w,-11.99*0.5) (1.6487*w,-10.04*0.5)
                                    ,Pull (-5.096*w,-16.93*0.5) (-11.84*w,-24.13*0.5)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script 0
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr |> scaleX (-1)
      , contents |> move (-0.4*width,textSpeed *t) --moves position of text 1.5 - 0.5*width,textSpeed *t
          |> clip (bubble |> ghost |> scaleX (-1))
      , bubble |> outlined (solid 0.25) textClr |> scaleX (-1)
      ]
    else
      []

narrationBubble : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
narrationBubble textClr fontStyle script width actor t =
  let
    bubble = rect (width+5) 10
    (contents,visibility) = mkScriptFor fontStyle textClr actor script 0
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr
      , contents |> move (-1-0.5*width,textSpeed *t) --moves position of text 1.5 - 0.5*width,textSpeed *t
          |> clip (bubble |> ghost )
      , bubble |> outlined (solid 0.25) textClr
      ]
    else
      []

lightBubble : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
lightBubble textClr fontStyle script width actor t =
  let
    w = (width+5)/20
    stem = curve (2.8477*w,-7.644) [Pull (-0.299*w,-7.644) (-3.447*w,-7.644)
                          ,Pull (-3.297*w,-10.34) (-3.147*w,-13.03)
                          ,Pull (-0.299*w,-13.03) (2.5480*w,-13.03)
                          ,Pull (2.6978*w,-10.34) (2.8477*w,-7.644)]
    bulb = curve (3.4473*w,-7.644) [Pull (-0.299*w,-7.644) (-4.046*w,-7.644)
                          ,Pull (-4.146*w,-4.546) (-5.545*w,-1.948)
                          ,Pull (-8.194*w,1.7985) (-7.644*w,5.5456)
                          ,Pull (-6.796*w,11.043) (-0.449*w,11.840)
                          ,Pull (6.1474*w,11.393) (7.0444*w,5.2459)
                          ,Pull (7.7951*w,1.7985) (5.2459*w,-1.648)
                          ,Pull (3.3966*w,-4.246) (3.4473*w,-7.644)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script 0
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ stem |> filled bubbleClr
      , bulb |> filled bubbleClr
      , contents |> move (2-0.4*width,textSpeed *t) --moves position of text 1.5 - 0.5*width,textSpeed *t
          |> clip (bulb |> ghost )
      , stem |> outlined (solid 0.25) textClr
      , bulb |> outlined (solid 0.25) textClr 
      , roundedRect (6.8*w) 0.25 0.125 |> filled textClr |> rotate (degrees 3) |> move (-0.3*w,-9)
      , roundedRect (6.8*w) 0.25 0.125 |> filled textClr |> rotate (degrees 3) |> move (-0.3*w,-10.5)
      , roundedRect (6.6*w) 0.25 0.125 |> filled textClr |> rotate (degrees 3) |> move (-0.3*w,-12)
      , line (-9.742*w,-1.049) (-13.03*w,-2.847) |> outlined (solid 0.25) textClr
      , line (-11.54*w,4.6463) (-14.83*w,4.3466) |> outlined (solid 0.25) textClr
      , line (-10.04*w,10.042) (-12.74*w,11.840) |> outlined (solid 0.25) textClr
      , line (-5.845*w,13.939) (-7.644*w,16.936) |> outlined (solid 0.25) textClr
      , line (-0.449*w,15.437) (-0.449*w,18.735) |> outlined (solid 0.25) textClr
      , line (5.2459*w,14.238) (7.0444*w,17.236) |> outlined (solid 0.25) textClr
      , line (9.4426*w,10.042) (12.140*w,11.840) |> outlined (solid 0.25) textClr
      , line (10.641*w,4.3466) (14.238*w,4.3466) |> outlined (solid 0.25) textClr
      , line (9.1428*w,-1.348) (12.140*w,-2.847) |> outlined (solid 0.25) textClr
    ]
    else
      []

heartBubbleLeft : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
heartBubbleLeft textClr fontStyle script width actor t =
  let
    heart = 
      let w = (width+5)/40
      in curve (-0.149*w,-14.23*0.5) [Pull (-11.04*w,-7.893*0.5) (-15.13*w,-1.648*0.5)
                                     ,Pull (-20.28*w,8.8454*0.5) (-13.93*w,13.339*0.5)
                                     ,Pull (-5.844*w,18.091*0.5) (0.1498*w,9.1428*0.5)
                                     ,Pull (8.1437*w,18.592*0.5) (15.737*w,11.241*0.5)
                                     ,Pull (20.438*w,5.6964*0.5) (14.538*w,-2.248*0.5)
                                     ,Pull (11.294*w,-7.043*0.5) (-0.149*w,-14.23*0.5)]
    mini1 = curve (-11.54,-12.44) [Pull (-13.09,-11.44) (-13.63,-10.64)
                                  ,Pull (-14.53,-9.392) (-13.33,-8.543)
                                  ,Pull (-12.44,-8.243) (-11.54,-9.142)
                                  ,Pull (-10.09,-7.992) (-9.442,-8.843)
                                  ,Pull (-8.692,-9.542) (-9.442,-10.64)
                                  ,Pull (-9.991,-11.54) (-11.54,-12.44)]
    mini2 = curve (-17.53,-13.93) [Pull (-18.13,-13.33) (-18.73,-12.74)
                                  ,Pull (-19.63,-11.79) (-18.73,-11.24)
                                  ,Pull (-18.33,-10.84) (-17.53,-11.54)
                                  ,Pull (-16.98,-10.74) (-16.03,-11.24)
                                  ,Pull (-15.53,-11.99) (-16.03,-12.74)
                                  ,Pull (-16.33,-13.18) (-17.53,-13.93)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script 0
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ heart |> filled bubbleClr
      , contents |> move (-0.35*width,textSpeed *t) --moves position of text 1.5 - 0.5*width,textSpeed *t
          |> clip (heart |> ghost )
      , heart |> outlined (solid 0.25) textClr
      , mini1 |> filled bubbleClr |> move (8-width/3,4)
      , mini1 |> outlined (solid 0.25) textClr |> move (8-width/3,4)
      , mini2 |> filled bubbleClr |> move (8-width/3,4)
      , mini2 |> outlined (solid 0.25) textClr |> move (8-width/3,4)
      ]
    else
      []

heartBubbleRight : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
heartBubbleRight textClr fontStyle script width actor t =
  let
    heart = 
      let w = (width+5)/40
      in curve (-0.149*w,-14.23*0.5) [Pull (-11.04*w,-7.893*0.5) (-15.13*w,-1.648*0.5)
                                     ,Pull (-20.28*w,8.8454*0.5) (-13.93*w,13.339*0.5)
                                     ,Pull (-5.844*w,18.091*0.5) (0.1498*w,9.1428*0.5)
                                     ,Pull (8.1437*w,18.592*0.5) (15.737*w,11.241*0.5)
                                     ,Pull (20.438*w,5.6964*0.5) (14.538*w,-2.248*0.5)
                                     ,Pull (11.294*w,-7.043*0.5) (-0.149*w,-14.23*0.5)]
    mini1 = curve (-11.54,-12.44) [Pull (-13.09,-11.44) (-13.63,-10.64)
                                  ,Pull (-14.53,-9.392) (-13.33,-8.543)
                                  ,Pull (-12.44,-8.243) (-11.54,-9.142)
                                  ,Pull (-10.09,-7.992) (-9.442,-8.843)
                                  ,Pull (-8.692,-9.542) (-9.442,-10.64)
                                  ,Pull (-9.991,-11.54) (-11.54,-12.44)]
    mini2 = curve (-17.53,-13.93) [Pull (-18.13,-13.33) (-18.73,-12.74)
                                  ,Pull (-19.63,-11.79) (-18.73,-11.24)
                                  ,Pull (-18.33,-10.84) (-17.53,-11.54)
                                  ,Pull (-16.98,-10.74) (-16.03,-11.24)
                                  ,Pull (-15.53,-11.99) (-16.03,-12.74)
                                  ,Pull (-16.33,-13.18) (-17.53,-13.93)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script 0
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ heart |> filled bubbleClr
      , contents |> move (-0.35*width,textSpeed *t) --moves position of text 1.5 - 0.5*width,textSpeed *t
          |> clip (heart |> ghost )
      , heart |> outlined (solid 0.25) textClr
      , mini1 |> filled bubbleClr |> move (13+width/3,3)
      , mini1 |> outlined (solid 0.25) textClr |> move (13+width/3,3)
      , mini2 |> filled bubbleClr |> move (25+width/3,3)
      , mini2 |> outlined (solid 0.25) textClr |> move (25+width/3,3)
      ]
    else
      []

phoneBubbleLeft : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
phoneBubbleLeft textClr fontStyle script width actor t =
  let
    bubble = 
      let w = width/40
      in curve (-14.83*w,-10.142*0.5) [ Pull (-16.93*w,-11.5*0.5) (-19.03*w,-12.74*0.5)
                                      ,Pull (-17.98*w,-12.74*0.5) (-16.93*w,-13.03*0.5)
                                      ,Pull (-22.78*w,-16.63*0.5) (-28.62*w,-20.23*0.5)
                                      ,Pull (-25.62*w,-16.78*0.5) (-22.63*w,-13.33*0.5)
                                      ,Pull (-23.53*w,-13.18*0.5) (-24.43*w,-13.03*0.5)
                                      ,Pull (-20.98*w,-10.19*0.5) (-17.53*w,-7.344*0.5)
                                      ,Pull (-20.18*w,-3.597*0.5) (-19.93*w,0.1498*0.5)
                                      ,Pull (-19.48*w,11.495*0.5) (-7.344*w,12.440*0.5)
                                      ,Pull (-0.299*w,12.440*0.5) (6.7447*w,12.440*0.5)
                                      ,Pull (19.789*w,11.494*0.5) (19.934*w,0.4496*0.5)
                                      ,Pull (19.789*w,-10.24*0.5) (7.6440*w,-12.14*0.5)
                                      ,Pull (0.4496*w,-12.89*0.5) (-6.744*w,-12.44*0.5)
                                      ,Pull (-12.14*w,-12.14*0.5) (-14.83*w,-10.142*0.5)
                                      ]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script (width/15)
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr
      , contents |> move (1.5 - 0.5*width,textSpeed *t) --moves position of text
          |> clip (bubble |> ghost)
      , bubble |> outlined (solid 0.25) textClr
      ]
    else
      []

phoneBubbleRight : Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
phoneBubbleRight textClr fontStyle script width actor t =
  let
    bubble = 
      let w = width/40
      in curve (-14.83*w,-10.142*0.5) [ Pull (-16.93*w,-11.5*0.5) (-19.03*w,-12.74*0.5)
                                      ,Pull (-17.98*w,-12.74*0.5) (-16.93*w,-13.03*0.5)
                                      ,Pull (-22.78*w,-16.63*0.5) (-28.62*w,-20.23*0.5)
                                      ,Pull (-25.62*w,-16.78*0.5) (-22.63*w,-13.33*0.5)
                                      ,Pull (-23.53*w,-13.18*0.5) (-24.43*w,-13.03*0.5)
                                      ,Pull (-20.98*w,-10.19*0.5) (-17.53*w,-7.344*0.5)
                                      ,Pull (-20.18*w,-3.597*0.5) (-19.93*w,0.1498*0.5)
                                      ,Pull (-19.48*w,11.495*0.5) (-7.344*w,12.440*0.5)
                                      ,Pull (-0.299*w,12.440*0.5) (6.7447*w,12.440*0.5)
                                      ,Pull (19.789*w,11.494*0.5) (19.934*w,0.4496*0.5)
                                      ,Pull (19.789*w,-10.24*0.5) (7.6440*w,-12.14*0.5)
                                      ,Pull (0.4496*w,-12.89*0.5) (-6.744*w,-12.44*0.5)
                                      ,Pull (-12.14*w,-12.14*0.5) (-14.83*w,-10.142*0.5)
                                      ]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script (width/15)
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr |> scaleX (-1)
      , contents |> move (1.5 - 0.5*width,textSpeed *t) --moves position of text
          |> clip (bubble |> ghost)
      , bubble |> outlined (solid 0.25) textClr |> scaleX (-1)
      ]
    else
      []

roundBubbleLeft : LineType -> Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
roundBubbleLeft line textClr fontStyle script width actor t =
  let
    bubble = 
      let w = (width+5)/40
      in curve (-12.14*w,-11.54*0.5) [Pull (-16.48*w,-15.43*0.5) (-20.83*w,-19.33*0.5)
                                     ,Pull (-18.43*w,-14.23*0.5) (-16.03*w,-9.142*0.5)
                                     ,Pull (-20.83*w,-3.947*0.5) (-19.63*w,2.5480*0.5)
                                     ,Pull (-17.33*w,12.594*0.5) (-6.744*w,12.740*0.5)
                                     ,Pull (0.1498*w,13.140*0.5) (7.0444*w,12.740*0.5)
                                     ,Pull (19.589*w,11.994*0.5) (20.234*w,0.7494*0.5)
                                     ,Pull (20.089*w,-10.14*0.5) (7.3442*w,-12.14*0.5)
                                     ,Pull (-7.648*w,-13.44*0.5) (-12.14*w,-11.54*0.5)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script (width/15)
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr
      , contents |> move (-0.5*width,textSpeed *t) --moves position of text
          |> clip (bubble |> ghost)
      , bubble |> outlined line textClr
      ]
    else
      []

roundBubbleRight : LineType -> Color -> (Stencil -> Stencil) -> Script actor -> Float -> actor -> Float -> Shape userMsg
roundBubbleRight line textClr fontStyle script width actor t =
  let
    bubble = 
      let w = (width+5)/40
      in curve (-12.14*w,-11.54*0.5) [Pull (-16.48*w,-15.43*0.5) (-20.83*w,-19.33*0.5)
                                     ,Pull (-18.43*w,-14.23*0.5) (-16.03*w,-9.142*0.5)
                                     ,Pull (-20.83*w,-3.947*0.5) (-19.63*w,2.5480*0.5)
                                     ,Pull (-17.33*w,12.594*0.5) (-6.744*w,12.740*0.5)
                                     ,Pull (0.1498*w,13.140*0.5) (7.0444*w,12.740*0.5)
                                     ,Pull (19.589*w,11.994*0.5) (20.234*w,0.7494*0.5)
                                     ,Pull (20.089*w,-10.14*0.5) (7.3442*w,-12.14*0.5)
                                     ,Pull (-7.648*w,-13.44*0.5) (-12.14*w,-11.54*0.5)]
    (contents,visibility) = mkScriptFor fontStyle textClr actor script (width/15)
    isVisible = List.any (\ start -> textSpeed*0.75 * t > scriptSpeed*0.75 * start - 2 && textSpeed * t < scriptSpeed * start + 4 ) visibility
  in
  scale 2 <| group <|
    if isVisible then
      [ bubble |> filled bubbleClr |> scaleX (-1)
      , contents |> move (-0.5*width,textSpeed *t) --moves position of text
          |> clip (bubble |> ghost)
      , bubble |> outlined line textClr |> scaleX (-1)
      ]
    else
      []

{-
repeatDuration : Float -> Int -> Float -> Float -> Float
repeatDuration speed duration startPosition time =
  speed * (time - toFloat duration * toFloat (floor time // duration)) + startPosition

repeatDistance : Float -> Float -> Float -> Float -> Float
repeatDistance speed distance startPosition time =
  repeatDuration speed (round <| distance / speed) startPosition time

animationPieces : List (Float, Float -> anytype) -> (Float -> anytype) -> Float -> anytype
animationPieces intervals finalAnimation time =
  case intervals of
    (duration, animation) :: rest ->
        if time <= duration then
          animation time
        else
          animationPieces rest finalAnimation (time - duration)
    [] ->
        finalAnimation time

plotGraph : (Float -> Float) -> Float -> Shape a
plotGraph f time =
  group
    [ openPolygon (List.map (\ t -> (-96+(toFloat t)/2.5 - 200 * toFloat (floor (time / 10)),f (toFloat t / 50))) <| List.range (500 * floor (time / 10)) (500 * ceiling (time / 10))) |> outlined (solid 1) (rgb 0 0 200)
    , group [
              circle 3 |> filled red
            , text ("(" ++ String.fromFloat time ++ ", " ++ String.fromFloat (toFloat (round <| (f time) * 100) / 100)  ++ ")")
                |> size 6
                |> filled black
                |> move (5, 5)
            ]

        |> move (-96+20* time - 200 * toFloat (floor (time / 10)),f (time))
    ]
-}
