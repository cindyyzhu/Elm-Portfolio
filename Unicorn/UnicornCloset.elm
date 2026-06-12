module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

myShapes model =
  case model.screen of
    SelectGender -> genderSelectScreen model
    Customise   -> bgShapes ++ roomShapes ++ characterView model ++ uiPanel model


-- ============================================================
-- SCREENS
-- ============================================================

genderSelectScreen model =
  [ rect 192 128 |> filled (rgb 245 238 255)
  , text "Character Creator" |> size 11 |> bold |> centered |> filled (rgb 90 70 130) |> move (0, 45)
  , text "Choose your base" |> size 7 |> centered |> filled (rgb 140 120 170) |> move (0, 35)

  -- Female card
  , roundedRect 52 70 6 |> filled (rgb 255 230 245) |> move (-32, -4)
  , roundedRect 52 70 6 |> outlined (solid 1.5) (rgb 210 160 200) |> move (-32, -4)
  , text "Female" |> size 8 |> bold |> centered |> filled (rgb 180 100 150) |> move (-32, -36)
  , femaleMiniPreview |> move (-32, 4)
  , roundedRect 40 10 3 |> filled (rgb 220 160 195) |> move (-32, -46)
  , text "Select" |> size 7 |> centered |> filled white |> move (-32, -47.5)
      |> notifyTap (ChooseGender Female)

  -- Male card
  , roundedRect 52 70 6 |> filled (rgb 220 240 255) |> move (32, -4)
  , roundedRect 52 70 6 |> outlined (solid 1.5) (rgb 150 180 210) |> move (32, -4)
  , text "Male" |> size 8 |> bold |> centered |> filled (rgb 80 120 170) |> move (32, -36)
  , maleMiniPreview |> move (32, 4)
  , roundedRect 40 10 3 |> filled (rgb 130 170 210) |> move (32, -46)
  , text "Select" |> size 7 |> centered |> filled white |> move (32, -47.5)
      |> notifyTap (ChooseGender Male)
  ]

-- Tiny preview for gender select screen (female)
femaleMiniPreview =
  group
  [ girl
  ] |> scale 0.5
  |> move (11, -3)

-- Tiny preview for gender select screen (male)
maleMiniPreview =
  group
  [ boy
  ] |> scale 0.5
  |> move (11, -3)



-- ============================================================
-- BACKGROUND
-- ============================================================

bgShapes =
  [ 
  

  ]

roomShapes =
  [ -- Back wall
    rect 200 130
      |> filled (rgb 200 170 130)
      |> move (0, 5)

    -- Hardwood floor
  , rect 200 30
      |> filled (rgb 160 100 55)
      |> move (0, -58)

    -- Floor planks
  , rect 200 1
      |> filled (rgb 130 80 40)
      |> move (0, -48)
  , rect 200 1
      |> filled (rgb 130 80 40)
      |> move (0, -56)
  , rect 1 30
      |> filled (rgb 130 80 40)
      |> move (-60, -58)
  , rect 1 30
      |> filled (rgb 130 80 40)
      |> move (0, -58)
  , rect 1 30
      |> filled (rgb 130 80 40)
      |> move (60, -58)

    -- Left wall panel
  , rect 30 130
      |> filled (rgb 200 170 130)
      |> move (-85, 5)

    -- Right wall panel
  , rect 30 130
      |> filled (rgb 200 170 130)
      |> move (85, 5)

    -- Ceiling / top shelf board
  , rect 200 8
      |> filled (rgb 180 140 90)
      |> move (0, 68)

    -- Hanging rod (wooden dowel)
  , rect 160 4
      |> filled (rgb 150 100 60)
      |> move (0, 48)

    -- Rod left bracket
  , rect 4 12
      |> filled (rgb 120 80 50)
      |> move (-80, 46)

    -- Rod right bracket
  , rect 4 12
      |> filled (rgb 120 80 50)
      |> move (80, 46)

    -- Hanging clothes: dress (left)
  , rect 18 38
      |> filled (rgb 210 120 150)
      |> move (-55, 22)
  , triangle 10
      |> filled (rgb 210 120 150)
      |> scaleY -1
      |> move (-55, 2)
  , rect 2 10
      |> filled (rgb 170 130 90)
      |> move (-55, 43)

    -- Hanger wire left
  , rect 14 1
      |> filled (rgb 170 170 170)
      |> move (-55, 38)
  , oval 3 3
      |> filled (rgb 170 170 170)
      |> move (-55, 48)

    -- Hanging clothes: shirt (center)
  , rect 22 28
      |> filled (rgb 100 160 210)
      |> move (0, 27)
  , rect 8 8
      |> filled (rgb 100 160 210)
      |> move (-13, 35)
  , rect 8 8
      |> filled (rgb 100 160 210)
      |> move (13, 35)
  , rect 2 10
      |> filled (rgb 170 130 90)
      |> move (0, 43)
  , rect 16 1
      |> filled (rgb 170 170 170)
      |> move (0, 38)
  , oval 3 3
      |> filled (rgb 170 170 170)
      |> move (0, 48)

    -- Hanging clothes: jacket (right)
  , rect 20 32
      |> filled (rgb 60 80 60)
      |> move (55, 24)
  , rect 8 10
      |> filled (rgb 60 80 60)
      |> move (44, 33)
  , rect 8 10
      |> filled (rgb 60 80 60)
      |> move (66, 33)
  , rect 2 10
      |> filled (rgb 170 130 90)
      |> move (55, 43)
  , rect 14 1
      |> filled (rgb 170 170 170)
      |> move (55, 38)
  , oval 3 3
      |> filled (rgb 170 170 170)
      |> move (55, 48)

    -- Bottom shelf
  , rect 160 6
      |> filled (rgb 180 140 90)
      |> move (0, -38)

   {- -- Shoe left
  , oval 14 6
      |> filled (rgb 80 50 30)
      |> move (-50, -35)
  , rect 10 6
      |> filled (rgb 80 50 30)
      |> move (-48, -32)

    -- Shoe right (pair)
  , oval 14 6
      |> filled (rgb 80 50 30)
      |> move (-32, -35)
  , rect 10 6
      |> filled (rgb 80 50 30)
      |> move (-30, -32) -}

    -- Folded sweater on shelf
  , rect 24 10
      |> filled (rgb 210 170 100)
      |> move (30, -33)
  , rect 24 2
      |> filled (rgb 190 150 80)
      |> move (30, -37)

    -- Hatbox on shelf
  , oval 18 10
      |> filled (rgb 200 100 100)
      |> move (65, -33)
  , rect 18 2
      |> filled (rgb 180 80 80)
      |> move (65, -38)

    -- Left wall shadow
  , rect 10 130
      |> filled (rgba 0 0 0 0.06)
      |> move (-95, 5)

    -- Right wall shadow
  , rect 10 130
      |> filled (rgba 0 0 0 0.06)
      |> move (95, 5)
  ]


-- ============================================================
-- DATA: SKIN TONES
-- ============================================================

skinTones =
  [ ( "Fair",   rgb 255 220 185 )
  , ( "Light",  rgb 248 225 215 )
  , ( "Medium", rgb 210 160 110 )
  , ( "Tan",    rgb 170 115 75  )
  , ( "Brown",  rgb 120 75  45  )
  , ( "Deep",   rgb 80  45  25  )
  ]

getSkin model =
  Tuple.second (getAt model.skinIdx skinTones ( "Light", rgb 248 225 215 ))


-- ============================================================
-- DATA: EYE COLOURS
-- ============================================================

eyeColList =
  [ ( "Brown",  rgb 80  50  30  )
  , ( "Blue",   rgb 60  100 160 )
  , ( "Green",  rgb 70  130 80  )
  , ( "Hazel",  rgb 130 100 60  )
  , ( "Grey",   rgb 110 110 110 )
  , ( "Amber",  rgb 200 140 50  )
  , ( "Violet", rgb 130 80  160 )
  ]

getEyeCol model =
  Tuple.second (getAt model.eyeIdx eyeColList ( "Brown", rgb 80 50 30 ))


-- ============================================================
-- DATA: HAIR COLOURS
-- ============================================================


hairColours =
  [ ( "Black",  rgb 30  20  10  )
  , ( "Brown",  rgb 80  50  20  )
  , ( "Blonde", rgb 200 170 80  )
  , ( "Auburn", rgb 180 80  40  )
  , ( "Silver", rgb 190 190 190 )
  , ( "Pink",   rgb 252 163 217 )
  , ( "Blue",   rgb 100 160 230 )
  , ( "Red",    rgb 200 60  40  )
  ]
  
  

getHairCol model =
  Tuple.second (getAt model.hairIdx hairColours ( "Brown", rgb 80 50 20 ))




-- ============================================================
-- DATA: HAIR STYLES (per gender)
-- ============================================================

femaleHairStyles = [ "Long and Wavy", "Ponytail", "Braid",  "Bun" ]
maleHairStyles   = [ "Wavy", "Spiky", "Swept", "Bangs" ]

getHairStyles model =
  case model.gender of
    Female -> femaleHairStyles
    Male   -> maleHairStyles


-- ============================================================
-- DATA: OUTFITS (per gender)
-- ============================================================

type alias Outfit =
  { name    : String
  , topR    : Int , topG    : Int , topB    : Int
  , botR    : Int , botG    : Int , botB    : Int
  , shoeR   : Int , shoeG   : Int , shoeB   : Int
  , accent  : GraphicSVG.Color
  }

femaleOutfits =
  [ { name="Ethereal",  topR=172,topG=225,topB=219, botR=208,botG=196,botB=246, shoeR=188,shoeG=230,shoeB=226, accent=rgb 197 201 239 }
  , { name="Fairy",    topR=200,topG=220,topB=255, botR=100,botG=120,botB=200, shoeR=80, shoeG=60, shoeB=100, accent=rgb 160 180 240 }
  , { name="Casual",     topR=255,topG=160,topB=200, botR=200,botG=100,botB=160, shoeR=120,shoeG=60, shoeB=100, accent=rgb 220 120 180 }
  , { name="Sporty",    topR=100,topG=200,topB=180, botR=60, botG=140,botB=120, shoeR=240,shoeG=240,shoeB=240, accent=rgb 80  180 160 }
  , { name="Formal",    topR=60, topG=60, topB=90,  botR=40, botG=40, botB=60,  shoeR=20, shoeG=20, shoeB=20,  accent=rgb 180 160 200 }
  , { name="Ballroom",    topR=60, topG=60, topB=90,  botR=40, botG=40, botB=60,  shoeR=20, shoeG=20, shoeB=20,  accent=rgb 180 160 200 }
  ]

maleOutfits =
  [ { name="Casual",    topR=162,topG=200,topB=209, botR=161,botG=187,botB=160, shoeR=153,shoeG=128,shoeB=106, accent=rgb 130 170 180 }
  , { name="Formal",    topR=60, topG=60, topB=60,  botR=40, botG=40, botB=40,  shoeR=200,shoeG=180,shoeB=160, accent=rgb 100 100 120 }
  , { name="Sporty",    topR=255,topG=180,topB=60,  botR=60, botG=80, botB=140, shoeR=40, shoeG=40, shoeB=60,  accent=rgb 240 160 40  }
  , { name="Fairy",    topR=220,topG=60, topB=80,  botR=40, botG=40, botB=40,  shoeR=20, shoeG=20, shoeB=20,  accent=rgb 200 200 200 }
  ]

getOutfits model =
  case model.gender of
    Female -> femaleOutfits
    Male   -> maleOutfits

getOutfit model =
  let
    outfits = getOutfits model
    def = { name="Default",topR=162,topG=200,topB=209,botR=161,botG=187,botB=160,shoeR=153,shoeG=128,shoeB=106,accent=rgb 130 170 180 }
  in
  getAt model.outfitIdx outfits def


-- ============================================================
-- DATA: ACCESSORIES
-- ============================================================

femaleAccessories = [ "None", "Glasses" ]
maleAccessories   = [ "None", "Glasses" ]

getAccessories model =
  case model.gender of
    Female -> femaleAccessories
    Male   -> maleAccessories


-- ============================================================
-- CHARACTER VIEW  (routes to male/female)
-- ============================================================

characterView model =
  case model.gender of
    Female -> [ femaleCharacter model |> move (-40, -5) ]
    Male   -> [ maleCharacter model   |> move (-40, -5) ]


-- ============================================================
-- FEMALE CHARACTER
-- ============================================================

femaleCharacter model =
  let
    skin    = getSkin model
    outfit  = getOutfit model
    hCol    = getHairCol model
    eCol    = getEyeCol model
    sIdx    = model.hairStyleIdx
    accIdx  = model.accIdx
    outfitIdx = model.outfitIdx
    
  in
  group
  [ femaleFace skin eCol hCol
  , femaleBody skin outfit outfitIdx 
  
   , femaleHair hCol skin sIdx
  , femaleAccessoryDraw accIdx
  
  ]

femaleBody skin outfit outfitIdx =
  case outfitIdx of 
    0 ->
      group
      [ outfit1 skin
      ]
    1 ->
      group [
      outfit2 skin
      |> scale 1.1
      |> move (35, -3)
      ]
    2 ->
      group [
        outfit3 skin
        |> move (-19, -15)
      
      ]
    3 -> 
      group [
      
        outfit4 skin
        |> scale 1.14
        |> move (-75.5, -4)
        
      
      ]
       
    4 ->
      group [
        outfit5 skin
        |> scale 1.2
        |> move (-15, -4)
      
      ]
      
    5 ->
      group [
      
        outfit6 skin
        |> scale 1
        |> move (-13, -8)
      
      ]
    _ -> 
      group []

      


femaleFace skin eCol hCol =
  group
  [ 
  curve (-16.88,41.368) [Pull (-14.28,41.368) (-11.68,41.368),Pull (-12.14,38.771) (-10.20,36.173),Pull (-9.733,34.875) (-6.863,33.576),Pull (-7.605,32.092) (-8.347,30.608),Pull (-7.733,27.826) (-8.718,25.043),Pull (-10.27,22.446) (-15.02,19.849),Pull (-22.40,21.460) (-25.78,24.672),Pull (-26.34,25.414) (-26.89,26.156),Pull (-26.34,26.527) (-25.78,26.898),Pull (-25.97,29.310) (-26.15,31.721),Pull (-17.91,33.744) (-16.88,41.368)]
 |> filled skin -- the face
 
 ,
 curve (-20.59,21.704) [Pull (-20.77,19.663) (-20.96,17.623),Pull (-22.26,18.237) (-23.55,17.252),Pull (-22.63,16.997) (-21.70,13.542),Pull (-18.55,14.956) (-15.39,13.171),Pull (-14.46,14.156) (-13.54,13.542),Pull (-12.24,14.284) (-10.94,15.026),Pull (-13.07,16.324) (-12.8,17.623),Pull (-14.09,18.208) (-15.39,17.994),Pull (-15.21,18.921) (-15.02,19.849),Pull (-18.62,20.463) (-20.59,21.704)]
 |> filled skin  -- the neck including the shoulders
 {--
 ,
 curve (-32.09,4.6376) [Pull (-32.27,3.7101) (-32.46,2.7826),Pull (-34.74,-0.556) (-35.43,-3.895),Pull (-36.33,-6.863) (-38.02,-9.831),Pull (-40.99,-12.18) (-43.96,-16.13),Pull (-43.96,-16.51) (-43.96,-16.88),Pull (-43.40,-17.25) (-42.85,-17.62),Pull (-41.42,-16.13) (-38.4,-14.65),Pull (-37.84,-14.46) (-37.28,-14.28),Pull (-37.28,-15.58) (-37.28,-16.88),Pull (-36.73,-18.08) (-36.17,-16.88),Pull (-35.80,-15.39) (-35.43,-13.91),Pull (-35.43,-12.42) (-35.43,-10.94),Pull (-33.76,-8.904) (-32.09,-6.863),Pull (-29.80,-3.153) (-29.12,0.5565),Pull (-28.19,2.0405) (-27.26,3.5246),Pull (-27.45,4.2666) (-27.64,5.0086),Pull (-29.86,5.3797) (-32.09,5.7507),Pull (-32.09,5.1942) (-32.09,4.6376)]
 |> filled skin -- the left arm including hands
 
 , curve (-2.782,7.6057) [Pull (-2.040,6.4927) (-1.298,5.3797),Pull (1.7275,3.3681) (3.1536,0.5565),Pull (5.0086,-2.040) (6.8637,-4.637),Pull (10.759,-5.878) (14.655,-8.718),Pull (13.286,-10.34) (8.7188,-7.976),Pull (9.2753,-9.275) (9.8318,-10.57),Pull (9.0898,-11.98) (8.3478,-10.20),Pull (7.4202,-9.275) (6.4927,-8.347),Pull (3.7101,-5.136) (0.9275,-3.524),Pull (-1.484,-0.742) (-3.895,2.0405),Pull (-5.008,3.5246) (-6.121,5.0086),Pull (-6.121,5.5652) (-6.121,6.1217),Pull (-4.452,7.0492) (-2.782,7.9768),Pull (-2.782,7.7913) (-2.782,7.6057)]
 |> filled skin -- the right arm including hands
 |> rotate (degrees -20)
 |> move (-5, 0)
 
 
 , 
  curve (-23.38,17.236) [Pull (-29.22,13.091) (-32.07,5.5456),Pull (-29.82,4.4964) (-27.57,3.4473),Pull (-24.72,6.5948) (-24.28,9.7423),Pull (-18.73,9.5925) (-13.18,9.4426),Pull (-12.29,9.7423) (-11.39,10.042),Pull (-9.043,7.6440) (-6.295,5.2459),Pull (-4.496,6.2950) (-2.697,7.3442),Pull (-6.243,13.790) (-13.18,17.836),Pull (-18.43,17.536) (-23.38,17.236)]
  |> filled skin -- chest area
  |> scale 0.95
  |> move (-5, 0) --}
  , 
  curve (-26.97,26.229) [Pull (-30.35,37.443) (-22.48,41.217),Pull (-19.54,42.537) (-15.88,41.817),Pull (-12.23,42.127) (-10.79,40.318),Pull (-7.792,37.341) (-7.194,33.723),Pull (-17.23,30.126) (-26.97,26.229)]
  |> filled skin -- head area 
  , 
  
  face_girl skin eCol hCol
   |> scale 0.72
   |> move (2, 15)

  ]

femaleHair hCol skin sIdx =
  case sIdx of
    0 -> -- Long and Wavy
      group
      [ hair2 hCol skin
      ]
    1 -> -- Ponytail
      group
      [ 
      hair1 hCol
      ]
    2 -> -- Braid
      group
      [ 
      hair5 hCol
      ]
    3 -> -- Bun
      group
      [ hair3 hCol
      |> scale 0.41
      |> move (-3, 30)
      ]
    _ -> 
      group
      [ 
      ]

femaleAccessoryDraw accIdx =
  case accIdx of
    0 -> group [] -- None
    1 -> -- glasses
      group
      [ roundedRect 12 8 2  |> outlined (solid 1.5) (rgb 60 60 60) |> move (-16, 22)
      , roundedRect 12 8 2  |> outlined (solid 1.5) (rgb 60 60 60) |> move (-32, 22)
      , rect 4 1.5 |> filled (rgb 60 60 60) |> move (-24, 22)
      ]
      |> scale 0.7
      |> move (1, 15.5)
    2 -> 
      group
      [ 
      ]
    3 -> 
      group
      [ 
      ]
    _ -> -- Headband
      group
      [ 
      ]


-- ============================================================
-- MALE CHARACTER
-- ============================================================

maleCharacter model =
  let
    skin    = getSkin model
    outfit  = getOutfit model
    hCol    = getHairCol model
    eCol    = getEyeCol model
    sIdx    = model.hairStyleIdx
    accIdx  = model.accIdx
    outfitIdx = model.outfitIdx

  in
  group
  [ maleClothes skin outfit outfitIdx
  , maleSkin skin
  , maleHair hCol sIdx
  , maleFace skin eCol hCol
  , maleAccessoryDraw accIdx
  ] |> move (23, 5)

maleSkin skin =
  group
  [  
  curve (-39.51,18.736) [Pull (-38.56,10.185) (-28.01,7.2347),Pull (-23.93,5.8492) (-19.84,6.8637),Pull (-8.556,9.3855) (-6.863,19.107),Pull (-6.863,29.124) (-6.863,39.142),Pull (-23.18,38.771) (-39.51,38.4),Pull (-39.69,28.382) (-39.51,18.736)]
  |> filled skin -- the face
  ,
  
 curve (-5.008,23.930) [Pull (-1.553,23.860) (-1.298,20.591),Pull (-1.153,16.237) (-5.008,14.284),Pull (-6.678,13.669) (-8.347,14.655),Pull (-6.220,16.881) (-6.492,19.107),Pull (-6.492,22.075) (-6.492,25.043),Pull (-5.565,24.486) (-5.008,23.930)]
  |>  filled skin -- the right ear
  ,
  
 curve (-39.51,18.736) [Pull (-40.81,21.147) (-42.11,23.559),Pull (-46.17,24.562) (-45.44,18.365),Pull (-43.92,13.310) (-38.4,14.655),Pull (-38.95,16.881) (-39.51,18.736)]
  |> filled skin -- the left ear
  
  {--
  ,
  
 curve (-26.89,7.2347) [Pull (-26.89,6.1217) (-26.89,5.0086),Pull (-26.71,3.3391) (-26.52,1.6695),Pull (-26.52,0.7420) (-26.52,-0.185),Pull (-23.18,0) (-19.84,0.1855),Pull (-19.29,1.1130) (-18.73,2.0405),Pull (-19.10,2.9681) (-19.47,3.8956),Pull (-19.66,5.3797) (-19.84,6.8637),Pull (-23.37,5.4492) (-26.89,7.2347)]
  |> filled (rgb 240 200 190) -- the neck
  ,
  
 curve (-43.96,-19.10) [Pull (-46.52,-22.81) (-45.07,-26.52),Pull (-44.70,-27.94) (-44.33,-26.15),Pull (-43.59,-28.34) (-42.85,-26.52),Pull (-41.36,-21.41) (-39.88,-24.30),Pull (-39.32,-25.90) (-38.77,-24.30),Pull (-38.77,-22.81) (-38.77,-21.33),Pull (-42.56,-21.42) (-43.96,-19.10)]
  |> filled (rgb 250 221 205) -- the the left hand
  ,
  
 curve (-7.605,-20.96) [Pull (-7.976,-22.63) (-8.347,-24.30),Pull (-7.605,-26.48) (-6.863,-24.67),Pull (-5.565,-21.65) (-4.266,-25.04),Pull (-3.339,-28.18) (-2.411,-26.52),Pull (-2.597,-25.41) (-2.782,-24.30),Pull (-2.040,-28.05) (-1.298,-25.41),Pull (-0.440,-22.44) (-2.782,-19.47),Pull (-3.994,-21.42) (-7.605,-20.96)]
  |>filled (rgb 250 221 205) -- the the right hand -}
  ]
           |> scale 0.8
           |> move (-10, 10)


maleClothes skin outfit outfitIdx =
  case outfitIdx of 
    0 ->
      group
      [ bOutfit1 skin
      |> scale 0.9
      |> move (-10, -4)
      ]
    1 ->
      group [
      bOutfit2 skin
      |> scale 0.95
      |> move (-5, -6)
      ]
    2 ->
      group [
        bOutfit3 skin
        |> move (-19, -4)
      
      ]
    3 -> 
      group [
      
        bOutfit4 skin
        |> scale 1.1
        |> move (-3, 9)
       
      
      ]
       
    
      
      
    _ -> 
      group []

maleBoots outfit =
  group
  [ ]

maleHair hCol sIdx =
  case sIdx of
    0 -> -- Wavy
      group
      [ curve (-11.68,36.173) [Pull (-11.93,34.133) (-10.57,32.092),Pull (-8.672,27.350) (-13.17,30.608),Pull (-17.64,33.762) (-16.51,36.915),Pull (-18.50,29.820) (-26.89,29.124),Pull (-28.34,30.608) (-25.78,32.092),Pull (-23.65,34.504) (-23.93,36.915),Pull (-25.31,29.976) (-34.68,30.237),Pull (-35.26,33.205) (-30.23,36.173),Pull (-34.50,35.107) (-38.77,27.640),Pull (-39.19,24.115) (-38.02,20.591),Pull (-36.77,17.849) (-39.51,19.107),Pull (-40.62,21.518) (-41.73,23.930),Pull (-44.39,24.973) (-45.44,22.817),Pull (-49.44,27.826) (-45.44,32.834),Pull (-46.74,31.536) (-48.04,30.237),Pull (-49.63,36.260) (-43.22,39.884),Pull (-44.89,39.426) (-46.56,41.368),Pull (-47.20,44.081) (-45.44,43.594),Pull (-41.73,43.234) (-38.02,47.675),Pull (-32.36,52.544) (-24.30,51.014),Pull (-26.15,52.127) (-28.01,53.240),Pull (-30.28,53.797) (-26.15,54.353),Pull (-23.37,54.869) (-20.59,51.385),Pull (-18.06,53.611) (-18.73,55.837),Pull (-17.43,57.124) (-16.13,53.611),Pull (-15.68,52.127) (-17.62,50.643),Pull (-12.61,51.773) (-7.605,47.304),Pull (-4.823,46.104) (-2.040,47.304),Pull (-1.924,43.849) (-5.008,43.594),Pull (1.5594,41.084) (0.9275,36.173),Pull (-0.371,36.115) (-1.669,37.657),Pull (2.8289,33.020) (0.9275,28.382),Pull (-0.185,29.866) (-1.298,31.350),Pull (1.7159,26.898) (-1.669,22.446),Pull (-4.266,25.362) (-6.863,19.478),Pull (-9.391,17.634) (-8.718,20.591),Pull (-6.933,25.043) (-8.347,29.495),Pull (-9.089,30.423) (-9.831,31.350),Pull (-10.75,33.762) (-11.68,36.173)]
        |> filled hCol -- the top hair
        ,

       curve (-40.99,14.284) [Pull (-38.89,13.657) (-38.4,9.8318),Pull (-37.47,9.4028) (-36.54,10.573),Pull (-35.54,6.5043) (-31.35,7.2347),Pull (-30.05,5.4782) (-28.75,6.1217),Pull (-28.01,6.4927) (-27.26,6.8637),Pull (-36.03,8.3594) (-38.4,14.655),Pull (-39.88,13.669) (-40.99,14.284)]
        |> filled hCol -- the left hair

        ,

       curve (-6.492,14.284) [Pull (-8.405,11.872) (-8.718,9.4608),Pull (-9.460,9.1884) (-10.20,11.315),Pull (-9.999,8.8753) (-15.39,7.2347),Pull (-16.69,5.2927) (-17.99,5.7507),Pull (-18.73,6.3072) (-19.47,6.8637),Pull (-12.71,8.7594) (-8.347,14.655),Pull (-7.605,14.469) (-6.492,14.284)]
        |> filled hCol -- the right hair

      ] |> scale 0.8
      |> move (-10, 10)
    1 -> -- Spiky
      group
      [
      bHair1 hCol
      |> scale 0.3
      |> move (-25, 40)
      ]
    2 -> -- Swept
      group
      [ bHair2 hCol
      |> scale 0.3
      |> move (-25, 40)
      ]
    3 -> -- Bangs
      group
      [ bHair3 hCol
      |> scale 0.4
      |> move (-15, 30)
      ]
    _ -> 
      group
      [ 
      ]

maleFace skin eCol hCol =
  group
  [   curve (-17.62,29.124) [Pull (-18.26,27.368) (-16.51,28.011),Pull (-13.91,28.626) (-11.31,27.640),Pull (-13.26,30.782) (-17.62,29.124)]
 |> filled hCol -- the right eyebrow
  ,
  
 curve (-29.86,28.011) [Pull (-27.89,27.553) (-29.12,29.495),Pull (-35.69,29.768) (-35.06,27.640),Pull (-32.46,28.626) (-29.86,28.011)]
 |> filled hCol -- the left eyebrow
  ,
  
 curve (-17.99,22.446) [Pull (-18.91,18.805) (-15.02,18.365),Pull (-12.8,17.692) (-10.57,20.220),Pull (-11.2,25.831) (-15.02,25.043),Pull (-17.09,24.144) (-17.99,22.446)]
 |> filled (rgb 247 252 255) -- the right eye
 ,
 
 curve (-10.20,21.704) [Pull (-10.57,20.962) (-10.94,20.220),Pull (-10.94,21.333) (-10.94,22.446),Pull (-12.31,26.173) (-16.88,24.301),Pull (-17.43,23.988) (-17.99,22.075),Pull (-18.16,25.930) (-13.54,25.785),Pull (-10.88,25.159) (-10.20,21.704)]
 |> filled (rgb 114 72 73) -- the right eyelash
  
  ,
  
 curve (-30.97,17.994) [Pull (-26.88,19.605) (-28.38,22.817),Pull (-31.72,27.773) (-35.06,23.930),Pull (-36.23,21.889) (-35.80,19.849),Pull (-34.00,17.321) (-30.97,17.994)]
 |>  filled (rgb 247 252 255) -- the left eye
 ,
 curve (-36.54,22.075) [Pull (-36.78,21.147) (-35.43,20.220),Pull (-36.34,24.231) (-32.46,25.043),Pull (-30.42,25.344) (-28.38,22.446),Pull (-29.37,26.515) (-33.57,25.785),Pull (-36.66,24.144) (-36.54,21.704)]
 |> filled (rgb 114 72 73) -- the left eyelash
  ,
 curve (-23.18,20.962) [Pull (-23.18,20.034) (-23.18,19.107)]
 |> outlined (solid 0.5)(rgb 195 135 124) -- the nose line
  ,
  curve (-24.67,17.623) [Pull (-23.37,20.208) (-22.07,17.994)]
 |> outlined (solid 0.5) (rgb 195 135 124) -- the nose 
  ,
  curve (-26.15,14.655) [Pull (-23.37,12.255) (-20.59,14.655)]
 |> outlined (solid 0.5) (rgb 195 135 124) -- the smile
 ,
 
 curve (-13.54,16.881) [Pull (-13.91,16.139) (-14.28,15.397)]
 |> outlined (solid 0.5) pink -- the right blush line
  ,
  
 curve (-12.8,15.768) [Pull (-12.24,16.324) (-11.68,16.881)]
 |> outlined (solid 0.5) pink -- the right blush line
  ,
  
 curve (-11.31,15.768) [Pull (-10.94,16.324) (-10.57,16.881)]
 |> outlined (solid 0.5) pink -- the right blush line
  ,
  
 curve (-33.57,15.397) [Pull (-33.20,15.953) (-32.83,16.510)]
 |> outlined (solid 0.5) pink -- the left blush line
  ,
  
 curve (-35.06,15.397) [Pull (-34.50,15.953) (-33.94,16.510)]
 |> outlined (solid 0.5) pink -- the left blush line
   ,
   
 curve (-36.17,16.139) [Pull (-35.43,16.510) (-34.68,16.881)]
 |> outlined (solid 0.5) pink -- the left blush line
  ,
  
 curve (-16.13,15.768) [Pull (-12.24,20.324) (-8.347,16.881),Pull (-11.44,11.524) (-16.13,15.768)]
 |> filled (rgb 237 169 160)
 |> makeTransparent 0.8-- the right blush 
  ,
  
 curve (-38.4,17.623) [Pull (-34.13,19.710) (-29.86,15.397),Pull (-35.73,10.510) (-38.4,17.623)]
 |> filled (rgb 237 169 160)
 |> makeTransparent 0.8-- the left blush
 , eyes_boy eCol
 {-oval 5 6
 |> filled (rgb 162 203 209) 
 -- the left eye
 |> move (-31.5,21.5)
 ,
 oval 3 4
 |> filled (rgb 83 108 130)
  -- the left eye
 |> move (-31.5,21.5)
 , -} , 
 circle 1
 |> filled white
  -- the left eye
 |> move (-32.5,22.5)
  {-,
  oval 5 6
 |> filled (rgb 162 203 209) 
  -- the right eye
 |> move (-15.5,21.5)
 ,
 oval 3 4
 |> filled (rgb 83 108 130)
 -- the right eye
 |> move (-16,21.5) -}
 ,
 circle 1
 |> filled white
  -- the left eye
 |> move (-16.5,22.5)
    
  ] |> scale 0.8
  |> move (-10, 10)
  
  
eyes_boy eCol =
  let
    shade factor = shadeColorEye factor eCol
  in
    group [
     oval 5 6
     |> filled (shade 1.7)
     |> move (-15.5,21.5)
     ,
     oval 3 4
     |> filled (shade 1.0)
     -- the right eye
     |> move (-16,21.5)

     , oval 5 6
     |> filled (shade 1.7)
     -- the left eye
     |> move (-31.5,21.5)
     ,
     oval 3 4
     |> filled (shade 1.0)
      -- the left eye
     |> move (-31.5,21.5)


    ]

maleAccessoryDraw accIdx =
  case accIdx of
    0 -> group [] -- None
    1 -> -- Glasses
      group
      [ roundedRect 12 8 2  |> outlined (solid 1.5) (rgb 60 60 60) |> move (-16, 22)
      , roundedRect 12 8 2  |> outlined (solid 1.5) (rgb 60 60 60) |> move (-32, 22)
      , rect 4 1.5 |> filled (rgb 60 60 60) |> move (-24, 22)
    
      ]
      |> move (-5, 5)
    2 -> 
      group
      [ 
      ]
    3 -> 
      group
      [ 
      ]
    _ -> 
      group
      [ 
      ]


-- ============================================================
-- UI PANEL
-- ============================================================

uiPanel model =
  let
    outfits = getOutfits model
    styles  = getHairStyles model
    accs    = getAccessories model
  in
  [ rect 72 128 |> filled (rgba 10 5 30 0.5) |> move (60, 0)
  , text "  Closet" |> size 10 |> bold |> filled white |> move (28, 52)
  , rect 72 1.5 |> filled (rgba 255 255 255 0.2) |> move (60, 44)
  -- back button
  , roundedRect 28 9 3 |> filled (rgba 255 255 255 0.15) |> move (74, 52)
  , text "     < Back" |> size 6 |> filled (rgba 255 255 255 0.7) |> move (63, 57) |> notifyTap GoBack
  ]
  ++ uiRow "    Outfit"    (List.map .name outfits)       model.outfitIdx    ChangedOutfit    36 model
  ++ uiRow "    Hair Colour"  (List.map Tuple.first hairColours) model.hairIdx  ChangedHair      21 model
  ++ uiRow "    Hairstyle" styles                          model.hairStyleIdx ChangedHairStyle  6 model
  ++ uiRow "    Eye Colour"      (List.map Tuple.first eyeColList) model.eyeIdx    ChangedEyes      -9 model
  ++ uiRow "    Skin"      (List.map Tuple.first skinTones)  model.skinIdx   ChangedSkin     -24 model
  ++ uiRow "    Accessory" accs                            model.accIdx       ChangedAcc      -39 model

uiRow labelStr opts idx msg yPos model =
  let
    total   = List.length opts
    current = getAt idx opts "?"
  in
  [ text labelStr |> size 6  |> filled (rgba 255 255 255 0.5) |> move (28, yPos + 7)
  , text current  |> size 7.5|> bold |> filled white           |> move (28 + 10, yPos - 1)
  , triangle 4 |> filled white |> rotate (degrees  90) |> move (26 + 5, yPos + 3)
      |> notifyTap (msg (modBy total (idx - 1 + total)))
  , triangle 4 |> filled white |> rotate (degrees -90) |> move (92, yPos + 3)
      |> notifyTap (msg (modBy total (idx + 1)))
  ]


-- ============================================================
-- UTILITIES
-- ============================================================

getAt idx list default =
  List.head (List.drop idx list) |> Maybe.withDefault default


-- ============================================================
-- MSG / MODEL / UPDATE
-- ============================================================

type Gender = Female | Male

type Screen = SelectGender | Customise

type Msg
  = Tick Float GetKeyState
  | ChooseGender Gender
  | GoBack
  | ChangedOutfit    Int
  | ChangedHair      Int
  | ChangedHairStyle Int
  | ChangedEyes      Int
  | ChangedSkin      Int
  | ChangedAcc       Int

type alias Model =
  { time         : Float
  , screen       : Screen
  , gender       : Gender
  , outfitIdx    : Int
  , hairIdx      : Int
  , hairStyleIdx : Int
  , eyeIdx       : Int
  , skinIdx      : Int
  , accIdx       : Int
  }

update msg model =
  case msg of
    Tick t _           -> { model | time = t }
    ChooseGender g     -> { model | gender = g, screen = Customise
                                  , outfitIdx = 0, hairStyleIdx = 0, accIdx = 0 }
    GoBack             -> { model | screen = SelectGender }
    ChangedOutfit    i -> { model | outfitIdx    = i }
    ChangedHair      i -> { model | hairIdx      = i }
    ChangedHairStyle i -> { model | hairStyleIdx = i }
    ChangedEyes      i -> { model | eyeIdx       = i }
    ChangedSkin      i -> { model | skinIdx      = i }
    ChangedAcc       i -> { model | accIdx       = i }

init =
  { time         = 0
  , screen       = SelectGender
  , gender       = Female
  , outfitIdx    = 0
  , hairIdx      = 5
  , hairStyleIdx = 0
  , eyeIdx       = 1
  , skinIdx      = 1
  , accIdx       = 0
  }

main = gameApp Tick { model = init, view = view, update = update, title = "Character Creator" }

view model = collage 192 128 (myShapes model)


-- ==================================================
-- ASSETS
-- ==================================================

-- FEMALE SHELL!!!
girl = group [
    light_part_dress
   ,
   boots_girl
   ,
   hair_girl
   ,
   accessories_girl

   ,
   dress_deatails

  ]

skinGirl = group  [
 curve (-16.88,41.368) [Pull (-14.28,41.368) (-11.68,41.368),Pull (-12.14,38.771) (-10.20,36.173),Pull (-9.733,34.875) (-6.863,33.576),Pull (-7.605,32.092) (-8.347,30.608),Pull (-7.733,27.826) (-8.718,25.043),Pull (-10.27,22.446) (-15.02,19.849),Pull (-22.40,21.460) (-25.78,24.672),Pull (-26.34,25.414) (-26.89,26.156),Pull (-26.34,26.527) (-25.78,26.898),Pull (-25.97,29.310) (-26.15,31.721),Pull (-17.91,33.744) (-16.88,41.368)]
 |> filled (rgb 248 229 223) -- the face
 ,
 curve (-20.59,21.704) [Pull (-20.77,19.663) (-20.96,17.623),Pull (-22.26,18.237) (-23.55,17.252),Pull (-22.63,16.997) (-21.70,13.542),Pull (-18.55,14.956) (-15.39,13.171),Pull (-14.46,14.156) (-13.54,13.542),Pull (-12.24,14.284) (-10.94,15.026),Pull (-13.07,16.324) (-12.8,17.623),Pull (-14.09,18.208) (-15.39,17.994),Pull (-15.21,18.921) (-15.02,19.849),Pull (-18.62,20.463) (-20.59,21.704)]
 |> filled (rgb 248 229 223)  -- the neck including the shoulders
 ,
 curve (-32.09,4.6376) [Pull (-32.27,3.7101) (-32.46,2.7826),Pull (-34.74,-0.556) (-35.43,-3.895),Pull (-36.33,-6.863) (-38.02,-9.831),Pull (-40.99,-12.18) (-43.96,-16.13),Pull (-43.96,-16.51) (-43.96,-16.88),Pull (-43.40,-17.25) (-42.85,-17.62),Pull (-41.42,-16.13) (-38.4,-14.65),Pull (-37.84,-14.46) (-37.28,-14.28),Pull (-37.28,-15.58) (-37.28,-16.88),Pull (-36.73,-18.08) (-36.17,-16.88),Pull (-35.80,-15.39) (-35.43,-13.91),Pull (-35.43,-12.42) (-35.43,-10.94),Pull (-33.76,-8.904) (-32.09,-6.863),Pull (-29.80,-3.153) (-29.12,0.5565),Pull (-28.19,2.0405) (-27.26,3.5246),Pull (-27.45,4.2666) (-27.64,5.0086),Pull (-29.86,5.3797) (-32.09,5.7507),Pull (-32.09,5.1942) (-32.09,4.6376)]
 |> filled (rgb 254 226 223) -- the left arm including hands
 ,
 curve (-2.782,7.6057) [Pull (-2.040,6.4927) (-1.298,5.3797),Pull (1.7275,3.3681) (3.1536,0.5565),Pull (5.0086,-2.040) (6.8637,-4.637),Pull (10.759,-5.878) (14.655,-8.718),Pull (13.286,-10.34) (8.7188,-7.976),Pull (9.2753,-9.275) (9.8318,-10.57),Pull (9.0898,-11.98) (8.3478,-10.20),Pull (7.4202,-9.275) (6.4927,-8.347),Pull (3.7101,-5.136) (0.9275,-3.524),Pull (-1.484,-0.742) (-3.895,2.0405),Pull (-5.008,3.5246) (-6.121,5.0086),Pull (-6.121,5.5652) (-6.121,6.1217),Pull (-4.452,7.0492) (-2.782,7.9768),Pull (-2.782,7.7913) (-2.782,7.6057)]
 |> filled (rgb 254 226 223) -- the right arm including hands
 ,
 curve (-24.30,-28.01) [Pull (-23.50,-28.93) (-24.30,-29.86),Pull (-25.22,-30.97) (-26.15,-32.09),Pull (-23.00,-34.62) (-19.84,-33.94),Pull (-18.73,-32.46) (-17.62,-30.97),Pull (-16.82,-29.31) (-17.62,-27.64),Pull (-20.96,-27.45) (-24.30,-27.26),Pull (-24.30,-27.64) (-24.30,-28.01)]
 |> filled (rgb 240 199 181) -- the left leg
  ,
 curve (-15.02,-26.89) [Pull (-15.02,-28.56) (-15.02,-30.23),Pull (-14.78,-31.72) (-16.13,-33.20),Pull (-12,-34.99) (-9.460,-33.57),Pull (-8.318,-29.31) (-7.976,-25.04),Pull (-10.94,-24.48) (-13.91,-23.93),Pull (-14.46,-25.41) (-15.02,-26.89)]
  |> filled (rgb 240 199 181) -- the right leg
  ,
 curve (-17.25,43.223) [Pull (-14.28,43.223) (-11.31,43.223),Pull (-11.31,40.997) (-11.31,38.771),Pull (-14.65,38.4) (-17.99,38.028),Pull (-17.62,40.626) (-17.25,43.223)] 
 |> filled (rgb 248 229 223)
 
 
 ]
 
dark_part_dress = group [
 dress_pieces
  ,
 curve (-22.81,12.428) [Pull (-20.77,13.228) (-18.73,12.428),Pull (-16.45,9.2347) (-15.76,2.0405),Pull (-18.73,2.3826) (-21.70,3.5246),Pull (-21.43,5.7507) (-23.55,7.9768),Pull (-21.98,10.202) (-22.81,12.428)]
 |> filled (rgb 197 201 239) -- the dress piece on the chest
 ,
 
 curve (-11.68,13.542) [Pull (-10.75,14.342) (-9.831,13.542),Pull (-8.231,10.202) (-9.831,6.8637),Pull (-10.01,5.1942) (-10.20,3.5246),Pull (-11.31,2.7826) (-12.42,2.0405),Pull (-10.85,7.7913) (-11.68,13.542)]
 |> filled (rgb 197 201 239)-- the far dress piece on the chest
 ,
 curve (-13.17,-0.185) [Pull (-12.33,-4.452) (-9.089,-8.718),Pull (-5.779,-15.38) (-1.669,-17.25),Pull (-0.185,-18.63) (1.2985,-17.62),Pull (1.4840,-17.25) (1.6695,-16.88),Pull (2.2260,-16.88) (2.7826,-16.88),Pull (3.5246,-18.55) (4.2666,-20.22),Pull (7.6057,-23.91) (10.944,-22.81),Pull (11.872,-23.18) (12.8,-23.55),Pull (15.640,-27.64) (16.881,-31.72),Pull (12.8,-30.46) (8.7188,-33.20),Pull (6.4927,-35.54) (4.2666,-34.68),Pull (3.0376,-33.94) (5.0086,-33.20),Pull (6.6782,-32.83) (8.3478,-32.46),Pull (9.0202,-31.90) (6.4927,-31.35),Pull (3.5246,-32.73) (0.5565,-31.72),Pull (0.1855,-31.35) (-0.185,-30.97),Pull (7.8434,-27.89) (-0.927,-28.01),Pull (-2.597,-28.19) (-4.266,-28.38),Pull (-4.266,-27.82) (-4.266,-27.26),Pull (0.7768,-25.97) (-5.379,-24.67),Pull (-5.750,-25.22) (-6.121,-25.78),Pull (-6.492,-25.41) (-6.863,-25.04),Pull (-10.20,-25.22) (-13.54,-25.41),Pull (-13.85,-23.07) (-15.76,-23.93),Pull (-19.85,-25.04) (-13.54,-26.15),Pull (-13.39,-26.89) (-17.25,-27.64),Pull (-21.14,-28.81) (-25.04,-28.38),Pull (-33.19,-30.60) (-26.15,-32.83),Pull (-27.09,-35.57) (-32.83,-34.31),Pull (-44.12,-30.66) (-45.82,-35.80),Pull (-45.93,-36.73) (-42.85,-37.65),Pull (-42.16,-40.64) (-50.27,-38.02),Pull (-55.98,-36.58) (-57.69,-39.14),Pull (-55.26,-31.16) (-48.04,-23.18),Pull (-44.33,-24.94) (-40.62,-24.30),Pull (-32.66,-26.75) (-29.49,-22.81),Pull (-29.12,-21.14) (-28.75,-19.47),Pull (-25.97,-21.26) (-23.18,-19.84),Pull (-13.16,-14.01) (-13.17,-0.185)]
 |> filled (rgb 208 196 246)
 |> addOutline (solid 0.4)  (rgb 124 121 176)-- the main dress piece
 ,
 curve (-22.81,12.428) [Pull (-23.18,10.388) (-23.55,8.3478),Pull (-20.78,10.388) (-22.81,12.428)]
 |> filled (rgb 197 201 239)
 ,
 skinGirl
 ]
 
light_part_dress = group [

 curve (-7.976,-10.94) [Pull (-4.875,-22.52) (15.026,-26.89),Pull (10.110,-10.92) (-7.976,-10.94)]
 |> filled (rgb 125 179 191)
 ,
   curve (-18.73,12.428) [Pull (-17.06,12.428) (-15.39,12.428),Pull (-14.28,12.614) (-13.17,12.8),Pull (-12.42,13.171) (-11.68,13.542),Pull (-8.057,7.7913) (-12.42,2.0405),Pull (-13.91,0.8405) (-15.39,2.0405),Pull (-18.26,7.2347) (-18.73,12.428)]
 |> filled (rgb 172 225 219) -- the dress piece on the chest
  ,
   curve (-13.17,-0.185) [Pull (-9.686,1.2985) (-10.20,2.7826),Pull (-2.968,0.7884) (4.2666,-7.605),Pull (13.031,-16.13) (15.397,-24.67),Pull (16.411,-25.97) (15.026,-27.26),Pull (13.356,-23.04) (11.686,-22.81),Pull (6.5913,-26.13) (3.8956,-19.84),Pull (5.7101,-17.99) (3.5246,-16.13),Pull (1.0260,-16.45) (0.9275,-18.36),Pull (-1.113,-19.25) (-3.153,-16.13),Pull (-7.049,-12.8) (-10.94,-9.460),Pull (-12.05,-4.823) (-13.17,-0.185)]
 |> filled (rgb 181 233 229)
 |> addOutline (solid 0.5) (rgb 147 198 202)-- the main dress piece on the right
 ,
 curve (-28.75,-19.47) [Pull (-24.67,-22.33) (-20.59,-17.99),Pull (-10.48,-9.089) (-13.17,-0.185),Pull (-21.03,0.0985) (-21.70,2.7826),Pull (-42.05,-2.330) (-53.61,-25.04),Pull (-50.82,-22.91) (-48.04,-23.18),Pull (-44.15,-25.74) (-40.25,-24.30),Pull (-33.08,-26.97) (-29.12,-22.44),Pull (-23.76,-23.14) (-28.01,-19.84)] 
 |>filled (rgb 181 233 229)
  |> addOutline (solid 0.5) (rgb 147 198 202)-- the main dress piece on the left
 ,
 curve (-21.70,3.5246) [Pull (-17.80,2.4115) (-13.91,1.2985),Pull (-11.87,2.4115) (-9.831,3.5246),Pull (-9.286,-0.730) (-13.54,-0.185),Pull (-21.22,-0.330) (-21.70,3.5246)]
 |> filled (rgb 183 226 232)
  |> addOutline (solid 0.5) (rgb 147 198 202)-- the waist tightner dress part
 ,
 curve (-21.70,13.542) [Pull (-18.55,15.356) (-15.39,13.171),Pull (-14.46,14.556) (-13.54,13.542),Pull (-12.24,14.284) (-10.94,15.026),Pull (-10.57,14.655) (-10.20,14.284),Pull (-11.68,13.542) (-13.17,12.8),Pull (-15.95,12.614) (-18.73,12.428),Pull (-20.77,12.028) (-22.81,12.428),Pull (-23.18,14.840) (-23.55,17.252),Pull (-22.63,16.997) (-21.70,13.542)]
 |> filled (rgb 193 245 232) -- the neck dress piece
 ,
 curve (-12.8,17.623) [Pull (-12.73,19.994) (-9.460,18.365),Pull (-7.478,15.924) (-3.895,14.284),Pull (-1.495,11.686) (-3.895,9.0898),Pull (-5.350,9.5768) (-7.605,6.8637),Pull (-8.533,6.2492) (-9.460,7.2347),Pull (-8.017,10.759) (-10.57,14.284),Pull (-12.88,15.953) (-12.8,17.623)]
 |> filled (rgb 193 245 232)
  |> addOutline (solid 0.5) (rgb 147 198 202)-- the right sleeve
 ,
 curve (-7.234,7.2347) [Pull (-5.565,9.7623) (-3.895,9.0898),Pull (-2.782,8.7188) (-1.669,8.3478),Pull (-2.226,8.4057) (-2.782,6.8637),Pull (-3.339,6.0637) (-3.895,6.8637),Pull (-4.452,8.1217) (-5.008,5.3797),Pull (-5.750,6.6086) (-6.492,4.6376),Pull (-7.049,4.4231) (-7.605,5.0086),Pull (-8.191,5.9362) (-7.234,7.2347)]
 |> filled (rgb 180 199 231)
 -- the right bottem sleeve
 ,
 curve (-31.35,15.026) [Pull (-26.06,20.939) (-23.18,17.252),Pull (-22.17,12.8) (-23.55,8.3478),Pull (-23.50,7.0492) (-25.04,5.7507),Pull (-28.56,6.4927) (-32.09,7.2347),Pull (-34.64,9.6463) (-33.20,12.057),Pull (-32.27,13.542) (-31.35,15.026)] 
 |> filled (rgb 193 245 232)
  |> addOutline (solid 0.5) (rgb 147 198 202)-- the left sleeve
 ,
 curve (-31.72,7.2347) [Pull (-31.53,6.8637) (-31.35,6.4927),Pull (-32.89,5.9362) (-32.83,5.3797),Pull (-31.90,3.5942) (-30.97,5.0086),Pull (-29.68,3.2231) (-28.38,4.6376),Pull (-25.85,2.4521) (-26.52,4.2666),Pull (-26.34,5.1942) (-26.15,6.1217),Pull (-28.75,6.6782) (-31.72,7.2347)]
 |>  filled (rgb 180 199 231) -- the left bottem sleeve
 ,
 curve (-16.51,2.0405) [Pull (-16.13,2.0405) (-15.76,2.0405),Pull (-15.76,2.4115) (-15.76,2.7826),Pull (-15.05,2.0405) (-13.54,1.2985),Pull (-14.84,1.4840) (-16.51,2.0405)]
 |> filled (rgb 172 225 219)
 ,
 dark_part_dress
 ]
 
dress_pieces = group  [
  

 curve (-35.80,-33.20) [Pull (-36.91,-36.17) (-38.02,-39.14),Pull (-33.76,-39.64) (-29.49,-41.73),Pull (-26.89,-42.66) (-24.30,-43.59),Pull (-19.63,-39.71) (-15.76,-40.62),Pull (-12.98,-41.18) (-10.20,-41.73),Pull (-4.266,-37.88) (1.6695,-38.02),Pull (0.3710,-34.50) (-0.927,-30.97),Pull (4.0985,-31.46) (3.5246,-28.75),Pull (-0.371,-26.56) (-4.266,-28.38),Pull (-4.266,-27.64) (-4.266,-26.89),Pull (-4.452,-26.89) (-4.637,-26.89),Pull (0.2608,-28.34) (-2.040,-25.78),Pull (-5.466,-22.98) (-6.492,-25.78),Pull (-6.220,-24.21) (-8.347,-25.04),Pull (-11.13,-24.67) (-13.91,-24.30),Pull (-15.58,-21.68) (-17.25,-24.67),Pull (-15.76,-26.82) (-14.28,-25.78),Pull (-14.19,-26.71) (-16.51,-27.64),Pull (-20.59,-27.45) (-24.67,-27.26),Pull (-24.30,-27.82) (-23.93,-28.38),Pull (-26.52,-27.71) (-29.12,-30.23),Pull (-30.62,-33.53) (-26.52,-32.83),Pull (-27.56,-36.22) (-35.80,-33.20)] 
 |> filled (rgb 135 143 215) -- the dress piece behing the leg
 ,
 curve (-36.17,-33.20) [Pull (-44.99,-31.70) (-45.82,-35.80),Pull (-45.93,-36.73) (-42.85,-37.65),Pull (-42.40,-40.02) (-49.15,-38.4),Pull (-57.64,-36.77) (-57.32,-39.14),Pull (-56.19,-42.01) (-50.27,-42.48),Pull (-45.26,-46.17) (-40.25,-45.07),Pull (-37.14,-42.11) (-38.02,-39.14),Pull (-36.91,-36.17) (-36.17,-33.20)] 
 |> filled (rgb 158 181 225) -- the left dress piece under the main dress piece
 ,
 curve (-2.040,-28.38) [Pull (0.5565,-35.24) (3.1536,-42.11),Pull (4.2666,-42.51) (5.3797,-42.11),Pull (9.0898,-41.61) (12.8,-39.51),Pull (13.628,-38.58) (12.057,-37.65),Pull (20.069,-34.68) (16.881,-31.72),Pull (7.4202,-29.86) (-2.040,-28.38)]
 |> filled (rgb 158 181 225) -- the right dress piece under the main dress piece
  ]
 
 
boots_girl = group [

 curve (-32.46,-47.67) [Pull (-33.79,-48.11) (-34.31,-51.75),Pull (-34.87,-52.68) (-35.43,-53.61),Pull (-34.87,-54.16) (-34.31,-54.72),Pull (-34.13,-54.35) (-33.94,-53.98),Pull (-33.79,-56.82) (-32.83,-58.06),Pull (-30.60,-60.59) (-28.38,-59.91),Pull (-26.44,-58.24) (-26.89,-56.57),Pull (-29.86,-52.31) (-32.46,-47.67)]
 |> filled (rgb 132 141 198) -- the left boots heel
 ,
 curve (-26.15,-31.72) [Pull (-25.18,-33.20) (-20.22,-34.68),Pull (-21.88,-38.21) (-23.55,-41.73),Pull (-27.81,-48.97) (-27.26,-56.20),Pull (-27.09,-60.95) (-31.72,-57.69),Pull (-32.89,-56.11) (-32.46,-52.12),Pull (-32.64,-51.01) (-32.83,-49.90),Pull (-32.89,-47.43) (-31.35,-46.56),Pull (-28.85,-44.72) (-28.75,-37.28),Pull (-27.45,-34.50) (-26.15,-31.72)]
 |> filled (rgb 188 230 226) -- the left boot
 ,
 curve (-16.88,-52.86) [Pull (-16.69,-55.28) (-16.51,-57.69),Pull (-15.95,-58.06) (-15.39,-58.43),Pull (-15.21,-57.69) (-15.02,-56.95),Pull (-14.46,-57.50) (-13.91,-58.06),Pull (-8.388,-61.66) (-6.863,-58.06),Pull (-11.87,-55.46) (-16.88,-52.86)]
 |> filled (rgb 132 141 198) -- the right boots heel
 ,
 curve (-16.13,-33.20) [Pull (-12.42,-35.17) (-8.718,-33.94),Pull (-10.01,-42.11) (-11.31,-50.27),Pull (-10.17,-52.31) (-9.831,-54.35),Pull (-8.347,-55.46) (-6.863,-56.57),Pull (-5.646,-59.32) (-12.42,-58.06),Pull (-13.54,-56.39) (-14.65,-54.72),Pull (-15.95,-53.79) (-17.25,-52.86),Pull (-17.89,-50.82) (-16.13,-48.78),Pull (-16.13,-41.18) (-16.13,-33.20)]
 |> filled (rgb 188 230 226) -- the right boot
 
 ]
 
accessories_girl = group [

  curve (-16.88,18.365) [Pull (-15.95,20.336) (-15.02,19.107),Pull (-15.21,18.550) (-15.39,17.994),Pull (-15.37,15.408) (-20.96,17.623),Pull (-20.83,22.179) (-19.10,18.736),Pull (-17.99,20.150) (-16.88,18.365)] 
 |> filled (rgb 198 221 237) -- the neck choker
 ,
 curve (-15.02,12.428) [Pull (-14.09,14.214) (-13.17,12.8),Pull (-13.35,12.243) (-13.54,11.686),Pull (-13.91,12.701) (-14.28,11.315),Pull (-14.65,11.872) (-15.02,12.428)]
 |> filled (rgb 132 141 198) -- the gem on the middle of the dress
 ,
 curve (-29.12,38.028) [Pull (-26.54,47.452) (-18.36,47.675),Pull (-14.46,47.633) (-10.57,46.191),Pull (-13.48,47.149) (-15.39,44.707),Pull (-19.63,47.192) (-22.07,45.078),Pull (-26.24,42.653) (-28.01,38.028),Pull (-28.19,37.843) (-28.38,37.657),Pull (-28.75,37.843) (-29.12,38.028)]
 |> filled (rgb 181 228 234)
  |> addOutline (solid 0.2) blue-- the headband
 ,
 curve (-13.91,56.579) [Pull (-16.72,51.756) (-18.73,46.933),Pull (-18.55,46.562) (-18.36,46.191),Pull (-16.88,45.449) (-15.39,44.707),Pull (-14.65,45.449) (-13.91,46.191),Pull (-13.21,51.385) (-13.91,56.579)]
 |> filled (rgb 135 189 189) -- the unicorn horn
  ,
 curve (-17.99,48.046) [Pull (-15.95,46.304) (-13.91,46.562),Pull (-13.72,47.860) (-13.54,49.159),Pull (-15.39,48.401) (-17.25,50.643),Pull (-17.62,49.344) (-17.99,48.046)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-18.73,46.933) [Pull (-18.36,47.489) (-17.99,48.046),Pull (-15.76,46.504) (-13.54,46.562),Pull (-13.54,46.376) (-13.54,46.191),Pull (-14.46,45.449) (-15.39,44.707),Pull (-16.88,45.449) (-18.36,46.191),Pull (-18.55,46.562) (-18.73,46.933)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-15.39,53.982) [Pull (-14.46,53.197) (-13.54,53.611)]
 |> outlined (solid 0.2)(rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.51,52.127) [Pull (-15.02,50.871) (-13.54,51.014)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.88,50.643) [Pull (-15.71,48.401) (-13.54,49.159)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-18.36,48.417) [Pull (-16.13,46.689) (-13.91,46.562)]
 |> outlined (solid 0.2) purple -- the unicorn horn line
 ,
 curve (-28.38,49.530) [Pull (-27.82,49.901) (-27.26,50.272),Pull (-27.08,50.828) (-26.89,51.385),Pull (-25.97,51.014) (-25.04,50.643),Pull (-25.04,50.272) (-25.04,49.901),Pull (-26.15,49.159) (-27.26,48.417),Pull (-27.82,49.159) (-28.38,49.530)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-25.04,50.643) [Pull (-24.67,51.014) (-24.30,51.385),Pull (-23.93,51.756) (-23.55,52.127),Pull (-23.37,51.571) (-23.18,51.014),Pull (-22.81,51.014) (-22.44,51.014),Pull (-22.44,50.828) (-22.44,50.643),Pull (-23.74,50.272) (-25.04,49.901),Pull (-25.04,50.457) (-25.04,50.643)]
 |>filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-28.01,49.159) [Pull (-28.75,49.159) (-29.49,49.159),Pull (-29.49,48.417) (-29.49,47.675),Pull (-29.31,47.489) (-29.12,47.304),Pull (-28.19,48.046) (-27.26,48.788),Pull (-27.26,48.788) (-28.01,49.159)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-29.49,47.675) [Pull (-30.42,47.675) (-31.35,47.675),Pull (-31.35,47.118) (-31.35,46.562),Pull (-31.53,46.562) (-31.72,46.562),Pull (-31.16,46.005) (-30.60,45.449),Pull (-29.68,46.376) (-28.75,47.304),Pull (-29.12,47.489) (-29.49,47.675)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-37.65,40.997) [Pull (-37.28,41.553) (-36.91,42.110),Pull (-36.54,41.553) (-36.17,40.997),Pull (-35.80,40.997) (-35.43,40.997),Pull (-35.98,40.626) (-36.54,40.255),Pull (-36.35,39.884) (-36.17,39.513),Pull (-36.54,39.698) (-36.91,39.884),Pull (-37.47,39.513) (-38.02,39.142),Pull (-37.84,39.884) (-37.65,40.626),Pull (-38.02,40.997) (-38.4,41.368),Pull (-38.02,41.182) (-37.65,40.997)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-28.01,25.043) [Pull (-27.64,25.6) (-27.26,26.156),Pull (-27.08,25.6) (-26.89,25.043),Pull (-26.34,25.043) (-25.78,25.043),Pull (-26.34,24.672) (-26.89,24.301),Pull (-26.71,23.744) (-26.52,23.188),Pull (-27.08,23.559) (-27.64,23.930),Pull (-28.01,23.744) (-28.38,23.559),Pull (-28.19,24.115) (-28.01,24.672),Pull (-28.56,25.043) (-29.12,25.414),Pull (-28.56,25.228) (-28.01,25.043)]
 |>filled (rgb 183 213 224) -- the star earring
 ]
 
hair_girl = group [
  
 face
 |> scale 0.72
 |> move (2,15)
 ,
 curve (-15.02,41.739) [Pull (-13.35,44.324) (-11.68,42.110),Pull (-12.41,37.657) (-8.347,33.205),Pull (-6.492,31.976) (-4.637,33.947),Pull (-9.263,37.843) (-9.089,41.739),Pull (-11.25,46.881) (-15.02,43.223),Pull (-17.43,46.481) (-19.84,41.739),Pull (-23.25,33.571) (-29.86,35.802),Pull (-33.37,38.956) (-32.09,42.110),Pull (-35.50,37.657) (-31.72,33.205),Pull (-28.75,30.863) (-25.78,31.721),Pull (-18.13,33.744) (-16.88,41.368),Pull (-16.75,44.353) (-15.02,41.739)]
 |> filled (rgb 252 163 217)
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the bangs
 ,
 curve (-15.39,44.707) [Pull (-11.68,47.936) (-7.976,43.965),Pull (-6.092,41.924) (-5.008,39.884),Pull (-4.208,37.657) (-5.008,35.431),Pull (-3.623,34.689) (-4.637,33.947),Pull (-9.263,37.843) (-9.089,41.739),Pull (-11.65,47.281) (-15.02,43.223),Pull (-17.43,46.081) (-19.84,41.739),Pull (-22.45,33.971) (-29.86,35.802),Pull (-30.97,37.286) (-32.09,38.771),Pull (-28.19,34.626) (-24.30,42.481),Pull (-21.84,47.594) (-15.39,44.707)]
 |> filled (rgb 252 163 217)
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the hair behind the bangs
 ,
 curve (-31.35,38.028) [Pull (-33.32,40.069) (-32.09,42.110),Pull (-31.86,45.078) (-27.64,48.046),Pull (-23.37,51.344) (-19.10,50.643),Pull (-11.72,50.475) (-8.347,44.707),Pull (-11.87,47.907) (-15.39,44.707),Pull (-22.83,48.023) (-24.67,41.739),Pull (-28.01,36.284) (-31.35,38.028)]
 |> filled  (rgb 252 163 217)
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the top head
 ,
 curve (-21.70,51.385) [Pull (-23.68,56.811) (-27.26,55.837),Pull (-31.16,57.895) (-35.06,54.353),Pull (-43.99,48.875) (-41.73,40.997),Pull (-41.59,34.875) (-45.44,28.753),Pull (-49.15,24.568) (-52.86,28.382),Pull (-53.91,29.681) (-51.75,30.979),Pull (-56.52,30.168) (-52.49,26.156),Pull (-49.71,24.185) (-46.93,25.414),Pull (-46.19,25.971) (-45.44,26.527),Pull (-52.61,20.962) (-56.57,15.397),Pull (-60.45,10.017) (-54.72,4.6376),Pull (-53.05,3.1536) (-51.38,1.6695),Pull (-50.81,-6.927) (-55.83,-3.524),Pull (-56.39,-2.411) (-56.95,-1.298),Pull (-58.32,-6.266) (-52.49,-7.234),Pull (-50.64,-7.350) (-48.78,-4.266),Pull (-48.73,-7.605) (-50.27,-10.94),Pull (-53.69,-12.57) (-54.72,-10.20),Pull (-54.53,-9.275) (-54.35,-8.347),Pull (-58.68,-13.47) (-51.01,-15.39),Pull (-48.97,-15.21) (-46.93,-15.02),Pull (-40.99,-7.275) (-35.06,-3.524),Pull (-35.36,-0.371) (-32.46,2.7826),Pull (-32.46,3.7101) (-32.46,4.6376),Pull (-34.70,5.5652) (-31.35,6.4927),Pull (-35.07,9.2753) (-33.20,12.057),Pull (-29.68,18.597) (-26.15,18.736),Pull (-24.98,21.518) (-25.41,24.301),Pull (-35.49,28.794) (-33.57,37.286),Pull (-34.83,39.698) (-32.09,42.110),Pull (-28.71,50.376) (-21.33,50.643),Pull (-21.51,51.2) (-21.70,51.385)]
 |> filled (rgb 252 163 217)
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the top pony
 ,
 curve (-6.863,32.463) [Pull (-8.492,30.608) (-6.121,28.753),Pull (-4.863,26.527) (-7.605,24.301),Pull (-9.020,23.188) (-7.234,22.075),Pull (-9.791,23.559) (-8.347,25.043),Pull (-6.162,26.713) (-7.976,28.382),Pull (-8.162,29.681) (-8.347,30.979),Pull (-7.791,31.907) (-7.234,32.834),Pull (-7.049,32.649) (-6.863,32.463)]
 |>  filled (rgb 252 163 217)
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the right side hair
 ,
 
 curve (-25.41,32.092) [Pull (-26.48,29.310) (-23.55,26.527),Pull (-23.44,21.872) (-26.52,22.817),Pull (-23.35,24.857) (-25.78,26.898),Pull (-25.78,29.310) (-25.41,32.092)]
 |>  filled (rgb 252 163 217)
  |> addOutline (solid 0.5) (rgb 190 123 156)-- the left side hair
 ,
 curve (-33.57,36.915) [Pull (-34.66,27.965) (-26.15,25.414),Pull (-25.97,28.568) (-25.78,31.721),Pull (-31.68,30.318) (-33.57,36.915)]
 |>  filled (rgb 252 163 217)
 |> addOutline (solid 0.5)(rgb 249 182 217) -- the left side hair
 ,
  curve (-31.72,46.562) [Pull (-38.71,43.571) (-36.91,30.979),Pull (-36.62,20.104) (-44.33,12.428)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes
  ,
  curve (-32.09,29.495) [Pull (-30.97,22.446) (-40.25,15.397),Pull (-48.35,7.2347) (-42.85,-0.927),Pull (-39.06,-5.379) (-42.48,-9.831)]
  |> outlined (solid 0.4) (rgb 211 141 177) -- hair strokes
  ,
  curve (-32.09,25.785) [Pull (-31.46,18.179) (-38.02,10.573),Pull (-42.27,2.5971) (-36.91,-5.379)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes lighter
  ,
  curve (-28.01,23.559) [Pull (-29.35,17.808) (-34.68,12.057),Pull (-38.53,6.3072) (-33.57,0.5565)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes lighter
  ,
   curve (-37.65,25.414) [Pull (-39.95,19.849) (-45.44,14.284),Pull (-52.90,7.7913) (-49.15,1.2985),Pull (-42.60,-5.750) (-48.04,-12.8),Pull (-51.38,-16.18) (-54.72,-13.17)]
  |> outlined (solid 0.4) (rgb 211 141 177) -- hair strokes 
  ,
   curve (-42.11,39.142) [Pull (-38.57,30.608) (-45.44,22.075),Pull (-53.95,14.626) (-52.86,7.9768)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes 
  ,
   curve (-39.14,7.9768) [Pull (-39.59,4.4521) (-37.65,0.9275),Pull (-35.50,-1.855) (-36.54,-4.637)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes 
  ,
   curve (-28.38,49.530) [Pull (-39.54,52.736) (-39.51,39.142),Pull (-39.01,36.904) (-36.91,29.866)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes 
  ,
   curve (-26.52,51.385) [Pull (-30.79,56.469) (-35.06,54.353)]
  |> outlined (solid 0.4) (rgb 211 141 177) -- hair strokes
  ,
   curve (-24.67,51.756) [Pull (-24.71,55.982) (-28.75,56.208)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes
  ,
   curve (-29.49,46.562) [Pull (-30.16,42.950) (-27.64,41.739)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes on the top head
   ,
   curve (-24.67,45.449) [Pull (-26.34,46.162) (-28.01,47.675)]
 |> outlined (solid 0.3) (rgb 190 123 156) -- hair strokes on the top head
 ,
   curve (-18.36,48.046) [Pull (-20.77,49.773) (-23.18,49.901)]
  |> outlined (solid 0.3) (rgb 190 123 156) -- hair strokes on the top head
  ,
  curve (-30.97,31.350) [Pull (-33.07,33.020) (-33.57,34.689)]
  |> outlined (solid 0.3) (rgb 211 141 177) -- hair strokes on the top head
  ,
 curve (-27.64,30.979) [Pull (-29.71,33.194) (-30.97,30.608),Pull (-31.46,28.568) (-28.75,26.527),Pull (-28.19,26.342) (-27.64,26.156),Pull (-26.89,26.898) (-26.15,27.640),Pull (-26.89,29.310) (-27.64,30.979)]
 |> filled (rgb 248 229 223)  -- the ear

 ] 

 
dress_deatails = group [

 curve (-15.02,0.1855) [Pull (-15.05,-3.524) (-16.88,-7.234)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-16.13,0.1855) [Pull (-17.15,-2.040) (-18.36,-4.266)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-17.99,-4.637) [Pull (-18.39,-7.049) (-20.59,-9.460)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-18.36,0.1855) [Pull (-20.72,-1.326) (-22.07,-4.637)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-20.22,0.9275) [Pull (-27.52,-2.808) (-32.83,-10.94)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-30.60,-19.47) [Pull (-30.43,-14.88) (-27.26,-11.68)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-12.05,-0.185) [Pull (-9.702,-2.282) (-8.347,-5.379)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-5.008,-7.605) [Pull (-1.255,-11.74) (1.2985,-16.88)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-9.460,1.6695) [Pull (-5.707,-0.869) (-3.153,-5.008)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (3.5246,-15.76) [Pull (2.8130,-11.68) (-1.298,-7.605)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-23.55,-10.94) [Pull (-26.40,-14.39) (-27.64,-19.84)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-40.25,-24.30) [Pull (-44.66,-29.49) (-45.07,-34.68)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
  curve (-26.15,-21.33) [Pull (-29.14,-25.6) (-29.12,-29.86)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
 curve (-15.39,-11.68) [Pull (-17.52,-18.17) (-17.25,-24.67)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
  curve (-12.8,-13.54) [Pull (-13.78,-19.47) (-13.17,-25.41)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
  curve (-10.57,-9.831) [Pull (-7.418,-17.43) (-6.863,-25.04)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
 curve (-6.492,-13.17) [Pull (-2.766,-19.66) (-2.040,-26.15)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
 curve (-0.556,-18.73) [Pull (2.4840,-22.95) (3.5246,-28.38)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
 curve (5.0086,-22.07) [Pull (7.7927,-26.89) (7.9768,-31.72)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
  curve (-6.492,-25.78) [Pull (-4.081,-23.75) (-1.669,-26.52),Pull (-1.953,-28.71) (-4.637,-26.89),Pull (-5.565,-26.34) (-6.492,-25.78)]
 |> filled  (rgb 135 143 215)
 ,
  curve (-3.895,-28.75) [Pull (6.9449,-27.86) (0.1855,-30.97),Pull (-1.855,-29.86) (-3.895,-28.75)]
 |> filled  (rgb 135 143 215)
  |> addOutline (solid 1)(rgb 135 143 215)
 
 
 ]
 

face_girl skin eCol hCol = group [   
 curve (-35.43,23.188) [Pull (-31.35,27.402) (-27.26,22.817),Pull (-27.45,21.147) (-27.64,19.478),Pull (-30.42,18.278) (-33.20,19.478),Pull (-35.51,21.333) (-35.43,23.188)]
  |> filled (rgb 253 250 255) -- the left eye
  ,
  
 curve (-27.64,23.559) [Pull (-30.12,28.330) (-35.80,24.301),Pull (-36.17,24.301) (-36.54,24.301),Pull (-36.78,23.559) (-35.43,22.817),Pull (-32.33,27.988) (-27.64,23.559)]
  |> filled (rgb 62 29 36)
  |> addOutline (solid 0.5)(rgb 62 29 36)-- the left eye eyelash
  
  ,
  
 curve (-20.96,19.478) [Pull (-20.09,23.918) (-17.62,23.559),Pull (-15.95,24.231) (-14.28,21.704),Pull (-14.59,19.420) (-16.51,18.736),Pull (-18.73,17.907) (-20.96,19.478)]
  |> filled (rgb 253 250 255)-- the right eye
  ,
  
 curve (-19.84,23.188) [Pull (-16.69,26.173) (-13.54,23.559),Pull (-12.61,23.002) (-11.68,22.446),Pull (-12.98,22.660) (-14.28,22.075),Pull (-15.86,25.031) (-19.84,23.188)]
  |> filled (rgb 62 29 36) -- the right eye eyelash
  ,
  
 curve (-22.07,18.365) [Pull (-20.28,17.252) (-21.70,16.139)]
  |> outlined (solid 0.3) (rgb 222 149 143) -- the nose
  ,
  

 curve (-24.30,16.881) [Pull (-23.93,16.695) (-23.55,16.510)]  
  |> outlined (solid 0.3) (rgb 222 149 143)-- the nostril on the left 
 ,
 
 curve (-22.81,16.510) [Pull (-22.44,16.510) (-22.07,16.510)]
  |> outlined (solid 0.3) (rgb 222 149 143) -- the nostril on the right
   ,
   
  curve (-28.01,14.655) [Pull (-27.82,14.469) (-27.64,14.284),Pull (-24.48,11.542) (-21.33,12.8),Pull (-20.96,13.356) (-20.59,13.913),Pull (-24.30,12.684) (-28.01,14.655)]
  |> filled (rgb 189 90 119) -- the inside of the mouth
  ,
    
 
 curve (-28.01,14.655) [Pull (-27.66,14.469) (-26.52,14.284),Pull (-25.41,14.684) (-24.30,14.284),Pull (-23.37,14.684) (-22.44,14.284),Pull (-21.70,14.098) (-20.96,13.913),Pull (-24.08,12.684) (-28.01,14.655)]
  |> filled (rgb 255 168 193) -- the upper lip
  ,
  
 curve (-28.01,14.284) [Pull (-27.08,13.727) (-26.15,13.171),Pull (-23.93,12.185) (-21.70,12.8),Pull (-21.14,13.356) (-20.59,13.913),Pull (-23.50,8.4985) (-28.01,14.284)]
  |> filled (rgb 255 168 193) -- the bottem lip
   ,
   
 curve (-24.67,13.542) [Pull (-23.74,13.542) (-22.81,13.542),Pull (-23.55,12.742) (-24.67,13.542)]
  |> filled white -- the teeth
  ,
  
 curve (-36.54,19.107) [Pull (-32.83,19.908) (-29.12,16.510),Pull (-30.33,13.668) (-33.94,15.026),Pull (-36.14,17.066) (-36.54,19.107)]
  |> filled (rgb 254 184 194)
  |> makeTransparent 0.8-- the left blush
  ,
  
 curve (-18.73,15.397) [Pull (-17.11,19.439) (-14.28,16.881),Pull (-15.01,13.439) (-18.73,15.397)]
 |> filled (rgb 254 184 194)
  |> makeTransparent 0.8-- the right blush
  ,
  
 curve (-30.97,29.124) [Pull (-28.75,29.282) (-26.52,27.640),Pull (-25.51,27.782) (-26.89,29.124),Pull (-28.19,29.795) (-29.49,29.866),Pull (-30.23,29.495) (-30.97,29.124)]
  |> filled hCol
  |>addOutline (solid 0.5) hCol -- the left eyebrow
 ,
 
 curve (-18.36,28.753) [Pull (-20.05,28.011) (-18.73,27.269),Pull (-16.51,28.055) (-14.28,27.640),Pull (-15.12,29.697) (-18.36,28.753)]
  |> filled hCol -- the right eyebrow
  ,
  eyes eCol
  ,
  circle 0.7
  |> filled white
  |> move (-33,23)
  ,
  circle 0.7
  |> filled white
  |> move (-30,23)
 
  ,
  circle 0.59
  |> filled white
  |> move (-19,22)
  ,
  circle 0.5
  |> filled white
  |> move (-16.5,22)
 
 ]


shadeColorEye factor col =
  if col == rgb 80 50 30 then rgb (min 255 (80 * factor)) (min 255 (50 * factor)) (min 255 (30 * factor))
  else if col == rgb 60 100 160 then rgb (min 255 (60 * factor)) (min 255 (100 * factor)) (min 255 (160 * factor))
  else if col == rgb 70 130 80 then rgb (min 255 (70 * factor)) (min 255 (130 * factor)) (min 255 (80 * factor))
  else if col == rgb 130 100 60 then rgb (min 255 (130 * factor)) (min 255 (100 * factor)) (min 255 (60 * factor))
  else if col == rgb 110 110 110 then rgb (min 255 (110 * factor)) (min 255 (110 * factor)) (min 255 (110 * factor))
  else if col == rgb 200 140 50 then rgb (min 255 (200 * factor)) (min 255 (140 * factor)) (min 255 (50 * factor))
  else if col == rgb 130 80 160 then rgb (min 255 (130 * factor)) (min 255 (80 * factor)) (min 255 (160 * factor))
  else col
  
eyes eCol =
  let
    shade factor = shadeColorEye factor eCol
  in
  group [
    circle 2.7
      |> filled (shade 1.7)
      |> move (-31.5,22)
    ,
    circle 1.9
      |> filled (shade 1.0)
      |> move (-31.5,22.2)
      
      , circle 2.4
  |> filled (shade 1.7)
  -- the right eye
  |> move (-18,21)
  ,
 circle 1.6
  |> filled (shade 1.0)
 
  |> move (-18,21.5)
  ]

face = group [   
 curve (-35.43,23.188) [Pull (-31.35,27.402) (-27.26,22.817),Pull (-27.45,21.147) (-27.64,19.478),Pull (-30.42,18.278) (-33.20,19.478),Pull (-35.51,21.333) (-35.43,23.188)]
  |> filled (rgb 253 250 255) -- the left eye
  ,
  
 curve (-27.64,23.559) [Pull (-30.12,28.330) (-35.80,24.301),Pull (-36.17,24.301) (-36.54,24.301),Pull (-36.78,23.559) (-35.43,22.817),Pull (-32.33,27.988) (-27.64,23.559)]
  |> filled (rgb 62 29 36)
  |> addOutline (solid 0.5)(rgb 62 29 36)-- the left eye eyelash
  
  ,
  
 curve (-20.96,19.478) [Pull (-20.09,23.918) (-17.62,23.559),Pull (-15.95,24.231) (-14.28,21.704),Pull (-14.59,19.420) (-16.51,18.736),Pull (-18.73,17.907) (-20.96,19.478)]
  |> filled (rgb 253 250 255)-- the right eye
  ,
  
 curve (-19.84,23.188) [Pull (-16.69,26.173) (-13.54,23.559),Pull (-12.61,23.002) (-11.68,22.446),Pull (-12.98,22.660) (-14.28,22.075),Pull (-15.86,25.031) (-19.84,23.188)]
  |> filled (rgb 62 29 36) -- the right eye eyelash
  ,
  
 curve (-22.07,18.365) [Pull (-20.28,17.252) (-21.70,16.139)]
  |> outlined (solid 0.3) (rgb 222 149 143) -- the nose
  ,
  

 curve (-24.30,16.881) [Pull (-23.93,16.695) (-23.55,16.510)]  
  |> outlined (solid 0.3) (rgb 222 149 143)-- the nostril on the left 
 ,
 
 curve (-22.81,16.510) [Pull (-22.44,16.510) (-22.07,16.510)]
  |> outlined (solid 0.3) (rgb 222 149 143) -- the nostril on the right
   ,
   
  curve (-28.01,14.655) [Pull (-27.82,14.469) (-27.64,14.284),Pull (-24.48,11.542) (-21.33,12.8),Pull (-20.96,13.356) (-20.59,13.913),Pull (-24.30,12.684) (-28.01,14.655)]
  |> filled (rgb 189 90 119) -- the inside of the mouth
  ,
    
 
 curve (-28.01,14.655) [Pull (-27.66,14.469) (-26.52,14.284),Pull (-25.41,14.684) (-24.30,14.284),Pull (-23.37,14.684) (-22.44,14.284),Pull (-21.70,14.098) (-20.96,13.913),Pull (-24.08,12.684) (-28.01,14.655)]
  |> filled (rgb 255 168 193) -- the upper lip
  ,
  
 curve (-28.01,14.284) [Pull (-27.08,13.727) (-26.15,13.171),Pull (-23.93,12.185) (-21.70,12.8),Pull (-21.14,13.356) (-20.59,13.913),Pull (-23.50,8.4985) (-28.01,14.284)]
  |> filled (rgb 255 168 193) -- the bottem lip
   ,
   
 curve (-24.67,13.542) [Pull (-23.74,13.542) (-22.81,13.542),Pull (-23.55,12.742) (-24.67,13.542)]
  |> filled white -- the teeth
  ,
  
 curve (-36.54,19.107) [Pull (-32.83,19.908) (-29.12,16.510),Pull (-30.33,13.668) (-33.94,15.026),Pull (-36.14,17.066) (-36.54,19.107)]
  |> filled (rgb 254 184 194)
  |> makeTransparent 0.8-- the left blush
  ,
  
 curve (-18.73,15.397) [Pull (-17.11,19.439) (-14.28,16.881),Pull (-15.01,13.439) (-18.73,15.397)]
 |> filled (rgb 254 184 194)
  |> makeTransparent 0.8-- the right blush
  ,
  
 curve (-30.97,29.124) [Pull (-28.75,29.282) (-26.52,27.640),Pull (-25.51,27.782) (-26.89,29.124),Pull (-28.19,29.795) (-29.49,29.866),Pull (-30.23,29.495) (-30.97,29.124)]
  |> filled (rgb 218 149 144) 
  |>addOutline (solid 0.5)(rgb 218 149 144) -- the left eyebrow
 ,
 
 curve (-18.36,28.753) [Pull (-20.05,28.011) (-18.73,27.269),Pull (-16.51,28.055) (-14.28,27.640),Pull (-15.12,29.697) (-18.36,28.753)]
  |> filled (rgb 218 149 144) -- the right eyebrow
  ,
  circle 2.7
  |> filled (rgb 172 187 228)
                        -- the left eye
  |> move (-31.5,22)
  ,
  circle 1.9
  |> filled (rgb 60 67 121)
  |> move (-31.5,22.2)
  ,
  circle 0.7
  |> filled white
  |> move (-33,23)
  ,
  circle 0.7
  |> filled white
  |> move (-30,23)
 ,
 circle 2.4
  |> filled (rgb 172 187 228)
  -- the right eye
  |> move (-18,21)
  ,
 circle 1.6
  |> filled (rgb 60 67 121)
 
  |> move (-18,21.5)
  ,
  circle 0.59
  |> filled white
  |> move (-19,22)
  ,
  circle 0.5
  |> filled white
  |> move (-16.5,22)
 
 ]
 
----- MALE SHELL
 
boy = group [
   skin_boy
 ,
 hair_boy
 ,
 clothes_boy
 ,
 boots_boy
 ,
 face_boy
 ,
 unicorn_badge
 |> scale 0.09
 |> move (-12.5,-7.8)

  ]
 
skin_boy = group [
 curve (-39.51,18.736) [Pull (-38.56,10.185) (-28.01,7.2347),Pull (-23.93,5.8492) (-19.84,6.8637),Pull (-8.556,9.3855) (-6.863,19.107),Pull (-6.863,29.124) (-6.863,39.142),Pull (-23.18,38.771) (-39.51,38.4),Pull (-39.69,28.382) (-39.51,18.736)]
  |> filled (rgb 250 221 205)-- the face
  ,
  
 curve (-5.008,23.930) [Pull (-1.553,23.860) (-1.298,20.591),Pull (-1.153,16.237) (-5.008,14.284),Pull (-6.678,13.669) (-8.347,14.655),Pull (-6.220,16.881) (-6.492,19.107),Pull (-6.492,22.075) (-6.492,25.043),Pull (-5.565,24.486) (-5.008,23.930)]
  |>  filled (rgb 250 221 205) -- the right ear
  ,
  
 curve (-39.51,18.736) [Pull (-40.81,21.147) (-42.11,23.559),Pull (-46.17,24.562) (-45.44,18.365),Pull (-43.92,13.310) (-38.4,14.655),Pull (-38.95,16.881) (-39.51,18.736)]
  |> filled (rgb 250 221 205) -- the left ear
  ,
  
 curve (-26.89,7.2347) [Pull (-26.89,6.1217) (-26.89,5.0086),Pull (-26.71,3.3391) (-26.52,1.6695),Pull (-26.52,0.7420) (-26.52,-0.185),Pull (-23.18,0) (-19.84,0.1855),Pull (-19.29,1.1130) (-18.73,2.0405),Pull (-19.10,2.9681) (-19.47,3.8956),Pull (-19.66,5.3797) (-19.84,6.8637),Pull (-23.37,5.4492) (-26.89,7.2347)]
  |> filled (rgb 240 200 190) -- the neck
  ,
  
 curve (-43.96,-19.10) [Pull (-46.52,-22.81) (-45.07,-26.52),Pull (-44.70,-27.94) (-44.33,-26.15),Pull (-43.59,-28.34) (-42.85,-26.52),Pull (-41.36,-21.41) (-39.88,-24.30),Pull (-39.32,-25.90) (-38.77,-24.30),Pull (-38.77,-22.81) (-38.77,-21.33),Pull (-42.56,-21.42) (-43.96,-19.10)]
  |> filled (rgb 250 221 205) -- the the left hand
  ,
  
 curve (-7.605,-20.96) [Pull (-7.976,-22.63) (-8.347,-24.30),Pull (-7.605,-26.48) (-6.863,-24.67),Pull (-5.565,-21.65) (-4.266,-25.04),Pull (-3.339,-28.18) (-2.411,-26.52),Pull (-2.597,-25.41) (-2.782,-24.30),Pull (-2.040,-28.05) (-1.298,-25.41),Pull (-0.440,-22.44) (-2.782,-19.47),Pull (-3.994,-21.42) (-7.605,-20.96)]
  |>filled (rgb 250 221 205) -- the the right hand
  ]
hair_boy = group [

  
 curve (-11.68,36.173) [Pull (-11.93,34.133) (-10.57,32.092),Pull (-8.672,27.350) (-13.17,30.608),Pull (-17.64,33.762) (-16.51,36.915),Pull (-18.50,29.820) (-26.89,29.124),Pull (-28.34,30.608) (-25.78,32.092),Pull (-23.65,34.504) (-23.93,36.915),Pull (-25.31,29.976) (-34.68,30.237),Pull (-35.26,33.205) (-30.23,36.173),Pull (-34.50,35.107) (-38.77,27.640),Pull (-39.19,24.115) (-38.02,20.591),Pull (-36.77,17.849) (-39.51,19.107),Pull (-40.62,21.518) (-41.73,23.930),Pull (-44.39,24.973) (-45.44,22.817),Pull (-49.44,27.826) (-45.44,32.834),Pull (-46.74,31.536) (-48.04,30.237),Pull (-49.63,36.260) (-43.22,39.884),Pull (-44.89,39.426) (-46.56,41.368),Pull (-47.20,44.081) (-45.44,43.594),Pull (-41.73,43.234) (-38.02,47.675),Pull (-32.36,52.544) (-24.30,51.014),Pull (-26.15,52.127) (-28.01,53.240),Pull (-30.28,53.797) (-26.15,54.353),Pull (-23.37,54.869) (-20.59,51.385),Pull (-18.06,53.611) (-18.73,55.837),Pull (-17.43,57.124) (-16.13,53.611),Pull (-15.68,52.127) (-17.62,50.643),Pull (-12.61,51.773) (-7.605,47.304),Pull (-4.823,46.104) (-2.040,47.304),Pull (-1.924,43.849) (-5.008,43.594),Pull (1.5594,41.084) (0.9275,36.173),Pull (-0.371,36.115) (-1.669,37.657),Pull (2.8289,33.020) (0.9275,28.382),Pull (-0.185,29.866) (-1.298,31.350),Pull (1.7159,26.898) (-1.669,22.446),Pull (-4.266,25.362) (-6.863,19.478),Pull (-9.391,17.634) (-8.718,20.591),Pull (-6.933,25.043) (-8.347,29.495),Pull (-9.089,30.423) (-9.831,31.350),Pull (-10.75,33.762) (-11.68,36.173)]
  |> filled (rgb 165 127 114) -- the top hair
  ,
  
 curve (-40.99,14.284) [Pull (-38.89,13.657) (-38.4,9.8318),Pull (-37.47,9.4028) (-36.54,10.573),Pull (-35.54,6.5043) (-31.35,7.2347),Pull (-30.05,5.4782) (-28.75,6.1217),Pull (-28.01,6.4927) (-27.26,6.8637),Pull (-36.03,8.3594) (-38.4,14.655),Pull (-39.88,13.669) (-40.99,14.284)]
  |> filled (rgb 144 96 84) -- the left hair
  ,
  
 curve (-6.492,14.284) [Pull (-8.405,11.872) (-8.718,9.4608),Pull (-9.460,9.1884) (-10.20,11.315),Pull (-9.999,8.8753) (-15.39,7.2347),Pull (-16.69,5.2927) (-17.99,5.7507),Pull (-18.73,6.3072) (-19.47,6.8637),Pull (-12.71,8.7594) (-8.347,14.655),Pull (-7.605,14.469) (-6.492,14.284)]
  |> filled (rgb 144 96 84) -- the right hair
  ]
clothes_boy = group [
  
 curve (-36.17,-28.38) [Pull (-37.34,-35.61) (-36.91,-42.85),Pull (-35.80,-44.57) (-34.68,-44.70),Pull (-31.16,-45.87) (-27.64,-45.44),Pull (-24.15,-43.53) (-24.67,-43.22),Pull (-24.48,-37.10) (-24.30,-30.97),Pull (-23.37,-29.16) (-22.44,-31.35),Pull (-23.06,-37.28) (-22.07,-43.22),Pull (-20.40,-44.73) (-18.73,-45.44),Pull (-15.02,-45.87) (-11.31,-44.70),Pull (-9.188,-43.40) (-9.460,-42.11),Pull (-9.617,-35.43) (-10.57,-28.75),Pull (-12.05,-26.15) (-13.54,-23.55),Pull (-20.59,-23.55) (-27.64,-23.55),Pull (-31.90,-25.97) (-36.17,-28.38)]
  |> filled (rgb 161 187 160) -- the pants
 
 ,
 curve (-29.49,3.8956) [Pull (-35.51,3.6579) (-39.14,-5.379),Pull (-43.12,-10.01) (-44.70,-14.65),Pull (-45.13,-16.32) (-43.96,-17.99),Pull (-40.99,-20.70) (-38.02,-20.22),Pull (-34.57,-18.97) (-34.31,-16.13),Pull (-23.18,-20.53) (-12.05,-16.13),Pull (-11.21,-19.77) (-7.976,-20.22),Pull (-5.194,-20.12) (-2.411,-17.62),Pull (-1.211,-15.58) (-2.411,-13.54),Pull (-6.620,-5.750) (-12.42,2.0405),Pull (-15.02,4.1681) (-17.62,3.8956),Pull (-19.04,0.9971) (-22.07,1.2985),Pull (-22.63,0.1855) (-23.18,-0.927),Pull (-23.74,0) (-24.30,0.9275),Pull (-28.49,1.2115) (-29.49,3.8956)]
  |> filled (rgb 162 200 209) -- the top of the shirt with thw two arms
  ,
  
 curve (-35.43,-18.73) [Pull (-36.91,-22.81) (-38.4,-26.89),Pull (-34.12,-30.53) (-25.04,-30.97),Pull (-24.91,-28.01) (-23.18,-25.04),Pull (-21.64,-27.82) (-21.70,-30.60),Pull (-15.02,-32.53) (-8.347,-27.26),Pull (-9.646,-23.18) (-10.94,-19.10),Pull (-11.31,-18.36) (-11.68,-17.62),Pull (-22.38,-22.42) (-34.68,-17.62),Pull (-35.06,-18.17) (-35.43,-18.73)]
  |> filled (rgb 163 201 210) -- the bottem of the shirt 
  ,
  
 curve (-18.73,6.4927) [Pull (-22.37,4.8231) (-22.81,3.1536),Pull (-22.81,1.4840) (-22.81,-0.185),Pull (-23.37,-2.185) (-23.93,-0.185),Pull (-23.93,1.6695) (-23.93,3.5246),Pull (-26.34,6.0231) (-28.75,6.1217),Pull (-29.52,5.0086) (-29.49,3.8956),Pull (-28.49,0.8115) (-24.30,0.9275),Pull (-23.18,0.9275) (-22.07,0.9275),Pull (-17.04,1.3971) (-17.62,4.2666),Pull (-17.43,5.0086) (-17.25,5.7507),Pull (-18.79,4.9217) (-18.73,6.4927)]
  |> filled (rgb 163 201 210) -- the bottem of the shirt 
  ,
  
 curve (-18.73,6.4927) [Pull (-22.37,4.8231) (-22.81,3.1536),Pull (-22.81,1.4840) (-22.81,-0.185),Pull (-23.37,-2.185) (-23.93,-0.185),Pull (-23.93,1.6695) (-23.93,3.5246),Pull (-26.34,6.0231) (-28.75,6.1217),Pull (-29.52,5.0086) (-29.49,3.8956),Pull (-28.49,0.8115) (-24.30,0.9275),Pull (-23.18,0.9275) (-22.07,0.9275),Pull (-17.04,1.3971) (-17.62,4.2666),Pull (-17.43,5.0086) (-17.25,5.7507),Pull (-18.79,4.9217) (-18.73,6.4927)]
  |> outlined (solid 0.3) white -- the colar of the shirt
  ,
  
 curve (-43.96,-17.99) [Pull (-45.56,-18.15) (-43.96,-19.10),Pull (-42.56,-21.42) (-38.77,-21.33),Pull (-36.77,-20.77) (-38.77,-20.22),Pull (-41.76,-20.30) (-43.96,-17.99)]
  |> filled (rgb 163 201 210) -- the bottem of th left sleeve
  ,
  curve (-2.411,-17.99) [Pull (-1.397,-18.55) (-2.782,-19.10),Pull (-3.994,-21.84) (-7.605,-20.59),Pull (-8.991,-21.20) (-7.976,-20.22),Pull (-4.394,-19.72) (-2.411,-17.99)]
  |> filled (rgb 163 201 210)-- the bottem of the right sleeve
  ,
  
 curve (-34.31,-16.13) [Pull (-34.50,-16.88) (-34.68,-17.62),Pull (-22.38,-22.02) (-11.68,-17.62),Pull (-11.47,-16.69) (-12.05,-15.76),Pull (-22.57,-20.96) (-34.31,-16.13)]
  |> filled (rgb 163 189 202)
  |> addOutline (solid 0.5) (rgb 163 189 202) -- the band on his stomach
  ,
  curve (-25.41,-1.669) [Pull (-27.01,-2.226) (-25.41,-2.782),Pull (-23.55,-2.782) (-21.70,-2.782),Pull (-20.10,-2.226) (-21.70,-1.669),Pull (-23.55,-1.669) (-25.41,-1.669)]
 |> filled (rgb 138 151 160) -- the first button on the shirt
  ,
  -- the second button
  
 curve (-25.04,-3.524) [Pull (-23.84,-4.081) (-25.04,-4.637),Pull (-26.45,-4.081) (-25.04,-3.524)]
 |>filled (rgb 138 151 160)
  ,
  
 curve (-22.07,-3.524) [Pull (-20.68,-4.266) (-21.70,-5.008),Pull (-23.48,-4.266) (-22.07,-3.524)]
 |> filled (rgb 138 151 160)
  ,
  
 curve (-24.30,-3.895) [Pull (-23.55,-3.895) (-22.81,-3.895)]
 |> outlined (solid 0.5) (rgb 138 151 160) -- the string conntecting the circles
  ,
  
 curve (-19.47,-2.411) [Pull (-17.06,-3.182) (-14.65,-3.153),Pull (-14.16,-6.579) (-16.88,-7.605),Pull (-20.97,-5.808) (-19.47,-2.411)]
 |> filled (rgb 218 185 144) -- the badge
 ,
 curve (-36.91,-24.30) [Pull (-35.16,-28.89) (-25.41,-29.49),Pull (-26.27,-26.52) (-23.93,-23.55),Pull (-23.00,-22.94) (-22.07,-23.93),Pull (-20.31,-26.52) (-20.96,-29.12),Pull (-15.02,-30.62) (-9.089,-26.52)]
 |> outlined (solid 0.5) white -- the print on the bottem shirt
 ,
 -- the deatails on the cloths. All the same color
 
 curve (-33.57,-3.895) [Pull (-34.90,-8.347) (-35.43,-12.8),Pull (-36.07,-14.28) (-34.31,-15.76)]
 |> outlined (solid 0.5)(rgb 95 127 138)
  ,
  
 curve (-12.8,-3.524) [Pull (-12.05,-7.976) (-11.31,-12.42),Pull (-11.28,-14.09) (-12.05,-15.76)]
 |> outlined (solid 0.5) (rgb 95 127 138)
  ,
  -- arms
 curve (-40.99,-19.84) [Pull (-39.66,-18.92) (-39.14,-17.99)]
 |> outlined (solid 0.5)(rgb 95 127 138) 
  ,
  
 curve (-43.22,-18.36) [Pull (-43.62,-17.25) (-43.22,-16.13)]
 |> outlined (solid 0.5) (rgb 95 127 138) 
  ,
  curve (-3.895,-18.36) [Pull (-3.281,-16.88) (-4.266,-15.39)]
 |> outlined (solid 0.5) (rgb 95 127 138)
  ,
  curve (-5.379,-19.47) [Pull (-7.478,-18.36) (-7.976,-17.25)]
 |> outlined (solid 0.5) (rgb 95 127 138)
  ,
  
 curve (-17.62,-17.62) [Pull (-15.73,-16.32) (-14.65,-15.02)]
 |> outlined (solid 0.5)(rgb 95 127 138)
  ,
  curve (-29.49,-17.62) [Pull (-31.99,-16.13) (-32.09,-14.65)]
  |> outlined (solid 0.5)(rgb 95 127 138)
 ,
 curve (-14.65,-18.73) [Pull (-14.46,-19.47) (-14.28,-20.22)]
 |> outlined (solid 0.5) (rgb 95 127 138)
  ,
  curve (-31.72,-18.73) [Pull (-32.27,-19.84) (-32.83,-20.96)]
 |> outlined (solid 0.5)(rgb 95 127 138)
  
  ]
  
boots_boy = group [
  
 curve (-35.80,-43.96) [Pull (-37.18,-45.82) (-36.17,-47.67),Pull (-30.97,-49.86) (-25.78,-48.04),Pull (-25.35,-46.37) (-26.52,-44.70),Pull (-31.16,-47.53) (-35.80,-43.96)]
  |> filled (rgb 170 137 120)
  |> addOutline (solid 0.5)(rgb 170 137 120)-- the left boots top
  ,
  
 curve (-35.06,-47.67) [Pull (-35.06,-49.90) (-35.06,-52.12),Pull (-38.30,-53.79) (-39.14,-55.46),Pull (-39.22,-56.79) (-36.91,-57.32),Pull (-31.47,-57.80) (-27.64,-55.09),Pull (-27.26,-54.72) (-26.89,-54.35),Pull (-27.08,-51.38) (-27.26,-48.41),Pull (-32.06,-50.01) (-35.06,-47.67)]
  |> filled (rgb 153 128 106) -- the left boots 
  ,
  
 curve (-20.22,-44.33) [Pull (-21.20,-46.19) (-20.59,-48.04),Pull (-15.39,-50.26) (-10.20,-47.67),Pull (-10.17,-46.19) (-10.94,-44.70),Pull (-16.54,-46.89) (-20.22,-44.33)]
  |>  filled (rgb 170 137 120) -- the right boots top
  ,
  
 curve (-19.84,-48.41) [Pull (-19.66,-51.94) (-19.47,-55.46),Pull (-17.71,-57.19) (-13.54,-57.32),Pull (-10.57,-57.53) (-7.605,-56.95),Pull (-6.846,-54.53) (-11.68,-52.12),Pull (-11.68,-50.08) (-11.68,-48.04),Pull (-14.10,-49.80) (-19.84,-48.41)]
  |> filled (rgb 153 128 106)  -- the right boots 
  ,
  
 curve (-39.08,-56.18) [Pull (-39.95,-57.16) (-38.43,-58.13),Pull (-33.05,-59.72) (-27.68,-56.50),Pull (-25.92,-55.69) (-27.35,-54.88),Pull (-34.58,-58.56) (-39.08,-56.18)]
 |> filled (rgb 116 91 87) -- the left boots heel
  ,
  
 curve (-7.491,-57.16) [Pull (-7.431,-57.97) (-9.770,-58.78),Pull (-12.05,-59.18) (-14.33,-58.78),Pull (-18.13,-57.64) (-19.54,-56.50),Pull (-20.57,-55.62) (-19.21,-55.53),Pull (-14.71,-59.38) (-7.491,-57.16)]
 |> filled (rgb 116 91 87)
 |> addOutline (solid 0.8)(rgb 116 91 87) -- the right boots heel
  ,
  
 curve (-36.17,-52.86) [Pull (-34.87,-52.44) (-33.57,-53.61)]
 |> outlined (solid 0.5) (rgb 123 87 71) -- the left boots lace
  ,
  
 curve (-35.06,-52.12) [Pull (-33.57,-51.29) (-32.09,-52.86)]
 |> outlined (solid 0.5) (rgb 123 87 71) -- the left boots lace
  ,
  
 curve (-10.57,-52.86) [Pull (-11.87,-52.62) (-13.17,-53.98)]
 |> outlined (solid 0.5) (rgb 123 87 71) -- the right boots lace
  ,
  curve (-11.68,-52.12) [Pull (-13.17,-51.48) (-14.65,-53.24)]
 |> outlined (solid 0.5) (rgb 123 87 71) -- the right boots lace
  ]
  
face_boy = group [
 
 curve (-17.62,29.124) [Pull (-18.26,27.368) (-16.51,28.011),Pull (-13.91,28.626) (-11.31,27.640),Pull (-13.26,30.782) (-17.62,29.124)]
 |> filled (rgb 158 103 96) -- the right eyebrow
  ,
  
 curve (-29.86,28.011) [Pull (-27.89,27.553) (-29.12,29.495),Pull (-35.69,29.768) (-35.06,27.640),Pull (-32.46,28.626) (-29.86,28.011)]
 |> filled (rgb 158 103 96) -- the left eyebrow
  ,
  
 curve (-17.99,22.446) [Pull (-18.91,18.805) (-15.02,18.365),Pull (-12.8,17.692) (-10.57,20.220),Pull (-11.2,25.831) (-15.02,25.043),Pull (-17.09,24.144) (-17.99,22.446)]
 |> filled (rgb 247 252 255) -- the right eye
 ,
 
 curve (-10.20,21.704) [Pull (-10.57,20.962) (-10.94,20.220),Pull (-10.94,21.333) (-10.94,22.446),Pull (-12.31,26.173) (-16.88,24.301),Pull (-17.43,23.988) (-17.99,22.075),Pull (-18.16,25.930) (-13.54,25.785),Pull (-10.88,25.159) (-10.20,21.704)]
 |> filled (rgb 114 72 73) -- the right eyelash
  
  ,
  
 curve (-30.97,17.994) [Pull (-26.88,19.605) (-28.38,22.817),Pull (-31.72,27.773) (-35.06,23.930),Pull (-36.23,21.889) (-35.80,19.849),Pull (-34.00,17.321) (-30.97,17.994)]
 |>  filled (rgb 247 252 255) -- the left eye
 ,
 curve (-36.54,22.075) [Pull (-36.78,21.147) (-35.43,20.220),Pull (-36.34,24.231) (-32.46,25.043),Pull (-30.42,25.344) (-28.38,22.446),Pull (-29.37,26.515) (-33.57,25.785),Pull (-36.66,24.144) (-36.54,21.704)]
 |> filled (rgb 114 72 73) -- the left eyelash
  ,
 curve (-23.18,20.962) [Pull (-23.18,20.034) (-23.18,19.107)]
 |> outlined (solid 0.5)(rgb 195 135 124) -- the nose line
  ,
  curve (-24.67,17.623) [Pull (-23.37,20.208) (-22.07,17.994)]
 |> outlined (solid 0.5) (rgb 195 135 124) -- the nose 
  ,
  curve (-26.15,14.655) [Pull (-23.37,12.255) (-20.59,14.655)]
 |> outlined (solid 0.5) (rgb 195 135 124) -- the smile
 ,
 
 curve (-13.54,16.881) [Pull (-13.91,16.139) (-14.28,15.397)]
 |> outlined (solid 0.5) pink -- the right blush line
  ,
  
 curve (-12.8,15.768) [Pull (-12.24,16.324) (-11.68,16.881)]
 |> outlined (solid 0.5) pink -- the right blush line
  ,
  
 curve (-11.31,15.768) [Pull (-10.94,16.324) (-10.57,16.881)]
 |> outlined (solid 0.5) pink -- the right blush line
  ,
  
 curve (-33.57,15.397) [Pull (-33.20,15.953) (-32.83,16.510)]
 |> outlined (solid 0.5) pink -- the left blush line
  ,
  
 curve (-35.06,15.397) [Pull (-34.50,15.953) (-33.94,16.510)]
 |> outlined (solid 0.5) pink -- the left blush line
   ,
   
 curve (-36.17,16.139) [Pull (-35.43,16.510) (-34.68,16.881)]
 |> outlined (solid 0.5) pink -- the left blush line
  ,
  
 curve (-16.13,15.768) [Pull (-12.24,20.324) (-8.347,16.881),Pull (-11.44,11.524) (-16.13,15.768)]
 |> filled (rgb 237 169 160)
 |> makeTransparent 0.8-- the right blush 
  ,
  
 curve (-38.4,17.623) [Pull (-34.13,19.710) (-29.86,15.397),Pull (-35.73,10.510) (-38.4,17.623)]
 |> filled (rgb 237 169 160)
 |> makeTransparent 0.8-- the left blush
 ,
 oval 5 6
 |> filled (rgb 162 203 209) 
 -- the left eye
 |> move (-31.5,21.5)
 ,
 oval 3 4
 |> filled (rgb 83 108 130)
  -- the left eye
 |> move (-31.5,21.5)
 ,
 circle 1
 |> filled white
  -- the left eye
 |> move (-32.5,22.5)
  ,
  oval 5 6
 |> filled (rgb 162 203 209) 
  -- the right eye
 |> move (-15.5,21.5)
 ,
 oval 3 4
 |> filled (rgb 83 108 130)
 -- the right eye
 |> move (-16,21.5)
 ,
 circle 1
 |> filled white
  -- the left eye
 |> move (-16.5,22.5)
    
  
  ]
  
unicorn_badge =  group [
  
 
  -- face 
  curve (-63.62,35.802) [Pull (-64.18,34.504) (-64.74,33.205),Pull (-65.66,31.907) (-66.59,30.608),Pull (-67.52,30.052) (-68.45,29.495),Pull (-69.19,29.310) (-69.93,29.124),Pull (-70.12,28.568) (-70.30,28.011),Pull (-70.12,27.084) (-69.93,26.156),Pull (-69.19,25.414) (-68.45,24.672),Pull (-67.33,23.744) (-66.22,22.817),Pull (-64.74,22.446) (-63.25,22.075),Pull (-61.95,22.446) (-60.66,22.817),Pull (-56.57,23.188) (-52.49,23.559),Pull (-53.42,23.188) (-54.35,22.817),Pull (-50.27,21.704) (-46.19,20.591),Pull (-46.19,21.704) (-46.19,22.817),Pull (-46.37,24.857) (-46.56,26.898),Pull (-46.19,28.568) (-45.82,30.237),Pull (-45.44,32.278) (-45.07,34.318),Pull (-45.26,36.359) (-45.44,38.4),Pull (-45.82,39.513) (-46.19,40.626),Pull (-46.37,40.440) (-46.56,40.255),Pull (-45.82,41.924) (-45.07,43.594),Pull (-45.44,45.820) (-45.82,48.046),Pull (-46.74,49.530) (-47.67,51.014),Pull (-48.97,49.901) (-50.27,48.788),Pull (-50.64,46.747) (-51.01,44.707),Pull (-50.64,43.408) (-50.27,42.110),Pull (-51.38,43.037) (-52.49,43.965),Pull (-53.05,42.481) (-53.61,40.997),Pull (-53.98,39.884) (-54.35,38.771),Pull (-55.46,37.657) (-56.57,36.544),Pull (-58.24,36.173) (-59.91,35.802),Pull (-60.66,35.802) (-61.40,35.802),Pull (-61.40,35.802) (-63.62,35.802)]
  |> filled (rgb 253 248 237)
  |> addOutline (solid 1) (rgb 253 248 237)
 ,
 -- eye
 curve (-53.61,35.431) [Pull (-52.68,35.988) (-51.75,36.544),Pull (-52.49,35.988) (-53.24,35.431),Pull (-53.24,35.246) (-53.24,35.060),Pull (-52.68,35.060) (-52.12,35.060),Pull (-51.57,35.431) (-51.01,35.802),Pull (-51.75,35.246) (-52.49,34.689),Pull (-52.49,34.689) (-52.49,34.689),Pull (-51.57,34.689) (-50.64,34.689),Pull (-51.57,34.504) (-52.49,34.318),Pull (-52.49,33.947) (-52.49,33.576),Pull (-51.57,33.576) (-50.64,33.576),Pull (-51.57,33.391) (-52.49,33.205),Pull (-51.75,33.020) (-51.01,32.834),Pull (-50.82,32.834) (-50.64,32.834),Pull (-51.38,32.834) (-52.12,32.834),Pull (-52.49,32.278) (-52.86,31.721),Pull (-53.24,30.979) (-53.61,30.237),Pull (-54.72,30.423) (-55.83,30.608),Pull (-56.76,30.608) (-57.69,30.608),Pull (-57.50,30.794) (-57.32,30.979),Pull (-57.32,31.721) (-57.32,32.463),Pull (-57.13,33.205) (-56.95,33.947),Pull (-56.39,34.504) (-55.83,35.060),Pull (-54.72,35.246) (-53.61,35.431)]
  |> filled black
  ,
 -- front hair 
 curve (-44.33,44.707) [Pull (-43.59,44.892) (-42.85,45.078),Pull (-41.73,44.892) (-40.62,44.707),Pull (-39.32,44.150) (-38.02,43.594),Pull (-37.28,42.481) (-36.54,41.368),Pull (-36.54,39.884) (-36.54,38.4),Pull (-36.73,37.472) (-36.91,36.544),Pull (-36.17,34.689) (-35.43,32.834),Pull (-34.68,31.536) (-33.94,30.237),Pull (-34.31,28.011) (-34.68,25.785),Pull (-35.43,24.486) (-36.17,23.188),Pull (-36.91,21.704) (-37.65,20.220),Pull (-37.84,18.365) (-38.02,16.510),Pull (-37.65,15.211) (-37.28,13.913),Pull (-36.17,13.542) (-35.06,13.171),Pull (-34.50,13.542) (-33.94,13.913),Pull (-33.76,14.655) (-33.57,15.397),Pull (-33.39,14.469) (-33.20,13.542),Pull (-33.76,12.8) (-34.31,12.057),Pull (-34.87,11.872) (-35.43,11.686),Pull (-37.28,12.243) (-39.14,12.8),Pull (-40.44,13.913) (-41.73,15.026),Pull (-42.48,16.881) (-43.22,18.736),Pull (-43.59,20.776) (-43.96,22.817),Pull (-44.52,22.260) (-45.07,21.704),Pull (-45.44,21.704) (-45.82,21.704),Pull (-46.00,24.301) (-46.19,26.898),Pull (-46.00,29.124) (-45.82,31.350),Pull (-45.44,33.947) (-45.07,36.544),Pull (-45.63,38.585) (-46.19,40.626),Pull (-46.19,40.811) (-44.33,44.707)]
   |> filled (gradient [ stop (rgb 252 199 244)  0 , stop blue 40, stop blue 200])
  ,
 -- top hair
 curve (-50.27,47.675) [Pull (-51.75,48.973) (-53.24,50.272),Pull (-54.91,50.457) (-56.57,50.643),Pull (-57.50,50.457) (-58.43,50.272),Pull (-60.10,49.159) (-61.77,48.046),Pull (-62.51,47.675) (-63.25,47.304),Pull (-64,46.933) (-64.74,46.562),Pull (-65.11,46.747) (-65.48,46.933),Pull (-65.85,47.675) (-66.22,48.417),Pull (-66.22,48.788) (-66.22,49.159),Pull (-66.59,48.788) (-66.96,48.417),Pull (-66.78,47.304) (-66.59,46.191),Pull (-65.66,46.005) (-64.74,45.820),Pull (-64.18,45.634) (-63.62,45.449),Pull (-64.37,44.707) (-65.11,43.965),Pull (-65.66,43.594) (-66.22,43.223),Pull (-67.33,40.811) (-68.45,38.4),Pull (-69.19,36.544) (-69.93,34.689),Pull (-71.42,33.762) (-72.90,32.834),Pull (-70.86,33.205) (-68.82,33.576),Pull (-66.78,34.875) (-64.74,36.173),Pull (-61.58,35.988) (-58.43,35.802),Pull (-56.76,37.657) (-55.09,39.513),Pull (-53.79,41.368) (-52.49,43.223),Pull (-51.75,43.037) (-51.01,42.852),Pull (-50.82,43.037) (-50.27,47.675)]
  |> filled (gradient [ stop (rgb 252 199 244)  0 , stop blue 40, stop blue 200])
  ,
  
  --smile
  curve (-64.37,25.043) [Pull (-64.55,24.672) (-64.74,24.301),Pull (-65.11,23.930) (-65.48,23.559),Pull (-65.85,23.373) (-66.22,23.188)]
   |> outlined (solid 1) black
   ,
   circle 1 
   |> filled white
   |> move (-54,33.8)
   ,
    circle 0.8
   |> filled white
   |> move (-56,32)
   ,
   oval 2 1
   |> filled pink
   |> move (-55,29) ]
   
-- GIRL HAIR 1
hair1 hCol = group [

  hair_1 hCol
     ,accessories_hair1


  ]

accessories_hair1 = group [

  
 curve (-29.12,38.028) [Pull (-26.54,47.452) (-18.36,47.675),Pull (-14.46,47.633) (-10.57,46.191),Pull (-13.48,47.149) (-15.39,44.707),Pull (-19.63,47.192) (-22.07,45.078),Pull (-26.24,42.653) (-28.01,38.028),Pull (-28.19,37.843) (-28.38,37.657),Pull (-28.75,37.843) (-29.12,38.028)]
 |> filled (rgb 181 228 234)
  |> addOutline (solid 0.2) blue-- the headband
 ,
 curve (-13.91,56.579) [Pull (-16.72,51.756) (-18.73,46.933),Pull (-18.55,46.562) (-18.36,46.191),Pull (-16.88,45.449) (-15.39,44.707),Pull (-14.65,45.449) (-13.91,46.191),Pull (-13.21,51.385) (-13.91,56.579)]
 |> filled (rgb 135 189 189) -- the unicorn horn
  ,
 curve (-17.99,48.046) [Pull (-15.95,46.304) (-13.91,46.562),Pull (-13.72,47.860) (-13.54,49.159),Pull (-15.39,48.401) (-17.25,50.643),Pull (-17.62,49.344) (-17.99,48.046)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-18.73,46.933) [Pull (-18.36,47.489) (-17.99,48.046),Pull (-15.76,46.504) (-13.54,46.562),Pull (-13.54,46.376) (-13.54,46.191),Pull (-14.46,45.449) (-15.39,44.707),Pull (-16.88,45.449) (-18.36,46.191),Pull (-18.55,46.562) (-18.73,46.933)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-15.39,53.982) [Pull (-14.46,53.197) (-13.54,53.611)]
 |> outlined (solid 0.2)(rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.51,52.127) [Pull (-15.02,50.871) (-13.54,51.014)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.88,50.643) [Pull (-15.71,48.401) (-13.54,49.159)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-18.36,48.417) [Pull (-16.13,46.689) (-13.91,46.562)]
 |> outlined (solid 0.2) purple -- the unicorn horn line
 ,
 curve (-28.38,49.530) [Pull (-27.82,49.901) (-27.26,50.272),Pull (-27.08,50.828) (-26.89,51.385),Pull (-25.97,51.014) (-25.04,50.643),Pull (-25.04,50.272) (-25.04,49.901),Pull (-26.15,49.159) (-27.26,48.417),Pull (-27.82,49.159) (-28.38,49.530)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-25.04,50.643) [Pull (-24.67,51.014) (-24.30,51.385),Pull (-23.93,51.756) (-23.55,52.127),Pull (-23.37,51.571) (-23.18,51.014),Pull (-22.81,51.014) (-22.44,51.014),Pull (-22.44,50.828) (-22.44,50.643),Pull (-23.74,50.272) (-25.04,49.901),Pull (-25.04,50.457) (-25.04,50.643)]
 |>filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-28.01,49.159) [Pull (-28.75,49.159) (-29.49,49.159),Pull (-29.49,48.417) (-29.49,47.675),Pull (-29.31,47.489) (-29.12,47.304),Pull (-28.19,48.046) (-27.26,48.788),Pull (-27.26,48.788) (-28.01,49.159)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-29.49,47.675) [Pull (-30.42,47.675) (-31.35,47.675),Pull (-31.35,47.118) (-31.35,46.562),Pull (-31.53,46.562) (-31.72,46.562),Pull (-31.16,46.005) (-30.60,45.449),Pull (-29.68,46.376) (-28.75,47.304),Pull (-29.12,47.489) (-29.49,47.675)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-37.65,40.997) [Pull (-37.28,41.553) (-36.91,42.110),Pull (-36.54,41.553) (-36.17,40.997),Pull (-35.80,40.997) (-35.43,40.997),Pull (-35.98,40.626) (-36.54,40.255),Pull (-36.35,39.884) (-36.17,39.513),Pull (-36.54,39.698) (-36.91,39.884),Pull (-37.47,39.513) (-38.02,39.142),Pull (-37.84,39.884) (-37.65,40.626),Pull (-38.02,40.997) (-38.4,41.368),Pull (-38.02,41.182) (-37.65,40.997)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-28.01,25.043) [Pull (-27.64,25.6) (-27.26,26.156),Pull (-27.08,25.6) (-26.89,25.043),Pull (-26.34,25.043) (-25.78,25.043),Pull (-26.34,24.672) (-26.89,24.301),Pull (-26.71,23.744) (-26.52,23.188),Pull (-27.08,23.559) (-27.64,23.930),Pull (-28.01,23.744) (-28.38,23.559),Pull (-28.19,24.115) (-28.01,24.672),Pull (-28.56,25.043) (-29.12,25.414),Pull (-28.56,25.228) (-28.01,25.043)]
 |>filled (rgb 183 213 224) -- the star earring
 ]
hair_1 hCol = group [
  
 curve (-29.73,46.222) [Pull (-34.15,40.434) (-33.93,32.646),Pull (-36.75,43.802) (-29.73,46.222)]
  |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156) -- hair behind top part
 ,
 curve (-15.02,41.739) [Pull (-13.35,44.324) (-11.68,42.110),Pull (-12.41,37.657) (-8.347,33.205),Pull (-6.492,31.976) (-4.637,33.947),Pull (-9.263,37.843) (-9.089,41.739),Pull (-11.25,46.881) (-15.02,43.223),Pull (-17.43,46.481) (-19.84,41.739),Pull (-23.25,33.571) (-29.86,35.802),Pull (-33.37,38.956) (-32.09,42.110),Pull (-35.50,37.657) (-31.72,33.205),Pull (-28.75,30.863) (-25.78,31.721),Pull (-18.13,33.744) (-16.88,41.368),Pull (-16.75,44.353) (-15.02,41.739)]
  |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the bangs
 
 ,
 curve (-15.39,44.707) [Pull (-11.68,47.936) (-7.976,43.965),Pull (-6.092,41.924) (-5.008,39.884),Pull (-4.208,37.657) (-5.008,35.431),Pull (-3.623,34.689) (-4.637,33.947),Pull (-9.263,37.843) (-9.089,41.739),Pull (-11.65,47.281) (-15.02,43.223),Pull (-17.43,46.081) (-19.84,41.739),Pull (-22.45,33.971) (-29.86,35.802),Pull (-30.97,37.286) (-32.09,38.771),Pull (-28.19,34.626) (-24.30,42.481),Pull (-21.84,47.594) (-15.39,44.707)]
  |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the hair behind the bangs
 ,
 curve (-31.35,38.028) [Pull (-33.32,40.069) (-32.09,42.110),Pull (-31.86,45.078) (-27.64,48.046),Pull (-23.37,51.344) (-19.10,50.643),Pull (-11.72,50.475) (-8.347,44.707),Pull (-11.87,47.907) (-15.39,44.707),Pull (-22.83,48.023) (-24.67,41.739),Pull (-28.01,36.284) (-31.35,38.028)]
  |> filled hCol
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the top head
 
 ,curve (-24.88,50.424) [Pull (-26.32,50.555) (-27.15,52.686),Pull (-28.12,52.400) (-29.09,51.393),Pull (-32.77,52.269) (-34.26,50.424),Pull (-39.67,42.505) (-41.69,34.585),Pull (-43.31,26.882) (-40.72,25.858),Pull (-37.58,24.080) (-36.84,22.303),Pull (-36.47,19.568) (-37.81,19.393),Pull (-39.30,19.100) (-39.43,20.686),Pull (-40.89,19.875) (-39.11,18.424),Pull (-37.49,17.041) (-35.87,17.777),Pull (-34.17,16.034) (-31.35,17.131),Pull (-30.72,15.928) (-29.73,16.484),Pull (-25.69,18.109) (-26.18,21.333),Pull (-26.26,23.757) (-27.47,26.181),Pull (-29.93,26.396) (-30.70,29.090),Pull (-32.88,30.853) (-33.29,33.616),Pull (-36.64,39.595) (-31.67,45.575),Pull (-27.34,47.799) (-24.88,50.424)]
  |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the top pony
 ,
 curve (-6.863,32.463) [Pull (-8.492,30.608) (-6.121,28.753),Pull (-4.863,26.527) (-7.605,24.301),Pull (-9.020,23.188) (-7.234,22.075),Pull (-9.791,23.559) (-8.347,25.043),Pull (-6.162,26.713) (-7.976,28.382),Pull (-8.162,29.681) (-8.347,30.979),Pull (-7.791,31.907) (-7.234,32.834),Pull (-7.049,32.649) (-6.863,32.463)]
  |> filled hCol
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the right side hair
 ,
 
 curve (-25.41,32.092) [Pull (-26.48,29.310) (-23.55,26.527),Pull (-23.44,21.872) (-26.52,22.817),Pull (-23.35,24.857) (-25.78,26.898),Pull (-25.78,29.310) (-25.41,32.092)]
  |> filled hCol
  |> addOutline (solid 0.5) (rgb 190 123 156)-- the left side hair
 ,
 curve (-33.57,36.915) [Pull (-34.66,27.965) (-26.15,25.414),Pull (-25.97,28.568) (-25.78,31.721),Pull (-31.68,30.318) (-33.57,36.915)]
  |> filled hCol
 |> addOutline (solid 0.5)(rgb 249 182 217) -- the left side hair
 ,curve (-29.73,49.454) [Pull (-31.51,49.914) (-33.29,49.454)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes
  ,

  curve (-32.32,48.161) [Pull (-34.42,47.006) (-36.52,41.050),Pull (-38.49,38.881) (-38.78,35.232),Pull (-39.25,27.608) (-36.52,26.505),Pull (-33.10,23.434) (-33.29,20.363),Pull (-34.79,17.050) (-37.17,17.777)]
  |> outlined (solid 0.4) (rgb 211 141 177) -- hair strokes
  ,

  curve (-33.61,33.939) [Pull (-34.79,31.353) (-34.26,28.767),Pull (-32.13,25.373) (-33.61,21.979)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes lighter
  ,
  

  curve (-33.61,33.616) [Pull (-34.03,28.232) (-30.06,24.888),Pull (-28.39,22.303) (-29.41,19.717),Pull (-29.72,17.844) (-31.67,17.131),Pull (-34.35,16.654) (-36.20,17.777)]
  |> outlined (solid 0.4) (rgb 211 141 177) -- hair strokes 
  ,
   curve (-29.49,46.562) [Pull (-30.16,42.950) (-27.64,41.739)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes on the top head
   ,
   curve (-24.67,45.449) [Pull (-26.34,46.162) (-28.01,47.675)]
 |> outlined (solid 0.3) (rgb 190 123 156) -- hair strokes on the top head
 ,
   curve (-18.36,48.046) [Pull (-20.77,49.773) (-23.18,49.901)]
  |> outlined (solid 0.3) (rgb 190 123 156) -- hair strokes on the top head
  ,
  curve (-30.97,31.350) [Pull (-33.07,33.020) (-33.57,34.689)]
  |> outlined (solid 0.3) (rgb 211 141 177) -- hair strokes on the top head
  

 ] 

-- GIRL HAIR 2

hair2 hCol skin = group [
  hair2_girl hCol skin
    ,accessories_hair2

  ]

hair2_girl hCol skin = group [
  
 
 curve (-15.02,41.739) [Pull (-13.35,44.324) (-11.68,42.110),Pull (-12.41,37.657) (-8.347,33.205),Pull (-6.492,31.976) (-4.637,33.947),Pull (-9.263,37.843) (-9.089,41.739),Pull (-11.25,46.881) (-15.02,43.223),Pull (-17.43,46.481) (-19.84,41.739),Pull (-23.25,33.571) (-29.86,35.802),Pull (-33.37,38.956) (-32.09,42.110),Pull (-35.50,37.657) (-31.72,33.205),Pull (-28.75,30.863) (-25.78,31.721),Pull (-18.13,33.744) (-16.88,41.368),Pull (-16.75,44.353) (-15.02,41.739)]
 |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the bangs
 ,
 curve (-15.39,44.707) [Pull (-11.68,47.936) (-7.976,43.965),Pull (-6.092,41.924) (-5.008,39.884),Pull (-4.208,37.657) (-5.008,35.431),Pull (-3.623,34.689) (-4.637,33.947),Pull (-9.263,37.843) (-9.089,41.739),Pull (-11.65,47.281) (-15.02,43.223),Pull (-17.43,46.081) (-19.84,41.739),Pull (-22.45,33.971) (-29.86,35.802),Pull (-30.97,37.286) (-32.09,38.771),Pull (-28.19,34.626) (-24.30,42.481),Pull (-21.84,47.594) (-15.39,44.707)]
 |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the hair behind the bangs
 ,
 curve (-31.35,38.028) [Pull (-33.32,40.069) (-32.09,42.110),Pull (-31.86,45.078) (-27.64,48.046),Pull (-23.37,51.344) (-19.10,50.643),Pull (-11.72,50.475) (-8.347,44.707),Pull (-11.87,47.907) (-15.39,44.707),Pull (-22.83,48.023) (-24.67,41.739),Pull (-28.01,36.284) (-31.35,38.028)]
 |> filled hCol
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the top head
 ,
 curve (-21.70,51.385) [Pull (-23.68,56.811) (-27.26,55.837),Pull (-31.16,57.895) (-35.06,54.353),Pull (-43.99,48.875) (-41.73,40.997),Pull (-41.59,34.875) (-45.44,28.753),Pull (-49.15,24.568) (-52.86,28.382),Pull (-53.91,29.681) (-51.75,30.979),Pull (-56.52,30.168) (-52.49,26.156),Pull (-49.71,24.185) (-46.93,25.414),Pull (-46.19,25.971) (-45.44,26.527),Pull (-52.61,20.962) (-56.57,15.397),Pull (-60.45,10.017) (-54.72,4.6376),Pull (-53.05,3.1536) (-51.38,1.6695),Pull (-50.81,-6.927) (-55.83,-3.524),Pull (-56.39,-2.411) (-56.95,-1.298),Pull (-58.32,-6.266) (-52.49,-7.234),Pull (-50.64,-7.350) (-48.78,-4.266),Pull (-48.73,-7.605) (-50.27,-10.94),Pull (-53.69,-12.57) (-54.72,-10.20),Pull (-54.53,-9.275) (-54.35,-8.347),Pull (-58.68,-13.47) (-51.01,-15.39),Pull (-48.97,-15.21) (-46.93,-15.02),Pull (-40.99,-7.275) (-35.06,-3.524),Pull (-35.36,-0.371) (-32.46,2.7826),Pull (-32.46,3.7101) (-32.46,4.6376),Pull (-34.70,5.5652) (-31.35,6.4927),Pull (-35.07,9.2753) (-33.20,12.057),Pull (-29.68,18.597) (-26.15,18.736),Pull (-24.98,21.518) (-25.41,24.301),Pull (-35.49,28.794) (-33.57,37.286),Pull (-34.83,39.698) (-32.09,42.110),Pull (-28.71,50.376) (-21.33,50.643),Pull (-21.51,51.2) (-21.70,51.385)]
 |> filled hCol
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the top pony
  
  
 ,
 curve (-6.863,32.463) [Pull (-8.492,30.608) (-6.121,28.753),Pull (-4.863,26.527) (-7.605,24.301),Pull (-9.020,23.188) (-7.234,22.075),Pull (-9.791,23.559) (-8.347,25.043),Pull (-6.162,26.713) (-7.976,28.382),Pull (-8.162,29.681) (-8.347,30.979),Pull (-7.791,31.907) (-7.234,32.834),Pull (-7.049,32.649) (-6.863,32.463)]
 |> filled hCol
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the right side hair
 ,
 
 curve (-25.41,32.092) [Pull (-26.48,29.310) (-23.55,26.527),Pull (-23.44,21.872) (-26.52,22.817),Pull (-23.35,24.857) (-25.78,26.898),Pull (-25.78,29.310) (-25.41,32.092)]
 |> filled hCol
  |> addOutline (solid 0.5) (rgb 190 123 156)-- the left side hair
 ,
 curve (-33.57,36.915) [Pull (-34.66,27.965) (-26.15,25.414),Pull (-25.97,28.568) (-25.78,31.721),Pull (-31.68,30.318) (-33.57,36.915)]
 |> filled hCol
 |> addOutline (solid 0.5)(rgb 249 182 217) -- the left side hair
 ,
  curve (-31.72,46.562) [Pull (-38.71,43.571) (-36.91,30.979),Pull (-36.62,20.104) (-44.33,12.428)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes
  ,
  curve (-32.09,29.495) [Pull (-30.97,22.446) (-40.25,15.397),Pull (-48.35,7.2347) (-42.85,-0.927),Pull (-39.06,-5.379) (-42.48,-9.831)]
  |> outlined (solid 0.4) (rgb 211 141 177) -- hair strokes
  ,
  curve (-32.09,25.785) [Pull (-31.46,18.179) (-38.02,10.573),Pull (-42.27,2.5971) (-36.91,-5.379)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes lighter
  ,
  curve (-28.01,23.559) [Pull (-29.35,17.808) (-34.68,12.057),Pull (-38.53,6.3072) (-33.57,0.5565)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes lighter
  ,
   curve (-37.65,25.414) [Pull (-39.95,19.849) (-45.44,14.284),Pull (-52.90,7.7913) (-49.15,1.2985),Pull (-42.60,-5.750) (-48.04,-12.8),Pull (-51.38,-16.18) (-54.72,-13.17)]
  |> outlined (solid 0.4) (rgb 211 141 177) -- hair strokes 
  ,
   curve (-42.11,39.142) [Pull (-38.57,30.608) (-45.44,22.075),Pull (-53.95,14.626) (-52.86,7.9768)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes 
  ,
   curve (-39.14,7.9768) [Pull (-39.59,4.4521) (-37.65,0.9275),Pull (-35.50,-1.855) (-36.54,-4.637)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes 
  ,
   curve (-28.38,49.530) [Pull (-39.54,52.736) (-39.51,39.142),Pull (-39.01,36.904) (-36.91,29.866)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes 
  ,
   curve (-26.52,51.385) [Pull (-30.79,56.469) (-35.06,54.353)]
  |> outlined (solid 0.4) (rgb 211 141 177) -- hair strokes
  ,
   curve (-24.67,51.756) [Pull (-24.71,55.982) (-28.75,56.208)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes
  ,
   curve (-29.49,46.562) [Pull (-30.16,42.950) (-27.64,41.739)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes on the top head
   ,
   curve (-24.67,45.449) [Pull (-26.34,46.162) (-28.01,47.675)]
 |> outlined (solid 0.3) (rgb 190 123 156) -- hair strokes on the top head
 ,
   curve (-18.36,48.046) [Pull (-20.77,49.773) (-23.18,49.901)]
  |> outlined (solid 0.3) (rgb 190 123 156) -- hair strokes on the top head
  ,
  curve (-30.97,31.350) [Pull (-33.07,33.020) (-33.57,34.689)]
  |> outlined (solid 0.3) (rgb 211 141 177) -- hair strokes on the top head
  ,
 curve (-27.64,30.979) [Pull (-29.71,33.194) (-30.97,30.608),Pull (-31.46,28.568) (-28.75,26.527),Pull (-28.19,26.342) (-27.64,26.156),Pull (-26.89,26.898) (-26.15,27.640),Pull (-26.89,29.310) (-27.64,30.979)]
 |> filled skin  -- the ear

  -- pony2 
  ,curve (-21.70,51.385) [Pull (-23.68,56.811) (-27.26,55.837),Pull (-31.16,57.895) (-35.06,54.353),Pull (-43.99,48.875) (-41.73,40.997),Pull (-41.59,34.875) (-45.44,28.753),Pull (-49.15,24.568) (-52.86,28.382),Pull (-53.91,29.681) (-51.75,30.979),Pull (-56.52,30.168) (-52.49,26.156),Pull (-49.71,24.185) (-46.93,25.414),Pull (-46.19,25.971) (-45.44,26.527),Pull (-52.61,20.962) (-56.57,15.397),Pull (-60.45,10.017) (-54.72,4.6376),Pull (-53.05,3.1536) (-51.38,1.6695),Pull (-50.81,-6.927) (-55.83,-3.524),Pull (-56.39,-2.411) (-56.95,-1.298),Pull (-58.32,-6.266) (-52.49,-7.234),Pull (-50.64,-7.350) (-48.78,-4.266),Pull (-48.73,-7.605) (-50.27,-10.94),Pull (-53.69,-12.57) (-54.72,-10.20),Pull (-54.53,-9.275) (-54.35,-8.347),Pull (-58.68,-13.47) (-51.01,-15.39),Pull (-48.97,-15.21) (-46.93,-15.02),Pull (-40.99,-7.275) (-35.06,-3.524),Pull (-35.36,-0.371) (-32.46,2.7826),Pull (-32.46,3.7101) (-32.46,4.6376),Pull (-34.70,5.5652) (-31.35,6.4927),Pull (-35.07,9.2753) (-33.20,12.057),Pull (-29.68,18.597) (-26.15,18.736),Pull (-24.98,21.518) (-25.41,24.301),Pull (-35.49,28.794) (-33.57,37.286),Pull (-34.83,39.698) (-32.09,42.110),Pull (-28.71,50.376) (-21.33,50.643),Pull (-21.51,51.2) (-21.70,51.385)]
 |> filled hCol
  |> addOutline (solid 0.3) (rgb 190 123 156)
  |> scaleX -1 |> move (-40,-2)
  -- the top pony
   ,
  curve (-31.72,46.562) [Pull (-38.71,43.571) (-36.91,30.979),Pull (-36.62,20.104) (-44.33,12.428)]
  |> outlined (solid 0.4)(rgb 211 141 177)
    |> scaleX -1 |> move (-40,-2)

  -- hair strokes
  ,
  curve (-32.09,29.495) [Pull (-30.97,22.446) (-40.25,15.397),Pull (-48.35,7.2347) (-42.85,-0.927),Pull (-39.06,-5.379) (-42.48,-9.831)]
  |> outlined (solid 0.4) (rgb 211 141 177) 
    |> scaleX -1 |> move (-39,-2)
-- hair strokes
  ,
  curve (-32.09,25.785) [Pull (-31.46,18.179) (-38.02,10.573),Pull (-42.27,2.5971) (-36.91,-5.379)]
  |> outlined (solid 0.4)(rgb 211 141 177) 
    |> scaleX -1 |> move (-39,-2)
-- hair strokes lighter
  ,
  curve (-28.01,23.559) [Pull (-29.35,17.808) (-34.68,12.057),Pull (-38.53,6.3072) (-33.57,0.5565)]
  |> outlined (solid 0.4)(rgb 211 141 177) 
    |> scaleX -1 |> move (-39,-2)
-- hair strokes lighter
  ,
   curve (-37.65,25.414) [Pull (-39.95,19.849) (-45.44,14.284),Pull (-52.90,7.7913) (-49.15,1.2985),Pull (-42.60,-5.750) (-48.04,-12.8),Pull (-51.38,-16.18) (-54.72,-13.17)]
  |> outlined (solid 0.4) (rgb 211 141 177)
    |> scaleX -1 |> move (-39,-2)
-- hair strokes 
  ,
   curve (-42.11,39.142) [Pull (-38.57,30.608) (-45.44,22.075),Pull (-53.95,14.626) (-52.86,7.9768)]
  |> outlined (solid 0.4)(rgb 211 141 177) 
    |> scaleX -1 |> move (-39,-2)
-- hair strokes 
  ,
   curve (-39.14,7.9768) [Pull (-39.59,4.4521) (-37.65,0.9275),Pull (-35.50,-1.855) (-36.54,-4.637)]
  |> outlined (solid 0.4)(rgb 211 141 177) 
    |> scaleX -1 |> move (-39,-2)
-- hair strokes 
  ,
   curve (-28.38,49.530) [Pull (-39.54,52.736) (-39.51,39.142),Pull (-39.01,36.904) (-36.91,29.866)]
  |> outlined (solid 0.4)(rgb 211 141 177)
    |> scaleX -1 |> move (-39,-2)
-- hair strokes 
  ,
   curve (-26.52,51.385) [Pull (-30.79,56.469) (-35.06,54.353)]
  |> outlined (solid 0.4) (rgb 211 141 177)
    |> scaleX -1 |> move (-39,-2)
-- hair strokes
  ,
   curve (-24.67,51.756) [Pull (-24.71,55.982) (-28.75,56.208)]
  |> outlined (solid 0.4)(rgb 211 141 177)
    |> scaleX -1 |> move (-39,-2)
-- hair strokes
  ,
   curve (-29.49,46.562) [Pull (-30.16,42.950) (-27.64,41.739)]
  |> outlined (solid 0.4)(rgb 211 141 177)
    |> scaleX -1 |> move (-39,-2)
-- hair strokes on the top head
   ,
   curve (-24.67,45.449) [Pull (-26.34,46.162) (-28.01,47.675)]
 |> outlined (solid 0.3) (rgb 190 123 156)
   |> scaleX -1 |> move (-39,-2)
-- hair strokes on the top head
 ,
   curve (-18.36,48.046) [Pull (-20.77,49.773) (-23.18,49.901)]
  |> outlined (solid 0.3) (rgb 190 123 156)
    |> scaleX -1 |> move (-39,-2)
  -- hair strokes on the top head
  ,
  curve (-30.97,31.350) [Pull (-33.07,33.020) (-33.57,34.689)]
  |> outlined (solid 0.3) (rgb 211 141 177)
    |> scaleX -1 |> move (-39,-2)
  -- hair strokes on the top head
  
  

 ] 
accessories_hair2 = group [

 curve (-29.12,38.028) [Pull (-26.54,47.452) (-18.36,47.675),Pull (-14.46,47.633) (-10.57,46.191),Pull (-13.48,47.149) (-15.39,44.707),Pull (-19.63,47.192) (-22.07,45.078),Pull (-26.24,42.653) (-28.01,38.028),Pull (-28.19,37.843) (-28.38,37.657),Pull (-28.75,37.843) (-29.12,38.028)]
 |> filled (rgb 181 228 234)
  |> addOutline (solid 0.2) blue-- the headband
 ,
 curve (-13.91,56.579) [Pull (-16.72,51.756) (-18.73,46.933),Pull (-18.55,46.562) (-18.36,46.191),Pull (-16.88,45.449) (-15.39,44.707),Pull (-14.65,45.449) (-13.91,46.191),Pull (-13.21,51.385) (-13.91,56.579)]
 |> filled (rgb 135 189 189) -- the unicorn horn
  ,
 curve (-17.99,48.046) [Pull (-15.95,46.304) (-13.91,46.562),Pull (-13.72,47.860) (-13.54,49.159),Pull (-15.39,48.401) (-17.25,50.643),Pull (-17.62,49.344) (-17.99,48.046)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-18.73,46.933) [Pull (-18.36,47.489) (-17.99,48.046),Pull (-15.76,46.504) (-13.54,46.562),Pull (-13.54,46.376) (-13.54,46.191),Pull (-14.46,45.449) (-15.39,44.707),Pull (-16.88,45.449) (-18.36,46.191),Pull (-18.55,46.562) (-18.73,46.933)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-15.39,53.982) [Pull (-14.46,53.197) (-13.54,53.611)]
 |> outlined (solid 0.2)(rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.51,52.127) [Pull (-15.02,50.871) (-13.54,51.014)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.88,50.643) [Pull (-15.71,48.401) (-13.54,49.159)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-18.36,48.417) [Pull (-16.13,46.689) (-13.91,46.562)]
 |> outlined (solid 0.2) purple -- the unicorn horn line
 ,
 curve (-28.38,49.530) [Pull (-27.82,49.901) (-27.26,50.272),Pull (-27.08,50.828) (-26.89,51.385),Pull (-25.97,51.014) (-25.04,50.643),Pull (-25.04,50.272) (-25.04,49.901),Pull (-26.15,49.159) (-27.26,48.417),Pull (-27.82,49.159) (-28.38,49.530)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-25.04,50.643) [Pull (-24.67,51.014) (-24.30,51.385),Pull (-23.93,51.756) (-23.55,52.127),Pull (-23.37,51.571) (-23.18,51.014),Pull (-22.81,51.014) (-22.44,51.014),Pull (-22.44,50.828) (-22.44,50.643),Pull (-23.74,50.272) (-25.04,49.901),Pull (-25.04,50.457) (-25.04,50.643)]
 |>filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-28.01,49.159) [Pull (-28.75,49.159) (-29.49,49.159),Pull (-29.49,48.417) (-29.49,47.675),Pull (-29.31,47.489) (-29.12,47.304),Pull (-28.19,48.046) (-27.26,48.788),Pull (-27.26,48.788) (-28.01,49.159)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-29.49,47.675) [Pull (-30.42,47.675) (-31.35,47.675),Pull (-31.35,47.118) (-31.35,46.562),Pull (-31.53,46.562) (-31.72,46.562),Pull (-31.16,46.005) (-30.60,45.449),Pull (-29.68,46.376) (-28.75,47.304),Pull (-29.12,47.489) (-29.49,47.675)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-37.65,40.997) [Pull (-37.28,41.553) (-36.91,42.110),Pull (-36.54,41.553) (-36.17,40.997),Pull (-35.80,40.997) (-35.43,40.997),Pull (-35.98,40.626) (-36.54,40.255),Pull (-36.35,39.884) (-36.17,39.513),Pull (-36.54,39.698) (-36.91,39.884),Pull (-37.47,39.513) (-38.02,39.142),Pull (-37.84,39.884) (-37.65,40.626),Pull (-38.02,40.997) (-38.4,41.368),Pull (-38.02,41.182) (-37.65,40.997)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-28.01,25.043) [Pull (-27.64,25.6) (-27.26,26.156),Pull (-27.08,25.6) (-26.89,25.043),Pull (-26.34,25.043) (-25.78,25.043),Pull (-26.34,24.672) (-26.89,24.301),Pull (-26.71,23.744) (-26.52,23.188),Pull (-27.08,23.559) (-27.64,23.930),Pull (-28.01,23.744) (-28.38,23.559),Pull (-28.19,24.115) (-28.01,24.672),Pull (-28.56,25.043) (-29.12,25.414),Pull (-28.56,25.228) (-28.01,25.043)]
 |>filled (rgb 183 213 224) -- the star earring
 -----------------------------------------------------------------------
  -- accessories on pony2: 
  ,
 curve (-28.38,49.530) [Pull (-27.82,49.901) (-27.26,50.272),Pull (-27.08,50.828) (-26.89,51.385),Pull (-25.97,51.014) (-25.04,50.643),Pull (-25.04,50.272) (-25.04,49.901),Pull (-26.15,49.159) (-27.26,48.417),Pull (-27.82,49.159) (-28.38,49.530)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue
   |> scaleX -1 |> move (-39,-2)

 -- the star on the pony
 ,
 curve (-25.04,50.643) [Pull (-24.67,51.014) (-24.30,51.385),Pull (-23.93,51.756) (-23.55,52.127),Pull (-23.37,51.571) (-23.18,51.014),Pull (-22.81,51.014) (-22.44,51.014),Pull (-22.44,50.828) (-22.44,50.643),Pull (-23.74,50.272) (-25.04,49.901),Pull (-25.04,50.457) (-25.04,50.643)]
 |>filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue
   |> scaleX -1 |> move (-39,-2)

 -- the star on the pony
 ,
 curve (-28.01,49.159) [Pull (-28.75,49.159) (-29.49,49.159),Pull (-29.49,48.417) (-29.49,47.675),Pull (-29.31,47.489) (-29.12,47.304),Pull (-28.19,48.046) (-27.26,48.788),Pull (-27.26,48.788) (-28.01,49.159)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue
   |> scaleX -1 |> move (-39,-2)

 -- the star on the pony
 ,
 curve (-29.49,47.675) [Pull (-30.42,47.675) (-31.35,47.675),Pull (-31.35,47.118) (-31.35,46.562),Pull (-31.53,46.562) (-31.72,46.562),Pull (-31.16,46.005) (-30.60,45.449),Pull (-29.68,46.376) (-28.75,47.304),Pull (-29.12,47.489) (-29.49,47.675)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue
   |> scaleX -1 |> move (-39,-2)

 -- the star on the pony
 ,
 curve (-37.65,40.997) [Pull (-37.28,41.553) (-36.91,42.110),Pull (-36.54,41.553) (-36.17,40.997),Pull (-35.80,40.997) (-35.43,40.997),Pull (-35.98,40.626) (-36.54,40.255),Pull (-36.35,39.884) (-36.17,39.513),Pull (-36.54,39.698) (-36.91,39.884),Pull (-37.47,39.513) (-38.02,39.142),Pull (-37.84,39.884) (-37.65,40.626),Pull (-38.02,40.997) (-38.4,41.368),Pull (-38.02,41.182) (-37.65,40.997)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
  |> scaleX -1 |> move (-39,-2)

 ]
 



-- GIRL HAIR 3

hair3 hCol = group [curve (-26.67,52.608) [Pull (-24.20,54.848) (-18.28,53.807),Pull (-10.97,50.771) (-8.393,44.215),Pull (-5.991,34.241) (-13.18,29.826),Pull (-16.93,28.627) (-20.68,27.428),Pull (-22.78,31.325) (-24.88,35.222),Pull (-29.07,41.667) (-33.27,48.112),Pull (-29.97,50.510) (-26.67,52.608)]
  |> filled hCol
  |> addOutline (solid 0.7) (rgb 190 123 156)-- hair, right bun
  ,
  curve (-29.67,26.829) [Pull (-30.54,28.658) (-32.97,28.927),Pull (-33.83,20.213) (-37.77,14.538),Pull (-41.63,9.5706) (-50.06,9.4426),Pull (-52.33,7.5136) (-55.45,6.7447),Pull (-55.33,0.0197) (-50.06,-6.145),Pull (-47.15,-14.31) (-56.05,-17.83),Pull (-54.11,-15.73) (-53.65,-13.63),Pull (-66.38,-7.326) (-73.14,4.9461),Pull (-78.49,17.107) (-75.24,28.028),Pull (-82.51,28.196) (-84.83,33.124),Pull (-87.52,39.219) (-86.33,43.915),Pull (-84.25,49.912) (-77.93,51.709),Pull (-75.59,54.858) (-69.84,54.407),Pull (-65.46,52.869) (-63.85,49.011),Pull (-61.00,47.512) (-58.15,46.014),Pull (-48.29,50.382) (-36.27,48.711),Pull (-22.75,44.887) (-16.48,34.023),Pull (-10.54,26.819) (-7.194,18.135),Pull (-6.564,13.939) (-6.894,9.7423),Pull (-9.222,6.3343) (-13.18,4.6463),Pull (-11.83,0.7691) (-8.393,-2.548),Pull (-7.793,-4.346) (-7.793,-6.145),Pull (-12.03,-8.072) (-13.18,-13.03),Pull (-12.75,-14.52) (-10.79,-15.13),Pull (-15.40,-15.96) (-15.58,-10.64),Pull (-14.64,-7.133) (-11.99,-5.545),Pull (-12.27,-3.597) (-14.68,-1.648),Pull (-14.08,4.0468) (-13.48,9.7423),Pull (-18.94,12.088) (-21.28,18.435),Pull (-20.98,23.381) (-23.08,28.327),Pull (-26.50,30.658) (-29.67,26.829)]
  |> filled hCol
  |> addOutline (solid 0.7) (rgb 190 123 156)-- main hair
  ,
  curve (-85.13,35.822) [Pull (-85.05,41.249) (-81.53,43.316),Pull (-78.45,44.396) (-76.74,42.716),Pull (-74.27,41.097) (-72.84,40.918),Pull (-74.64,41.817) (-76.44,42.716),Pull (-78.46,49.002) (-77.03,52.009),Pull (-78.14,47.362) (-76.44,42.716),Pull (-77.29,51.213) (-70.74,51.709),Pull (-67.45,50.691) (-66.84,47.512),Pull (-64.29,46.763) (-61.75,46.014),Pull (-64.29,42.566) (-66.84,39.119),Pull (-70.69,42.685) (-70.74,49.011)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-34.77,48.412) [Pull (-20.40,44.589) (-13.18,28.927)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-65.94,42.416) [Pull (-66.49,46.163) (-66.24,49.911),Pull (-63.72,53.381) (-58.15,48.412),Pull (-62.26,45.385) (-64.44,40.318),Pull (-65.90,38.520) (-66.84,36.121),Pull (-66.89,32.313) (-69.54,31.025),Pull (-73.10,30.734) (-74.94,33.124),Pull (-73.63,35.233) (-69.24,35.822),Pull (-63.90,36.979) (-66.24,42.416),Pull (-70.02,43.057) (-72.24,41.217),Pull (-73.50,40.269) (-72.24,36.721),Pull (-70.53,35.481) (-66.54,37.320)]
  |> filled (rgb 186 237 241)
  |> addOutline (solid 0.5) (rgb 110 136 181) -- Blue bow left
  ,
  curve (-27.27,40.018) [Pull (-19.26,38.261) (-16.48,32.824),Pull (-20.88,35.882) (-27.27,37.021),Pull (-33.27,37.470) (-39.26,37.920),Pull (-33.12,38.819) (-27.27,40.018)]
  |> filled (rgb 181 228 234)
  |> addOutline (solid 0.2) blue -- the headband filler
  ,
  horn
  |> scale 2.5
  |> move (7.5,-78)
  ,
  curve (-22.78,38.519) [Pull (-21.43,37.470) (-20.08,36.421),Pull (-23.38,36.871) (-26.67,37.320),Pull (-26.22,37.920) (-25.77,38.519),Pull (-24.28,38.519) (-22.78,38.519)]
  |> filled (rgb 181 228 234) -- the headband filler
  ,
  curve (-56.65,8.8430) [Pull (-50.31,12.748) (-48.86,21.733),Pull (-45.65,32.677) (-35.97,34.622),Pull (-44.45,33.227) (-45.26,23.831),Pull (-45.07,17.985) (-47.96,12.140),Pull (-49.80,9.2821) (-53.35,7.9437)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-57.25,26.529) [Pull (-57.25,26.529) (-57.25,26.529),Pull (-54.91,15.405) (-62.05,9.4426)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-69.54,3.1475) [Pull (-71.50,4.2362) (-72.54,6.4449)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-70.14,8.5433) [Pull (-73.75,10.181) (-75.24,13.939)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-69.84,19.334) [Pull (-73.15,22.541) (-74.94,27.428)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-62.65,26.229) [Pull (-66.99,27.567) (-68.94,31.625)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-58.45,33.723) [Pull (-63.23,34.831) (-64.44,40.018)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-42.86,44.814) [Pull (-47.47,47.663) (-55.15,47.512)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-80.63,29.526) [Pull (-78.24,34.344) (-73.14,36.721),Pull (-76.11,35.262) (-78.23,33.124),Pull (-78.49,30.725) (-77.03,28.327)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-29.07,31.325) [Pull (-25.63,35.454) (-20.38,32.824),Pull (-16.17,29.127) (-16.48,23.831),Pull (-14.68,15.786) (-9.892,10.941)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-73.14,31.025) [Pull (-74.67,29.857) (-74.64,27.128)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-26.67,50.510) [Pull (-26.67,50.510) (-26.67,50.510),Pull (-20.62,53.301) (-18.28,47.213),Pull (-17.61,44.365) (-18.58,41.517),Pull (-16.81,45.414) (-19.48,49.311),Pull (-24.30,50.432) (-25.48,46.313)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke
  ,
  curve (-11.99,48.711) [Pull (-11.74,41.735) (-16.78,39.718),Pull (-11.81,40.517) (-9.892,44.515)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke 
  ,
  curve (-15.28,34.023) [Pull (-12.74,34.473) (-10.19,33.723)]
  |> outlined (solid 0.5) (rgb 190 123 156)-- Hair stroke 
  ,
  curve (-21.28,40.318) [Pull (-21.28,40.318) (-21.28,40.318),Pull (-19.73,42.918) (-17.98,40.318),Pull (-16.48,38.669) (-14.98,37.021),Pull (-14.87,35.531) (-16.48,35.522),Pull (-19.06,37.670) (-21.28,40.318)]
  |> filled (rgb 181 228 234)
  |> addOutline (solid 0.2) blue -- Right side bow
  
  ]
  
horn = group [ curve (-29.12,38.028) [Pull (-26.54,47.452) (-18.36,47.675),Pull (-14.46,47.633) (-10.57,46.191),Pull (-13.48,47.149) (-15.39,44.707),Pull (-19.63,47.192) (-22.07,45.078),Pull (-26.24,42.653) (-28.01,38.028),Pull (-28.19,37.843) (-28.38,37.657),Pull (-28.75,37.843) (-29.12,38.028)]
 |> filled (rgb 181 228 234)
  |> addOutline (solid 0.2) blue-- the headband
 ,
 curve (-13.91,56.579) [Pull (-16.72,51.756) (-18.73,46.933),Pull (-18.55,46.562) (-18.36,46.191),Pull (-16.88,45.449) (-15.39,44.707),Pull (-14.65,45.449) (-13.91,46.191),Pull (-13.21,51.385) (-13.91,56.579)]
 |> filled (rgb 135 189 189) -- the unicorn horn
  ,
 curve (-17.99,48.046) [Pull (-15.95,46.304) (-13.91,46.562),Pull (-13.72,47.860) (-13.54,49.159),Pull (-15.39,48.401) (-17.25,50.643),Pull (-17.62,49.344) (-17.99,48.046)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-18.73,46.933) [Pull (-18.36,47.489) (-17.99,48.046),Pull (-15.76,46.504) (-13.54,46.562),Pull (-13.54,46.376) (-13.54,46.191),Pull (-14.46,45.449) (-15.39,44.707),Pull (-16.88,45.449) (-18.36,46.191),Pull (-18.55,46.562) (-18.73,46.933)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-15.39,53.982) [Pull (-14.46,53.197) (-13.54,53.611)]
 |> outlined (solid 0.2)(rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.51,52.127) [Pull (-15.02,50.871) (-13.54,51.014)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.88,50.643) [Pull (-15.71,48.401) (-13.54,49.159)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-18.36,48.417) [Pull (-16.13,46.689) (-13.91,46.562)]
 |> outlined (solid 0.2) purple -- the unicorn horn line
 ]
 
-- GIRL HAIR 5

hair5 hCol = group [

  hair_5 hCol
    ,accessories_hair5

  ]
 
accessories_hair5 = group [



 curve (-29.12,38.028) [Pull (-26.54,47.452) (-18.36,47.675),Pull (-14.46,47.633) (-10.57,46.191),Pull (-13.48,47.149) (-15.39,44.707),Pull (-19.63,47.192) (-22.07,45.078),Pull (-26.24,42.653) (-28.01,38.028),Pull (-28.19,37.843) (-28.38,37.657),Pull (-28.75,37.843) (-29.12,38.028)]
 |> filled (rgb 181 228 234)
  |> addOutline (solid 0.2) blue-- the headband
 ,
 curve (-13.91,56.579) [Pull (-16.72,51.756) (-18.73,46.933),Pull (-18.55,46.562) (-18.36,46.191),Pull (-16.88,45.449) (-15.39,44.707),Pull (-14.65,45.449) (-13.91,46.191),Pull (-13.21,51.385) (-13.91,56.579)]
 |> filled (rgb 135 189 189) -- the unicorn horn
  ,
 curve (-17.99,48.046) [Pull (-15.95,46.304) (-13.91,46.562),Pull (-13.72,47.860) (-13.54,49.159),Pull (-15.39,48.401) (-17.25,50.643),Pull (-17.62,49.344) (-17.99,48.046)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-18.73,46.933) [Pull (-18.36,47.489) (-17.99,48.046),Pull (-15.76,46.504) (-13.54,46.562),Pull (-13.54,46.376) (-13.54,46.191),Pull (-14.46,45.449) (-15.39,44.707),Pull (-16.88,45.449) (-18.36,46.191),Pull (-18.55,46.562) (-18.73,46.933)]
 |> filled (rgb 169 160 225) -- the purple part of the unicorn horn
 ,
 curve (-15.39,53.982) [Pull (-14.46,53.197) (-13.54,53.611)]
 |> outlined (solid 0.2)(rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.51,52.127) [Pull (-15.02,50.871) (-13.54,51.014)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-16.88,50.643) [Pull (-15.71,48.401) (-13.54,49.159)]
 |> outlined (solid 0.2) (rgb 196 214 250) -- the unicorn horn line
 ,
 curve (-18.36,48.417) [Pull (-16.13,46.689) (-13.91,46.562)]
 |> outlined (solid 0.2) purple -- the unicorn horn line
 ,
 curve (-28.38,49.530) [Pull (-27.82,49.901) (-27.26,50.272),Pull (-27.08,50.828) (-26.89,51.385),Pull (-25.97,51.014) (-25.04,50.643),Pull (-25.04,50.272) (-25.04,49.901),Pull (-26.15,49.159) (-27.26,48.417),Pull (-27.82,49.159) (-28.38,49.530)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-25.04,50.643) [Pull (-24.67,51.014) (-24.30,51.385),Pull (-23.93,51.756) (-23.55,52.127),Pull (-23.37,51.571) (-23.18,51.014),Pull (-22.81,51.014) (-22.44,51.014),Pull (-22.44,50.828) (-22.44,50.643),Pull (-23.74,50.272) (-25.04,49.901),Pull (-25.04,50.457) (-25.04,50.643)]
 |>filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-28.01,49.159) [Pull (-28.75,49.159) (-29.49,49.159),Pull (-29.49,48.417) (-29.49,47.675),Pull (-29.31,47.489) (-29.12,47.304),Pull (-28.19,48.046) (-27.26,48.788),Pull (-27.26,48.788) (-28.01,49.159)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-29.49,47.675) [Pull (-30.42,47.675) (-31.35,47.675),Pull (-31.35,47.118) (-31.35,46.562),Pull (-31.53,46.562) (-31.72,46.562),Pull (-31.16,46.005) (-30.60,45.449),Pull (-29.68,46.376) (-28.75,47.304),Pull (-29.12,47.489) (-29.49,47.675)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 ,
 curve (-37.65,40.997) [Pull (-37.28,41.553) (-36.91,42.110),Pull (-36.54,41.553) (-36.17,40.997),Pull (-35.80,40.997) (-35.43,40.997),Pull (-35.98,40.626) (-36.54,40.255),Pull (-36.35,39.884) (-36.17,39.513),Pull (-36.54,39.698) (-36.91,39.884),Pull (-37.47,39.513) (-38.02,39.142),Pull (-37.84,39.884) (-37.65,40.626),Pull (-38.02,40.997) (-38.4,41.368),Pull (-38.02,41.182) (-37.65,40.997)]
 |> filled (rgb 183 213 224)
 |> addOutline (solid 0.2) blue-- the star on the pony
 
 
 ,  curve (-31.03,-6.464) [Pull (-27.05,-5.172) (-27.15,-8.080),Pull (-28.42,-9.499) (-30.38,-7.757),Pull (-33.06,-7.915) (-34.26,-7.434),Pull (-37.08,-5.218) (-34.26,-4.202),Pull (-32.59,-4.168) (-32,-5.494),Pull (-30.75,-5.138) (-31.03,-6.464)]
  |>   filled (rgb 252 163 217)  |> addOutline (solid 0.2) (rgb 190 123 156) -- hair tie

  , 
  curve (-32.32,-5.494) [Pull (-33.29,-4.471) (-34.26,-4.848),Pull (-35.04,-5.494) (-34.26,-6.141),Pull (-34.77,-6.787) (-32.64,-7.434),Pull (-31.51,-6.474) (-30.38,-7.434),Pull (-28.21,-8.917) (-27.79,-8.080),Pull (-26.96,-6.292) (-30.06,-6.464),Pull (-30.70,-5.281) (-31.35,-5.818),Pull (-31.83,-5.494) (-32.32,-5.494)]

   |> filled (rgb 198 221 237) |> addOutline (solid 0.2) (rgb 190 123 156) -- hair tie (inside)



 ]
 
hair_5 hCol = group [
  
 
 
  curve (-23.59,50.424) [Pull (-26.99,53.137) (-32.32,53.010),Pull (-40.70,50.567) (-40.72,40.404),Pull (-42.50,29.571) (-40.72,25.858),Pull (-43.21,23.029) (-38.78,20.040),Pull (-41.24,17.054) (-37.49,14.868),Pull (-39.47,12.282) (-36.52,9.6969),Pull (-38.81,6.7759) (-34.26,5.4949),Pull (-36.74,3.5555) (-33.93,1.6161),Pull (-35.07,-0.680) (-32.96,-1.616),Pull (-34.22,-3.232) (-32.64,-4.848),Pull (-30.88,-8.404) (-32.96,-11.95),Pull (-30.47,-13.09) (-29.41,-10.66),Pull (-29.07,-8.404) (-29.73,-6.141),Pull (-27.91,-5.003) (-28.44,-2.585),Pull (-27.96,-0.808) (-29.09,0.9696),Pull (-27.47,3.3939) (-29.41,5.8181),Pull (-27.59,8.4040) (-29.73,10.989),Pull (-28.16,13.414) (-30.70,15.838),Pull (-28.92,18.424) (-30.06,21.010),Pull (-28.90,25.535) (-31.67,30.060),Pull (-37.49,42.242) (-23.59,50.424)]
  |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156) -- braid outline
 , --{ hair strokes of braid 
 curve (-29.09,49.454) [Pull (-32,51.094) (-34.90,49.454)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.8
  ,
  curve (-37.49,47.515) [Pull (-39.52,45.690) (-39.43,42.666),Pull (-39.09,37.494) (-39.11,32.323)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.8
  ,
  curve (-31.67,46.545) [Pull (-36.64,46.282) (-36.84,42.020),Pull (-36.98,36.363) (-40.40,30.707),Pull (-40.83,27.081) (-37.81,25.535)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.8
  ,
  curve (-34.26,38.464) [Pull (-40.33,31.983) (-37.17,26.181),Pull (-37.40,24.244) (-35.87,22.626),Pull (-36.91,19.745) (-35.23,18.424),Pull (-35.92,15.403) (-34.26,14.222),Pull (-34.43,9.5515) (-32.32,8.0808),Pull (-33.28,6.4646) (-32.64,4.8484),Pull (-31.08,2.7474) (-31.67,0.6464),Pull (-31.89,-0.161) (-31.03,-0.969),Pull (-31.89,-2.101) (-31.03,-3.232),Pull (-30.42,-4.202) (-30.70,-5.171),Pull (-31.29,-6.303) (-31.35,-7.434)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,curve (-34.26,38.141) [Pull (-33.49,35.393) (-33.61,32.646),Pull (-36.53,30.035) (-37.17,26.505),Pull (-37.42,24.727) (-35.87,22.949),Pull (-33.93,24.152) (-32,27.474),Pull (-31.96,30.702) (-34.26,38.141)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,curve (-40.72,26.181) [Pull (-39.12,23.505) (-35.55,22.949),Pull (-36.79,20.408) (-35.23,18.747),Pull (-40.16,20.168) (-41.37,22.949),Pull (-41.69,24.565) (-40.72,26.181)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,curve (-39.11,20.040) [Pull (-40.52,15.894) (-37.17,14.868),Pull (-35.55,13.643) (-33.93,13.898),Pull (-35.88,16.161) (-35.23,18.424),Pull (-37.01,19.393) (-39.11,20.040)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,curve (-37.49,15.191) [Pull (-39.36,12.444) (-36.20,9.6969),Pull (-34.26,8.1288) (-32.32,8.0808),Pull (-34.55,10.989) (-34.26,13.898),Pull (-35.87,14.387) (-37.49,15.191)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,curve (-36.20,10.020) [Pull (-38.45,7.7159) (-34.90,5.1717),Pull (-33.61,4.9684) (-32.32,4.5252),Pull (-33.52,6.3030) (-32,8.0808),Pull (-34.18,8.0105) (-36.20,10.020)]
    |> outlined (solid 0.2) (rgb 190 123 156)
    ,curve (-35.23,5.8181) [Pull (-37.01,1.9923) (-31.67,0.6464),Pull (-32.24,2.7474) (-32.32,4.8484),Pull (-34.09,4.7533) (-35.23,5.8181)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,curve (-31.67,0.6464) [Pull (-33.51,0.9129) (-34.58,1.9393),Pull (-35.35,0.1616) (-32.96,-1.616),Pull (-32.16,-2.237) (-31.35,-1.939),Pull (-31.53,-1.292) (-31.03,-0.646),Pull (-31.97,0.1616) (-31.67,0.6464)]
    |> outlined (solid 0.2) (rgb 190 123 156)
   ,curve (-32.96,-1.292) [Pull (-34.37,-3.878) (-30.70,-6.464),Pull (-30.57,-4.202) (-31.67,-1.939),Pull (-32.16,-2.476) (-32.96,-1.292)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,
  curve (-32.32,26.828) [Pull (-27.24,22.949) (-31.67,19.070),Pull (-33.10,18.157) (-33.93,16.484)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,
  curve (-30.38,20.040) [Pull (-28.04,17.961) (-33.93,12.282)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,
  curve (-30.70,15.515) [Pull (-27.94,13.252) (-29.73,10.989),Pull (-31.71,9.8753) (-32.32,8.0808)]

  |> outlined (solid 0.2) (rgb 190 123 156)
  ,curve (-30.70,15.515) [Pull (-27.94,13.252) (-29.73,10.989),Pull (-31.71,9.8753) (-32.32,8.0808)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,
  curve (-29.73,10.989) [Pull (-27.04,7.4343) (-31.67,3.8787)]
  |> outlined (solid 0.2) (rgb 190 123 156)

  ,curve (-32,4.2020) [Pull (-31.17,2.5858) (-31.35,0.9696),Pull (-32.83,3.0707) (-32,4.2020)]
  |> filled (rgb 190 123 156)
  ,
  curve (-29.09,0.9696) [Pull (-30.06,-0.758) (-31.03,-0.646)]  
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,
  curve (-28.44,-2.262) [Pull (-31.03,-4.202) (-30.70,-6.141)]
  |> outlined (solid 0.2) (rgb 190 123 156)
  ,
  curve (-33.61,35.555) [Pull (-37.31,32.600) (-37.49,28.444)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.8
  ,
  curve (-32.64,30.707) [Pull (-35.66,27.797) (-35.87,24.888)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-41.05,24.888) [Pull (-39.40,21.369) (-35.87,21.010)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-31.03,27.797) [Pull (-31.96,24.404) (-34.58,21.010)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-30.06,26.181) [Pull (-31.16,22.464) (-34.90,18.747)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.8
  ,
  curve (-39.11,19.393) [Pull (-37.33,17.102) (-35.55,17.131)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  
  ,curve (-38.14,13.252) [Pull (-35.84,10.521) (-33.93,10.989)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-29.73,19.393) [Pull (-33.03,16.649) (-33.93,14.545)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.8
  ,
  curve (-39.43,18.101) [Pull (-37.83,15.546) (-34.90,15.191)]  
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-29.41,14.222) [Pull (-32.77,11.797) (-33.29,9.3737)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-36.84,8.4040) [Pull (-34.74,6.5143) (-32.64,6.4646)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-29.09,8.4040) [Pull (-30.70,7.7462) (-32.32,4.8484)] 
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.7
  ,
  curve (-35.23,4.5252) [Pull (-33.65,2.2723) (-31.67,1.9393)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-28.44,4.2020) [Pull (-30.17,3.3874) (-31.35,1.2929)]
  |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-33.93,0.6464) [Pull (-31.83,-2.766) (-29.73,-1.939)]
    |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
  ,
  curve (-28.44,0) [Pull (-30.96,-2.222) (-32.32,-4.525)]
      |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6
   ,
  curve (-30.70,9.6969) [Pull (-30.25,7.1111) (-31.67,4.5252)]
    |> outlined (solid 0.2) (rgb 190 123 156) |> makeTransparent 0.6

  --} end of strokes for the braid
 
 ,curve (-15.02,41.739) [Pull (-13.35,44.324) (-11.68,42.110),Pull (-12.41,37.657) (-8.347,33.205),Pull (-6.492,31.976) (-4.637,33.947),Pull (-9.263,37.843) (-9.089,41.739),Pull (-11.25,46.881) (-15.02,43.223),Pull (-17.43,46.481) (-19.84,41.739),Pull (-23.25,33.571) (-29.86,35.802),Pull (-33.37,38.956) (-32.09,42.110),Pull (-35.50,37.657) (-31.72,33.205),Pull (-28.75,30.863) (-25.78,31.721),Pull (-18.13,33.744) (-16.88,41.368),Pull (-16.75,44.353) (-15.02,41.739)]
  |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the bangs
 
 ,
 curve (-15.39,44.707) [Pull (-11.68,47.936) (-7.976,43.965),Pull (-6.092,41.924) (-5.008,39.884),Pull (-4.208,37.657) (-5.008,35.431),Pull (-3.623,34.689) (-4.637,33.947),Pull (-9.263,37.843) (-9.089,41.739),Pull (-11.65,47.281) (-15.02,43.223),Pull (-17.43,46.081) (-19.84,41.739),Pull (-22.45,33.971) (-29.86,35.802),Pull (-30.97,37.286) (-32.09,38.771),Pull (-28.19,34.626) (-24.30,42.481),Pull (-21.84,47.594) (-15.39,44.707)]
  |> filled hCol
 |> addOutline (solid 0.3) (rgb 190 123 156)-- the hair behind the bangs
 ,
 curve (-31.35,38.028) [Pull (-33.32,40.069) (-32.09,42.110),Pull (-31.86,45.078) (-27.64,48.046),Pull (-23.37,51.344) (-19.10,50.643),Pull (-11.72,50.475) (-8.347,44.707),Pull (-11.87,47.907) (-15.39,44.707),Pull (-22.83,48.023) (-24.67,41.739),Pull (-28.01,36.284) (-31.35,38.028)]
  |> filled hCol
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the top head
 
 
 ,
 curve (-6.863,32.463) [Pull (-8.492,30.608) (-6.121,28.753),Pull (-4.863,26.527) (-7.605,24.301),Pull (-9.020,23.188) (-7.234,22.075),Pull (-9.791,23.559) (-8.347,25.043),Pull (-6.162,26.713) (-7.976,28.382),Pull (-8.162,29.681) (-8.347,30.979),Pull (-7.791,31.907) (-7.234,32.834),Pull (-7.049,32.649) (-6.863,32.463)]
  |> filled hCol
  |> addOutline (solid 0.3) (rgb 190 123 156)-- the right side hair

 ,
 curve (-33.57,36.915) [Pull (-34.66,27.965) (-26.15,25.414),Pull (-25.97,28.568) (-25.78,31.721),Pull (-31.68,30.318) (-33.57,36.915)]
  |> filled hCol
 |> addOutline (solid 0.2)(rgb 190 123 156)-- the left side hair

 ,
 
 curve (-25.41,32.092) [Pull (-26.48,29.310) (-23.55,26.527),Pull (-23.44,21.872) (-26.52,22.817),Pull (-23.35,24.857) (-25.78,26.898),Pull (-25.78,29.310) (-25.41,32.092)]
  |> filled hCol
  |> addOutline (solid 0.5) (rgb 190 123 156)-- the left side hair
  
  
  ,
   curve (-29.49,46.562) [Pull (-30.16,42.950) (-27.64,41.739)]
  |> outlined (solid 0.4)(rgb 211 141 177) -- hair strokes on the top head
   ,
   curve (-24.67,45.449) [Pull (-26.34,46.162) (-28.01,47.675)]
 |> outlined (solid 0.3) (rgb 190 123 156) -- hair strokes on the top head
 ,
   curve (-18.36,48.046) [Pull (-20.77,49.773) (-23.18,49.901)]
  |> outlined (solid 0.3) (rgb 190 123 156) -- hair strokes on the top head
  ,
  curve (-30.97,31.350) [Pull (-33.07,33.020) (-33.57,34.689)]
  |> outlined (solid 0.3) (rgb 211 141 177) -- hair strokes on the top head
 

 ] 

 
-- GIRL OUTFIT 1

outfit1 skin = group [
   light_part_dress_outfit1 skin
 ,
 boots_outfit1
 ,
 dress_details_outfit1
  ]
 
dark_part_dress_outfit1 skin = group [
   curve (-32.09,4.6376) [Pull (-32.27,3.7101) (-32.46,2.7826),Pull (-34.74,-0.556) (-35.43,-3.895),Pull (-36.33,-6.863) (-38.02,-9.831),Pull (-40.99,-12.18) (-43.96,-16.13),Pull (-43.96,-16.51) (-43.96,-16.88),Pull (-43.40,-17.25) (-42.85,-17.62),Pull (-41.42,-16.13) (-38.4,-14.65),Pull (-37.84,-14.46) (-37.28,-14.28),Pull (-37.28,-15.58) (-37.28,-16.88),Pull (-36.73,-18.08) (-36.17,-16.88),Pull (-35.80,-15.39) (-35.43,-13.91),Pull (-35.43,-12.42) (-35.43,-10.94),Pull (-33.76,-8.904) (-32.09,-6.863),Pull (-29.80,-3.153) (-29.12,0.5565),Pull (-28.19,2.0405) (-27.26,3.5246),Pull (-27.45,4.2666) (-27.64,5.0086),Pull (-29.86,5.3797) (-32.09,5.7507),Pull (-32.09,5.1942) (-32.09,4.6376)]
 |> filled skin -- the left arm including hands
 
 , curve (-2.782,7.6057) [Pull (-2.040,6.4927) (-1.298,5.3797),Pull (1.7275,3.3681) (3.1536,0.5565),Pull (5.0086,-2.040) (6.8637,-4.637),Pull (10.759,-5.878) (14.655,-8.718),Pull (13.286,-10.34) (8.7188,-7.976),Pull (9.2753,-9.275) (9.8318,-10.57),Pull (9.0898,-11.98) (8.3478,-10.20),Pull (7.4202,-9.275) (6.4927,-8.347),Pull (3.7101,-5.136) (0.9275,-3.524),Pull (-1.484,-0.742) (-3.895,2.0405),Pull (-5.008,3.5246) (-6.121,5.0086),Pull (-6.121,5.5652) (-6.121,6.1217),Pull (-4.452,7.0492) (-2.782,7.9768),Pull (-2.782,7.7913) (-2.782,7.6057)]
 |> filled skin -- the right arm including hands
 , 
 dress_pieces_outfit1
  ,
 curve (-22.81,12.428) [Pull (-20.77,13.228) (-18.73,12.428),Pull (-16.45,9.2347) (-15.76,2.0405),Pull (-18.73,2.3826) (-21.70,3.5246),Pull (-21.43,5.7507) (-23.55,7.9768),Pull (-21.98,10.202) (-22.81,12.428)]
 |> filled (rgb 197 201 239) -- the dress piece on the chest
 ,
 
 curve (-11.68,13.542) [Pull (-10.75,14.342) (-9.831,13.542),Pull (-8.231,10.202) (-9.831,6.8637),Pull (-10.01,5.1942) (-10.20,3.5246),Pull (-11.31,2.7826) (-12.42,2.0405),Pull (-10.85,7.7913) (-11.68,13.542)]
 |> filled (rgb 197 201 239)-- the far dress piece on the chest
 ,
 curve (-13.17,-0.185) [Pull (-12.33,-4.452) (-9.089,-8.718),Pull (-5.779,-15.38) (-1.669,-17.25),Pull (-0.185,-18.63) (1.2985,-17.62),Pull (1.4840,-17.25) (1.6695,-16.88),Pull (2.2260,-16.88) (2.7826,-16.88),Pull (3.5246,-18.55) (4.2666,-20.22),Pull (7.6057,-23.91) (10.944,-22.81),Pull (11.872,-23.18) (12.8,-23.55),Pull (15.640,-27.64) (16.881,-31.72),Pull (12.8,-30.46) (8.7188,-33.20),Pull (6.4927,-35.54) (4.2666,-34.68),Pull (3.0376,-33.94) (5.0086,-33.20),Pull (6.6782,-32.83) (8.3478,-32.46),Pull (9.0202,-31.90) (6.4927,-31.35),Pull (3.5246,-32.73) (0.5565,-31.72),Pull (0.1855,-31.35) (-0.185,-30.97),Pull (7.8434,-27.89) (-0.927,-28.01),Pull (-2.597,-28.19) (-4.266,-28.38),Pull (-4.266,-27.82) (-4.266,-27.26),Pull (0.7768,-25.97) (-5.379,-24.67),Pull (-5.750,-25.22) (-6.121,-25.78),Pull (-6.492,-25.41) (-6.863,-25.04),Pull (-10.20,-25.22) (-13.54,-25.41),Pull (-13.85,-23.07) (-15.76,-23.93),Pull (-19.85,-25.04) (-13.54,-26.15),Pull (-13.39,-26.89) (-17.25,-27.64),Pull (-21.14,-28.81) (-25.04,-28.38),Pull (-33.19,-30.60) (-26.15,-32.83),Pull (-27.09,-35.57) (-32.83,-34.31),Pull (-44.12,-30.66) (-45.82,-35.80),Pull (-45.93,-36.73) (-42.85,-37.65),Pull (-42.16,-40.64) (-50.27,-38.02),Pull (-55.98,-36.58) (-57.69,-39.14),Pull (-55.26,-31.16) (-48.04,-23.18),Pull (-44.33,-24.94) (-40.62,-24.30),Pull (-32.66,-26.75) (-29.49,-22.81),Pull (-29.12,-21.14) (-28.75,-19.47),Pull (-25.97,-21.26) (-23.18,-19.84),Pull (-13.16,-14.01) (-13.17,-0.185)]
 |> filled (rgb 208 196 246)
 |> addOutline (solid 0.4)  (rgb 124 121 176)-- the main dress piece
 ,
 curve (-22.81,12.428) [Pull (-23.18,10.388) (-23.55,8.3478),Pull (-20.78,10.388) (-22.81,12.428)]
 |> filled (rgb 197 201 239)
 
 ,  curve (-24.30,-28.01) [Pull (-23.50,-28.93) (-24.30,-29.86),Pull (-25.22,-30.97) (-26.15,-32.09),Pull (-23.00,-34.62) (-19.84,-33.94),Pull (-18.73,-32.46) (-17.62,-30.97),Pull (-16.82,-29.31) (-17.62,-27.64),Pull (-20.96,-27.45) (-24.30,-27.26),Pull (-24.30,-27.64) (-24.30,-28.01)]
 |> filled skin -- the left leg
  ,
 curve (-15.02,-26.89) [Pull (-15.02,-28.56) (-15.02,-30.23),Pull (-14.78,-31.72) (-16.13,-33.20),Pull (-12,-34.99) (-9.460,-33.57),Pull (-8.318,-29.31) (-7.976,-25.04),Pull (-10.94,-24.48) (-13.91,-23.93),Pull (-14.46,-25.41) (-15.02,-26.89)]
  |> filled skin -- the right leg

 ]
 
light_part_dress_outfit1 skin = group [

 curve (-7.976,-10.94) [Pull (-4.875,-22.52) (15.026,-26.89),Pull (10.110,-10.92) (-7.976,-10.94)]
 |> filled (rgb 125 179 191)
 ,
   curve (-18.73,12.428) [Pull (-17.06,12.428) (-15.39,12.428),Pull (-14.28,12.614) (-13.17,12.8),Pull (-12.42,13.171) (-11.68,13.542),Pull (-8.057,7.7913) (-12.42,2.0405),Pull (-13.91,0.8405) (-15.39,2.0405),Pull (-18.26,7.2347) (-18.73,12.428)]
 |> filled (rgb 172 225 219) -- the dress piece on the chest
  ,
   curve (-13.17,-0.185) [Pull (-9.686,1.2985) (-10.20,2.7826),Pull (-2.968,0.7884) (4.2666,-7.605),Pull (13.031,-16.13) (15.397,-24.67),Pull (16.411,-25.97) (15.026,-27.26),Pull (13.356,-23.04) (11.686,-22.81),Pull (6.5913,-26.13) (3.8956,-19.84),Pull (5.7101,-17.99) (3.5246,-16.13),Pull (1.0260,-16.45) (0.9275,-18.36),Pull (-1.113,-19.25) (-3.153,-16.13),Pull (-7.049,-12.8) (-10.94,-9.460),Pull (-12.05,-4.823) (-13.17,-0.185)]
 |> filled (rgb 181 233 229)
 |> addOutline (solid 0.5) (rgb 147 198 202)-- the main dress piece on the right
 ,
 curve (-28.75,-19.47) [Pull (-24.67,-22.33) (-20.59,-17.99),Pull (-10.48,-9.089) (-13.17,-0.185),Pull (-21.03,0.0985) (-21.70,2.7826),Pull (-42.05,-2.330) (-53.61,-25.04),Pull (-50.82,-22.91) (-48.04,-23.18),Pull (-44.15,-25.74) (-40.25,-24.30),Pull (-33.08,-26.97) (-29.12,-22.44),Pull (-23.76,-23.14) (-28.01,-19.84)] 
 |>filled (rgb 181 233 229)
  |> addOutline (solid 0.5) (rgb 147 198 202)-- the main dress piece on the left
 ,
 curve (-21.70,3.5246) [Pull (-17.80,2.4115) (-13.91,1.2985),Pull (-11.87,2.4115) (-9.831,3.5246),Pull (-9.286,-0.730) (-13.54,-0.185),Pull (-21.22,-0.330) (-21.70,3.5246)]
 |> filled (rgb 183 226 232)
  |> addOutline (solid 0.5) (rgb 147 198 202)-- the waist tightner dress part
 ,
 curve (-21.70,13.542) [Pull (-18.55,15.356) (-15.39,13.171),Pull (-14.46,14.556) (-13.54,13.542),Pull (-12.24,14.284) (-10.94,15.026),Pull (-10.57,14.655) (-10.20,14.284),Pull (-11.68,13.542) (-13.17,12.8),Pull (-15.95,12.614) (-18.73,12.428),Pull (-20.77,12.028) (-22.81,12.428),Pull (-23.18,14.840) (-23.55,17.252),Pull (-22.63,16.997) (-21.70,13.542)]
 |> filled (rgb 193 245 232) -- the neck dress piece
 ,
 curve (-12.8,17.623) [Pull (-12.73,19.994) (-9.460,18.365),Pull (-7.478,15.924) (-3.895,14.284),Pull (-1.495,11.686) (-3.895,9.0898),Pull (-5.350,9.5768) (-7.605,6.8637),Pull (-8.533,6.2492) (-9.460,7.2347),Pull (-8.017,10.759) (-10.57,14.284),Pull (-12.88,15.953) (-12.8,17.623)]
 |> filled (rgb 193 245 232)
  |> addOutline (solid 0.5) (rgb 147 198 202)-- the right sleeve
 ,
 curve (-7.234,7.2347) [Pull (-5.565,9.7623) (-3.895,9.0898),Pull (-2.782,8.7188) (-1.669,8.3478),Pull (-2.226,8.4057) (-2.782,6.8637),Pull (-3.339,6.0637) (-3.895,6.8637),Pull (-4.452,8.1217) (-5.008,5.3797),Pull (-5.750,6.6086) (-6.492,4.6376),Pull (-7.049,4.4231) (-7.605,5.0086),Pull (-8.191,5.9362) (-7.234,7.2347)]
 |> filled (rgb 180 199 231)
 -- the right bottem sleeve
 ,
 curve (-31.35,15.026) [Pull (-26.06,20.939) (-23.18,17.252),Pull (-22.17,12.8) (-23.55,8.3478),Pull (-23.50,7.0492) (-25.04,5.7507),Pull (-28.56,6.4927) (-32.09,7.2347),Pull (-34.64,9.6463) (-33.20,12.057),Pull (-32.27,13.542) (-31.35,15.026)] 
 |> filled (rgb 193 245 232)
  |> addOutline (solid 0.5) (rgb 147 198 202)-- the left sleeve
 ,
 curve (-31.72,7.2347) [Pull (-31.53,6.8637) (-31.35,6.4927),Pull (-32.89,5.9362) (-32.83,5.3797),Pull (-31.90,3.5942) (-30.97,5.0086),Pull (-29.68,3.2231) (-28.38,4.6376),Pull (-25.85,2.4521) (-26.52,4.2666),Pull (-26.34,5.1942) (-26.15,6.1217),Pull (-28.75,6.6782) (-31.72,7.2347)]
 |>  filled (rgb 180 199 231) -- the left bottem sleeve
 ,
 curve (-16.51,2.0405) [Pull (-16.13,2.0405) (-15.76,2.0405),Pull (-15.76,2.4115) (-15.76,2.7826),Pull (-15.05,2.0405) (-13.54,1.2985),Pull (-14.84,1.4840) (-16.51,2.0405)]
 |> filled (rgb 172 225 219)
 ,
 dark_part_dress_outfit1 skin
 ]
 
dress_pieces_outfit1 = group  [
  

 curve (-35.80,-33.20) [Pull (-36.91,-36.17) (-38.02,-39.14),Pull (-33.76,-39.64) (-29.49,-41.73),Pull (-26.89,-42.66) (-24.30,-43.59),Pull (-19.63,-39.71) (-15.76,-40.62),Pull (-12.98,-41.18) (-10.20,-41.73),Pull (-4.266,-37.88) (1.6695,-38.02),Pull (0.3710,-34.50) (-0.927,-30.97),Pull (4.0985,-31.46) (3.5246,-28.75),Pull (-0.371,-26.56) (-4.266,-28.38),Pull (-4.266,-27.64) (-4.266,-26.89),Pull (-4.452,-26.89) (-4.637,-26.89),Pull (0.2608,-28.34) (-2.040,-25.78),Pull (-5.466,-22.98) (-6.492,-25.78),Pull (-6.220,-24.21) (-8.347,-25.04),Pull (-11.13,-24.67) (-13.91,-24.30),Pull (-15.58,-21.68) (-17.25,-24.67),Pull (-15.76,-26.82) (-14.28,-25.78),Pull (-14.19,-26.71) (-16.51,-27.64),Pull (-20.59,-27.45) (-24.67,-27.26),Pull (-24.30,-27.82) (-23.93,-28.38),Pull (-26.52,-27.71) (-29.12,-30.23),Pull (-30.62,-33.53) (-26.52,-32.83),Pull (-27.56,-36.22) (-35.80,-33.20)] 
 |> filled (rgb 135 143 215) -- the dress piece behing the leg
 ,
 curve (-36.17,-33.20) [Pull (-44.99,-31.70) (-45.82,-35.80),Pull (-45.93,-36.73) (-42.85,-37.65),Pull (-42.40,-40.02) (-49.15,-38.4),Pull (-57.64,-36.77) (-57.32,-39.14),Pull (-56.19,-42.01) (-50.27,-42.48),Pull (-45.26,-46.17) (-40.25,-45.07),Pull (-37.14,-42.11) (-38.02,-39.14),Pull (-36.91,-36.17) (-36.17,-33.20)] 
 |> filled (rgb 158 181 225) -- the left dress piece under the main dress piece
 ,
 curve (-2.040,-28.38) [Pull (0.5565,-35.24) (3.1536,-42.11),Pull (4.2666,-42.51) (5.3797,-42.11),Pull (9.0898,-41.61) (12.8,-39.51),Pull (13.628,-38.58) (12.057,-37.65),Pull (20.069,-34.68) (16.881,-31.72),Pull (7.4202,-29.86) (-2.040,-28.38)]
 |> filled (rgb 158 181 225) -- the right dress piece under the main dress piece
  ]
 
 
boots_outfit1 = group [

 curve (-32.46,-47.67) [Pull (-33.79,-48.11) (-34.31,-51.75),Pull (-34.87,-52.68) (-35.43,-53.61),Pull (-34.87,-54.16) (-34.31,-54.72),Pull (-34.13,-54.35) (-33.94,-53.98),Pull (-33.79,-56.82) (-32.83,-58.06),Pull (-30.60,-60.59) (-28.38,-59.91),Pull (-26.44,-58.24) (-26.89,-56.57),Pull (-29.86,-52.31) (-32.46,-47.67)]
 |> filled (rgb 132 141 198) -- the left boots heel
 ,
 curve (-26.15,-31.72) [Pull (-25.18,-33.20) (-20.22,-34.68),Pull (-21.88,-38.21) (-23.55,-41.73),Pull (-27.81,-48.97) (-27.26,-56.20),Pull (-27.09,-60.95) (-31.72,-57.69),Pull (-32.89,-56.11) (-32.46,-52.12),Pull (-32.64,-51.01) (-32.83,-49.90),Pull (-32.89,-47.43) (-31.35,-46.56),Pull (-28.85,-44.72) (-28.75,-37.28),Pull (-27.45,-34.50) (-26.15,-31.72)]
 |> filled (rgb 188 230 226) -- the left boot
 ,
 curve (-16.88,-52.86) [Pull (-16.69,-55.28) (-16.51,-57.69),Pull (-15.95,-58.06) (-15.39,-58.43),Pull (-15.21,-57.69) (-15.02,-56.95),Pull (-14.46,-57.50) (-13.91,-58.06),Pull (-8.388,-61.66) (-6.863,-58.06),Pull (-11.87,-55.46) (-16.88,-52.86)]
 |> filled (rgb 132 141 198) -- the right boots heel
 ,
 curve (-16.13,-33.20) [Pull (-12.42,-35.17) (-8.718,-33.94),Pull (-10.01,-42.11) (-11.31,-50.27),Pull (-10.17,-52.31) (-9.831,-54.35),Pull (-8.347,-55.46) (-6.863,-56.57),Pull (-5.646,-59.32) (-12.42,-58.06),Pull (-13.54,-56.39) (-14.65,-54.72),Pull (-15.95,-53.79) (-17.25,-52.86),Pull (-17.89,-50.82) (-16.13,-48.78),Pull (-16.13,-41.18) (-16.13,-33.20)]
 |> filled (rgb 188 230 226) -- the right boot
 
 ]
 
 
dress_details_outfit1 = group [

 curve (-15.02,0.1855) [Pull (-15.05,-3.524) (-16.88,-7.234)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-16.13,0.1855) [Pull (-17.15,-2.040) (-18.36,-4.266)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-17.99,-4.637) [Pull (-18.39,-7.049) (-20.59,-9.460)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-18.36,0.1855) [Pull (-20.72,-1.326) (-22.07,-4.637)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-20.22,0.9275) [Pull (-27.52,-2.808) (-32.83,-10.94)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-30.60,-19.47) [Pull (-30.43,-14.88) (-27.26,-11.68)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-12.05,-0.185) [Pull (-9.702,-2.282) (-8.347,-5.379)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-5.008,-7.605) [Pull (-1.255,-11.74) (1.2985,-16.88)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-9.460,1.6695) [Pull (-5.707,-0.869) (-3.153,-5.008)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (3.5246,-15.76) [Pull (2.8130,-11.68) (-1.298,-7.605)]
  |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
 curve (-23.55,-10.94) [Pull (-26.40,-14.39) (-27.64,-19.84)]
 |> outlined (solid 0.3) (rgb 147 198 202) -- the light dress lines
 ,
  curve (-40.25,-24.30) [Pull (-44.66,-29.49) (-45.07,-34.68)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
  curve (-26.15,-21.33) [Pull (-29.14,-25.6) (-29.12,-29.86)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
 curve (-15.39,-11.68) [Pull (-17.52,-18.17) (-17.25,-24.67)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
  curve (-12.8,-13.54) [Pull (-13.78,-19.47) (-13.17,-25.41)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
  curve (-10.57,-9.831) [Pull (-7.418,-17.43) (-6.863,-25.04)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
 curve (-6.492,-13.17) [Pull (-2.766,-19.66) (-2.040,-26.15)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
 curve (-0.556,-18.73) [Pull (2.4840,-22.95) (3.5246,-28.38)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
 curve (5.0086,-22.07) [Pull (7.7927,-26.89) (7.9768,-31.72)]
 |> outlined (solid 0.2)(rgb 124 121 176) -- the dark dress lines
 ,
  curve (-6.492,-25.78) [Pull (-4.081,-23.75) (-1.669,-26.52),Pull (-1.953,-28.71) (-4.637,-26.89),Pull (-5.565,-26.34) (-6.492,-25.78)]
 |> filled  (rgb 135 143 215)
 ,
  curve (-3.895,-28.75) [Pull (6.9449,-27.86) (0.1855,-30.97),Pull (-1.855,-29.86) (-3.895,-28.75)]
 |> filled  (rgb 135 143 215)
  |> addOutline (solid 1)(rgb 135 143 215)
 
 
 ]
 
 
-- OUTFIT 2

outfit2 skin = group [
   curve (-20.59,21.704) [Pull (-20.77,19.663) (-20.96,17.623),Pull (-22.26,18.237) (-23.55,17.252),Pull (-22.63,16.997) (-21.70,13.542),Pull (-18.55,14.956) (-15.39,13.171),Pull (-14.46,14.156) (-13.54,13.542),Pull (-12.24,14.284) (-10.94,15.026),Pull (-13.07,16.324) (-12.8,17.623),Pull (-14.09,18.208) (-15.39,17.994),Pull (-15.21,18.921) (-15.02,19.849),Pull (-18.62,20.463) (-20.59,21.704)]
 |> filled skin
 |> move (-1.5,17)-- the neck including the shoulders
  |> scale 0.9
 |> move (-32, -15)
 ,
 curve (-32.09,4.6376) [Pull (-32.27,3.7101) (-32.46,2.7826),Pull (-34.74,-0.556) (-35.43,-3.895),Pull (-36.33,-6.863) (-38.02,-9.831),Pull (-40.99,-12.18) (-43.96,-16.13),Pull (-43.96,-16.51) (-43.96,-16.88),Pull (-43.40,-17.25) (-42.85,-17.62),Pull (-41.42,-16.13) (-38.4,-14.65),Pull (-37.84,-14.46) (-37.28,-14.28),Pull (-37.28,-15.58) (-37.28,-16.88),Pull (-36.73,-18.08) (-36.17,-16.88),Pull (-35.80,-15.39) (-35.43,-13.91),Pull (-35.43,-12.42) (-35.43,-10.94),Pull (-33.76,-8.904) (-32.09,-6.863),Pull (-29.80,-3.153) (-29.12,0.5565),Pull (-28.19,2.0405) (-27.26,3.5246),Pull (-27.45,4.2666) (-27.64,5.0086),Pull (-29.86,5.3797) (-32.09,5.7507),Pull (-32.09,5.1942) (-32.09,4.6376)]
 |> filled skin
 |> move (-1,15)-- the left arm including hands
  |> scale 0.9
 |> move (-32, -15)
 ,
 curve (-2.782,7.6057) [Pull (-2.040,6.4927) (-1.298,5.3797),Pull (1.7275,3.3681) (3.1536,0.5565),Pull (5.0086,-2.040) (6.8637,-4.637),Pull (10.759,-5.878) (14.655,-8.718),Pull (13.286,-10.34) (8.7188,-7.976),Pull (9.2753,-9.275) (9.8318,-10.57),Pull (9.0898,-11.98) (8.3478,-10.20),Pull (7.4202,-9.275) (6.4927,-8.347),Pull (3.7101,-5.136) (0.9275,-3.524),Pull (-1.484,-0.742) (-3.895,2.0405),Pull (-5.008,3.5246) (-6.121,5.0086),Pull (-6.121,5.5652) (-6.121,6.1217),Pull (-4.452,7.0492) (-2.782,7.9768),Pull (-2.782,7.7913) (-2.782,7.6057)]
 |> filled skin
 |> move (-8,10)-- the right arm including hands
  |> scale 0.9
 |> move (-32, -15)
  , 
  curve (-56.57,17.994) [Pull (-54.35,16.411) (-52.12,12.428),Pull (-51.75,12.8) (-51.38,13.171),Pull (-52.25,15.953) (-54.72,18.736),Pull (-55.92,18.736) (-56.57,17.994)]
 |> filled (rgb 165 178 240) -- the left strap of the dress
 ,
  curve (-45.07,18.365) [Pull (-43.59,15.768) (-42.11,13.171),Pull (-41.92,13.171) (-41.73,13.171),Pull (-42.66,15.768) (-43.59,18.365),Pull (-43.59,17.565) (-45.07,18.365)]
 |> filled (rgb 165 178 240) -- the right strap of the dress
 ,
 curve (-52.49,19.107) [Pull (-56.91,18.579) (-57.32,17.252),Pull (-59.51,11.130) (-62.51,5.0086),Pull (-58.93,5.3391) (-56.95,1.6695),Pull (-56.82,4.8231) (-55.09,7.9768),Pull (-48.04,5.5652) (-40.99,3.1536),Pull (-38.15,2.8811) (-36.91,5.0086),Pull (-39.14,10.573) (-41.36,16.139),Pull (-42.60,18.452) (-45.44,18.365),Pull (-48.17,14.336) (-52.49,19.107)]
 |> filled (rgb 246 239 246)
 |> makeTransparent 0.98-- the lace under the dress
 ,
 
 curve (-62.51,5.0086) [Pull (-66.09,2.4985) (-68.08,-2.411),Pull (-68.91,-3.710) (-67.33,-5.008),Pull (-65.66,-3.350) (-64,-6.492),Pull (-64,-6.863) (-64,-7.234),Pull (-58.87,-5.182) (-56.95,1.6695),Pull (-58.15,5.2695) (-62.51,5.0086)]
 |> filled (rgb 246 239 246) -- the left arm blouse 
 ,
 
 curve (-36.91,5.0086) [Pull (-34.13,1.1130) (-31.35,-2.782),Pull (-31.53,-3.524) (-31.72,-4.266),Pull (-33.02,-4.794) (-34.31,-6.121),Pull (-36.85,-0.255) (-40.99,2.4115),Pull (-37.21,3.2115) (-36.91,5.0086)]
 |> filled (rgb 246 239 246)  -- the right arm blouse 
 ,
 
  curve (-54.72,7.9768) [Pull (-53.79,9.4608) (-52.86,10.944),Pull (-50.75,16.730) (-45.44,11.315),Pull (-44.60,14.857) (-41.36,12.8),Pull (-39.76,10.417) (-41.36,7.2347),Pull (-41.18,5.1942) (-40.99,3.1536),Pull (-50.31,1.3101) (-53.24,4.2666),Pull (-53.18,5.9362) (-54.72,7.6057),Pull (-54.72,7.6057) (-54.72,7.9768)]
   |> filled (rgb 178 188 247) -- the croset above the belt
 , 
 
 curve (-48.41,10.573) [Pull (-47.08,6.3072) (-46.56,2.0405),Pull (-44.89,2.0405) (-43.22,2.0405),Pull (-45.19,6.8637) (-43.96,11.686),Pull (-43.96,11.686) (-48.41,10.573)]
 |> filled (rgb 171 216 226)
 ,
 
 curve (-53.24,4.2666) [Pull (-47.73,1.0956) (-40.62,3.5246),Pull (-39.42,2.1971) (-40.62,1.6695),Pull (-46.31,-0.759) (-53.61,2.4115),Pull (-54.96,2.5971) (-53.24,4.2666)]
 |> filled (rgb 157 201 219) -- the belt
 ,
 
 curve (-45.82,2.7826) [Pull (-42.89,3.4550) (-43.96,0.9275),Pull (-46.89,0.2550) (-45.82,2.7826)]
 |> filled (rgb 221 244 250) -- the belt buckle

 ,
 
 curve (-76.24,-27.64) [Pull (-74.90,-32.20) (-69.56,-33.57),Pull (-60.92,-36.07) (-70.67,-36.17),Pull (-68.78,-41.01) (-62.88,-40.25),Pull (-62.14,-40.81) (-61.40,-41.36),Pull (-56.20,-45.92) (-51.01,-42.48),Pull (-49.53,-44.23) (-48.04,-43.59),Pull (-37.24,-42.56) (-32.83,-39.14),Pull (-39.42,-37.84) (-33.20,-36.54),Pull (-26.11,-35.33) (-25.41,-31.72),Pull (-35.47,-32.91) (-23.93,-26.89),Pull (-24.11,-26.34) (-24.30,-25.78),Pull (-32.83,-18.92) (-41.36,-12.05),Pull (-58.80,-19.84) (-76.24,-27.64)]
 |> filled (rgb 146 133 210) -- the dress peice behind the leg
 ,
 curve (-47.30,-17.25) [Pull (-47.48,-20.96) (-47.67,-24.67),Pull (-50.08,-28.38) (-52.49,-32.09),Pull (-56.88,-33.00) (-58.06,-29.12),Pull (-56.42,-26.15) (-53.98,-23.18),Pull (-54.53,-20.77) (-55.09,-18.36),Pull (-53.81,-15.40) (-47.30,-17.25)] 
 |> filled  skin
 
  -- the left leg
  ,
 curve (-46.56,-17.25) [Pull (-46.56,-22.26) (-46.56,-27.26),Pull (-47.91,-28.51) (-47.67,-31.35),Pull (-44.70,-33.72) (-41.73,-32.09),Pull (-41.24,-24.48) (-39.14,-16.88),Pull (-43.14,-12.08) (-46.56,-17.25)]   
   |> filled skin
  -- the right leg
 ,
 
 curve (-44.70,0.1855) [Pull (-57.50,-8.904) (-70.30,-17.99),Pull (-71.97,-20.77) (-73.64,-23.55),Pull (-74.94,-25.78) (-76.24,-28.01),Pull (-71.79,-28.22) (-67.33,-27.64),Pull (-66.59,-25.6) (-65.85,-23.55),Pull (-60.88,-23.91) (-59.91,-19.47),Pull (-57.13,-20.06) (-54.35,-19.84),Pull (-54.48,-16.15) (-45.82,-17.25),Pull (-47.07,-16.69) (-44.33,-16.13),Pull (-41.33,-17.71) (-39.14,-16.88),Pull (-37.2,-16.23) (-37.65,-17.99),Pull (-35.98,-17.99) (-34.31,-17.99),Pull (-33.76,-20.59) (-33.20,-23.18),Pull (-28.75,-26.08) (-24.30,-25.78),Pull (-24.18,-23.37) (-27.26,-20.96),Pull (-27.92,-17.06) (-30.97,-13.17),Pull (-30.97,-13.17) (-44.70,0.1855)]
 |> filled (rgb 204 176 250) -- the purple part of the dress
 ,
 
 
 curve (-61.77,-23.55) [Pull (-59.47,-20.26) (-53.98,-20.96),Pull (-50.27,-19.36) (-46.56,-20.96),Pull (-40.45,-18.77) (-39.14,-20.59),Pull (-32.75,-18.56) (-33.57,-21.33),Pull (-30.60,-19.73) (-27.64,-21.33),Pull (-50.70,-3.646) (-61.77,-23.55)]
  |> filled (rgb 204 176 250)
 
  ,
 -- the purple dress deatails
 curve (-73.27,-23.55) [Pull (-70.92,-22.54) (-66.96,-23.93),Pull (-64.55,-24.35) (-62.14,-23.18)]
 |> outlined (solid 0.5)(rgb 164 132 224)
 ,
 
 curve (-62.51,-15.39) [Pull (-64.24,-18.17) (-64.37,-20.96),Pull (-60.66,-18.40) (-56.95,-19.84),Pull (-55.65,-19.84) (-54.35,-19.84)]
  |> outlined (solid 0.5)(rgb 164 132 224)
 ,
 
 curve (-51.75,-11.31) [Pull (-54.62,-14.46) (-55.09,-17.62)]
  |> outlined (solid 0.5)(rgb 164 132 224)
 ,
 
 curve (-45.44,-4.637) [Pull (-47.79,-9.373) (-46.93,-16.51)]
 |> outlined (solid 0.5)(rgb 164 132 224)
 ,
 
 curve (-41.73,-5.008) [Pull (-38.65,-9.646) (-38.77,-14.28)]
 |> outlined (solid 0.5)(rgb 164 132 224)
 ,
 
 curve (-31.35,-19.47) [Pull (-28.93,-18.64) (-26.52,-20.22)]
 |> outlined (solid 0.3)(rgb 164 132 224)
 
 
 ,
 
 curve (-53.61,2.4115) [Pull (-56.63,1.3565) (-58.06,-1.298),Pull (-59.03,-5.466) (-64,-7.234),Pull (-66.25,-9.831) (-67.71,-12.42),Pull (-67.95,-13.17) (-66.59,-13.91),Pull (-69.65,-15.33) (-70.30,-18.36),Pull (-66.22,-19.68) (-62.14,-15.39),Pull (-58.99,-16.04) (-55.83,-14.28),Pull (-48.77,-12.41) (-47.30,-5.750),Pull (-44.40,-4.811) (-44.70,0.9275),Pull (-44.26,-2.440) (-40.62,-5.008),Pull (-38.91,-10.77) (-33.20,-10.94),Pull (-31.90,-13.65) (-30.60,-13.17),Pull (-33.24,-5.750) (-39.88,1.6695),Pull (-46.68,-1.530) (-53.61,2.4115)]
 |> filled (rgb 192 205 245) -- the top of the dress
  ,
  
 curve (-62.51,-42.85) [Pull (-65.60,-44.24) (-65.48,-48.04),Pull (-66.04,-49.34) (-66.59,-50.64),Pull (-65.85,-51.2) (-65.11,-51.75),Pull (-63.81,-47.30) (-62.51,-42.85)]
 |> filled (rgb 196 224 236)
  |> addOutline (solid 0.5) (rgb 165 184 210)-- the left boots heel
  
  ,
 
 curve (-58.06,-28.75) [Pull (-57.09,-31.80) (-52.12,-32.46),Pull (-55.89,-38.77) (-58.06,-45.07),Pull (-59.23,-48.78) (-58.80,-52.49),Pull (-56.68,-58.51) (-61.77,-57.32),Pull (-65.84,-54.99) (-65.11,-50.27),Pull (-65.81,-45.73) (-62.51,-43.59),Pull (-61.08,-36.17) (-58.06,-28.75)]
 |> filled (rgb 196 224 236) -- the left boot
 |> addOutline (solid 0.5) (rgb 165 184 210)
 ,
 
 curve (-48.04,-30.97) [Pull (-44.70,-33.13) (-41.36,-32.09),Pull (-42.88,-39.69) (-43.59,-47.30),Pull (-43.39,-52.42) (-38.4,-54.35),Pull (-37.24,-57.62) (-42.48,-57.69),Pull (-46.49,-56.29) (-47.30,-52.49),Pull (-47.30,-53.79) (-47.30,-55.09),Pull (-48.23,-54.91) (-49.15,-54.72),Pull (-49.34,-53.05) (-49.53,-51.38),Pull (-50.35,-48.60) (-48.78,-45.82),Pull (-48.41,-38.58) (-48.04,-30.97)]
 |> filled (rgb 196 224 236) -- the right boot
  |> addOutline (solid 0.5) (rgb 165 184 210)
 ,

 -- the dress peice behing the legs deatails
 
 curve (-57.32,-21.33) [Pull (-62.26,-28.19) (-64,-35.06)]
 |> outlined (solid 1) (rgb 153 145 223)
 ,
 
 curve (-40.62,-24.30) [Pull (-38.12,-31.16) (-38.02,-38.02)]
  |> outlined (solid 1) (rgb 153 145 223)
  |>  move (2,0)
 ,
 
 curve (-34.68,-24.30) [Pull (-31.82,-27.64) (-31.35,-30.97)]
 |> outlined (solid 1) (rgb 153 145 223)
 ,
 -- the shoe deatail
 
 curve (-62.14,-41.73) [Pull (-60.10,-45.80) (-58.06,-45.07)]
 |> outlined (solid 0.3) (rgb 165 184 210)
 ,
 
 curve (-63.25,-42.85) [Pull (-62.73,-44.15) (-61.40,-45.44)]
 |> outlined (solid 0.3) (rgb 165 184 210)
 ,
 
 curve (-58.80,-30.23) [Pull (-57.03,-34.09) (-52.86,-33.94)]
 |> outlined (solid 0.3) (rgb 165 184 210)
 ,
 
 curve (-65.11,-53.24) [Pull (-62.14,-51.88) (-59.17,-52.12)]
 |> outlined (solid 0.3) (rgb 165 184 210)
 ,
 
 curve (-45.44,-53.98) [Pull (-42.60,-53.82) (-41.36,-52.86)]
 |> outlined (solid 0.3) (rgb 165 184 210)
 ,
 
 curve (-48.41,-45.44) [Pull (-46.00,-47.23) (-43.59,-45.82)]
 |> outlined (solid 0.3) (rgb 165 184 210)
 ,
 
 curve (-48.41,-32.83) [Pull (-45.07,-34.40) (-41.73,-33.57)]
 |> outlined (solid 0.3) (rgb 165 184 210) ]
 
 
 -- OUTFIT 3
 
outfit3 skin = group [
  outfit_3dress skin
   |> scale 1.2
   |> move (0,10)
   ,
   pearl_outfit3
   |> scale 1.18
   |> move (-0.3,10)

  ]
outfit_3dress skin = group [
   curve (-7.234,-23.18) [Pull (-6.805,-25.04) (-7.976,-26.89),Pull (-9.860,-29.68) (-10.94,-32.46),Pull (-8.991,-38.16) (-4.637,-35.06),Pull (-1.211,-27.09) (-0.185,-23.93),Pull (-3.385,-17.93) (-7.234,-23.18)]
  |> filled skin -- the left leg
  ,
  
 curve (2.7826,-23.93) [Pull (2.2260,-28.01) (1.6695,-32.09),Pull (1.4840,-34.31) (1.2985,-36.54),Pull (4.6376,-39.13) (7.9768,-36.91),Pull (7.7043,-30.05) (9.8318,-23.18),Pull (5.4318,-19.18) (2.7826,-23.93)]
  |> filled skin -- the right leg
  
  ,  curve (-11.68,8.7188) [Pull (-13.20,6.3072) (-13.91,3.8956),Pull (-16.75,0.4289) (-17.99,-4.637),Pull (-22.16,-5.692) (-23.93,-8.347),Pull (-25.33,-10.34) (-18.73,-8.347),Pull (-18.57,-10.93) (-17.62,-8.718),Pull (-11.41,-0.742) (-7.605,7.2347),Pull (-9.205,10.034) (-11.68,8.7188)]  
  |> filled skin -- the left arm
  ,
  
 curve (10.944,8.7188) [Pull (11.814,5.9362) (14.284,3.1536),Pull (17.895,-0.371) (19.107,-3.895),Pull (22.075,-4.365) (25.043,-7.234),Pull (25.530,-8.405) (22.817,-7.976),Pull (19.107,-6.492) (15.397,-5.008),Pull (13.171,-2.597) (10.944,-0.185),Pull (9.6463,1.8550) (8.3478,3.8956),Pull (8.5333,5.7507) (8.7188,7.6057),Pull (8.7188,10.405) (10.944,8.7188)]
  |> filled skin -- the right arm
  , 
  curve (-7.234,17.994) [Pull (-5.750,18.765) (-4.266,18.736),Pull (1.7855,13.565) (4.6376,17.994),Pull (10.121,12.8) (7.6057,7.6057),Pull (7.2347,5.5652) (6.8637,3.5246),Pull (10.927,4.3304) (20.591,-6.863),Pull (18.927,-12.60) (6.8637,-13.54),Pull (-8.979,-15.10) (-17.62,-9.460),Pull (-12.30,-0.168) (-5.379,3.5246),Pull (-5.936,5.9362) (-6.492,8.3478),Pull (-6.463,13.171) (-7.234,17.994)]
 |> filled (rgb 185 223 224)
 |> addOutline (solid 0.4) (rgb 169 206 214)-- the main dress peice
 ,
 
 curve (-4.266,18.736) [Pull (-4.637,18.550) (-5.008,18.365),Pull (3.1999,12.365) (5.0086,18.365),Pull (4.4521,18.365) (3.8956,18.365),Pull (2.6956,13.965) (-4.266,18.736)]
 |> filled (rgb 222 233 238) -- the lace around the neck

 
 ,
 
 curve (-12.8,10.944) [Pull (-14.00,10.202) (-12.8,9.4608),Pull (-9.831,7.5478) (-6.863,7.2347),Pull (-6.063,7.7913) (-6.863,8.3478),Pull (-6.678,8.3478) (-12.8,10.944)]
 |> filled (rgb 199 225 229) -- the left arm white sleeve
 
 ,
 curve (-7.234,17.994) [Pull (-9.646,18.168) (-12.05,13.542),Pull (-13.22,12.243) (-12.8,10.944),Pull (-9.646,8.4463) (-6.492,8.3478),Pull (-4.765,10.388) (-4.637,12.428),Pull (-4.736,16.011) (-7.234,17.994)]
 |> filled (rgb 185 223 224) -- the left arm sleeve
 ,
 
 curve (11.315,10.573) [Pull (12.301,10.017) (11.686,9.4608),Pull (11.217,8.5333) (8.3478,7.6057),Pull (7.9478,7.5478) (8.3478,9.0898),Pull (8.3478,10.289) (11.315,10.573)]
 |> filled (rgb 199 225 229) -- the right arm white sleeve
 
 ,
 
 curve (4.6376,18.365) [Pull (7.2347,18.510) (9.8318,14.655),Pull (12.173,12.614) (11.315,10.573),Pull (9.6463,8.6318) (7.9768,9.0898),Pull (6.7072,13.727) (4.6376,18.365)]
 |>filled (rgb 185 223 224) -- the right arm sleeve
 ,
 
 curve (-21.33,-16.88) [Pull (-20.33,-19.75) (-16.13,-20.22),Pull (-10.20,-24.93) (-4.266,-22.44),Pull (1.2985,-25.43) (6.8637,-22.81),Pull (10.944,-24.47) (15.026,-21.33),Pull (18.823,-22.40) (20.220,-19.47),Pull (25.402,-19.00) (25.785,-16.13),Pull (25.785,-18.13) (-21.33,-16.88)]
 |>filled (rgb 204 170  244)-- a purple dress piece
 
 ,
 
 curve (-18.73,-13.91) [Pull (-20.03,-15.39) (-21.33,-16.88),Pull (-17.43,-20.15) (-13.54,-20.22),Pull (-8.533,-22.96) (-3.524,-21.70),Pull (1.6695,-24.28) (6.8637,-22.07),Pull (10.944,-23.33) (15.026,-20.59),Pull (17.437,-22.03) (19.849,-19.47),Pull (23.246,-18.82) (25.043,-15.76),Pull (24.486,-14.65) (23.930,-13.54),Pull (23.930,-13.35) (23.930,-13.17),Pull (23.930,-15.97) (-18.73,-13.91)]
 |> filled (rgb 228 202 240) -- the dress piece under the purple dress piece
 
 ,
 
 curve (-15.76,-7.234) [Pull (-14.65,-7.518) (-13.54,-10.20),Pull (-13.44,-11.21) (-10.94,-9.831),Pull (-7.976,-8.915) (-5.008,-12.8),Pull (-3.524,-13.60) (-2.040,-12.8),Pull (0.0985,-9.043) (4.6376,-11.68),Pull (9.2057,-13.13) (10.573,-10.57),Pull (12.8,-8.573) (15.026,-10.57),Pull (16.881,-11.08) (18.736,-7.605),Pull (19.663,-6.434) (20.591,-6.863),Pull (22.817,-7.675) (25.043,-11.68),Pull (23.762,-14.28) (16.881,-16.88),Pull (17.211,-14.32) (13.542,-15.76),Pull (7.7797,-20.69) (-2.782,-17.62),Pull (-5.234,-20.29) (-11.68,-15.76),Pull (-12.98,-14.13) (-14.28,-16.51),Pull (-15.58,-15.95) (-16.88,-15.39),Pull (-19.10,-13.29) (-21.33,-12.8),Pull (-19.47,-11.13) (-17.62,-9.460),Pull (-18.02,-9.460) (-15.76,-7.234)]
 |> filled (rgb 205 168 248)-- the purple dress part
 ,
 
 curve (0.9275,5.3797) [Pull (2.0405,6.5797) (3.1536,5.3797),Pull (3.7681,4.2666) (2.7826,3.1536),Pull (2.0405,2.5391) (1.2985,3.5246),Pull (0.7130,4.4521) (0.9275,5.3797)]
 |> filled (rgb 205 167 243)-- the circle of the bow
 |> addOutline (solid 0.3) (rgb 175 135 232)
 ,
 
 curve (2.7826,5.3797) [Pull (6.7942,10.736) (7.6057,6.4927),Pull (8.5913,3.5246) (7.9768,0.5565),Pull (6.1797,-1.344) (2.7826,3.1536),Pull (2.7826,3.1536) (2.7826,5.3797)]
 |> filled (rgb 205 167 243)
 |> addOutline (solid 0.3) (rgb 175 135 232)-- the right part of the bow
 ,
 
 curve (0.9275,5.3797) [Pull (-4.069,10.365) (-4.266,5.7507),Pull (-4.695,3.1536) (-3.524,0.5565),Pull (-1.513,-2.144) (1.2985,3.1536),Pull (1.2985,3.1536) (0.9275,5.3797)]
 |> filled (rgb 205 167 243)
 |> addOutline (solid 0.3) (rgb 175 135 232)-- the left part of the bow
 ,
 
 curve (-13.91,-43.22) [Pull (-15.61,-43.23) (-16.51,-48.04),Pull (-17.31,-49.34) (-16.51,-50.64),Pull (-15.95,-50.82) (-15.39,-51.01),Pull (-13.66,-47.11) (-13.91,-43.22)]
 |> filled (rgb 190 229 226)
 |> addOutline (solid 0.4) (rgb 177 210 214)-- the left boots heel
 ,
 
 curve (-15.02,-54.35) [Pull (-13.84,-57.83) (-9.460,-57.32),Pull (-6.475,-56.29) (-9.089,-52.86),Pull (-11.48,-48.86) (-15.02,-54.35)]
 |> filled (rgb 234 242 245)
 |> addOutline (solid 0.5) (rgb 210 226 231)-- the front of the left boot
 
 ,
 
 curve (-10.94,-32.09) [Pull (-9.791,-35.76) (-4.637,-35.43),Pull (-8.649,-40.81) (-9.460,-46.19),Pull (-9.889,-49.71) (-8.718,-53.24),Pull (-11.31,-51.02) (-13.91,-53.61),Pull (-14.46,-53.98) (-15.02,-54.35),Pull (-16.01,-51.94) (-15.39,-49.53),Pull (-15.58,-49.53) (-15.76,-49.53),Pull (-14.65,-46.19) (-13.54,-42.85),Pull (-13.44,-37.84) (-10.94,-32.83)]
 |> filled (rgb 190 229 226)
 |> addOutline (solid 0.4) (rgb 177 210 214)-- the left boot
 ,
 
 curve (8.7188,-53.24) [Pull (12.788,-54.29) (12.057,-56.95),Pull (8.1623,-59.80) (4.2666,-55.46),Pull (8.2666,-50.88) (8.7188,-53.24)]
 |> filled (rgb 234 242 245)
 |> addOutline (solid 0.5) (rgb 210 226 231)-- the front of the right boot
 
 ,
 
 curve (1.2985,-36.17) [Pull (4.6376,-37.74) (7.9768,-36.91),Pull (7.2347,-42.48) (6.4927,-48.04),Pull (6.9913,-50.64) (9.0898,-53.24),Pull (6.6782,-54.35) (4.2666,-55.46),Pull (3.5246,-54.16) (2.7826,-52.86),Pull (2.7826,-54.35) (2.7826,-55.83),Pull (1.8550,-55.65) (0.9275,-55.46),Pull (0.9275,-53.79) (0.9275,-52.12),Pull (-0.301,-49.90) (1.6695,-47.67),Pull (0.4695,-41.92) (1.2985,-36.17)]
 |> filled (rgb 190 229 226)
 |> addOutline (solid 0.4) (rgb 177 210 214)-- the right boot
 
 ,
 -- the teal main dress deatails
 curve (-3.895,2.0405) [Pull (-7.791,-4.081) (-11.68,-10.20)]
 |> outlined (solid 0.8) (rgb 169 206 214)
 ,
 
 curve (0.5565,0.1855) [Pull (-2.098,-6.492) (-3.153,-13.17)]
  |> outlined (solid 0.8) (rgb 169 206 214) 
 ,
 
 curve (8.3478,-0.185) [Pull (13.286,-5.379) (15.026,-10.57)]
  |> outlined (solid 0.8) (rgb 169 206 214)
  ,
  
 curve (-0.927,13.542) [Pull (0.7420,13.600) (2.4115,12.057),Pull (3.5246,14.000) (4.6376,13.542)]
  |> outlined (solid 0.5) (rgb 169 206 214)
 
 ,
 -- the dress piece under the purple dress piece deatails
 curve (18.365,-16.51) [Pull (19.907,-17.80) (19.849,-19.10)]
  |> outlined (solid 0.5)(rgb 191 159 232) 
 ,
 
 curve (10.573,-17.62) [Pull (12.486,-19.47) (12.8,-21.33)]
  |> outlined (solid 0.5) (rgb 191 159 232)  
  ,
  
 curve (5.3797,-18.73) [Pull (4.7652,-20.40) (5.7507,-22.07)]
  |> outlined (solid 0.5) (rgb 191 159 232) 
 ,
 
 curve (-3.153,-17.62) [Pull (-2.939,-19.66) (-3.524,-21.70)]
   |> outlined (solid 0.5) (rgb 191 159 232) 

 ,
 
 curve (-11.68,-15.39) [Pull (-12.82,-17.80) (-13.17,-20.22)]
  |> outlined (solid 0.5) (rgb 191 159 232)  
  ,
  -- the deatails of the shoes
  
 curve (1.2985,-37.65) [Pull (5.6521,-39.41) (7.6057,-38.77)]
 |> outlined (solid 0.5) (rgb 181 201 232)
 ,
 
 curve (1.6695,-45.82) [Pull (4.2666,-47.97) (6.8637,-46.93)]
 |> outlined (solid 0.5) (rgb 181 201 232)
 ,
 
 curve (-11.68,-33.94) [Pull (-9.304,-38.01) (-6.121,-37.28)]
 |> outlined (solid 0.5) (rgb 181 201 232)
 ,
 
 curve (-13.54,-42.85) [Pull (-11.71,-45.16) (-9.089,-45.07)]
 |> outlined (solid 0.5) (rgb 181 201 232)
 ]
 
pearl_outfit3 = group [
  circle 0.6
  |> filled white
  |> addOutline (solid 0.2) (rgb 225 209 237)
  |> move (-2, 19)
  ,
   circle 0.6
  |> filled white
  |> addOutline (solid 0.2) (rgb 225 209 237)
  |> move (-1, 18.5)
  ,
  circle 0.6
 |> filled white
 |> addOutline (solid 0.2) (rgb 225 209 237)
  |> move (0, 18)
  ,
   circle 0.6
  |> filled white
  |> addOutline (solid 0.2) (rgb 225 209 237)
  |> move (1, 17.9)
  ,
   circle 0.6
 |> filled white
 |> addOutline (solid 0.2) (rgb 225 209 237)
  |> move (2, 18)
  ,
   circle 0.6
  |> filled white
  |> addOutline (solid 0.2) (rgb 225 209 237)
  |> move (3, 18.2)
 
 
 ]
  
-- OUTFIT 4


 
outfit4 skin = group [ 
  curve (42.110,-14.65) [Pull (42.724,-19.66) (41.739,-24.67),Pull (40.255,-26.89) (38.771,-29.12),Pull (42.110,-32.79) (45.449,-32.46),Pull (48.446,-24.67) (50.643,-16.88),Pull (48.243,-10.08) (42.110,-14.65)]
 |> filled skin -- the left leg
  ,
  
 curve (52.869,-16.13) [Pull (51.298,-20.90) (52.127,-27.26),Pull (51.385,-29.31) (50.643,-31.35),Pull (55.368,-32.73) (57.692,-31.72),Pull (57.976,-23.74) (60.660,-15.76),Pull (58.875,-10.56) (52.869,-16.13)]
 |> filled skin -- the right leg
 
 ,   curve (32.834,-5.750) [Pull (29.623,-7.791) (28.011,-9.831),Pull (27.623,-12.04) (32.834,-9.460),Pull (32.191,-12.41) (33.947,-10.57),Pull (35.889,-8.904) (35.431,-7.234),Pull (35.031,-4.220) (32.834,-5.750)] 
 |> filled skin -- the left hand
 ,
 curve (66.597,-5.379) [Pull (69.379,-6.678) (72.162,-7.976),Pull (73.165,-10.74) (66.968,-8.718),Pull (69.368,-10.26) (66.968,-10.20),Pull (64.869,-8.718) (64.371,-7.234),Pull (63.785,-5.234) (66.597,-5.379)]
 |> filled skin -- the right hand
 ,
 curve (37.286,-14.65) [Pull (38.156,-17.61) (40.626,-15.76),Pull (42.295,-18.93) (43.965,-16.51),Pull (46.376,-20.08) (48.788,-17.25),Pull (51.014,-21.25) (53.240,-17.25),Pull (55.866,-20.85) (57.692,-17.25),Pull (60.162,-20.08) (61.031,-16.51),Pull (62.730,-17.76) (63.628,-15.02),Pull (62.515,-12.98) (61.402,-10.94),Pull (61.402,-11.13) (61.402,-11.31),Pull (50.086,-10.94) (38.771,-10.57),Pull (38.028,-12.61) (37.286,-14.65)]    
    |> filled (rgb 193 148 235)
     |> addOutline (solid 0.5) (rgb 196 168 229)-- the  skirt
    ,
 curve (33.576,-4.266) [Pull (31.118,-2.040) (35.060,0.1855),Pull (39.043,7.6057) (40.626,15.026),Pull (42.208,18.382) (46.191,16.139),Pull (49.159,15.397) (52.127,14.655),Pull (54.168,15.582) (56.208,16.510),Pull (58.492,15.484) (59.176,12.057),Pull (61.373,6.3072) (64.371,0.5565),Pull (67.698,-1.669) (66.226,-3.895),Pull (64.742,-5.565) (63.257,-7.234),Pull (62.144,-7.849) (61.031,-6.863),Pull (63.002,-8.533) (61.773,-10.20),Pull (49.872,-15.43) (38.771,-9.460),Pull (39.142,-8.533) (39.513,-7.605),Pull (38.028,-9.205) (36.544,-7.605),Pull (35.460,-5.136) (33.576,-4.266)]
  |> filled (rgb 220 236 249)
  |> addOutline (solid 0.5) (rgb 204 214 239)
  -- the hoodie
    ,
     curve (39.142,-9.460) [Pull (38.556,-10.38) (38.771,-11.31),Pull (52.457,-15.71) (62.144,-11.31),Pull (62.759,-10.75) (61.773,-10.20),Pull (48.973,-15.00) (39.142,-9.460)]
   |> filled (rgb 220 236 249)
   |> addOutline (solid 0.5) (rgb 204 214 239)-- hoodie under
   
   ,
    
 curve (43.594,9.8318) [Pull (44.910,2.9681) (40.626,-3.895),Pull (40.771,-8.950) (36.915,-7.605)]
   |> outlined (solid 0.5) (rgb 204 214 239)-- hoodie under
    
  ,
  curve (51.756,15.397) [Pull (53.727,18.423) (52.498,19.849),Pull (57.739,20.394) (56.579,16.139),Pull (55.553,13.797) (52.127,14.655),Pull (45.547,14.997) (41.368,16.139),Pull (40.997,15.582) (40.626,15.026),Pull (39.194,21.194) (46.562,20.962),Pull (46.991,20.034) (45.820,19.107),Pull (48.788,17.652) (51.756,15.397)] 
 |> filled (rgb 207 184 246) -- the hood of the hoodie
 
 ,
 
 curve (44.707,4.2666) [Pull (53.913,3.6521) (59.918,4.6376),Pull (59.918,3.1536) (59.918,1.6695),Pull (54.313,-1.744) (44.707,2.0405),Pull (46.307,3.1536) (44.707,4.2666)]
 |> filled (rgb 248 222 225)-- the color orange on the shirt
 ,
 curve (44.336,6.4927) [Pull (53.942,5.8782) (59.547,6.8637),Pull (59.547,5.9362) (59.547,5.0086),Pull (54.127,4.0231) (44.707,4.6376),Pull (44.521,5.7507) (44.336,6.4927)]
 |> filled (rgb 235 241 250)-- the color white on the shirt
 ,
 
 curve (45.078,7.9768) [Pull (53.913,7.7623) (59.547,8.3478),Pull (63.142,5.8202) (44.336,6.4927),Pull (44.892,7.2347) (45.078,7.9768)]
 |> filled (rgb 225 208 239)-- the color pink on the shirt
 ,
 
 curve (45.449,9.4608) [Pull (55.698,9.0318) (59.547,10.202),Pull (64.127,7.8898) (44.707,7.9768),Pull (44.892,8.7188) (45.449,9.4608)]
 |> filled (rgb 250 188 202)-- the color red on the shirt
 ,
 
 curve (45.078,1.2985) [Pull (53.484,-1.286) (60.289,0.9275),Pull (61.646,-0.371) (61.402,-1.669),Pull (53.240,-4.869) (45.078,-1.669),Pull (43.878,-0.185) (45.078,1.2985)]
 |> filled (rgb 225 208 239)-- the color pink on the shirt
 
 ,
 
 curve (49.159,9.8318) [Pull (49.171,12.817) (53.982,10.202),Pull (57.223,13.188) (58.063,10.573),Pull (55.611,9.0028) (49.159,9.8318)]
 |> filled (rgb 197 218 250)-- the color blue on the heart
 ,
 
 curve (53.982,10.202) [Pull (57.623,14.631) (58.063,9.4608),Pull (57.994,7.0492) (54.724,4.6376),Pull (49.942,6.0637) (49.159,9.0898),Pull (48.371,14.046) (53.982,10.202)]
 |> outlined (solid 0.8) blue
 |> makeTransparent 0.6-- the heart on the hoodie
 
 ,
 
 curve (38.771,-29.49) [Pull (41.124,-32.76) (45.078,-32.83),Pull (41.281,-38.40) (39.884,-43.96),Pull (39.142,-45.26) (38.4,-46.56),Pull (36.730,-46.56) (35.060,-46.56),Pull (34.133,-45.44) (33.205,-44.33),Pull (34.318,-43.03) (35.431,-41.73),Pull (35.901,-35.61) (38.771,-29.49)]
 |> filled white
 |> addOutline (solid 0.5) (rgb 205 225 238)-- the left sock
 ,
 
 curve (51.014,-31.72) [Pull (54.539,-33.10) (58.063,-32.09),Pull (57.321,-38.40) (56.579,-44.70),Pull (56.208,-46.19) (55.837,-47.67),Pull (54.724,-48.41) (53.611,-49.15),Pull (52.498,-48.23) (51.385,-47.30),Pull (51.385,-46.56) (51.385,-45.82),Pull (51.2,-38.77) (51.014,-31.72)]
 |> filled white
  |> addOutline (solid 0.5) (rgb 205 225 238)-- the right sock
 ,
 
 curve (38.028,-31.35) [Pull (38.4,-30.42) (38.771,-29.49),Pull (40.939,-32.95) (44.707,-33.20),Pull (43.965,-34.31) (43.223,-35.43),Pull (40.440,-35.17) (38.028,-31.35)]
 |> filled (rgb 208 235 243)-- the left socks blue
 ,
 
 curve (36.915,-33.57) [Pull (39.698,-37.06) (42.481,-36.54),Pull (42.110,-37.65) (41.739,-38.77),Pull (38.956,-39.28) (36.173,-35.80),Pull (37.344,-34.68) (36.915,-33.57)]
 |> filled (rgb 208 235 243)-- the left socks blue
  ,
  
 curve (35.802,-38.4) [Pull (38.214,-41.11) (40.626,-40.62),Pull (40.440,-41.55) (40.255,-42.48),Pull (37.843,-43.92) (35.431,-41.36),Pull (35.617,-40.06) (35.802,-38.4)]
 |> filled (rgb 208 235 243)-- the left socks blue
 ,
 
 curve (35.431,-42.48) [Pull (35.617,-43.40) (35.802,-44.33),Pull (35.617,-44.70) (35.431,-45.07),Pull (34.875,-44.33) (34.318,-43.59),Pull (34.689,-42.85) (35.431,-42.48)]
 |> filled (rgb 208 235 243)-- the left socks blue
 ,
 
 curve (51.014,-33.94) [Pull (54.353,-35.91) (57.692,-34.68),Pull (57.692,-33.39) (57.692,-32.09),Pull (55.953,-32.70) (51.014,-31.72),Pull (51.014,-32.83) (51.014,-33.94)]
 |> filled (rgb 208 235 243)-- the right socks blue
 ,
 
 curve (51.014,-36.17) [Pull (54.168,-37.15) (57.321,-36.54),Pull (57.136,-37.84) (56.950,-39.14),Pull (54.168,-39.97) (51.385,-38.4),Pull (51.385,-37.28) (51.014,-36.17)]
 |> filled (rgb 208 235 243)-- the right socks blue
 ,
 
 curve (51.385,-40.25) [Pull (54.168,-42.22) (56.950,-40.99),Pull (56.765,-42.29) (56.579,-43.59),Pull (53.982,-44.42) (51.385,-42.85),Pull (51.385,-41.36) (51.385,-40.25)]
 |> filled (rgb 208 235 243)-- the right socks blue
 ,
 
 curve (51.385,-44.33) [Pull (53.982,-46.52) (56.579,-44.70),Pull (56.208,-45.82) (55.837,-46.93),Pull (53.611,-47.36) (51.385,-46.19),Pull (51.385,-45.26) (51.385,-44.33)]
 |> filled (rgb 208 235 243)-- the right socks blue
 ,
 
 curve (32.463,-46.93) [Pull (31.234,-49.15) (33.205,-51.38),Pull (33.617,-57.15) (38.028,-57.32),Pull (39.884,-57.32) (41.739,-57.32),Pull (43.310,-56.02) (42.481,-54.72),Pull (37.472,-50.82) (32.463,-46.93)]
 |> filled (rgb 222 207 248)
 |> addOutline (solid 0.4)(rgb 166 147 204)-- the left shoe heel
 
 ,
 
 curve (38.771,-47.30) [Pull (40.498,-46.00) (40.626,-44.70),Pull (38.428,-43.10) (35.431,-44.70),Pull (35.246,-46.00) (35.060,-47.30),Pull (35.246,-44.52) (35.431,-41.73),Pull (32.747,-42.55) (32.463,-46.56),Pull (32.562,-50.08) (35.060,-53.61),Pull (36.730,-55.52) (38.4,-55.83),Pull (44.284,-56.96) (41.368,-52.49),Pull (38.811,-49.53) (40.255,-46.56),Pull (40.069,-46.19) (38.771,-47.30)]
 |> filled (rgb 245 185 237)
 |> addOutline (solid 0.5)(rgb 235 178 239)-- the left shoe
 ,
 
 curve (49.901,-49.90) [Pull (49.571,-53.75) (53.240,-53.61),Pull (56.278,-58.08) (62.515,-56.95),Pull (64.086,-55.83) (63.257,-54.72),Pull (56.579,-52.31) (49.901,-49.90)]
 |> filled (rgb 222 207 248)
 |> addOutline (solid 0.4)(rgb 166 147 204)-- the right shoe heel
 ,
 
 curve (57.321,-47.67) [Pull (58.307,-46.19) (57.692,-44.70),Pull (55.837,-44.49) (53.982,-45.07),Pull (53.553,-46.93) (54.724,-48.78),Pull (52.040,-49.24) (51.756,-47.30),Pull (51.571,-46.00) (51.385,-44.70),Pull (50.614,-43.69) (50.643,-45.07),Pull (50.457,-46.56) (50.272,-48.04),Pull (48.927,-52.45) (53.982,-52.86),Pull (58.434,-57.18) (62.886,-55.09),Pull (64.173,-53.61) (60.660,-52.12),Pull (57.976,-48.91) (57.321,-47.67)]
 |> filled (rgb 245 185 237)
 |> addOutline (solid 0.5)(rgb 235 178 239)-- the right shoe
 ,
 
 curve (36.173,-54.72) [Pull (39.142,-52.16) (42.110,-53.61),Pull (43.542,-57.36) (36.173,-54.72)]
 |> filled (rgb 251 250 253)-- the left shoe white part
 ,
 
 curve (58.063,-55.09) [Pull (58.718,-53.39) (61.773,-52.49),Pull (65.518,-56.19) (58.063,-55.09)]
 |> filled (rgb 251 250 253)-- the right shoe white part
 ,
 

 curve (32.463,-6.121) [Pull (35.147,-5.634) (35.431,-8.347),Pull (36.359,-9.176) (37.286,-7.605),Pull (36.660,-4.336) (32.834,-4.266),Pull (31.634,-5.194) (32.834,-6.121)] 
 
 |> filled (rgb 199 214 244) -- the bottom of the left sleeve
 ,
 

 curve (64.371,-7.605) [Pull (64.869,-6.492) (66.968,-5.379),Pull (66.597,-4.637) (66.226,-3.895),Pull (60.713,-6.336) (64.371,-7.605)] 
 |> filled (rgb 199 214 244) -- the bottom of the right sleeve
 ,
 -- laces of the left shoe
 curve (39.884,-47.67) [Pull (38.028,-47.48) (36.173,-47.30),Pull (35.043,-48.66) (39.513,-48.41),Pull (39.698,-48.04) (39.884,-47.67)]
 |> filled (rgb 251 250 253)
 ,
 
 curve (36.544,-48.78) [Pull (35.930,-49.34) (36.915,-49.90),Pull (38.4,-49.90) (39.884,-49.90),Pull (39.814,-48.35) (36.544,-48.78)]
 |> filled (rgb 251 250 253)
 ,
 
 curve (36.544,-50.64) [Pull (38.4,-50.24) (40.255,-50.64),Pull (39.199,-51.84) (36.544,-50.64)]
 |>filled (rgb 251 250 253)
 ,
 
 curve (36.915,-51.38) [Pull (38.771,-51.38) (40.626,-51.38),Pull (40.626,-51.75) (40.626,-52.12),Pull (38.956,-52.12) (37.286,-52.12),Pull (37.286,-52.12) (36.915,-51.38)]
 |> filled (rgb 251 250 253)
 ,
  -- laces of the right shoe
 
 curve (54.724,-48.41) [Pull (56.023,-48.23) (57.321,-48.04),Pull (57.507,-48.23) (57.692,-48.41),Pull (57.008,-49.58) (54.724,-49.15),Pull (54.724,-48.78) (54.724,-48.41)]
 |> filled (rgb 251 250 253)
 ,
 
 curve (55.095,-50.27) [Pull (56.765,-48.91) (58.434,-49.15),Pull (58.620,-49.71) (58.805,-50.27),Pull (57.136,-49.65) (55.466,-50.64),Pull (55.281,-50.45) (55.095,-50.27)]
 |> filled (rgb 251 250 253)
 ,
 
 curve (55.837,-51.38) [Pull (56.892,-49.81) (59.547,-50.64),Pull (59.733,-50.82) (59.918,-51.01),Pull (58.249,-51.38) (56.579,-51.75),Pull (56.579,-51.75) (55.837,-51.38)]
 |> filled (rgb 251 250 253)
 ,
 
 curve (57.692,-52.49) [Pull (58.991,-52.12) (60.289,-51.75),Pull (60.475,-51.94) (60.660,-52.12),Pull (59.547,-52.49) (58.434,-52.86),Pull (58.063,-52.68) (57.692,-52.49)]
 |> filled (rgb 251 250 253) 
 
 ]
 
-- OUTFIT 5

outfit5 skin = group [

   dress_outfit5 skin
 ,
 right_shoe_outfit5
 |> move (-55,-2)
 ,
 left_shoe_outfit5
 |> move (-54.5,0)

  ]

dress_outfit5 skin = group [ 

  curve (-18.73,-3.153) [Pull (-19.10,-4.266) (-19.47,-5.379),Pull (-21.88,-5.478) (-24.30,-7.976),Pull (-25.28,-9.962) (-19.47,-8.347),Pull (-18.29,-7.904) (-19.10,-9.460),Pull (-19.95,-11.43) (-17.99,-10.20),Pull (-15.91,-7.234) (-15.02,-4.266),Pull (-16.22,-1.052) (-18.73,-3.153)]
 |> filled skin -- left hand
 ,
 curve (12.428,-3.153) [Pull (13.399,-3.895) (13.171,-4.637),Pull (16.139,-5.121) (19.107,-7.605),Pull (19.652,-9.191) (15.397,-7.976),Pull (14.655,-7.976) (13.913,-7.976),Pull (13.913,-7.976) (13.913,-7.976),Pull (16.513,-10.31) (13.913,-9.460),Pull (10.872,-7.049) (9.8318,-4.637),Pull (9.7304,-2.295) (12.428,-3.153)]
 |> filled skin -- right hand
 ,

 curve (-12.05,-16.51) [Pull (-7.605,-17.25) (-3.153,-17.99),Pull (-4.878,-26.89) (-10.20,-35.80),Pull (-15.57,-38.14) (-16.13,-32.09),Pull (-10.69,-25.50) (-12.05,-16.51)]
 |> filled skin -- left leg
 ,
 curve (-1.669,-17.62) [Pull (2.5971,-16.63) (6.8637,-17.25),Pull (4.0086,-27.45) (3.1536,-37.65),Pull (-0.371,-40.08) (-3.895,-36.91),Pull (-1.582,-29.86) (-1.669,-17.62)]
 |> filled skin -- right leg
 
 ,
  curve (-7.234,17.994) [Pull (-12.18,17.797) (-13.54,12.8),Pull (-16.09,5.9362) (-19.84,-0.927),Pull (-20.06,-2.040) (-19.47,-3.153),Pull (-16.88,-2.481) (-14.28,-5.008),Pull (-10.67,0.5565) (-9.460,6.1217),Pull (-9.275,4.4521) (-9.089,2.7826),Pull (-8.718,1.1130) (-8.347,-0.556),Pull (-0.742,-1.113) (6.8637,-1.669),Pull (7.1913,-3.710) (8.7188,-5.750),Pull (10.515,-3.066) (13.913,-2.782),Pull (12.886,0.9275) (9.4608,4.6376),Pull (7.8347,10.202) (5.0086,15.768),Pull (3.6260,18.095) (-0.556,17.623),Pull (-0.556,17.437) (-7.234,17.994)]
 |> filled (rgb 248 236 243)
 |> addOutline (solid 0.4) (rgb 218 208 224)-- the shirt under the overall
 ,
 curve (-9.460,6.8637) [Pull (-8.718,8.5333) (-7.976,10.202),Pull (-6.863,13.542) (-5.750,16.881),Pull (-2.226,16.695) (1.2985,16.510),Pull (3.3391,8.7188) (5.3797,0.9275),Pull (-1.669,2.0405) (-8.718,3.1536),Pull (-9.089,5.0086) (-9.460,6.8637)]
 |> filled (rgb 248 193 225) -- the shirt desgin under the overall
 
 ,
 -- the stripes on the left arm
 curve (-19.10,-0.556) [Pull (-16.12,-0.855) (-13.54,-3.153),Pull (-13.51,-4.124) (-14.28,-3.895),Pull (-16.08,-1.597) (-19.47,-1.298),Pull (-20.07,-0.898) (-19.10,-0.556)]
 |> filled (rgb 243 208 227) -- pink stripe
 ,
 curve (-17.99,2.4115) [Pull (-14.02,1.7275) (-12.05,-0.556),Pull (-12.02,-1.327) (-12.8,-1.298),Pull (-14.78,0.7855) (-18.36,1.6695),Pull (-18.36,1.6695) (-17.99,2.4115)]
 |> filled (rgb 244 221 193) -- orange stripe
 ,
 curve (-10.57,2.7826) [Pull (-12.74,5.2811) (-16.51,5.3797),Pull (-16.69,4.8231) (-16.88,4.2666),Pull (-13.91,4.3536) (-10.94,2.0405),Pull (-10.94,2.0405) (-10.57,2.7826)]
 |> filled (rgb 243 208 227) -- pink stripe
 ,
 curve (-14.65,9.8318) [Pull (-11.25,9.3478) (-9.460,6.8637),Pull (-9.231,6.1217) (-10.20,5.3797),Pull (-11.80,8.0637) (-15.39,8.3478),Pull (-15.21,8.3478) (-14.65,9.8318)]
 |> filled (rgb 244 221 193) -- orange stripe
 ,
 curve (-13.17,12.8) [Pull (-10.75,12.501) (-8.347,10.202),Pull (-7.576,11.130) (-7.605,12.057),Pull (-9.217,14.356) (-12.42,14.655),Pull (-13.22,14.055) (-13.17,12.8)]
 |> filled (rgb 243 208 227) -- pink stripe
 ,
 curve (-10.94,16.510) [Pull (-9.089,14.655) (-7.234,12.8),Pull (-7.420,14.469) (-7.605,16.139),Pull (-9.275,16.510) (-10.94,16.510)]
 |> filled (rgb 244 221 193) -- orange stripe
 ,
 -- the right arm stripes
 curve (7.9768,-3.153) [Pull (10.573,-0.440) (13.171,-0.927),Pull (13.356,-1.484) (13.542,-2.040),Pull (11.130,-1.568) (8.7188,-3.895),Pull (7.1333,-3.895) (7.9768,-3.153)]
 |> filled (rgb 244 221 193) -- orange stripe
 ,
 curve (6.8637,-0.185) [Pull (8.2753,2.7275) (11.686,2.0405),Pull (11.872,1.2985) (12.057,0.5565),Pull (9.2608,1.2144) (6.8637,-0.927),Pull (5.0637,-0.927) (6.8637,-0.185)] 
 |> filled (rgb 243 208 227) -- pink stripe
 ,
  curve (6.1217,4.6376) [Pull (7.6057,5.9942) (9.0898,5.7507),Pull (9.2753,5.1942) (9.4608,4.6376),Pull (7.9768,4.2956) (6.4927,3.1536),Pull (4.9072,3.8956) (6.1217,4.6376)]
 |> filled (rgb 244 221 193) -- orange stripe
 ,
 curve (5.7507,7.9768) [Pull (7.0492,9.1478) (8.3478,8.7188),Pull (8.3478,8.1623) (8.3478,7.6057),Pull (7.0492,7.8202) (5.7507,7.2347),Pull (4.5507,7.6057) (5.7507,7.9768)]
 |> filled (rgb 243 208 227) -- pink stripe
 ,
 curve (4.6376,10.202) [Pull (5.7507,10.759) (6.8637,11.315),Pull (7.2492,10.759) (7.2347,10.202),Pull (5.9362,9.8318) (4.6376,9.4608),Pull (4.6376,10.017) (4.6376,10.202)]
 |> filled (rgb 244 221 193) -- orange stripe
 ,
 curve (-10.57,17.252) [Pull (-7.918,16.055) (-6.863,12.057),Pull (-6.733,4.0347) (-10.20,2.4115),Pull (-10.20,0.9275) (-10.20,-0.556),Pull (-10.20,-0.556) (-10.20,-0.556),Pull (-3.255,-4.913) (6.4927,-1.669),Pull (7.3652,6.6086) (4.6376,11.686),Pull (4.7246,15.855) (2.4115,17.623),Pull (1.6695,17.623) (0.9275,17.623),Pull (2.2695,15.026) (2.4115,12.428),Pull (-1.113,12.428) (-4.637,12.428),Pull (-5.321,16.411) (-7.605,17.994),Pull (-7.605,17.994) (-10.57,17.252)]
 |> filled (rgb 161 210 213) -- the top of the overall
 ,
 curve (-10.20,-0.556) [Pull (-1.669,-0.927) (6.8637,-1.298),Pull (9.7478,-7.420) (9.8318,-13.54),Pull (6.2666,-17.85) (-1.298,-15.76),Pull (-10.77,-17.89) (-14.65,-12.42),Pull (-12.82,-5.092) (-10.20,-0.556)]
  |> filled (rgb 161 210 213) -- the bottom of the overall
 |> addOutline (solid 0.3) (rgb 126 187 193) 
 ,
 curve (-3.895,9.0898) [Pull (0,9.0898) (3.8956,9.0898),Pull (5.0405,0.3942) (0.1855,1.2985),Pull (-4.626,1.8376) (-4.637,7.9768),Pull (-4.637,8.5333) (-4.637,9.0898),Pull (-4.637,9.0898) (-3.895,9.0898)]
 |> outlined (solid 0.3) (rgb 126 187 193) -- the pouch on top of the overall
 ,
 curve (-5.750,11.686) [Pull (-5.008,13.286) (-4.266,11.686),Pull (-5.008,10.872) (-5.750,11.686)]
 |> filled (rgb 250 155 214) -- left button
 ,
 curve (3.1536,11.686) [Pull (3.7101,12.686) (4.2666,11.686),Pull (3.7101,10.486) (3.1536,11.686)]
 |> filled (rgb 250 155 214) -- right button
 ,
 curve (-5.379,-0.927) [Pull (-6.104,-6.095) (-12.42,-6.863),Pull (-12.61,-6.863) (-12.8,-6.863),Pull (-12.98,-7.420) (-13.17,-7.976),Pull (-5.347,-7.252) (-3.524,-0.927),Pull (-4.452,-0.927) (-5.379,-0.927)]
 |> outlined (solid 0.3) (rgb 126 187 193) -- left pocket 
 ,
 curve (4.2666,-1.298) [Pull (5.1072,-5.524) (8.3478,-5.750),Pull (8.3478,-6.121) (8.3478,-6.492),Pull (4.1362,-5.881) (3.5246,-1.669),Pull (3.8956,-1.284) (4.2666,-1.298)]
 |>outlined (solid 0.3) (rgb 126 187 193)-- right pocket 
 ,
 curve (-0.556,-12.05) [Pull (-0.527,-13.54) (-1.298,-15.02)]
 |>outlined (solid 0.3) (rgb 126 187 193)-- middle 
 ,
 curve (-0.556,-0.927) [Pull (1.4144,-4.637) (0.1855,-8.347),Pull (0.9275,-9.147) (1.6695,-8.347),Pull (2.0985,-4.823) (0.9275,-1.298),Pull (0.9275,-1.298) (-0.556,-0.927)] 
 |>outlined (solid 0.3) (rgb 126 187 193)-- middle 
 ,
 curve (-14.65,-12.42) [Pull (-7.976,-16.11) (-1.298,-15.39),Pull (-0.098,-16.51) (-1.298,-17.62),Pull (-9.362,-18.92) (-15.02,-15.02),Pull (-14.84,-13.72) (-14.65,-12.42)]
 |> filled (rgb 223 239 239)
 |> addOutline (solid 0.5) (rgb 194 225 225)-- left foldover
 ,
 curve (-1.298,-15.02) [Pull (5.4666,-16.69) (9.8318,-13.17),Pull (11.188,-13.66) (10.944,-15.76),Pull (7.0231,-18.49) (-1.298,-17.62),Pull (-1.298,-16.32) (-1.298,-15.02)]
 |> filled (rgb 223 239 239)
 |> addOutline (solid 0.5) (rgb 194 225 225)-- right foldover
 ,
 curve (-16.13,-32.46) [Pull (-14.38,-36.13) (-9.831,-35.80),Pull (-12.45,-40.44) (-14.28,-45.07),Pull (-15.58,-46.00) (-16.88,-46.93),Pull (-21.79,-47.29) (-19.10,-42.85),Pull (-17.83,-36.45) (-16.13,-32.46)]
 |> filled (rgb 245 244 246) -- left sock
 ,
 curve (-16.88,-34.68) [Pull (-14.92,-37.37) (-10.57,-37.65),Pull (-10.20,-36.73) (-9.831,-35.80),Pull (-14.58,-36.53) (-16.13,-32.46),Pull (-16.51,-33.57) (-16.88,-34.68)]
 |> filled (rgb 207 234 247) -- top of the sock
 ,
 curve (-17.25,-36.17) [Pull (-16.46,-39.04) (-11.68,-39.51),Pull (-12.24,-40.25) (-12.8,-40.99),Pull (-16.19,-40.91) (-17.99,-38.02),Pull (-17.43,-37.28) (-17.25,-36.17)]
 |> filled (rgb 179 223 225) -- left sock stripe 1
 ,
 curve (-18.36,-40.62) [Pull (-15.95,-42.75) (-13.54,-42.48),Pull (-13.51,-43.40) (-14.28,-44.33),Pull (-17.31,-43.80) (-18.73,-42.48),Pull (-18.75,-41.55) (-18.36,-40.62)]
 |> filled (rgb 179 223 225) -- left sock stripe 2
 ,
 curve (-3.524,-36.91) [Pull (-0.185,-38.88) (3.1536,-37.65),Pull (2.5971,-42.66) (2.0405,-47.67),Pull (1.1130,-49.15) (0.1855,-50.64),Pull (-2.040,-50.27) (-4.266,-49.90),Pull (-3.495,-43.40) (-3.524,-36.91)]
 |> filled (rgb 245 244 246) -- right sock
 ,
 curve (-3.524,-36.91) [Pull (-0.185,-39.48) (3.1536,-37.65),Pull (2.9681,-38.77) (2.7826,-39.88),Pull (-1.971,-40.32) (-3.524,-38.77),Pull (-3.524,-37.84) (-3.524,-36.91)]
 |> filled (rgb 207 234 247) -- top of the sock
 ,
 curve (-3.524,-40.62) [Pull (-0.371,-41.99) (2.7826,-41.36),Pull (2.5971,-42.48) (2.4115,-43.59),Pull (-0.556,-44.02) (-3.524,-42.85),Pull (-3.524,-41.73) (-3.524,-40.62)]
 |> filled (rgb 179 223 225)-- right sock stripe 1
 ,
 curve (-3.524,-44.70) [Pull (-0.556,-46.07) (2.4115,-45.44),Pull (2.2260,-46.37) (2.0405,-47.30),Pull (-0.742,-46.93) (-3.524,-46.56),Pull (-3.724,-46.03) (-3.524,-44.70)]
 |> filled (rgb 179 223 225) -- right sock stripe 2
 ,
 curve (-3.895,-47.67) [Pull (-2.411,-48.04) (-0.927,-48.41),Pull (-0.927,-48.97) (-0.927,-49.53),Pull (-2.226,-49.53) (-3.524,-49.53),Pull (-3.524,-48.60) (-3.895,-47.67)]
 |> filled (rgb 179 223 225) -- right sock stripe 3
 
  ]
right_shoe_outfit5 = group [

 curve (49.901,-49.90) [Pull (49.571,-53.75) (53.240,-53.61),Pull (56.278,-58.08) (62.515,-56.95),Pull (64.086,-55.83) (63.257,-54.72),Pull (56.579,-52.31) (49.901,-49.90)]
 |> filled (rgb 228 224 241)
 |> addOutline (solid 0.2)(rgb 174 173 208)-- the right shoe heel
 ,
 curve (57.321,-47.67) [Pull (58.307,-46.19) (57.692,-44.70),Pull (55.837,-44.49) (53.982,-45.07),Pull (53.553,-46.93) (54.724,-48.78),Pull (52.040,-49.24) (51.756,-47.30),Pull (51.571,-46.00) (51.385,-44.70),Pull (50.614,-43.69) (50.643,-45.07),Pull (50.457,-46.56) (50.272,-48.04),Pull (48.927,-52.45) (53.982,-52.86),Pull (58.434,-57.18) (62.886,-55.09),Pull (64.173,-53.61) (60.660,-52.12),Pull (57.976,-48.91) (57.321,-47.67)]
 |> filled (rgb 233 199 238)
 |> addOutline (solid 0.5)(rgb 212 231 236)-- the right shoe
 ,
 curve (58.063,-55.09) [Pull (58.718,-53.39) (61.773,-52.49),Pull (65.518,-56.19) (58.063,-55.09)]
 |> filled (rgb 251 250 253)-- the right shoe white part
 ,
  -- laces of the right shoe
 curve (54.724,-48.41) [Pull (56.023,-48.23) (57.321,-48.04),Pull (57.507,-48.23) (57.692,-48.41),Pull (57.008,-49.58) (54.724,-49.15),Pull (54.724,-48.78) (54.724,-48.41)]
 |> filled (rgb 251 250 253)
 ,
 curve (55.095,-50.27) [Pull (56.765,-48.91) (58.434,-49.15),Pull (58.620,-49.71) (58.805,-50.27),Pull (57.136,-49.65) (55.466,-50.64),Pull (55.281,-50.45) (55.095,-50.27)]
 |> filled (rgb 251 250 253)
 ,
 curve (55.837,-51.38) [Pull (56.892,-49.81) (59.547,-50.64),Pull (59.733,-50.82) (59.918,-51.01),Pull (58.249,-51.38) (56.579,-51.75),Pull (56.579,-51.75) (55.837,-51.38)]
 |> filled (rgb 251 250 253)
 ,
 curve (57.692,-52.49) [Pull (58.991,-52.12) (60.289,-51.75),Pull (60.475,-51.94) (60.660,-52.12),Pull (59.547,-52.49) (58.434,-52.86),Pull (58.063,-52.68) (57.692,-52.49)]
 |> filled (rgb 251 250 253) ]

left_shoe_outfit5 = group [
 curve (32.463,-46.93) [Pull (31.234,-49.15) (33.205,-51.38),Pull (33.617,-57.15) (38.028,-57.32),Pull (39.884,-57.32) (41.739,-57.32),Pull (43.310,-56.02) (42.481,-54.72),Pull (37.472,-50.82) (32.463,-46.93)]
 |> filled (rgb 228 224 241)
 |> addOutline (solid 0.2)(rgb 174 173 208)-- the left shoe heel
  ,
  curve (38.771,-47.30) [Pull (40.498,-46.00) (40.626,-44.70),Pull (38.428,-43.10) (35.431,-44.70),Pull (35.246,-46.00) (35.060,-47.30),Pull (35.246,-44.52) (35.431,-41.73),Pull (32.747,-42.55) (32.463,-46.56),Pull (32.562,-50.08) (35.060,-53.61),Pull (36.730,-55.52) (38.4,-55.83),Pull (44.284,-56.96) (41.368,-52.49),Pull (38.811,-49.53) (40.255,-46.56),Pull (40.069,-46.19) (38.771,-47.30)]
 |> filled (rgb 233 199 238)
 |> addOutline (solid 0.5)(rgb 212 231 236)-- the left shoe
 ,
 curve (36.173,-54.72) [Pull (39.142,-52.16) (42.110,-53.61),Pull (43.542,-57.36) (36.173,-54.72)]
 |> filled (rgb 251 250 253)-- the left shoe white part
 ,
  -- laces of the left shoe
 curve (39.884,-47.67) [Pull (38.028,-47.48) (36.173,-47.30),Pull (35.043,-48.66) (39.513,-48.41),Pull (39.698,-48.04) (39.884,-47.67)]
 |> filled (rgb 251 250 253)
 ,
 curve (36.544,-48.78) [Pull (35.930,-49.34) (36.915,-49.90),Pull (38.4,-49.90) (39.884,-49.90),Pull (39.814,-48.35) (36.544,-48.78)]
 |> filled (rgb 251 250 253)
 ,
 curve (36.544,-50.64) [Pull (38.4,-50.24) (40.255,-50.64),Pull (39.199,-51.84) (36.544,-50.64)]
 |>filled (rgb 251 250 253)
 ,
 curve (36.915,-51.38) [Pull (38.771,-51.38) (40.626,-51.38),Pull (40.626,-51.75) (40.626,-52.12),Pull (38.956,-52.12) (37.286,-52.12),Pull (37.286,-52.12) (36.915,-51.38)]
 |> filled (rgb 251 250 253)
  ]
  
-- OUTFIT 6

outfit6 skin = group [
  curve (-8.393,30.426) [Pull (-5.245,28.526) (-2.098,28.627),Pull (-2.098,27.728) (-2.098,26.829),Pull (-2.098,26.679) (-2.098,26.529),Pull (-0.899,26.529) (0.2997,26.529),Pull (4.9778,26.540) (5.0960,24.430),Pull (6.7346,19.185) (8.6932,13.939),Pull (12.840,8.5939) (16.786,1.6487),Pull (20.234,0.0901) (23.681,-1.948),Pull (23.213,-3.848) (18.585,-1.948),Pull (18.355,-2.847) (18.885,-4.346),Pull (19.256,-5.947) (14.988,-1.348),Pull (11.951,3.5971) (6.5948,8.5433),Pull (5.2654,9.8922) (5.0960,11.241),Pull (4.9461,13.189) (4.7962,15.138),Pull (4.3466,12.590) (3.8969,10.042),Pull (-2.548,10.042) (-8.992,10.042),Pull (-10.04,13.039) (-11.09,16.037),Pull (-11.84,16.037) (-12.59,16.037),Pull (-13.42,12.590) (-14.98,9.1428),Pull (-15.74,6.6044) (-17.38,4.9461),Pull (-19.48,2.3981) (-21.58,-0.149),Pull (-21.79,-2.697) (-24.88,-5.245),Pull (-26.24,-5.907) (-23.68,-2.248),Pull (-28.84,-5.658) (-31.17,-2.548),Pull (-29.95,-0.749) (-23.98,1.0491),Pull (-21.92,6.4449) (-19.18,11.840),Pull (-16.69,17.016) (-15.88,23.231),Pull (-14.65,25.920) (-10.19,26.529),Pull (-9.292,26.978) (-8.393,27.428),Pull (-8.393,28.927) (-8.393,30.426)]
    |>filled skin
    --necklace
  , curve (-9.892,27.128) [Pull (-9.142,27.278) (-8.393,27.428),Pull (-7.184,25.519) (-4.496,24.730),Pull (-0.327,23.949) (-1.199,26.529),Pull (-0.749,26.679) (-0.299,26.829),Pull (0.5508,24.580) (-1.798,23.531),Pull (-5.246,22.481) (-9.892,27.128)]
    |>filled (rgb 200 200 100)
    |>addOutline (solid 0.05) (hsl (degrees 308) 0.441 0.681),
  --sleeve
  curve (-10.19,26.529) [Pull (-12.44,26.799) (-14.68,25.629),Pull (-15.46,24.880) (-15.88,24.131),Pull (-17.04,23.381) (-17.08,22.632),Pull (-17.15,22.332) (-17.98,22.032),Pull (-19.12,20.683) (-17.98,19.334),Pull (-16.48,19.455) (-14.98,18.135),Pull (-14.68,17.965) (-14.38,17.836),Pull (-12.41,18.026) (-12.29,16.936),Pull (-12.16,16.157) (-9.592,16.337),Pull (-7.422,21.583) (-10.19,26.529)]
    |>filled (hsl (degrees 308) 0.441 0.681)
    |>makeTransparent 0.6
    |>addOutline (solid 0.14) (hsl (degrees 280) 0.553 0.676),
  --sleeve
  curve (2.72,25.92) [Pull (3.8400,27.859) (5.92,24.32),Pull (9.3799,22.499) (8.48,20.48),Pull (9.0399,19.68) (8.48,18.88),Pull (7.52,18.000) (6.56,17.92),Pull (6.4399,17.260) (5.6,17.28),Pull (5.5399,19.259) (4.32,20.48),Pull (4.6199,21.339) (3.68,21.44),Pull (3.2,23.68) (2.72,25.92)]
    |>filled (hsl (degrees 308) 0.441 0.681)
    |>makeTransparent 0.6
    |>addOutline (solid 0.14) (hsl (degrees 280) 0.553 0.676),
  curve (-9.76,16.32) [Pull (-11.21,16.120) (-12,16.96),Pull (-12.68,18.039) (-14.24,17.92),Pull (-15.2,18.140) (-16.16,19.2),Pull (-17.11,19.659) (-18.08,19.2),Pull (-18.65,18.4) (-18.08,17.6),Pull (-16.32,17.399) (-14.56,16.32),Pull (-13.28,15.060) (-12,14.72),Pull (-10.50,15.160) (-9.76,16.32)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.12) purple,
  curve (5.6,16.96) [Pull (5.2200,15.84) (4.96,14.72),Pull (5.2800,14.360) (7.84,16),Pull (9.7399,16.840) (9.76,18.24),Pull (9.5399,19.219) (8.48,18.88),Pull (7.52,18.140) (6.56,17.92),Pull (6.4399,17.44) (5.6,16.96)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.12) purple,
  curve (-12.32,26.24) [Pull (-11.2,26.819) (-10.08,26.56),Pull (-7.540,23.68) (-7.2,20.8),Pull (-8,20.48) (-8.8,20.16),Pull (-8.440,23.979) (-12.32,26.24)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.12) purple,
  curve (0.48,26.56) [Pull (1.6,26.759) (2.72,25.92),Pull (3.2,23.68) (3.68,21.44),Pull (3.04,22.139) (2.4,21.76),Pull (2.2000,23.660) (0.48,26.56)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.12) purple,
    --dress1
  curve (-8.48,20.16) [Pull (-4.96,22.839) (-1.44,19.84),Pull (-0.799,18.960) (-0.16,19.84),Pull (0.8199,21.459) (2.4,21.76),Pull (5.9399,21.799) (5.6,17.6),Pull (4.1600,13.760) (4.96,9.92),Pull (-2.4,8.1600) (-9.76,9.92),Pull (-9.840,12.64) (-11.04,15.36),Pull (-9.100,16.760) (-8.48,20.16)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.12) purple,
  curve (5.28,17.28) [Pull (5.4400,17.060) (6.56,17.92),Pull (7.68,17.880) (8.8,18.88),Pull (10.079,18.739) (9.44,17.6),Pull (7.1999,15.500) (4.96,14.4),Pull (4.3800,15.84) (5.28,17.28)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.12) purple,
  --dress2
  curve (-9.76,9.92) [Pull (-13.46,8.4599) (-23.84,-5.44),Pull (-24.53,-6.08) (-23.52,-6.72),Pull (-28.03,-10.57) (-26.4,-11.52),Pull (-29.54,-15.84) (-33.76,-20.16),Pull (-33.90,-20.71) (-33.44,-20.8),Pull (-36.66,-22.83) (-34.08,-23.04),Pull (-36.64,-26.11) (-39.2,-28.48),Pull (-41.14,-29.89) (-39.52,-30.4),Pull (-41.65,-33.44) (-44.64,-36.48),Pull (-45.48,-37.59) (-44.64,-38.72),Pull (-43.36,-39.78) (-42.08,-40.32),Pull (-42.86,-41.12) (-43.04,-41.92),Pull (-43.88,-43.53) (-39.2,-46.08),Pull (-36.8,-47.04) (-34.4,-46.4),Pull (-32.85,-46.73) (-33.44,-48.32),Pull (-34.44,-50.02) (-30.56,-51.2),Pull (-28.16,-51.98) (-25.76,-50.56),Pull (-24.49,-53.20) (-17.76,-53.44),Pull (-14.08,-53.46) (-10.4,-52.48),Pull (-8.8,-51.57) (-7.2,-52.48),Pull (-0.800,-54.60) (5.6,-51.2),Pull (6.0999,-50.56) (5.6,-49.92),Pull (6.4,-48.89) (7.2,-49.92),Pull (16.699,-49.60) (15.2,-46.08),Pull (14.780,-45.59) (15.2,-45.12),Pull (19.52,-46.58) (23.84,-43.2),Pull (24.339,-42.24) (23.2,-41.28),Pull (27.019,-40.12) (28.32,-37.44),Pull (29.259,-35.2) (27.68,-32.96),Pull (26.320,-31.04) (27.04,-29.12),Pull (26.659,-25.67) (22.88,-20.48),Pull (23.699,-18.88) (23.2,-17.92),Pull (20.020,-13.12) (17.44,-8.32),Pull (18.819,-7.679) (17.12,-5.76),Pull (16.32,-4.8) (15.52,-3.84),Pull (16.499,-2.719) (14.88,-1.6),Pull (10.979,6.6199) (4.64,9.92),Pull (-2.72,8.3600) (-9.76,9.92)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.12) purple,
  curve (-0.299,8.8430) [Pull (0.4496,8.8430) (1.1990,8.8430),Pull (2.8583,7.4247) (2.9976,4.6463),Pull (2.9971,3.8969) (4.1967,3.1475),Pull (4.9461,2.8981) (5.6955,1.6487),Pull (6.4146,-0.070) (8.0936,-0.749),Pull (8.6932,-1.008) (9.2927,-1.948),Pull (10.641,-3.118) (11.990,-2.847),Pull (12.440,-2.517) (12.889,-3.147),Pull (14.088,-3.537) (15.288,-3.447),Pull (16.487,-5.096) (17.686,-6.744),Pull (17.486,-7.484) (16.487,-7.344),Pull (14.688,-7.944) (12.889,-6.145),Pull (10.201,-6.645) (9.5925,-4.946),Pull (8.8430,-3.896) (8.0936,-2.847),Pull (6.3746,-2.128) (5.6955,-2.248),Pull (5.0656,-2.287) (5.3957,-3.447),Pull (6.8049,-5.215) (7.4941,-7.943),Pull (9.3030,-8.912) (10.192,-11.24),Pull (10.800,-12.79) (12.889,-13.33),Pull (13.199,-13.78) (13.189,-14.23),Pull (14.538,-14.45) (15.887,-15.43),Pull (16.416,-16.79) (17.985,-17.23),Pull (20.084,-18.29) (22.182,-18.43),Pull (23.042,-19.03) (22.782,-19.63),Pull (22.782,-20.08) (22.782,-20.53),Pull (24.730,-23.98) (26.679,-27.42),Pull (28.079,-28.92) (26.679,-30.42),Pull (27.698,-32.52) (27.878,-34.62),Pull (21.732,-36.24) (17.985,-33.42),Pull (17.985,-31.77) (17.985,-30.12),Pull (15.737,-30.32) (13.489,-29.52),Pull (12.519,-29.11) (12.590,-27.42),Pull (8.4320,-27.87) (7.7939,-25.92),Pull (7.6440,-24.43) (7.4941,-22.93),Pull (5.3957,-23.59) (3.2974,-22.93),Pull (2.5480,-22.45) (1.7985,-22.93),Pull (-1.348,-23.44) (-4.496,-22.03),Pull (-6.145,-23.09) (-7.793,-22.63),Pull (-8.543,-22.97) (-9.292,-22.63),Pull (-9.182,-25.68) (-10.19,-25.92),Pull (-10.70,-28.57) (-14.08,-28.62),Pull (-15.58,-28.62) (-17.08,-28.62),Pull (-16.96,-32.18) (-20.68,-32.82),Pull (-22.48,-32.91) (-24.28,-32.52),Pull (-24.89,-37.45) (-28.47,-37.62),Pull (-31.02,-37.34) (-33.57,-37.62),Pull (-34.39,-38.60) (-36.57,-38.22),Pull (-39.86,-37.32) (-43.16,-36.42),Pull (-44.21,-36.09) (-45.26,-36.72),Pull (-42.56,-33.57) (-39.86,-30.42),Pull (-40.87,-29.81) (-39.56,-28.32),Pull (-36.69,-25.62) (-34.77,-22.93),Pull (-35.40,-22.33) (-35.07,-21.73),Pull (-34.32,-21.13) (-33.57,-20.53),Pull (-32.22,-20.56) (-30.87,-21.43),Pull (-29.97,-21.87) (-29.07,-20.83),Pull (-28.18,-20.18) (-25.18,-21.13),Pull (-23.83,-21.25) (-22.48,-19.93),Pull (-22.00,-19.40) (-20.68,-19.63),Pull (-17.98,-20.16) (-15.28,-17.53),Pull (-11.33,-17.52) (-9.292,-14.23),Pull (-2.695,-8.243) (-2.098,-2.248),Pull (-2.997,-2.738) (-3.896,-2.548),Pull (-5.185,-5.775) (-8.393,-8.243),Pull (-10.23,-7.813) (-12.59,-9.142),Pull (-13.83,-11.38) (-16.48,-10.94),Pull (-17.68,-10.15) (-18.88,-11.24),Pull (-20.38,-12.23) (-21.88,-10.34),Pull (-22.63,-9.831) (-23.38,-10.64),Pull (-25.18,-11.79) (-26.97,-10.94),Pull (-27.48,-10.19) (-26.67,-9.442),Pull (-24.95,-7.943) (-23.98,-6.444),Pull (-20.68,-7.844) (-17.38,-7.044),Pull (-16.03,-6.424) (-14.68,-7.044),Pull (-13.18,-7.024) (-11.69,-5.845),Pull (-10.27,-5.666) (-8.093,-4.046),Pull (-6.315,-4.808) (-3.896,-0.449),Pull (-0.758,4.1967) (-0.299,8.8430)]
    |>filled (hsl (degrees 297) 0.53 0.77)
    |>addOutline (solid 0.12) purple,
  curve (-45.26,-36.72) [Pull (-42.73,-36.35) (-36.57,-38.22),Pull (-35.00,-38.24) (-33.87,-37.62),Pull (-31.17,-37.47) (-28.47,-37.92),Pull (-24.57,-36.74) (-24.28,-32.52),Pull (-18.69,-33.49) (-17.38,-30.42),Pull (-16.85,-29.52) (-17.08,-28.62),Pull (-10.40,-28.97) (-10.49,-25.92),Pull (-8.802,-25.02) (-9.592,-22.63),Pull (-7.044,-23.09) (-4.496,-22.03),Pull (-1.348,-23.32) (1.7985,-22.93),Pull (2.4978,-22.43) (3.5971,-22.93),Pull (5.1056,-23.49) (7.4941,-22.93),Pull (7.2033,-27.06) (9.5925,-27.42),Pull (10.941,-27.42) (12.290,-27.42),Pull (12.379,-29.18) (14.388,-29.82),Pull (16.187,-29.97) (17.985,-30.12),Pull (17.836,-31.77) (17.686,-33.42),Pull (22.782,-36.24) (27.878,-34.62),Pull (27.728,-33.87) (27.578,-33.12),Pull (30.730,-37.47) (23.081,-41.21),Pull (23.891,-42.10) (23.981,-43.31),Pull (22.724,-45.11) (15.587,-45.11),Pull (14.908,-45.41) (14.988,-45.71),Pull (16.168,-47.36) (13.189,-49.01),Pull (10.192,-49.66) (7.1943,-49.91),Pull (5.8849,-49.05) (5.6955,-50.51),Pull (4.3178,-52.53) (-0.299,-53.20),Pull (-4.196,-53.23) (-8.093,-52.30),Pull (-9.142,-52.02) (-10.19,-52.30),Pull (-17.53,-55.32) (-24.88,-51.70),Pull (-25.92,-50.54) (-26.97,-51.11),Pull (-31.41,-51.96) (-33.57,-49.61),Pull (-32.45,-46.99) (-34.77,-46.61),Pull (-39.72,-46.96) (-43.16,-43.31),Pull (-43.46,-42.11) (-42.56,-40.91),Pull (-41.70,-39.94) (-43.16,-40.01),Pull (-46.23,-38.37) (-45.26,-36.72)]
    |>filled purple
    |>makeTransparent 0.45,
  curve (4.4964,11.840) [Pull (4.4964,11.840) (4.4964,11.840),Pull (4.6463,10.941) (4.7962,10.042),Pull (-2.548,8.5221) (-9.892,10.042),Pull (-9.572,10.941) (-9.892,11.840),Pull (-2.847,10.380) (4.4964,11.840)]
    |>outlined (solid 0.1) purple,
  curve (-38.66,-37.92) [Pull (-38.96,-39.26) (-37.77,-40.61),Pull (-38.10,-43.07) (-33.87,-43.01),Pull (-29.66,-43.30) (-28.77,-46.91),Pull (-28.31,-48.15) (-26.37,-47.51),Pull (-20.83,-46.89) (-15.28,-48.71),Pull (-12.44,-49.60) (-9.592,-48.41),Pull (-9.142,-47.92) (-8.693,-48.71),Pull (-6.227,-50.54) (1.1990,-47.81),Pull (2.6978,-47.08) (4.1967,-47.51),Pull (4.8764,-47.58) (4.7962,-46.61),Pull (4.9047,-45.36) (8.6932,-45.71),Pull (12.171,-45.59) (12.290,-43.91),Pull (12.569,-43.01) (14.688,-42.11),Pull (18.266,-42.11) (18.885,-40.31),Pull (19.244,-39.02) (20.683,-38.81),Pull (24.072,-37.49) (23.981,-35.52),Pull (20.683,-35.37) (18.585,-34.02),Pull (17.685,-33.27) (17.985,-30.12),Pull (15.887,-30.33) (13.789,-29.82),Pull (12.809,-29.45) (12.590,-27.12),Pull (10.791,-27.27) (8.9929,-27.42),Pull (7.8233,-27.00) (8.0936,-25.62),Pull (7.9437,-24.13) (7.7939,-22.63),Pull (6.1451,-23.54) (4.4964,-23.53),Pull (3.4473,-23.77) (2.3981,-22.93),Pull (-1.049,-23.44) (-4.496,-22.03),Pull (-5.005,-22.00) (-5.995,-22.93),Pull (-6.764,-23.06) (-8.693,-22.03),Pull (-9.562,-21.71) (-9.592,-23.23),Pull (-9.552,-23.83) (-9.592,-24.43),Pull (-10.08,-27.36) (-12.88,-28.62),Pull (-15.13,-28.80) (-17.38,-28.62),Pull (-17.04,-29.82) (-17.38,-31.02),Pull (-18.29,-32.86) (-21.28,-32.82),Pull (-22.78,-32.67) (-24.28,-32.52),Pull (-24.65,-34.47) (-25.77,-36.42),Pull (-26.53,-37.23) (-28.17,-37.32),Pull (-33.27,-36.92) (-34.77,-38.51),Pull (-35.50,-38.77) (-36.87,-38.22),Pull (-37.77,-37.92) (-38.66,-37.92)]
    |>filled purple 
    |>makeTransparent 0.4,
  curve (27.578,-34.62) [Pull (23.081,-36.21) (18.585,-33.72),Pull (17.455,-33.12) (18.285,-32.52),Pull (20.724,-32.22) (21.882,-31.92),Pull (23.873,-31.02) (21.583,-30.12),Pull (19.624,-30.00) (17.985,-30.12),Pull (14.627,-30.83) (13.189,-29.22),Pull (12.889,-28.32) (12.590,-27.42),Pull (9.5920,-27.86) (7.7939,-26.22),Pull (6.8021,-25.33) (12.290,-24.43),Pull (14.460,-23.53) (11.990,-22.63),Pull (9.7423,-22.22) (7.4941,-22.93),Pull (5.3957,-23.21) (3.2974,-22.93),Pull (2.6978,-22.59) (2.0983,-22.93),Pull (-1.348,-23.10) (-4.796,-22.03),Pull (-6.295,-22.57) (-7.793,-22.63),Pull (-8.693,-22.63) (-9.592,-22.63),Pull (-11.69,-22.34) (-13.18,-22.93),Pull (-15.16,-23.98) (-13.18,-25.03),Pull (-11.84,-25.48) (-10.49,-25.92),Pull (-10.30,-27.50) (-12.59,-28.32),Pull (-14.83,-28.47) (-17.08,-28.62),Pull (-17.68,-28.62) (-18.28,-28.62),Pull (-19.60,-28.84) (-18.28,-29.82),Pull (-17.98,-30.12) (-17.68,-30.42),Pull (-17.96,-32.26) (-20.68,-32.82),Pull (-22.48,-33.05) (-24.28,-32.52),Pull (-26.22,-31.89) (-28.17,-32.22),Pull (-30.04,-33.05) (-28.47,-34.32),Pull (-26.89,-35.14) (-26.07,-36.72),Pull (-29.07,-38.28) (-32.07,-37.32),Pull (-32.93,-37.47) (-33.87,-37.62),Pull (-35.41,-38.71) (-38.07,-37.92),Pull (-40.76,-36.87) (-43.46,-36.42),Pull (-44.36,-36.27) (-45.26,-36.72)]
    |>outlined (solid 0.2) purple,
  curve (17.985,-30.12) [Pull (19.484,-30.22) (20.983,-30.12),Pull (24.383,-30.60) (21.583,-31.92),Pull (20.804,-30.64) (17.985,-30.12)]
    |>filled purple 
    |>makeTransparent 0.45,
  curve (10.791,-24.73) [Pull (14.780,-23.83) (12.290,-22.93),Pull (9.8922,-22.27) (7.4941,-22.93),Pull (11.942,-24.16) (10.791,-24.73)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-9.592,-22.63) [Pull (-11.54,-22.18) (-13.48,-22.93),Pull (-14.70,-23.83) (-13.48,-24.73),Pull (-12.07,-23.42) (-9.592,-22.63)]
    |>filled purple
    |>makeTransparent 0.4,
 curve (-17.38,-28.62) [Pull (-19.12,-28.65) (-18.58,-29.52),Pull (-17.98,-29.07) (-17.38,-28.62)]
    |>filled purple
    |>makeTransparent 0.4,
 curve (-24.58,-32.52) [Pull (-26.37,-31.95) (-28.17,-32.22),Pull (-29.87,-33.27) (-28.17,-34.32),Pull (-26.85,-33.10) (-24.58,-32.52)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-3.896,-2.548) [Pull (-2.997,-2.718) (-2.098,-2.248),Pull (-1.268,-1.819) (-1.199,0.4496),Pull (-1.348,2.2482) (-1.498,4.0468)]
    |>outlined (solid 0.1) purple,
  curve (-23.38,-10.34) [Pull (-22.22,-8.843) (-21.58,-7.344),Pull (-21.13,-7.624) (-20.68,-7.344),Pull (-21.60,-8.843) (-21.88,-10.34),Pull (-22.29,-9.872) (-23.38,-10.34)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-18.28,-7.344) [Pull (-17.68,-7.254) (-17.08,-7.044),Pull (-17.23,-8.992) (-16.78,-10.94),Pull (-17.68,-10.28) (-18.58,-10.94),Pull (-18.05,-8.992) (-18.28,-7.344)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-14.98,-7.344) [Pull (-14.02,-8.843) (-13.78,-10.34),Pull (-13.06,-9.442) (-11.69,-8.543),Pull (-10.64,-6.295) (-8.393,-4.046),Pull (-10.19,-5.606) (-11.99,-5.845),Pull (-13.04,-6.954) (-14.98,-7.344)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-2.997,0.7494) [Pull (-3.177,-0.899) (-4.196,-2.548),Pull (-4.496,-3.747) (-5.395,-4.946),Pull (-4.885,-3.597) (-5.096,-2.248),Pull (-4.196,-1.239) (-2.997,0.7494)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (0.2997,8.8430) [Pull (0.5800,5.8454) (-0.299,2.8477),Pull (0.3110,-2.879) (-2.398,-4.046),Pull (-2.028,-3.147) (-2.098,-2.248),Pull (-0.988,-1.019) (-1.199,1.0491),Pull (-1.348,2.5480) (-1.498,4.0468),Pull (-0.459,6.4449) (-0.299,8.8430),Pull (-0.149,8.8430) (0.2997,8.8430)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (3.2974,3.7470) [Pull (3.6371,1.3489) (3.8969,-1.049),Pull (4.0463,-2.658) (5.3957,-2.548)]
    |>outlined (solid 0.1) purple,
  curve (0.2997,8.5433) [Pull (1.2792,6.4449) (1.4988,4.3466),Pull (1.4978,-1.880) (3.8969,-3.747),Pull (4.6463,-4.196) (5.3957,-4.046),Pull (5.5459,-3.297) (5.0960,-2.548),Pull (3.9668,-2.540) (2.9976,3.7470),Pull (3.0383,6.7350) (1.1990,8.8430),Pull (0.5995,8.6932) (0.2997,8.5433)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (5.6955,1.6487) [Pull (6.0748,0.4496) (7.4941,-0.749),Pull (8.4534,-0.688) (9.2927,-1.948),Pull (9.0826,-3.447) (9.5925,-4.946),Pull (8.8430,-3.576) (8.0936,-2.847),Pull (7.3442,-2.597) (6.5948,-2.548),Pull (6.5651,-0.599) (5.6955,1.6487)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (11.690,-2.847) [Pull (12.710,-2.617) (12.889,-3.147),Pull (13.708,-5.395) (15.288,-7.644),Pull (13.828,-7.154) (12.889,-6.145),Pull (12.590,-4.496) (11.690,-2.847)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-2.997,-8.843) [Pull (-3.316,-15.43) (-4.796,-22.03)]
    |>outlined (solid 0.1) purple,
  curve (7.1943,-7.943) [Pull (7.8635,-15.13) (9.2927,-22.33)]
    |>outlined (solid 0.1) purple,
  curve (-2.398,-4.046) [Pull (-2.807,-6.594) (-3.297,-9.142),Pull (-3.606,-15.43) (-4.796,-21.73),Pull (-5.545,-22.27) (-6.295,-22.33),Pull (-4.196,-9.249) (-2.398,-4.046)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (5.3957,-3.747) [Pull (6.7750,-5.405) (7.1943,-7.943),Pull (9.9426,-15.13) (11.690,-22.33),Pull (10.491,-21.97) (9.2927,-22.33),Pull (8.5936,-15.58) (6.8946,-8.843),Pull (6.4051,-6.295) (5.3957,-3.747)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-11.39,-16.63) [Pull (-12.04,-20.08) (-14.08,-23.53)]
    |>outlined (solid 0.1) purple,
  curve (-11.39,-16.63) [Pull (-12.04,-20.08) (-14.08,-23.53),Pull (-14.37,-24.13) (-13.78,-24.73),Pull (-12.14,-25.67) (-10.49,-25.92),Pull (-12.44,-26.22) (-14.38,-25.33),Pull (-15.50,-24.43) (-14.98,-23.53),Pull (-12.83,-20.08) (-11.39,-16.63)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (10.192,-11.84) [Pull (11.230,-17.68) (13.189,-23.53)]
    |>outlined (solid 0.1) purple,
  curve (10.192,-11.84) [Pull (11.230,-17.68) (13.189,-23.53),Pull (13.211,-24.50) (9.5925,-25.03),Pull (10.941,-25.31) (12.290,-25.03),Pull (14.219,-24.69) (13.789,-23.23),Pull (12.290,-17.68) (10.192,-11.84)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-15.28,-17.53) [Pull (-15.92,-23.08) (-18.88,-28.62)]
    |>outlined (solid 0.1) purple,
  curve (19.484,-18.13) [Pull (20.393,-24.58) (22.782,-31.02)]
    |>outlined (solid 0.1) purple,
  curve (19.484,-18.13) [Pull (20.393,-24.58) (22.782,-31.02),Pull (22.523,-32.00) (20.384,-32.22),Pull (19.334,-32.37) (18.285,-32.52),Pull (20.683,-32.95) (23.081,-32.82),Pull (24.021,-32.07) (23.681,-31.32),Pull (21.583,-24.58) (19.484,-18.13)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-15.28,-17.53) [Pull (-16.01,-23.23) (-19.18,-28.92),Pull (-19.25,-29.37) (-18.28,-29.82),Pull (-18.13,-29.97) (-17.98,-30.12),Pull (-18.73,-30.27) (-19.48,-29.82),Pull (-20.17,-29.22) (-19.78,-28.62),Pull (-17.06,-23.08) (-15.28,-17.53)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-15.52,-17.85) [Pull (-15.33,-21.18) (-18.14,-24.52),Pull (-19.44,-25.32) (-20.75,-24.52),Pull (-22.41,-24.77) (-23.36,-25.97),Pull (-24.85,-27.43) (-27.13,-26.84),Pull (-28.15,-26.82) (-29.17,-27.71),Pull (-30.66,-29.74) (-33.23,-30.33),Pull (-36.17,-28.31) (-39.90,-30.33)]
    |>outlined (solid 0.1) purple,
  curve (-23.94,-21.04) [Pull (-28.22,-21.27) (-28.29,-22.78),Pull (-28.59,-23.60) (-30.04,-23.07),Pull (-31.63,-22.35) (-33.23,-22.20),Pull (-34.55,-22.01) (-34.68,-23.07)]
    |>outlined (solid 0.1) purple,
  curve (-24.52,-21.04) [Pull (-26.87,-21.32) (-28.29,-22.49),Pull (-28.32,-23.36) (-29.75,-23.07),Pull (-34.71,-21.61) (-34.68,-23.07),Pull (-33.07,-22.76) (-29.75,-23.65),Pull (-27.42,-23.66) (-27.42,-23.07),Pull (-27.03,-22.05) (-24.52,-21.04)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-15.81,-20.75) [Pull (-16.99,-24.12) (-19.01,-25.10),Pull (-20.22,-25.43) (-20.75,-24.52),Pull (-22.59,-24.81) (-23.36,-25.97),Pull (-24.95,-27.41) (-27.42,-26.84),Pull (-29.02,-27.17) (-29.75,-28.58),Pull (-31.49,-29.88) (-33.23,-30.33),Pull (-36.42,-28.61) (-39.61,-30.33),Pull (-36.71,-30.16) (-33.81,-31.20),Pull (-32.78,-31.40) (-28.87,-29.17),Pull (-28.34,-28.10) (-26.84,-27.71),Pull (-24.38,-28.06) (-21.91,-25.97),Pull (-21.18,-25.23) (-20.46,-25.68),Pull (-16.90,-26.60) (-15.81,-20.75)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (10.594,-12.04) [Pull (11.425,-14.80) (13.496,-17.56),Pull (14.422,-20.02) (16.108,-20.17),Pull (18.025,-20.36) (19.301,-22.20),Pull (20.607,-24.07) (21.913,-24.81),Pull (24.235,-27.57) (26.557,-30.33),Pull (28.002,-28.87) (26.848,-27.42),Pull (25.176,-23.80) (22.784,-20.46),Pull (22.909,-19.00) (21.913,-18.43),Pull (18.026,-17.99) (15.818,-15.52),Pull (14.732,-14.24) (13.206,-14.07),Pull (13.061,-13.46) (12.916,-13.20),Pull (11.900,-13.00) (10.594,-12.04)]
    |>filled (hsl (degrees 297) 0.53 0.77)
    |>addOutline (solid 0.12) purple,
  curve (10.884,-12.33) [Pull (12.485,-12.80) (13.206,-14.07),Pull (14.802,-14.27) (16.399,-16.39),Pull (18.616,-18.47) (21.913,-18.43),Pull (22.909,-18.80) (22.784,-20.46),Pull (22.013,-19.30) (19.882,-19.30),Pull (16.734,-18.61) (14.947,-16.39),Pull (14.077,-15.09) (13.206,-14.94),Pull (12.590,-13.64) (10.884,-12.33)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (10.594,-12.04) [Pull (11.545,-14.80) (13.496,-17.56),Pull (13.962,-19.48) (16.108,-20.17),Pull (17.705,-20.40) (19.301,-22.20),Pull (20.207,-23.85) (21.913,-25.10),Pull (24.235,-27.59) (26.557,-30.33),Pull (23.510,-27.51) (20.462,-24.81),Pull (19.271,-23.80) (18.721,-22.78),Pull (17.014,-20.92) (14.947,-20.46),Pull (13.411,-19.44) (12.916,-18.43),Pull (11.755,-15.23) (10.594,-12.04)]
    |>filled purple
    |>makeTransparent 0.4,
  curve (-9.723,10.013) [Pull (-2.467,8.2336) (4.7891,10.013),Pull (6.0952,8.9977) (7.4013,7.9818),Pull (6.0952,9.0023) (4.7891,9.1428),Pull (4.9342,8.7074) (5.0793,8.2721),Pull (5.0188,8.7074) (3.9183,9.1428),Pull (3.3932,8.8526) (3.6281,8.5623),Pull (3.7178,8.8526) (3.0476,9.1428),Pull (2.5824,8.5623) (2.7573,7.9818),Pull (2.5317,8.5623) (1.3061,9.1428),Pull (0.4353,8.9977) (-0.435,8.8526),Pull (-1.455,8.4172) (-1.596,7.9818),Pull (-1.381,8.4172) (-1.886,8.8526),Pull (-2.661,8.4172) (-2.757,7.9818),Pull (-2.832,8.4172) (-3.628,8.8526),Pull (-4.543,8.5623) (-4.498,8.2721),Pull (-4.509,8.5623) (-5.079,8.8526),Pull (-6.450,8.2721) (-6.820,7.6916),Pull (-6.180,8.4172) (-6.820,9.1428),Pull (-8.106,8.7074) (-8.272,8.2721),Pull (-8.037,8.8526) (-8.562,9.4331),Pull (-9.742,8.7074) (-9.723,7.9818),Pull (-9.203,8.9977) (-9.723,10.013)]
    |>filled purple
    |>makeTransparent 0.6,
  curve (-0.725,11.174) [Pull (0.1451,11.254) (1.0158,11.174),Pull (1.9009,10.013) (1.3061,8.8526),Pull (0.4353,8.8526) (-0.435,8.8526),Pull (-1.320,9.8587) (-0.725,11.174)]
    |>filled (rgb 200 200 100)
    |>addOutline (solid 0.05) (hsl (degrees 308) 0.441 0.681)
    |>makeTransparent 0.6,
  accessory_outfit6
    |>scale 0.08
    |>move (-0.2, 16),
 --leg
  curve (-2.997,-22.63) [Pull (-3.896,-22.33) (-4.796,-22.03),Pull (-7.044,-23.12) (-9.292,-22.93),Pull (-9.142,-25.32) (-10.19,-26.22),Pull (-10.70,-27.81) (-12.29,-28.32),Pull (-16.28,-32.67) (-17.08,-37.02),Pull (-18.41,-41.06) (-20.38,-45.11),Pull (-22.71,-46.49) (-23.08,-49.31),Pull (-22.66,-53.50) (-22.48,-57.70),Pull (-20.98,-58.00) (-19.48,-58.30),Pull (-17.00,-53.05) (-16.48,-47.81),Pull (-12.24,-40.61) (-7.194,-33.42),Pull (-4.345,-30.27) (-3.896,-27.12),Pull (-3.597,-24.88) (-2.997,-22.63)]
    |>filled skin,
  curve (-1.498,-22.93) [Pull (-1.838,-26.52) (-1.498,-30.12),Pull (-3.598,-35.67) (-3.297,-41.21),Pull (-2.657,-47.06) (-3.297,-52.90),Pull (-2.809,-57.07) (1.1990,-59.80),Pull (5.3675,-60.94) (5.0960,-58.00),Pull (3.6870,-55.89) (2.3981,-52.90),Pull (2.3378,-48.11) (2.9976,-43.31),Pull (4.3771,-37.92) (4.1967,-32.52),Pull (5.7859,-27.87) (6.2950,-23.23),Pull (4.4964,-23.44) (2.6978,-22.93),Pull (0.3595,-23.21) (-1.498,-22.93)]
    |>filled skin,
  shoe_outfit6,
  shoe_outfit6
    |>move (12, 2)
    |>rotate (degrees -35),
  curve (-19.18,-50.81) [Pull (-17.77,-51.13) (-17.08,-52.30),Pull (-17.23,-52.90) (-17.38,-53.50),Pull (-18.58,-52.37) (-19.78,-52.00),Pull (-19.63,-51.55) (-19.18,-50.81)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.1) purple

  ]

accessory_outfit6 = group [
  curve (-8.393,-19.93) [Pull (-7.313,-27.42) (-8.393,-34.92),Pull (-3.857,-29.77) (1.7985,-25.62),Pull (8.1148,-28.26) (11.391,-34.02),Pull (12.930,-27.72) (12.590,-21.43),Pull (20.084,-19.22) (27.578,-19.33),Pull (21.133,-16.44) (14.688,-11.84),Pull (18.666,-6.295) (20.683,-0.749),Pull (14.988,-3.558) (9.2927,-4.046),Pull (5.2955,2.2482) (2.0983,8.5433),Pull (-0.459,1.3489) (-3.896,-5.845),Pull (-12.44,-5.236) (-20.98,-3.747),Pull (-15.44,-8.393) (-11.99,-13.03),Pull (-16.78,-15.43) (-21.58,-17.23),Pull (-15.13,-17.53) (-8.393,-19.93)]
    |>filled (rgb 250 250 200),
  circle 8
    |>filled red
    |>move (2, -15)
    ]

shoe_outfit6 = group [
  curve (-3.297,-52.60) [Pull (-4.847,-54.45) (-4.196,-57.10),Pull (-3.716,-58.75) (-4.196,-60.40),Pull (-3.147,-60.85) (-2.098,-61.30),Pull (-1.498,-61.00) (-0.899,-60.70),Pull (0.7178,-63.69) (6.2950,-63.40),Pull (7.1943,-63.10) (8.0936,-62.80),Pull (8.2435,-61.75) (8.3934,-60.70),Pull (8.4339,-59.95) (7.1943,-59.20),Pull (6.2950,-58.73) (5.3957,-57.70),Pull (3.4969,-57.81) (2.3981,-59.20),Pull (1.0491,-58.56) (-0.299,-56.80),Pull (1.4385,-55.69) (3.8969,-55.90),Pull (3.4473,-55.15) (2.9976,-54.40),Pull (0.8992,-54.32) (-1.199,-55.60),Pull (-2.638,-53.95) (-3.297,-52.60)]
    |>filled (hsl (degrees 280) 0.553 0.676)
    |>addOutline (solid 0.1) purple,
  curve (-0.899,-60.70) [Pull (-1.808,-58.63) (-4.196,-58.00)]
    |>outlined (solid 0.1) purple,
  curve (-2.098,-61.30) [Pull (-2.098,-60.25) (-2.098,-59.20)]
    |>outlined (solid 0.1) purple,
  curve (-2.098,-61.30) [Pull (-2.098,-60.25) (-2.098,-59.20),Pull (-1.208,-59.95) (-1.199,-60.70),Pull (-1.648,-61.00) (-2.098,-61.30)]
    |>filled purple 
    |>makeTransparent 0.4
    ]
     
-- BOY OUTFIT 1
bOutfit1 skin = group [
    pants_bOutfit1 , 
  hoodie_bOutfit1 skin , neck_bOutfit1 skin,
  shoes_bOutfit1

  ]

neck_bOutfit1 skin = 
  group 
  [
  
  curve (-17.77,23.272) [Pull (-21.01,23.111) (-24.24,22.949),Pull (-24.06,21.494) (-24.24,20.040),Pull (-24.56,19.537) (-24.88,19.393),Pull (-24.68,18.527) (-24.24,18.101),Pull (-22.30,17.939) (-20.36,17.777),Pull (-18.76,19.232) (-17.45,20.686),Pull (-17.75,21.979) (-17.45,23.272),Pull (-17.61,23.434) (-17.77,23.272)]
    |> filled skin
    |> move (0,-1)

  ]
hoodie_bOutfit1 skin = group [
  curve (-17.45,17.131) [Pull (-13.41,17.364) (-9.373,15.838),Pull (-7.174,14.050) (-5.494,10.343),Pull (-3.117,5.8181) (-1.939,1.2929),Pull (-0.642,-0.808) (-2.585,-2.909),Pull (-2.278,-6.248) (-5.171,-6.787),Pull (-6.787,-9.255) (-8.404,-8.404),Pull (-9.050,-8.242) (-9.696,-8.080),Pull (-7.350,-9.223) (-8.404,-12.60),Pull (-8.727,-13.02) (-9.050,-12.92),Pull (-8.570,-14.54) (-9.050,-15.83),Pull (-20.97,-20.49) (-34.58,-15.51),Pull (-34.24,-14.22) (-34.26,-12.92),Pull (-36.34,-11.98) (-34.58,-7.757),Pull (-36.24,-11.89) (-37.49,-7.757),Pull (-39.42,-7.987) (-39.75,-5.818),Pull (-39.37,-4.040) (-39.75,-2.262),Pull (-40.39,0.6032) (-38.78,2.9090),Pull (-36.52,7.9191) (-34.26,12.929),Pull (-32.74,16.248) (-30.38,16.808),Pull (-23.91,12.529) (-17.45,17.131)]
  |> filled (rgb 245 240 221) |> addOutline (solid 0.5) (rgb 180 170 151) -- the outline of the hoodie
   ,
  curve (-19.07,16.808) [Pull (-22.30,16.311) (-25.53,17.454),Pull (-24.24,15.191) (-22.94,12.929),Pull (-21.01,15.030) (-19.07,16.808)]
  |> filled (rgb 251 245 228)
  ,
  curve (-24.88,17.454) [Pull (-23.57,16.891) (-21.65,16.808),Pull (-20.68,16.528) (-19.71,16.808)]
  |> outlined (solid 0.2) (rgb 234 201 182)
  ,
  curve (-12.28,21.333) [Pull (-21.56,23.050) (-27.79,20.686),Pull (-28.73,19.717) (-27.79,18.747),Pull (-25.67,16.323) (-22.62,13.898),Pull (-25.75,19.252) (-23.91,20.686),Pull (-18.48,21.342) (-17.45,19.717),Pull (-18.56,17.861) (-20.36,16.484),Pull (-20.22,16.301) (-13.57,19.717),Pull (-11.92,20.285) (-12.28,21.333)]
  |> filled (rgb 241 234 215)
  ,curve (-21.97,13.898) [Pull (-15.83,15.353) (-9.696,16.808),Pull (-10.08,15.838) (-7.757,14.868),Pull (-7.347,16.646) (-9.696,18.424),Pull (-9.573,21.985) (-12.92,22.626),Pull (-19.07,23.767) (-25.21,22.949),Pull (-29.99,21.828) (-30.38,18.747),Pull (-32.16,17.454) (-31.35,16.161),Pull (-27.47,14.530) (-23.59,13.898),Pull (-23.27,13.898) (-22.94,13.898),Pull (-26.77,16.646) (-28.44,19.393),Pull (-29.36,20.986) (-24.24,21.979),Pull (-18.26,22.916) (-12.28,21.333),Pull (-11.25,20.202) (-14.22,19.070),Pull (-19.66,16.646) (-22.62,14.222),Pull (-22.30,14.060) (-21.97,13.898)]
  |> filled (rgb 245 240 221) |> addOutline (solid 0.3) (rgb 180 170 151) -- the outline of the hat
  
  ,curve (-6.464,-5.818) [Pull (-8.128,-7.919) (-11.31,-10.02),Pull (-11.86,-10.98) (-12.92,-11.95),Pull (-16.14,-10.25) (-16.80,-6.464),Pull (-16.64,-6.141) (-16.48,-5.818),Pull (-15.03,-5.916) (-13.57,-5.494),Pull (-12.12,-3.537) (-10.66,-1.939),Pull (-8.404,-3.717) (-6.464,-5.818)]
  |> filled skin -- hand
  ,
  curve (-33.29,-3.555) [Pull (-32.32,-4.686) (-31.35,-5.818),Pull (-32.48,-7.919) (-33.61,-10.02),Pull (-35.08,-10.22) (-36.20,-6.141),Pull (-34.74,-4.848) (-33.29,-3.555)]
    |> filled skin -- hand

  ,
  curve (-8.404,-8.080) [Pull (-6.287,-9.612) (-5.171,-6.464),Pull (-4.914,-5.010) (-5.818,-3.555),Pull (-6.949,-2.045) (-8.080,-1.616),Pull (-9.373,-0.994) (-10.66,-1.292),Pull (-11.71,-2.101) (-11.95,-2.909),Pull (-7.536,-3.271) (-7.434,-7.434),Pull (-7.919,-8.375) (-8.404,-8.080)]
  |> filled (rgb 245 240 221) -- cuff 
  ,
  curve (-8.404,-8.080) [Pull (-6.287,-9.612) (-5.171,-6.464),Pull (-4.914,-5.010) (-5.818,-3.555),Pull (-6.949,-2.045) (-8.080,-1.616),Pull (-9.373,-0.994) (-10.66,-1.292),Pull (-11.71,-2.101) (-11.95,-2.909),Pull (-7.536,-3.271) (-7.434,-7.434)]
  |> outlined (solid 0.5) (rgb 180 170 151) -- cuff outline
  ,
  curve (-34.90,-9.696) [Pull (-37.18,-10.62) (-37.17,-6.787),Pull (-36.92,-5.171) (-35.55,-3.555),Pull (-34.14,-2.533) (-32.64,-3.232),Pull (-31.84,-4.040) (-32,-4.848),Pull (-33.89,-4.518) (-35.23,-6.787),Pull (-35.71,-7.919) (-35.55,-9.050),Pull (-35.19,-9.212) (-34.90,-9.696)]
  |> filled (rgb 245 240 221) --cuff

  ,curve (-34.90,-9.696) [Pull (-37.18,-10.62) (-37.17,-6.787),Pull (-36.92,-5.171) (-35.55,-3.555),Pull (-34.14,-2.533) (-32.64,-3.232),Pull (-31.84,-4.040) (-32,-4.848),Pull (-35.45,-4.809) (-35.55,-9.050)]
     |> outlined (solid 0.5) (rgb 180 170 151) -- cuff outline

  ,curve (-13.25,-14.22) [Pull (-12.42,-12.92) (-12.28,-11.63),Pull (-16.28,-9.357) (-16.16,-3.878),Pull (-23.43,-3.695) (-30.70,-3.232),Pull (-32.92,-6.949) (-34.26,-10.66),Pull (-33.61,-12.67) (-32.96,-13.25),Pull (-23.11,-16.37) (-13.25,-14.22)]
  |> filled (rgb 245 240 221) |> addOutline (solid 0.5) (rgb 180 170 151) -- pocket
  ,
  curve (-9.050,-12.92) [Pull (-14.05,-15.09) (-22.62,-14.86),Pull (-32.90,-14.43) (-34.90,-11.95)]
    |> outlined (solid 0.5) (rgb 180 170 151) -- outline
  ,
  curve (-23.27,15.191) [Pull (-25.22,16.977) (-25.85,20.363)]
    |> outlined (solid 0.3) (rgb 180 170 151) -- outline
  ,
  curve (-20.68,16.484) [Pull (-18.10,18.747) (-15.51,21.010)]
    |> outlined (solid 0.3) (rgb 180 170 151) -- outline

  ,
  curve (-2.909,4.5252) [Pull (-5.656,4.3371) (-8.404,2.9090),Pull (-9.696,2.4026) (-10.98,1.6161),Pull (-10.91,2.1010) (-11.31,2.5858),Pull (-8.888,4.4987) (-6.464,5.1717),Pull (-5.010,5.5549) (-3.555,5.8181),Pull (-3.452,4.7933) (-2.909,4.5252)]
  |> filled (rgb 141 179 198) --strip on arm
  ,
  curve (-3.555,6.7878) [Pull (-7.434,6.4501) (-11.31,3.2323),Pull (-11.71,3.5571) (-11.63,4.2020),Pull (-9.847,6.5830) (-5.818,8.4040),Pull (-5.171,8.8856) (-4.525,8.7272),Pull (-4.202,7.7575) (-3.555,6.7878)]
  |> filled (rgb 141 179 198) --strip on arm
  ,
  curve (-12.60,7.7575) [Pull (-11.93,4.4884) (-10.98,1.9393),Pull (-11.26,1.2929) (-10.98,0.6464)]
    |> outlined (solid 0.5) (rgb 180 170 151)
  ,
  curve (-5.171,1.2929) [Pull (-12.00,2.4951) (-11.63,-2.262)]
    |> outlined (solid 0.5) (rgb 180 170 151) 
    ,curve (-9.050,-9.050) [Pull (-9.760,-10.47) (-10.98,-10.02),Pull (-11.31,-8.888) (-11.63,-7.757),Pull (-12.92,-6.184) (-14.22,-5.171),Pull (-13.87,-4.425) (-12.92,-3.878),Pull (-11.63,-4.588) (-10.34,-5.818),Pull (-9.696,-7.272) (-9.050,-9.050)]
  |> filled (rgb 148 185 203) |> addOutline (solid 0.3) (rgb 77 113 136) -- watch 
  
  ,curve (-9.373,-7.757) [Pull (-9.643,-8.962) (-11.31,-8.727),Pull (-12.73,-8.535) (-12.28,-6.464),Pull (-12.11,-5.679) (-10.66,-5.494),Pull (-9.180,-5.964) (-9.373,-7.757)]
  |> filled (rgb 148 185 203) |> addOutline (solid 0.3) (rgb 77 113 136) --circle on watch 
  ,
  curve (-10.02,-6.464) [Pull (-10.50,-6.787) (-10.98,-7.111),Pull (-10.66,-7.434) (-10.34,-7.757)]
  |> outlined (solid 0.3) grey  
  ,curve (-32.64,5.4949) [Pull (-34.42,7.1111) (-36.20,8.7272),Pull (-36.84,8.0391) (-37.17,7.1111),Pull (-34.90,5.3149) (-32.64,3.8787),Pull (-32.64,4.6868) (-32.64,5.4949)]
  |> filled (rgb 141 179 198) --strip on arm
  ,
  curve (-32.96,2.9090) [Pull (-34.42,4.0404) (-35.87,5.1717),Pull (-36.82,5.8965) (-37.49,6.1414),Pull (-37.81,5.4949) (-38.14,4.8484),Pull (-35.71,3.3939) (-33.29,1.9393),Pull (-32.95,2.5858) (-32.96,2.9090)]

  |> filled (rgb 141 179 198)--strip on arm
  ,
  curve (-32.32,9.3737) [Pull (-32.62,4.2020) (-33.29,-0.969),Pull (-33.13,-0.808) (-33.29,-0.646),Pull (-32.38,-1.777) (-32.64,-2.909),Pull (-32.66,-2.909) (-32.96,-2.909)]
    |> outlined (solid 0.5) (rgb 180 170 151) -- outline
    ,
  curve (-37.49,0.9696) [Pull (-34.61,1.8248) (-33.29,0)]
    |> outlined (solid 0.5) (rgb 180 170 151) -- outline
   ,
   
  curve (-19.39,16.161) [Pull (-19.95,12.422) (-20.04,8.4040),Pull (-20.82,8.0905) (-20.68,9.6969),Pull (-20.58,13.707) (-20.04,15.838),Pull (-19.85,16.281) (-19.39,16.161)]
    |> filled (rgb 155 186 206) |> addOutline (solid 0.2) (rgb 132 145 147)
   ,
  curve (-24.88,15.838) [Pull (-25.45,12.241) (-25.85,8.4040),Pull (-26.44,8.1672) (-26.50,9.0505),Pull (-26.06,12.786) (-25.53,16.161),Pull (-25.11,16.339) (-24.88,15.838)]
    |> filled (rgb 155 186 206) |> addOutline (solid 0.2) (rgb 132 145 147)

 ]
  
shoes_bOutfit1 = 
  group 
  [
  -- right shoe 
  curve (-14.54,-60.12) [Pull (-13.27,-57.34) (-9.050,-57.85),Pull (-6.767,-57.84) (-4.525,-60.12),Pull (-4.203,-59.93) (-4.202,-59.47),Pull (-5.168,-57.20) (-5.494,-53.33),Pull (-7.434,-52.33) (-9.373,-52.68),Pull (-13.82,-52.41) (-14.86,-53.65),Pull (-14.56,-56.26) (-14.86,-58.50),Pull (-14.94,-60.57) (-14.54,-60.12)]
  |> filled (rgb 147 180 200) |> addOutline (solid 0.3) (rgb 132 150 163)
  
   ,
  curve (-14.54,-60.12) [Pull (-13.27,-57.34) (-9.050,-57.85),Pull (-6.767,-57.84) (-4.525,-60.12),Pull (-5.914,-62.23) (-10.34,-62.06),Pull (-13.68,-62.36) (-14.54,-59.79)]
  |> filled (rgb 202 222 231)
  , curve (-3.878,-61.09) [Pull (-5.224,-62.98) (-9.050,-63.03),Pull (-11.05,-63.16) (-13.25,-62.70),Pull (-14.32,-62.48) (-14.86,-61.73),Pull (-15.41,-61.12) (-15.19,-59.79),Pull (-14.54,-60.09) (-13.89,-60.12),Pull (-12.07,-61.44) (-8.404,-61.09),Pull (-4.803,-60.43) (-4.202,-58.82),Pull (-3.940,-59.79) (-3.878,-61.09)]
  |> filled (rgb 202 222 231) |> addOutline (solid 0.3) (rgb 132 150 163)
  ,
  curve (-7.434,-56.56) [Pull (-7.755,-54.14) (-7.757,-51.71),Pull (-7.415,-50.90) (-7.434,-50.10),Pull (-8.550,-48.91) (-10.66,-48.80),Pull (-12.97,-49.19) (-13.25,-49.77),Pull (-13.22,-51.23) (-12.28,-52.68),Pull (-11.92,-54.62) (-11.95,-56.56),Pull (-9.696,-56.46) (-7.434,-56.56)]
  |> filled (rgb 147 180 200) |> addOutline (solid 0.3) (rgb 132 150 163)
   , curve (-6.787,-55.27) [Pull (-10.31,-54.51) (-12.92,-55.59),Pull (-13.44,-56.21) (-12.60,-56.24),Pull (-11.62,-55.62) (-7.434,-55.91),Pull (-6.471,-56.09) (-6.787,-55.27)]
  |> filled (rgb 213 233 244) |> addOutline (solid 0.2) (rgb 83 117 139) -- shoe laces
  ,
  curve (-7.111,-52.36) [Pull (-10.18,-51.99) (-13.25,-53.97),Pull (-13.41,-54.60) (-12.92,-54.30),Pull (-10.38,-52.67) (-7.111,-52.68),Pull (-6.971,-52.52) (-7.111,-52.36)]
  |> filled (rgb 213 233 244) |> addOutline (solid 0.2) (rgb 83 117 139) -- shoe laces
  ,
  curve (-7.111,-53.97) [Pull (-9.703,-52.37) (-13.57,-52.36),Pull (-14.13,-52.90) (-13.25,-53.01),Pull (-10.48,-52.91) (-7.434,-54.30),Pull (-6.792,-54.37) (-7.111,-53.97)]
  |> filled (rgb 213 233 244) |> addOutline (solid 0.2) (rgb 83 117 139) -- shoe laces
  --- end of right shoe
  -- left shoe 
   ,curve (-22.30,-56.24) [Pull (-24.29,-57.45) (-28.12,-57.85),Pull (-31.72,-59.94) (-35.87,-59.47),Pull (-39.92,-58.84) (-40.40,-57.85),Pull (-41.18,-59.92) (-40.40,-60.12),Pull (-34.38,-62.62) (-29.41,-60.44),Pull (-28.12,-59.57) (-26.82,-59.47),Pull (-23.40,-59.64) (-21.97,-58.18),Pull (-21.98,-57.05) (-22.30,-56.24)]
    |> filled (rgb 203 224 229) |> addOutline (solid 0.3) (rgb 104 136 152)

  ,curve (-22.30,-56.24) [Pull (-24.29,-57.45) (-28.12,-57.85),Pull (-31.72,-59.94) (-35.87,-59.47),Pull (-40.40,-58.90) (-40.40,-58.18),Pull (-38.62,-56.56) (-36.84,-54.94),Pull (-35.87,-53.01) (-33.61,-51.07),Pull (-30.54,-50.29) (-27.47,-51.07),Pull (-26.34,-52.53) (-25.21,-52.68),Pull (-23.29,-52.17) (-22.62,-51.07),Pull (-22.18,-53.65) (-22.30,-56.24)]
  |> filled (rgb 147 180 200) |> addOutline (solid 0.3) (rgb 132 150 163)
  , curve (-33.29,-55.91) [Pull (-35.07,-54.71) (-36.84,-54.62),Pull (-34.66,-52.46) (-32.96,-51.07),Pull (-33.92,-48.65) (-32,-47.83),Pull (-28.70,-47.76) (-28.12,-49.13),Pull (-27.84,-51.10) (-29.41,-51.39),Pull (-31.35,-53.49) (-33.29,-55.91)]
   |> filled (rgb 143 180 200) |> addOutline (solid 0.3) (rgb 55 77 109)
  ,curve (-33.29,-55.91) [Pull (-35.07,-54.71) (-36.84,-54.62),Pull (-38.70,-54.97) (-40.08,-56.24),Pull (-40.82,-57.21) (-40.40,-58.18),Pull (-36.20,-60.04) (-32,-59.15),Pull (-31.42,-57.37) (-33.29,-55.91)]
  |> filled (rgb 202 222 231) |> addOutline (solid 0.3) (rgb 85 116 135)
   ,curve (-31.67,-54.94) [Pull (-33.57,-53.42) (-35.87,-53.33),Pull (-36.15,-53.51) (-35.87,-53.97),Pull (-34.61,-53.92) (-32,-55.27),Pull (-31.47,-55.42) (-31.67,-54.94)]
  |> filled (rgb 213 233 244) |> addOutline (solid 0.2) (rgb 83 117 139) -- shoe laces
 ,
  curve (-29.41,-52.68) [Pull (-31.51,-51.11) (-33.61,-50.74),Pull (-34.17,-50.91) (-33.93,-51.39),Pull (-31.83,-51.96) (-29.73,-53.33),Pull (-29.09,-53.42) (-29.41,-52.68)]
    |> filled (rgb 213 233 244) |> addOutline (solid 0.2) (rgb 83 117 139) -- shoe laces
  ,
  curve (-28.44,-52.04) [Pull (-31.65,-50.78) (-34.58,-52.04),Pull (-34.96,-52.58) (-34.58,-52.36),Pull (-31.81,-51.44) (-28.76,-52.68),Pull (-28.50,-52.56) (-28.44,-52.04)]
    |> filled (rgb 213 233 244) |> addOutline (solid 0.2) (rgb 83 117 139) -- shoe laces

  ]
pants_bOutfit1 = 
  group 
  [
  
  curve (-9.696,-14.54) [Pull (-21.81,-14.54) (-33.93,-14.54),Pull (-33.61,-23.43) (-33.29,-32.32),Pull (-33.59,-36.36) (-33.29,-40.40),Pull (-33.23,-43.20) (-33.93,-43.95),Pull (-35.13,-47.05) (-32.96,-47.51),Pull (-35.32,-50.77) (-32,-51.07),Pull (-24.27,-52.63) (-22.62,-51.71),Pull (-21.54,-50.89) (-22.30,-48.16),Pull (-20.75,-47.58) (-21.65,-43.95),Pull (-21.05,-40.93) (-21.97,-35.55),Pull (-21.37,-34.42) (-21.97,-33.29),Pull (-21.65,-28.44) (-21.33,-23.59),Pull (-19.33,-34.10) (-16.80,-44.60),Pull (-17.65,-45.89) (-17.45,-47.19),Pull (-17.16,-48.32) (-15.83,-49.45),Pull (-16.85,-52.79) (-14.22,-52.68),Pull (-5.176,-53.06) (-5.171,-51.71),Pull (-3.970,-52.00) (-4.848,-48.48),Pull (-3.031,-46.06) (-5.494,-43.63),Pull (-4.936,-41.99) (-5.818,-39.11),Pull (-6.243,-37.17) (-6.787,-35.23),Pull (-6.252,-33.61) (-7.757,-32),Pull (-8.167,-22.94) (-9.696,-14.54)]
  |> filled ( rgb 58 77 110) |> addOutline (solid 0.5) (rgb 25 41 66)
  ,curve (-9.696,-14.86) [Pull (-10.98,-15.35) (-12.28,-15.83),Pull (-10.56,-24.56) (-9.696,-33.29),Pull (-7.125,-38.62) (-7.434,-43.95),Pull (-5.611,-46.72) (-6.787,-48.16),Pull (-6.086,-49.93) (-6.464,-51.71),Pull (-5.761,-52.03) (-5.818,-52.04),Pull (-4.194,-51.36) (-5.171,-48.48),Pull (-3.813,-46.30) (-5.494,-43.63),Pull (-5.241,-39.59) (-6.787,-35.55),Pull (-6.992,-33.77) (-7.757,-32),Pull (-8.648,-19.33) (-9.696,-14.86)]
  |> filled (rgb 146 182 202)
  ,curve (-10.98,-15.51) [Pull (-9.738,-24.56) (-8.727,-33.61),Pull (-5.975,-41.32) (-6.464,-43.95),Pull (-4.661,-46.38) (-5.818,-48.80),Pull (-5.118,-50.42) (-5.818,-52.04),Pull (-5.196,-51.40) (-5.494,-48.48),Pull (-4.198,-46.75) (-6.141,-43.31),Pull (-6.352,-38.10) (-8.404,-33.29),Pull (-9.373,-23.91) (-10.34,-14.54),Pull (-10.82,-15.03) (-10.98,-15.51)]
  |> filled (rgb 58 77 110)
  
  
  ]

-- BOY OUTFIT 2
bOutfit2 skin = group [
  bagBACK_bOutfit2 ,  
   shoes_bOutfit2, 
   pants_bOutfit2, 
   hand1_bOutfit2 skin, 
   shirt_bOutfit2 ,
   neck_bOutfit2 skin,
   sweater_bOutfit2, 
   logo_bOutfit2 , 
   book_bOutfit2 , 
   hand2_bOutfit2 skin , 
   arm2_bOutfit2, 
   bagStraps_bOutfit2

  ]

neck_bOutfit2 skin = 
  group 
  [
  
  curve (-20.68,21.010) [Pull (-20.68,22.303) (-20.68,23.595),Pull (-24.24,23.111) (-27.79,22.626),Pull (-27.63,21.333) (-27.47,20.040),Pull (-27.10,19.830) (-25.53,18.101),Pull (-21.25,20.397) (-20.68,21.333)]
    |> filled skin |> addOutline (solid 0.3) (rgb 171 106 84)

  ]
sweater_bOutfit2 = group [

  
  curve (-13.25,-9.050) [Pull (-15.67,-10.14) (-18.10,-11.63),Pull (-22.78,-13.62) (-27.47,-12.92),Pull (-30.38,-13.18) (-33.29,-12.28),Pull (-34.42,-5.010) (-35.55,2.2626),Pull (-35.71,6.3030) (-35.87,10.343),Pull (-34.10,14.222) (-32.32,18.101),Pull (-31.19,18.747) (-30.06,19.393),Pull (-28.96,11.625) (-26.50,9.6969),Pull (-21.40,13.390) (-18.10,20.363),Pull (-13.38,18.262) (-10.66,16.161),Pull (-4.054,5.3927) (-4.202,-1.616),Pull (-5.291,-4.408) (-6.141,-8.080),Pull (-7.434,-9.628) (-8.727,-9.696),Pull (-9.033,-10.88) (-10.02,-11.63),Pull (-11.23,-11.32) (-13.25,-9.050)]
  |> filled (rgb 42 57 86) |> addOutline (solid 0.3) (rgb 28 42 68)
  ,
  curve (-8.727,-9.696) [Pull (-9.033,-10.82) (-10.02,-11.95),Pull (-12.22,-9.605) (-14.86,-9.050),Pull (-14.52,-7.659) (-13.57,-6.787),Pull (-11.01,-6.682) (-8.727,-9.696)]
  |> filled (rgb 42 57 86) |> addOutline (solid 0.3) (rgb 28 42 68)
  ,
  curve (-8.404,0.9696) [Pull (-11.48,0.8583) (-12.92,-1.292),Pull (-12.53,-2.644) (-13.57,-3.555),Pull (-14.73,-5.310) (-13.89,-6.464)]
  |> outlined (solid 0.3) (rgb 28 42 68)
  ,
  curve (-9.050,2.2626) [Pull (-10.84,2.0329) (-11.95,0.3232)]
  |> outlined (solid 0.3) (rgb 28 42 68)
  ,
  curve (-10.66,15.515) [Pull (-12.29,15.040) (-12.92,12.606),Pull (-12.28,7.2727) (-11.63,1.9393),Pull (-11.47,1.4545) (-11.31,0.9696)]
  |> outlined (solid 0.3) (rgb 28 42 68)
  ,
  curve (-16.16,19.070) [Pull (-20.73,11.232) (-26.50,7.4343),Pull (-30.39,10.449) (-32,18.424)]
  |> outlined (solid 0.3) (rgb 28 42 68)

 ]
logo_bOutfit2 = group 
  [
  
  curve (-17.45,6.4646) [Pull (-17.37,7.4343) (-17.45,8.4040),Pull (-18.48,9.1488) (-20.04,9.3737),Pull (-21.43,8.7688) (-22.30,8.4040),Pull (-22.34,6.9494) (-21.97,5.4949),Pull (-21.45,4.1052) (-20.04,3.5555),Pull (-18.16,3.8852) (-17.77,5.4949),Pull (-17.61,5.9797) (-17.45,6.4646)]
  |> outlined (solid 0.3 ) (rgb 209 192 172)
  ,
  curve (-17.77,6.4646) [Pull (-18.42,6.6262) (-19.07,6.7878),Pull (-18.90,7.1111) (-18.74,7.4343),Pull (-19.07,7.4343) (-19.39,7.4343),Pull (-19.55,7.9191) (-19.71,8.4040),Pull (-20.04,7.9191) (-20.36,7.4343),Pull (-20.52,7.5959) (-20.68,7.7575),Pull (-20.68,7.4343) (-20.68,7.1111),Pull (-21.33,6.9494) (-21.97,6.7878),Pull (-21.49,6.3030) (-21.01,5.8181),Pull (-20.52,5.8181) (-20.04,5.8181),Pull (-20.20,5.3333) (-20.36,4.8484),Pull (-19.71,4.8484) (-19.07,4.8484),Pull (-19.23,5.3333) (-19.39,5.8181),Pull (-18.58,6.1414) (-17.77,6.4646)]
  |> filled  (rgb 209 192 172)
  ]
shirt_bOutfit2 = 
  group
  [
  
  curve (-18.10,20.363) [Pull (-18.52,21.333) (-19.39,22.303),Pull (-20.52,23.006) (-21.65,22.949),Pull (-24.88,23.307) (-28.12,22.626),Pull (-29.91,20.848) (-30.70,19.070),Pull (-29.24,12.020) (-26.50,9.0505),Pull (-18.50,14.868) (-18.10,20.363)]
  |> filled white |> addOutline (solid 0.3) (rgb 138 147 156)
  
  ,
  curve (-21.97,14.545) [Pull (-23.25,16.324) (-24.88,18.424)]
  |> outlined (solid 0.3) (rgb 138 147 156)
  ,
  curve (-23.59,16.484) [Pull (-24.08,15.353) (-24.56,14.222),Pull (-24.40,13.090) (-24.24,11.959),Pull (-25.21,10.828) (-26.18,9.6969),Pull (-26.98,10.666) (-27.79,11.636),Pull (-27.31,13.090) (-26.82,14.545),Pull (-27.15,15.515) (-27.47,16.484),Pull (-26.98,17.131) (-26.50,17.777),Pull (-25.21,17.616) (-23.91,17.454),Pull (-23.75,16.969) (-23.59,16.484)]
  |> filled (rgb 62 85 117) |> addOutline (solid 0.3) (rgb 13 34 58)
  ,
  curve (-24.56,14.222) [Pull (-25.69,14.383) (-26.82,14.545)]
  |> outlined (solid 0.2) (rgb 13 34 58)
  ,
  curve (-20.04,21.979) [Pull (-21.28,20.202) (-24.88,18.424),Pull (-25.25,18.101) (-25.21,17.777),Pull (-27.24,19.273) (-28.12,21.010)]
  |> outlined (solid 0.2) (rgb 138 147 156)
  ,
  curve (-28.76,14.868) [Pull (-27.47,17.246) (-25.85,18.424)]
  |> outlined (solid 0.2) (rgb 138 147 156)
  ,curve (-10.02,-11.31) [Pull (-10.22,-11.79) (-10.66,-12.28),Pull (-12.76,-10.37) (-14.86,-10.02),Pull (-14.38,-9.212) (-13.89,-8.404),Pull (-11.79,-9.535) (-10.02,-11.31)]
  |> filled white


  ]
book_bOutfit2 = 
  group 
  [
  
  curve (-35.55,3.2323) [Pull (-32,1.8793) (-28.44,0.6464),Pull (-30.14,-8.664) (-32,-17.45),Pull (-32.96,-17.61) (-33.93,-17.77),Pull (-32.16,-8.727) (-30.38,0.3232),Pull (-33.45,1.7777) (-36.52,3.2323),Pull (-35.87,3.3939) (-35.55,3.2323)]
  |> filled (rgb 237 227 202)
  ,curve (-27.79,0) [Pull (-27.62,0.6464) (-28.44,1.2929),Pull (-31.83,2.5858) (-35.23,3.8787),Pull (-36.50,3.9371) (-37.49,3.5555),Pull (-40.11,-5.171) (-42.34,-13.89),Pull (-38.30,-16.59) (-34.26,-18.10),Pull (-32.32,-8.888) (-30.38,0.3232),Pull (-33.61,1.7777) (-36.84,3.2323),Pull (-36.04,3.3939) (-35.23,3.5555),Pull (-31.83,2.1010) (-28.44,0.6464),Pull (-30.38,-8.404) (-32.32,-17.45),Pull (-32.64,-17.45) (-32.96,-17.45),Pull (-33.12,-18.17) (-32,-18.10),Pull (-29.89,-8.888) (-27.79,0.3232)]
  |> filled (rgb 116 140 92) |> addOutline (solid 0.3) (rgb 78 91 58)
  
  ]
shoes_bOutfit2 = 
  group 
  [
  
  curve (-8.727,-52.04) [Pull (-6.960,-58.50) (-7.434,-60.44),Pull (-8.215,-62.23) (-11.63,-62.38),Pull (-16.06,-62.47) (-17.77,-60.76),Pull (-17.99,-59.95) (-17.77,-59.15),Pull (-16.16,-60.83) (-14.54,-60.76),Pull (-9.289,-61.45) (-7.434,-58.82)]
  |> filled (rgb 102 67 47) |> addOutline (solid 0.3 )(rgb 87 48 28)
  ,curve (-9.050,-51.71) [Pull (-6.772,-59.70) (-9.373,-60.44),Pull (-17.41,-61.55) (-17.77,-58.82),Pull (-17.61,-54.46) (-17.13,-50.10),Pull (-13.09,-50.90) (-9.050,-51.71)]
  
  |> filled (rgb 127 81 57) |> addOutline (solid 0.2) (rgb 87 48 28)
  ,
  curve (-9.696,-54.30) [Pull (-10.87,-51.75) (-13.25,-51.71),Pull (-15.52,-52.06) (-16.48,-53.97),Pull (-16.07,-58.08) (-14.86,-58.18),Pull (-11.56,-58.85) (-10.02,-57.53),Pull (-9.398,-56.09) (-9.696,-54.30)]
  |> outlined (solid 0.3) (rgb 89 51 28)
  , 
  curve (-9.373,-54.62) [Pull (-12.92,-53.00) (-16.48,-54.62),Pull (-16.48,-55.27) (-16.48,-55.91),Pull (-12.68,-54.43) (-9.373,-55.91),Pull (-9.373,-55.11) (-9.373,-54.62)]
    |> outlined (solid 0.3) (rgb 89 51 28) -- outline
   ,
   
  curve (-30.38,-59.15) [Pull (-31.15,-59.06) (-31.67,-58.50),Pull (-30.70,-58.26) (-29.73,-58.50),Pull (-29.86,-59.22) (-30.38,-59.15)]
  |> filled (rgb 80 44 28)

  ,curve (-26.18,-55.91) [Pull (-27.16,-56.72) (-31.03,-57.21),Pull (-35.23,-59.88) (-40.08,-59.47),Pull (-42.92,-58.98) (-43.95,-57.85),Pull (-43.77,-56.22) (-42.66,-55.27),Pull (-40.08,-54.67) (-37.49,-52.36),Pull (-36.56,-50.99) (-34.58,-50.42),Pull (-32.09,-51.36) (-32.96,-53.97),Pull (-29.73,-52.84) (-26.50,-51.71),Pull (-26.04,-53.65) (-26.18,-55.91)]
  |> filled (rgb 127 81 57) |> addOutline (solid 0.2) (rgb 87 48 28)
  ,

  curve (-26.18,-55.91) [Pull (-27.16,-56.72) (-31.03,-57.21),Pull (-35.23,-59.88) (-40.08,-59.47),Pull (-42.92,-58.98) (-43.95,-57.85),Pull (-44.33,-58.66) (-43.95,-59.47),Pull (-36.81,-62.31) (-32,-59.15),Pull (-30.67,-58.09) (-30.06,-59.15),Pull (-26.79,-58.96) (-25.85,-58.18),Pull (-25.80,-56.72) (-26.18,-55.91)]
    |> filled (rgb 102 67 47) |> addOutline (solid 0.3 )(rgb 87 48 28)
  ,curve (-32.64,-53.65) [Pull (-34.23,-55.89) (-38.14,-56.56),Pull (-41.52,-56.88) (-42.34,-55.59),Pull (-40.26,-54.66) (-37.81,-52.68),Pull (-36.34,-51.55) (-35.55,-50.42),Pull (-32.52,-50.15) (-32.64,-53.65)]
  |> filled (rgb 127 81 57) |> addOutline (solid 0.2) (rgb 87 48 28) -- outline
  ,
  curve (-33.29,-54.30) [Pull (-35.71,-52.01) (-38.14,-52.36),Pull (-38.62,-52.60) (-39.11,-53.33),Pull (-36.79,-53.44) (-34.90,-55.27),Pull (-33.56,-55.04) (-33.29,-54.30)]
  |> filled (rgb 127 81 57) |> addOutline (solid 0.2) (rgb 87 48 28)

  ]
pants_bOutfit2 = 
  group 
  [
  
  
  curve (-13.25,-8.080) [Pull (-10.65,-16.11) (-10.34,-31.67),Pull (-9.440,-32.96) (-9.696,-34.26),Pull (-7.388,-47.31) (-8.080,-48.80),Pull (-6.565,-52.78) (-9.050,-52.68),Pull (-13.91,-51.49) (-17.13,-53.33),Pull (-18.10,-53.55) (-19.07,-52.68),Pull (-19.24,-51.55) (-18.74,-50.42),Pull (-20.11,-49.63) (-19.71,-48.48),Pull (-20.98,-34.74) (-24.88,-21.01),Pull (-24.69,-27.47) (-25.21,-33.93),Pull (-24.37,-38.12) (-24.88,-43.95),Pull (-24.83,-48.12) (-25.53,-49.13),Pull (-24.93,-50.74) (-25.21,-52.36),Pull (-29.06,-53.78) (-32.64,-51.71),Pull (-36.60,-51.79) (-37.17,-50.74),Pull (-37.73,-49.29) (-36.84,-47.83),Pull (-37.97,-46.70) (-37.17,-45.57),Pull (-36.48,-38.52) (-36.20,-31.35),Pull (-37.04,-20.84) (-36.52,-10.34),Pull (-24.72,-8.888) (-13.25,-8.080)]
  |> filled (rgb 167 139 102) |> addOutline ( solid 0.3) (rgb 119 91 61)
  ,
  curve (-18.42,-50.10) [Pull (-17.61,-50.31) (-16.80,-49.45),Pull (-14.25,-48.27) (-10.66,-49.45),Pull (-9.858,-49.71) (-9.050,-49.45)]
  |> outlined ( solid 0.3) (rgb 119 91 61)
  ,
  curve (-14.54,-47.19) [Pull (-15.21,-41.69) (-16.16,-36.20),Pull (-17.85,-28.12) (-19.07,-20.04)]
  |> outlined ( solid 0.3) (rgb 119 91 61)
  ,
  curve (-26.82,-17.77) [Pull (-25.39,-18.12) (-24.88,-16.16),Pull (-24.91,-13.89) (-25.21,-11.63),Pull (-26.50,-11.31) (-27.79,-10.98),Pull (-27.55,-15.26) (-26.82,-17.77),Pull (-27.31,-19.65) (-24.88,-21.01)]
  |> outlined ( solid 0.3) (rgb 119 91 61)
  ,
  curve (-33.29,-20.36) [Pull (-33.85,-32.32) (-33.93,-44.28),Pull (-34.96,-45.91) (-34.26,-46.86)]
  |> outlined ( solid 0.3) (rgb 119 91 61)
  ,
  curve (-25.85,-49.45) [Pull (-27.95,-50.21) (-30.06,-49.13),Pull (-31.83,-48.14) (-33.61,-48.16),Pull (-35.07,-47.83) (-36.52,-47.83)]
  |> outlined ( solid 0.3) (rgb 119 91 61)



  ]
hand1_bOutfit2 skin =
  group 
  [ -- hand
   curve (-11.31,-11.63) [Pull (-11.84,-13.73) (-12.92,-15.83),Pull (-15.32,-13.53) (-15.83,-10.66),Pull (-14.91,-10.62) (-14.22,-9.696),Pull (-12.76,-10.66) (-11.31,-11.63)]
  |> filled skin 
  ,
  curve (-11.95,-16.48) [Pull (-14.22,-15.55) (-16.48,-10.02)]
      |> outlined ( solid 0.3) (rgb 119 91 61) -- outline pocket
   
  
  ]
hand2_bOutfit2 skin = group
  [
  --- hand 2
  curve (-37.81,-6.141) [Pull (-39.75,-7.757) (-41.69,-9.373),Pull (-41.18,-11.79) (-39.75,-14.22),Pull (-37.44,-17.02) (-33.61,-14.54),Pull (-31.93,-13.89) (-32.64,-13.25),Pull (-36.04,-12.95) (-35.87,-9.373),Pull (-34.58,-10.49) (-33.29,-10.02),Pull (-33.19,-9.535) (-33.29,-9.050),Pull (-34.42,-8.584) (-35.55,-7.757),Pull (-38.29,-6.852) (-37.81,-6.141)]

  |> filled skin
  ,curve (-32.64,-13.89) [Pull (-34.26,-14.83) (-35.55,-13.57),Pull (-36.32,-13.08) (-36.84,-12.28)]  
   |> outlined (solid 0.3) (rgb 171 106 84)
  ,
  curve (-37.81,-13.57) [Pull (-37.16,-14.74) (-35.23,-15.51),Pull (-33.52,-15.67) (-33.61,-14.54)]
   |> outlined (solid 0.6) (rgb 171 106 84)
  ,
  curve (-38.78,-14.22) [Pull (-37.97,-15.37) (-36.52,-15.83),Pull (-35.74,-15.89) (-35.55,-15.19)]
   |> outlined (solid 0.3) (rgb 171 106 84)
  ]

arm2_bOutfit2 = group 

  [
  
  curve (-32.64,18.101) [Pull (-34.26,14.383) (-35.87,10.666),Pull (-35.87,7.4343) (-35.87,4.2020),Pull (-36.98,4.2987) (-37.49,3.5555),Pull (-37.53,1.7777) (-38.14,0),Pull (-37.62,-2.424) (-38.14,-4.848),Pull (-37.61,-5.979) (-37.49,-7.111),Pull (-39.57,-8.467) (-41.37,-10.34),Pull (-42.18,-10.87) (-42.66,-9.050),Pull (-44.91,-7.611) (-44.60,-5.171),Pull (-45.05,0.6503) (-43.31,3.2323),Pull (-40.08,10.235) (-36.84,15.838),Pull (-34.74,17.949) (-32.64,18.101)]
  |> filled (rgb 42 57 86) |> addOutline (solid 0.3) (rgb 28 42 68)
  ,
  curve (-38.14,-4.848) [Pull (-40.78,-6.307) (-42.66,-8.727),Pull (-42.28,-10.63) (-41.37,-10.66)]
  |> outlined (solid 0.3) (rgb 28 42 68)
  ,
  curve (-40.40,0.9696) [Pull (-39.43,1.0664) (-38.46,0.3232),Pull (-37.84,-1.131) (-37.81,-2.585),Pull (-36.83,-4.138) (-37.49,-5.171)]
  |> outlined (solid 0.3) (rgb 28 42 68)
  ,
  curve (-38.14,1.6161) [Pull (-39.03,2.8842) (-40.40,3.2323)]
  |> outlined (solid 0.3) (rgb 28 42 68)


  ]
bagBACK_bOutfit2 = 
  group 
   [
   
  curve (-12.28,-16.16) [Pull (-6.808,-15.14) (-5.494,-12.92),Pull (-4.026,1.6161) (-7.757,16.161),Pull (-9.451,19.599) (-14.54,19.717),Pull (-17.49,20.437) (-20.04,19.717),Pull (-16.16,1.7777) (-12.28,-16.16)]
  |> filled (rgb 215 170 115) |> addOutline (solid 0.3) (rgb 155 123 82)
  ,
  curve (-9.696,-15.19) [Pull (-8.398,-11.31) (-10.02,-7.434),Pull (-10.98,-8.888) (-11.95,-10.34),Pull (-11.79,-12.92) (-11.63,-15.51),Pull (-11.04,-15.73) (-9.696,-15.19)]
  |> filled (rgb 193 153 102) |> addOutline (solid 0.3) (rgb 155 123 82)
   ] 

bagStraps_bOutfit2 = 
  group 
  [
  
  curve (-12.28,0) [Pull (-13.67,3.2301) (-14.22,10.020),Pull (-14.15,15.198) (-12.28,17.777),Pull (-12.96,18.907) (-15.83,19.717),Pull (-18.10,15.828) (-17.45,10.020),Pull (-16.41,2.1971) (-12.92,-2.585),Pull (-12.58,-1.454) (-12.60,-0.323),Pull (-12.26,-0.481) (-12.28,0)]
  |> filled (rgb 215 170 115) |> addOutline (solid 0.3) (rgb 155 123 82)
  
  ,curve (-13.89,4.2020) [Pull (-13.98,6.1933) (-14.86,6.4646),Pull (-16.15,7.0365) (-16.48,4.8484),Pull (-16.17,2.9220) (-14.86,3.5555),Pull (-13.96,3.7387) (-13.89,4.2020)]
  |> filled (rgb 215 170 115) |> addOutline (solid 0.3) (rgb 155 123 82)
  ,
  curve (-34.58,3.8787) [Pull (-33.76,14.899) (-29.73,20.040),Pull (-32.16,19.970) (-34.58,18.101),Pull (-36.59,13.809) (-36.52,7.7575),Pull (-36.36,5.6565) (-36.20,3.5555),Pull (-35.23,3.3939) (-34.26,3.2323),Pull (-34.42,3.5555) (-34.58,3.8787)]
    |> filled (rgb 215 170 115) |> addOutline (solid 0.3) (rgb 155 123 82)
  ,
  curve (-34.58,6.7878) [Pull (-35.55,8.5294) (-36.52,7.1111),Pull (-36.69,4.4814) (-35.23,5.1717),Pull (-34.16,5.1197) (-34.58,6.7878)]
  |> filled (rgb 215 170 115) |> addOutline (solid 0.3) (rgb 155 123 82)


  ]

-- BOY OUTFIT 3


  
bOutfit3 skin = group [
  legs_bOutfit3 skin, 
  socks_bOutfit3, 
  boot_bOutfit3, 
  pants_bOutfit3 ,
  shirt_bOutfit3 skin, 
  vest_bOutfit3 , 
  bag_bOutfit3 , 
  sleeve_bOutfit3 skin, 
  scarf_bOutfit3 , 
  neck_bOutfit3 skin

  ]
scarf_bOutfit3 = 
  group 
  [
  
  curve (3.2323,14.545) [Pull (1.9393,15.067) (0.6464,14.868),Pull (-4.040,12.089) (-8.727,10.989),Pull (-6.493,7.1111) (-10.02,3.2323),Pull (-9.763,6.7878) (-10.66,10.343),Pull (-10.89,6.9175) (-12.60,5.1717),Pull (-13.99,6.6262) (-13.57,8.0808),Pull (-13.90,9.6969) (-11.63,11.313),Pull (-11.95,11.294) (-12.28,11.636),Pull (-14.70,11.682) (-17.13,12.929),Pull (-18.88,13.437) (-19.39,14.545),Pull (-19.66,15.893) (-18.10,16.161),Pull (-17.78,18.032) (-14.86,18.424),Pull (-11.44,20.790) (-2.585,19.717),Pull (0.8086,18.782) (0.3232,16.808),Pull (3.2777,15.676) (3.2323,14.545)]
  |> filled (rgb 139 127 83) |> addOutline (solid 0.3) (rgb 76 66 31)
  ,curve (-9.050,8.0808) [Pull (-9.093,9.2121) (-9.696,10.343)]
  |> outlined (solid 0.3) (rgb 76 66 31)
  ,
  curve (-12.28,8.0808) [Pull (-12.39,9.2905) (-11.31,10.020)]
  |> outlined (solid 0.3) (rgb 76 66 31)
  ,
  curve (-9.373,11.636) [Pull (-9.418,10.666) (-10.34,9.6969),Pull (-10.98,9.3969) (-11.63,9.6969),Pull (-12.39,10.426) (-12.28,11.636),Pull (-12.14,12.699) (-9.373,12.282),Pull (-9.373,11.797) (-9.373,11.636)]
  |> filled (rgb 139 127 83) |> addOutline (solid 0.3) (rgb 76 66 31)
  ,
  curve (-5.494,13.898) [Pull (-6.974,12.689) (-9.373,11.959)]
  |> outlined (solid 0.3) (rgb 76 66 31)
  ,
  curve (-14.54,14.222) [Pull (-13.97,12.692) (-11.95,12.282)]
  |> outlined (solid 0.3) (rgb 76 66 31)
  ,curve (-1.939,18.424) [Pull (-6.076,15.913) (-9.373,12.282)]
  |> outlined (solid 0.3) (rgb 76 66 31)
  ,
  curve (-11.31,12.606) [Pull (-13.65,15.191) (-15.19,17.777),Pull (-15.26,18.585) (-13.89,19.393)]
  |> outlined (solid 0.3) (rgb 76 66 31)

  ]
bag_bOutfit3 = 
  group 
  [
  
  curve (3.8787,-0.323) [Pull (5.6565,-5.979) (7.4343,-11.63),Pull (6.4646,-11.79) (5.4949,-11.95),Pull (3.8787,-6.626) (2.2626,-1.292),Pull (3.0707,-0.808) (3.8787,-0.323)]
  |> filled (rgb 131 88 56) |> addOutline (solid 0.3) (rgb 72 43 21)
  ,
  curve (10.020,-20.36) [Pull (10.375,-17.61) (9.0505,-14.86),Pull (9.4721,-14.44) (9.3737,-13.25),Pull (8.5656,-10.89) (7.7575,-10.02),Pull (6.6414,-8.756) (4.5252,-9.373),Pull (1.9393,-10.34) (-0.646,-11.31),Pull (-1.454,-11.63) (-2.262,-11.95),Pull (-1.592,-17.29) (-0.323,-22.62),Pull (1.7226,-23.98) (4.8484,-23.27),Pull (10.454,-22.65) (10.020,-20.04)]
  |> filled (rgb 140 94 61) |> addOutline (solid 0.3) (rgb 78 43 21)
  ,
  curve (7.4343,-9.696) [Pull (9.1440,-11.95) (9.3737,-14.22),Pull (9.4240,-15.35) (7.4343,-16.48),Pull (4.2933,-17.58) (3.2323,-16.48),Pull (1.9393,-15.04) (0.6464,-11.63)]
  |> outlined (solid 0.3) (rgb 72 43 21)
  ,
  curve (8.0808,-19.07) [Pull (7.5959,-16.80) (7.1111,-14.54),Pull (6.4646,-14.70) (5.8181,-14.86),Pull (6.3030,-17.13) (6.7878,-19.39),Pull (7.9343,-20.67) (8.0808,-18.74)]
  |> filled (rgb 131 88 56) |> addOutline (solid 0.3) (rgb 72 43 21)
  ,
  curve (8.0808,-17.45) [Pull (7.9191,-16.80) (7.7575,-16.16),Pull (6.8894,-16.16) (6.1414,-16.80),Pull (6.0030,-17.61) (6.4646,-18.42),Pull (6.4646,-17.93) (6.4646,-17.45),Pull (7.1111,-17.13) (7.7575,-16.80),Pull (7.7575,-17.13) (7.7575,-17.45),Pull (7.9191,-17.45) (8.0808,-17.45)]
  |> filled (rgb 186 162 141) |> addOutline (solid 0.3) (rgb 133 106 85)
  ,
  curve (9.6969,-21.01) [Pull (7.5878,-22.87) (3.8787,-22.30),Pull (2.7058,-17.45) (1.2929,-12.60),Pull (-0.323,-11.62) (-1.939,-12.92),Pull (-1.929,-17.15) (0,-22.94),Pull (0.6129,-23.39) (2.5858,-23.59),Pull (7.4814,-23.70) (9.6969,-21.01)]
  |> filled (rgb 121 79 55) |> addOutline (solid 0.3) (rgb 72 43 21)
  ,
  curve (0.3232,-12.28) [Pull (1.0264,-13.25) (0.9696,-14.22),Pull (0.1383,-16.08) (-1.292,-14.86),Pull (-1.616,-13.73) (-1.939,-12.60),Pull (-0.646,-12.44) (0.6464,-12.28)]
  |> filled (rgb 139 93 60) |> addOutline (solid 0.3) (rgb 72 43 21)
  ,
  curve (0,-11.95) [Pull (-10.95,1.2929) (-15.83,14.545),Pull (-17.13,14.383) (-18.42,14.222),Pull (-17.14,9.3737) (-14.54,4.5252),Pull (-8.980,-6.200) (-1.616,-12.60),Pull (-0.808,-12.12) (0,-11.95)]
  |> filled (rgb 138 95 60) |> addOutline (solid 0.3) (rgb 72 43 21)
  ,
  curve (-12.92,7.7575) [Pull (-14.22,7.1111) (-15.51,6.4646),Pull (-15.53,5.3333) (-14.54,4.2020),Pull (-12.57,5.0101) (-11.95,5.8181),Pull (-12.28,6.7878) (-12.92,7.7575)]
  |> filled (rgb 175 153 132) |> addOutline (solid 0.3) (rgb 136 108 85)
  ,
  curve (-12.60,6.1414) [Pull (-13.25,5.4949) (-14.22,4.8484),Pull (-14.70,5.4949) (-15.19,6.1414),Pull (-14.22,6.6262) (-13.25,7.1111),Pull (-12.92,6.6262) (-12.60,6.1414)]
  |> filled (rgb 138 95 60)
  ,
  curve (-4.848,-5.818) [Pull (-5.818,-6.464) (-6.787,-7.111)]
    |> outlined (solid 0.1) (rgb 72 43 21)
    ,
  curve (-4.848,-6.464) [Pull (-5.656,-6.949) (-6.464,-7.434)]
  |> outlined (solid 0.3) (rgb 72 43 21)

  ]
sleeve_bOutfit3 skin = group 
  [
 
  curve (10.989,-3.232) [Pull (9.6969,-4.970) (8.4040,-6.787),Pull (6.9527,-7.269) (6.1414,-7.111),Pull (2.1971,-4.686) (1.2929,-2.262),Pull (1.6745,-1.616) (1.6161,-0.969),Pull (1.6993,0.1616) (2.2626,1.2929),Pull (1.5777,1.8210) (1.2929,2.9090),Pull (1.0129,5.1301) (1.2929,7.1111),Pull (1.4177,9.2121) (2.2626,11.313),Pull (3.3939,13.342) (4.5252,13.252),Pull (6.0214,10.020) (7.7575,6.7878),Pull (9.8537,3.3939) (10.989,0),Pull (10.706,-1.489) (10.343,-1.939),Pull (10.926,-2.424) (10.989,-3.232)]
  |> filled skin -- shirt
  ,
  curve (-21.65,-2.262) [Pull (-24.62,-2.272) (-26.82,-0.323)]    
  |> outlined (solid 0.3) (rgb 168 146 123)
  ,curve (8.0808,-4.525) [Pull (6.7949,-7.289) (2.9090,-9.373),Pull (2.5577,-11.14) (0.6464,-12.28),Pull (-0.183,-13.54) (-1.292,-13.57),Pull (-2.497,-13.83) (-2.262,-12.92),Pull (-3.329,-13.38) (-3.555,-11.95),Pull (-4.562,-12.33) (-4.848,-10.98),Pull (-5.930,-10.18) (-5.171,-9.373),Pull (-4.363,-8.242) (-3.555,-7.111),Pull (-3.555,-6.949) (-3.555,-6.787),Pull (-1.939,-6.626) (-0.323,-6.464),Pull (1.8545,-4.202) (3.2323,-1.939),Pull (5.6565,-2.472) (8.0808,-4.525)]
   |> filled skin -- right arm
  , curve (-1.939,-12.60) [Pull (-1.174,-11.95) (-0.969,-11.31)]
  |> outlined (solid 0.2) (rgb 171 106 84)  |> move (-0.12,-0.12)
  ,
  curve (-1.939,-10.34) [Pull (-1.965,-10.98) (-3.232,-11.63)]
  |> outlined (solid 0.2) (rgb 171 106 84)  |> move (-0.12,-0.12)
  ,
  curve (-2.909,-9.050) [Pull (-3.015,-9.858) (-4.202,-10.66)]
  |> outlined (solid 0.2) (rgb 171 106 84)  |> move (-0.2,-0.2)
  ,curve (8.0808,-4.202) [Pull (5.6565,-1.769) (3.2323,-1.616)]
  |> outlined (solid 0.6) (rgb 168 146 123) |> makeTransparent 0.8
  ,
  curve (10.989,-3.555) [Pull (10.476,-1.599) (8.4040,-0.323),Pull (5.1717,1.4767) (1.9393,-0.323)]
     |> outlined (solid 0.3) (rgb 168 146 123)
  ]
vest_bOutfit3 = 
  group 
  [
   curve (-16.48,-18.10) [Pull (-16.75,-18.33) (-19.39,-17.77),Pull (-22.83,-17.16) (-23.59,-15.83),Pull (-23.18,-10.34) (-22.30,-4.848),Pull (-20.77,0.9345) (-21.01,7.7575),Pull (-21.01,10.828) (-21.01,13.898),Pull (-17.93,15.030) (-14.86,16.161),Pull (-14.26,12.606) (-13.89,9.0505),Pull (-12.78,3.3939) (-14.22,-2.262),Pull (-15.35,-10.02) (-16.48,-18.10)]
  |> filled (rgb 142 136 88) |> addOutline (solid 0.2) (rgb 69 56 30)
   ,
  curve (4.5252,-16.48) [Pull (-4.552,-19.43) (-7.111,-18.42),Pull (-9.017,-7.757) (-8.404,2.9090),Pull (-8.071,10.875) (-1.939,16.161),Pull (2.4529,15.847) (4.5252,13.252),Pull (4.0404,13.472) (3.5555,13.252),Pull (-0.574,8.5278) (1.6161,0.3232),Pull (3.0707,-7.919) (4.5252,-16.48)]
  |> filled (rgb 142 136 88) |> addOutline (solid 0.2) (rgb 69 56 30)
  ,curve (-15.19,5.8181) [Pull (-15.71,2.2626) (-16.48,-1.292),Pull (-20.87,-2.428) (-21.65,-0.323),Pull (-21.17,3.0707) (-20.68,6.4646),Pull (-17.93,6.3030) (-15.19,5.8181)]
    |> filled (rgb 142 136 88) |> addOutline (solid 0.2) (rgb 69 56 30) -- pocket
  ,
  curve (-15.51,5.8181) [Pull (-15.67,4.8484) (-15.83,3.8787),Pull (-16.21,3.3939) (-18.74,2.9090),Pull (-20.64,3.5555) (-21.33,4.2020),Pull (-21.33,5.3333) (-20.68,6.4646)]
  |>  outlined (solid 0.2) (rgb 69 56 30)
  ,
  curve (-18.42,3.8787) [Pull (-18.40,4.4404) (-19.07,4.2020),Pull (-18.94,3.4004) (-18.42,3.8787)]
  |> filled (rgb 135 121 84) |> addOutline (solid 0.2) (rgb 69 56 30)
  ,
  curve (-17.45,-6.141) [Pull (-17.86,-10.34) (-18.74,-14.54),Pull (-20.04,-15.06) (-21.33,-14.54),Pull (-22.96,-14.07) (-23.59,-12.92),Pull (-22.78,-8.888) (-21.97,-4.848),Pull (-19.71,-5.494) (-17.45,-6.141)]
    |> filled (rgb 142 136 88) |> addOutline (solid 0.2) (rgb 69 56 30) -- pocket 2 
  ,
  curve (-17.45,-5.818) [Pull (-17.75,-7.272) (-18.42,-8.727),Pull (-19.87,-9.268) (-21.33,-9.050),Pull (-22.40,-8.762) (-23.27,-7.434),Pull (-22.78,-6.141) (-22.30,-4.848),Pull (-19.87,-5.333) (-17.45,-5.818)]
    |> filled (rgb 142 136 88) |> addOutline (solid 0.2) (rgb 69 56 30) -- pocket
  ,
  curve (-20.68,-8.080) [Pull (-21.17,-7.340) (-21.65,-8.080),Pull (-20.87,-9.079) (-20.68,-8.080)]
  |> filled (rgb 135 121 84) |> addOutline (solid 0.2) (rgb 69 56 30)

  ,
  curve (-0.323,3.5555) [Pull (-0.323,1.1313) (-0.323,-1.292),Pull (-1.036,-1.776) (-2.909,-1.939),Pull (-5.363,-1.736) (-5.818,-1.292),Pull (-5.979,1.2929) (-6.141,3.8787),Pull (-6.141,3.8787) (-6.141,3.8787),Pull (-6.141,5.0101) (-6.141,6.1414),Pull (-3.232,6.1414) (-0.323,6.1414),Pull (-0.323,5.0101) (-0.323,3.5555)]
      |> filled (rgb 142 136 88) |> addOutline (solid 0.2) (rgb 69 56 30) -- pocket  ,
  ,curve (-0.323,6.1414) [Pull (-0.323,5.0101) (-0.323,3.8787),Pull (-0.874,3.2323) (-2.585,2.5858),Pull (-5.423,2.9323) (-6.141,3.8787),Pull (-6.141,4.8484) (-6.141,5.8181)]
  |>  outlined (solid 0.2) (rgb 69 56 30)
  ,
  curve (-2.585,3.8787) [Pull (-3.190,4.4987) (-3.555,3.8787),Pull (-3.070,2.7604) (-2.585,3.8787)]
  |> filled (rgb 135 121 84) |> addOutline (solid 0.2) (rgb 69 56 30)
  ,
  
  curve (0.6464,-8.727) [Pull (-2.424,-9.535) (-5.494,-10.34),Pull (-5.268,-13.85) (-4.202,-15.83),Pull (-1.711,-15.81) (1.9393,-15.19),Pull (1.2929,-11.79) (0.6464,-8.727)]
    |> filled (rgb 142 136 88) |> addOutline (solid 0.2) (rgb 69 56 30) -- pocket

  ]
shirt_bOutfit3 skin = 
  group
  [
  
  curve (-23.91,-20.36) [Pull (-23.27,-21.01) (-23.59,-21.65),Pull (-24.08,-22.23) (-24.56,-21.97),Pull (-26.83,-20.40) (-26.18,-18.42),Pull (-25.98,-17.01) (-23.91,-20.36)]
   |> filled skin -- left hand
  ,
  curve (-22.62,-6.464) [Pull (-22.95,-10.02) (-23.59,-13.57),Pull (-23.23,-15.51) (-23.59,-17.45),Pull (-23.65,-20.66) (-24.24,-20.36),Pull (-25.05,-20.05) (-25.85,-17.77),Pull (-27.09,-19.52) (-24.56,-22.30),Pull (-24.74,-23.16) (-25.21,-22.62),Pull (-26.34,-22.73) (-27.47,-21.01),Pull (-28.24,-19.69) (-28.76,-18.10),Pull (-28.33,-15.22) (-27.15,-13.89),Pull (-27.30,-9.535) (-26.82,-5.171),Pull (-24.72,-5.818) (-22.62,-6.464)]
   |> filled skin -- left finger

  ,curve (2.5858,-16.16) [Pull (-3.393,-16.94) (-9.373,-17.13),Pull (-17.31,-16.61) (-21.97,-14.54),Pull (-20.52,-4.848) (-19.07,4.8484),Pull (-20.46,-0.728) (-22.62,-6.464),Pull (-26.21,-6.354) (-28.12,-4.525),Pull (-28.57,-3.555) (-27.79,-2.585),Pull (-27.75,0.2486) (-26.50,0.3232),Pull (-26.82,1.9393) (-25.85,3.5555),Pull (-22.78,12.567) (-19.71,13.898),Pull (-10.50,14.868) (-1.292,15.838),Pull (1.1064,-0.161) (2.5858,-16.16)]
  |> filled (rgb 248 233 207) |> addOutline (solid 0.3) (rgb 168 146 123) -- shirt
  
  ]
pants_bOutfit3 = group 
  [
  curve (5.4949,-32) [Pull (4.7690,-33.13) (0.3232,-34.26),Pull (-5.237,-34.93) (-7.757,-33.61),Pull (-8.279,-32.16) (-8.080,-30.70),Pull (-8.122,-30.06) (-8.404,-29.41),Pull (-9.212,-26.50) (-10.02,-23.59),Pull (-10.02,-27.15) (-10.02,-30.70),Pull (-9.600,-32.20) (-10.02,-33.29),Pull (-12.67,-34.07) (-16.16,-33.93),Pull (-21.17,-34.03) (-23.27,-32.32),Pull (-23.37,-30.86) (-23.27,-29.41),Pull (-23.11,-29.25) (-22.94,-29.09),Pull (-22.46,-21.17) (-21.97,-13.25),Pull (-10.66,-13.41) (0.6464,-13.57),Pull (3.8690,-21.49) (5.1717,-29.41),Pull (5.7733,-30.52) (5.4949,-32)]
  |> filled (rgb 203 175 135) |> addOutline (solid 0.3) (rgb 138 108 72)
  , curve (5.4949,-28.12) [Pull (4.4090,-29.73) (0.3232,-30.06),Pull (-0.581,-29.41) (-0.646,-28.44),Pull (-1.092,-25.05) (-1.939,-21.65),Pull (0.9696,-20.91) (3.8787,-21.01),Pull (5.1068,-24.28) (5.4949,-28.12)]
  |> filled (rgb 203 175 135) |> addOutline (solid 0.3) (rgb 138 108 72) -- pocket
  ,
  curve (-1.939,-21.65) [Pull (-1.131,-24.57) (-0.323,-24.56),Pull (3.2610,-24.61) (4.5252,-23.27),Pull (4.1587,-22.14) (3.2323,-21.01)]
  |>outlined (solid 0.3) (rgb 138 108 72)
  ,
  curve (5.4949,-29.09) [Pull (3.2323,-30.46) (0.9696,-31.03),Pull (-1.777,-31.57) (-4.525,-31.67),Pull (-7.623,-31.39) (-8.080,-30.70)]
  |>outlined (solid 0.3) (rgb 138 108 72)
  ,
  curve (-10.02,-30.38) [Pull (-13.27,-31.34) (-17.45,-31.03),Pull (-21.06,-30.90) (-23.27,-29.41)]
  |>outlined (solid 0.3) (rgb 138 108 72)
  ,
  curve (-20.68,-29.41) [Pull (-20.36,-25.37) (-20.04,-21.33),Pull (-21.33,-20.84) (-22.62,-20.36),Pull (-23.31,-21.51) (-23.59,-23.27),Pull (-23.27,-23.67) (-22.94,-23.59),Pull (-23.61,-25.55) (-23.59,-28.12),Pull (-22.70,-30.02) (-20.68,-29.41)]
  |> filled (rgb 203 175 135) |> addOutline (solid 0.3) (rgb 138 108 72) --pocket
  ,
  curve (-20.04,-21.33) [Pull (-20.04,-21.33) (-20.04,-21.33),Pull (-20.02,-22.78) (-21.01,-24.24),Pull (-23.82,-24.41) (-23.59,-23.27),Pull (-23.45,-21.81) (-22.62,-20.36)]
  |>outlined (solid 0.3) (rgb 138 108 72)
  , curve (-9.696,-23.59) [Pull (-10.02,-22.82) (-10.34,-22.30),Pull (-11.23,-22.25) (-11.95,-21.01),Pull (-12.46,-18.18) (-12.60,-15.51)]
  |>outlined (solid 0.5) (rgb 138 108 72) |> move (0,-0.3)
  ,
  curve (-10.66,-16.48) [Pull (-10.32,-18.10) (-10.34,-19.71),Pull (-10.97,-20.62) (-11.95,-20.36)]
   |>outlined (solid 0.2) (rgb 138 108 72)
 
  ]
neck_bOutfit3 skin = group 
  [

  curve (-5.818,17.777) [Pull (-5.818,18.909) (-5.818,20.040),Pull (-8.888,19.555) (-11.95,19.070),Pull (-11.95,18.101) (-11.95,17.131),Pull (-8.228,16.276) (-5.818,18.101)]
  |> filled skin
  ,
  curve (-4.202,19.070) [Pull (-9.508,15.265) (-13.57,18.101)]
  |> outlined (solid 0.3) (rgb 76 66 31)

  
  ]
legs_bOutfit3 skin = 
  group 
  [
   curve (2.2626,-31.03) [Pull (3.0474,-33.45) (3.2323,-35.87),Pull (5.0987,-40.79) (4.5252,-46.54),Pull (1.2929,-46.86) (-1.939,-47.19),Pull (-3.289,-43.95) (-3.878,-40.72),Pull (-4.280,-39.11) (-4.202,-37.49),Pull (-5.593,-34.42) (-6.464,-31.35),Pull (-2.101,-31.03) (2.2626,-31.03)]
    |> filled skin
  ,
  curve (-12.28,-29.73) [Pull (-11.76,-32.96) (-11.95,-36.20),Pull (-10.76,-41.25) (-12.28,-47.19),Pull (-15.67,-47.03) (-19.07,-46.86),Pull (-19.59,-41.85) (-19.71,-36.84),Pull (-20.52,-32.78) (-21.01,-27.47),Pull (-16.64,-28.60) (-12.28,-29.73)]
  |> filled skin


  ]
socks_bOutfit3 = 
  group 
  [
    
  curve (4.8484,-42.66) [Pull (0.8080,-45.30) (-3.232,-43.31),Pull (-3.785,-45.46) (-1.939,-50.10),Pull (1.7777,-50.10) (5.4949,-50.10),Pull (5.3333,-46.54) (5.1717,-42.98),Pull (5.0101,-42.66) (4.8484,-42.66)]
  |> filled (rgb 245 232 205) |> addOutline (solid 0.3) (rgb 185 159 132)
 ,
  curve (-11.63,-42.66) [Pull (-14.69,-44.96) (-19.71,-42.66),Pull (-20.17,-43.15) (-20.04,-43.63),Pull (-20.13,-46.14) (-19.07,-48.48),Pull (-15.67,-48.64) (-12.28,-48.80),Pull (-11.41,-46.06) (-11.31,-43.31),Pull (-11.29,-42.84) (-11.63,-42.66)]
  |> filled (rgb 245 232 205) |> addOutline (solid 0.3) (rgb 185 159 132)

  ]
boot_bOutfit3 =
  group 
  [
  curve (5.1717,-46.22) [Pull (6.3365,-47.17) (6.1414,-48.48),Pull (6.8094,-53.65) (7.7575,-58.82),Pull (6.9781,-60.71) (3.8787,-59.79),Pull (2.5858,-59.73) (1.2929,-60.12),Pull (-1.363,-60.45) (-1.939,-59.15),Pull (-2.802,-57.83) (-2.585,-56.24),Pull (-2.610,-51.86) (-3.555,-48.80),Pull (-3.712,-47.87) (-2.909,-47.19),Pull (-3.217,-48.50) (-0.646,-48.80),Pull (4.6642,-48.52) (5.4949,-47.19),Pull (4.9933,-46.70) (5.1717,-46.22)]
  |> filled (rgb 196 148 99) |> addOutline (solid 0.3) (rgb 97 60 33) -- shoe right 
  ,
  curve (7.7575,-58.50) [Pull (8.1591,-59.37) (8.0808,-60.44),Pull (8.0711,-61.25) (6.1414,-62.06),Pull (4.8587,-62.64) (1.6161,-62.38),Pull (-1.783,-62.21) (-2.262,-60.76),Pull (-2.544,-59.95) (-2.585,-59.15),Pull (-3.607,-57.69) (-2.909,-56.24),Pull (-2.077,-59.54) (-0.646,-59.79),Pull (1.6161,-59.53) (3.8787,-59.47),Pull (7.2781,-60.10) (7.7575,-58.50)]
  |> filled (rgb 152 114 77) |> addOutline (solid 0.3) (rgb 96 58 22) -- bottom shoe right
  
  ,curve (-10.66,-55.59) [Pull (-10.97,-56.38) (-13.25,-56.56),Pull (-15.19,-57.13) (-17.13,-58.18),Pull (-19.58,-59.58) (-22.94,-59.15),Pull (-24.56,-58.50) (-26.18,-58.18),Pull (-27.52,-57.85) (-27.47,-57.53),Pull (-27.97,-55.45) (-24.24,-54.30),Pull (-21.76,-52.52) (-21.01,-50.74),Pull (-21.21,-48.80) (-21.01,-46.86),Pull (-20.64,-46.08) (-19.07,-45.89),Pull (-17.45,-46.12) (-15.83,-46.86),Pull (-15.27,-47.35) (-15.19,-47.83),Pull (-11.95,-48.11) (-11.63,-46.86),Pull (-11.63,-46.70) (-11.63,-46.54),Pull (-10.37,-46.89) (-10.66,-48.48),Pull (-10.96,-49.61) (-10.98,-50.74),Pull (-10.20,-53.45) (-10.66,-55.59)]
  |> filled (rgb 196 148 99) |> addOutline (solid 0.3) (rgb 97 60 33) -- shoe left

  ,curve (-10.66,-55.59) [Pull (-10.97,-56.38) (-13.25,-56.56),Pull (-15.19,-57.13) (-17.13,-58.18),Pull (-19.58,-59.58) (-22.94,-59.15),Pull (-24.56,-58.50) (-26.18,-58.18),Pull (-27.52,-57.85) (-27.47,-57.53),Pull (-28.15,-57.36) (-27.79,-59.47),Pull (-25.95,-61.26) (-22.62,-60.76),Pull (-22.46,-60.60) (-22.30,-60.44),Pull (-22.14,-60.46) (-21.97,-60.76),Pull (-21.49,-61.04) (-21.01,-60.76),Pull (-20.84,-60.60) (-20.68,-60.44),Pull (-20.64,-60.96) (-20.36,-60.76),Pull (-19.65,-60.78) (-19.39,-60.44),Pull (-19.39,-60.28) (-19.39,-60.12),Pull (-19.07,-60.98) (-18.74,-60.44),Pull (-16.41,-60.39) (-16.80,-59.15),Pull (-15.51,-58.92) (-14.22,-58.18),Pull (-14.22,-58.66) (-14.22,-59.15),Pull (-10.86,-58.98) (-10.34,-57.85),Pull (-10.34,-56.72) (-10.34,-55.59),Pull (-10.34,-55.43) (-10.66,-55.59)]
  |> filled (rgb 152 114 77) |> addOutline (solid 0.3) (rgb 96 58 22) --bottom shoe left
  ,
  curve (-14.22,-59.15) [Pull (-14.86,-58.98) (-15.51,-58.82),Pull (-14.86,-58.50) (-14.22,-58.18),Pull (-14.22,-58.66) (-14.22,-59.15)]
  |> filled (rgb 127 93 66)
  ,
  curve (4.5252,-47.83) [Pull (4.1939,-46.51) (2.2626,-46.54),Pull (-1.093,-46.87) (-0.969,-47.51),Pull (-0.966,-48.80) (-0.323,-50.10),Pull (2.2626,-50.26) (4.8484,-50.42),Pull (4.6868,-48.96) (4.5252,-47.83)]
  |> filled (rgb 196 148 99)
  ,curve (4.5252,-47.83) [Pull (4.1939,-46.51) (2.2626,-46.54),Pull (-1.093,-46.87) (-0.969,-47.51),Pull (-0.928,-48.48) (-0.646,-49.45)]
  |> outlined (solid 0.3) (rgb 97 60 33) -- outline
  ,curve (7.4343,-56.88) [Pull (6.7030,-55.90) (5.1717,-55.59),Pull (4.0468,-55.14) (4.2020,-53.01),Pull (4.1420,-51.07) (4.2020,-49.13),Pull (4.4084,-48.12) (5.4949,-47.51)]
  |> outlined (solid 0.2) (rgb 116 76 40) -- outline
  ,
  curve (-1.939,-57.85) [Pull (-1.488,-56.64) (0.3232,-55.91),Pull (0.9648,-55.26) (0.6464,-53.65),Pull (0.4400,-51.39) (-0.646,-49.13),Pull (-2.357,-48.28) (-2.909,-47.51)]
  |> outlined (solid 0.2) (rgb 116 76 40) -- outline
  ,curve (-2.585,-53.33) [Pull (-1.402,-55.11) (-1.939,-56.88),Pull (-2.101,-56.88) (-2.262,-56.88)]
    |> outlined (solid 0.2) (rgb 116 76 40) -- outline
  ,
  curve (-10.98,-51.39) [Pull (-13.28,-53.91) (-13.25,-56.56)]
    |> outlined (solid 0.2) (rgb 116 76 40) -- outline
  ,
  curve (-11.31,-50.42) [Pull (-11.54,-51.04) (-13.89,-51.07),Pull (-14.71,-50.87) (-13.89,-47.83)]
    |> outlined (solid 0.2) (rgb 116 76 40) -- outline
   ,
  curve (-17.13,-57.85) [Pull (-17.11,-57.05) (-18.10,-56.24),Pull (-20.44,-55.47) (-19.71,-53.97),Pull (-17.50,-53.01) (-16.80,-49.77),Pull (-16.73,-48.30) (-15.19,-47.83),Pull (-11.83,-47.91) (-11.31,-47.19)]
    |> outlined (solid 0.2) (rgb 116 76 40) -- outline
    
  ,curve (-23.27,-53.65) [Pull (-21.57,-53.53) (-20.36,-50.10),Pull (-20.66,-48.48) (-20.36,-46.86)]
    |> outlined (solid 0.2) (rgb 116 76 40) -- outline
  ,curve (5.1717,-53.97) [Pull (2.5858,-53.52) (0,-54.30),Pull (-0.696,-54.86) (0.6464,-54.62),Pull (2.9090,-54.06) (5.1717,-54.30),Pull (5.6301,-53.98) (5.1717,-53.97)]
  |> filled (rgb 159 117 78) |> addOutline (solid 0.1) (rgb 118 76 37)  -- shoe laces
  ,
  curve (4.5252,-52.04) [Pull (2.4242,-51.72) (0.3232,-52.36),Pull (0.0248,-52.52) (0.6464,-52.68),Pull (2.5858,-52.14) (4.5252,-52.36),Pull (4.5252,-52.20) (4.5252,-52.04)]
    |> filled (rgb 159 117 78) |> addOutline (solid 0.1) (rgb 118 76 37) -- shoe laces

  ,
  curve (4.8484,-52.36) [Pull (3.5555,-51.39) (2.2626,-50.42),Pull (1.9393,-49.66) (1.6161,-50.10),Pull (0,-49.52) (-1.616,-50.10),Pull (-2.631,-51.84) (-0.646,-51.71),Pull (-0.813,-52.67) (1.9393,-50.42),Pull (2.7123,-49.63) (4.5252,-49.45),Pull (6.2252,-50.54) (4.5252,-51.71),Pull (2.2626,-50.46) (0,-50.10),Pull (-1.244,-50.58) (-0.969,-51.07),Pull (-1.403,-51.98) (4.2020,-49.77),Pull (5.4036,-50.42) (4.5252,-51.07),Pull (1.6458,-50.17) (0.6464,-52.68),Pull (0.1432,-53.52) (0,-53.01),Pull (1.1313,-51.55) (2.2626,-50.10),Pull (3.3939,-51.55) (4.5252,-53.01),Pull (5.0868,-52.90) (4.8484,-52.04)]
  |> filled (rgb 159 117 78) |> addOutline (solid 0.1) (rgb 118 76 37) -- shoe laces
  ,
  curve (-17.77,-52.36) [Pull (-18.66,-50.90) (-19.07,-49.45),Pull (-19.53,-49.17) (-19.71,-49.45),Pull (-21.01,-48.65) (-22.30,-49.13),Pull (-23.31,-50.85) (-21.33,-50.74),Pull (-19.34,-49.82) (-16.16,-50.10),Pull (-16.04,-51.30) (-16.80,-51.07),Pull (-18.42,-50.72) (-20.04,-49.45),Pull (-21.99,-49.43) (-21.97,-49.77),Pull (-22.71,-50.63) (-16.48,-49.45),Pull (-14.98,-50.42) (-15.83,-51.39),Pull (-16.96,-52.15) (-18.10,-51.07)]
  |> filled (rgb 159 117 78) |> addOutline (solid 0.1) (rgb 118 76 37) -- shoe laces
  ,
  curve (-16.80,-52.36) [Pull (-19.07,-51.37) (-21.33,-51.39),Pull (-21.79,-51.39) (-21.65,-51.39),Pull (-19.55,-51.72) (-17.45,-52.68),Pull (-16.75,-52.36) (-16.80,-52.36)]
  |> filled (rgb 159 117 78) |> addOutline (solid 0.1) (rgb 118 76 37) -- shoe laces
 ,
  curve (-18.10,-53.65) [Pull (-20.20,-52.51) (-22.30,-52.36),Pull (-22.74,-52.52) (-22.94,-53.01),Pull (-20.84,-52.77) (-18.74,-54.30),Pull (-18.10,-53.81) (-18.10,-53.65)]
   |> filled (rgb 159 117 78) |> addOutline (solid 0.1) (rgb 118 76 37) -- shoe laces
  ]
  
-- BOY OUTFIT 4

bOutfit4 skin = group [
   skin_bOutfit4 skin

 ,
 clothes_bOutfit4
 ,
 boots_bOutfit4
 
 ,
 unicorn_badge_bOutfit4
 |> scale 0.09
 |> move (-12.5,-7.8)

  ]
 
skin_bOutfit4 skin = group [
  curve (-26.89,7.2347) [Pull (-26.89,6.1217) (-26.89,5.0086),Pull (-26.71,3.3391) (-26.52,1.6695),Pull (-26.52,0.7420) (-26.52,-0.185),Pull (-23.18,0) (-19.84,0.1855),Pull (-19.29,1.1130) (-18.73,2.0405),Pull (-19.10,2.9681) (-19.47,3.8956),Pull (-19.66,5.3797) (-19.84,6.8637),Pull (-23.37,5.4492) (-26.89,7.2347)]
  |> filled skin -- the neck
  , 
  
 curve (-43.96,-19.10) [Pull (-46.52,-22.81) (-45.07,-26.52),Pull (-44.70,-27.94) (-44.33,-26.15),Pull (-43.59,-28.34) (-42.85,-26.52),Pull (-41.36,-21.41) (-39.88,-24.30),Pull (-39.32,-25.90) (-38.77,-24.30),Pull (-38.77,-22.81) (-38.77,-21.33),Pull (-42.56,-21.42) (-43.96,-19.10)]
  |> filled skin -- the the left hand
  ,
  
 curve (-7.605,-20.96) [Pull (-7.976,-22.63) (-8.347,-24.30),Pull (-7.605,-26.48) (-6.863,-24.67),Pull (-5.565,-21.65) (-4.266,-25.04),Pull (-3.339,-28.18) (-2.411,-26.52),Pull (-2.597,-25.41) (-2.782,-24.30),Pull (-2.040,-28.05) (-1.298,-25.41),Pull (-0.440,-22.44) (-2.782,-19.47),Pull (-3.994,-21.42) (-7.605,-20.96)]
  |>filled skin -- the the right hand
  ]
  
clothes_bOutfit4 = group [
  
 curve (-36.17,-28.38) [Pull (-37.34,-35.61) (-36.91,-42.85),Pull (-35.80,-44.57) (-34.68,-44.70),Pull (-31.16,-45.87) (-27.64,-45.44),Pull (-24.15,-43.53) (-24.67,-43.22),Pull (-24.48,-37.10) (-24.30,-30.97),Pull (-23.37,-29.16) (-22.44,-31.35),Pull (-23.06,-37.28) (-22.07,-43.22),Pull (-20.40,-44.73) (-18.73,-45.44),Pull (-15.02,-45.87) (-11.31,-44.70),Pull (-9.188,-43.40) (-9.460,-42.11),Pull (-9.617,-35.43) (-10.57,-28.75),Pull (-12.05,-26.15) (-13.54,-23.55),Pull (-20.59,-23.55) (-27.64,-23.55),Pull (-31.90,-25.97) (-36.17,-28.38)]
  |> filled (rgb 161 187 160) -- the pants
 
 ,
 curve (-29.49,3.8956) [Pull (-35.51,3.6579) (-39.14,-5.379),Pull (-43.12,-10.01) (-44.70,-14.65),Pull (-45.13,-16.32) (-43.96,-17.99),Pull (-40.99,-20.70) (-38.02,-20.22),Pull (-34.57,-18.97) (-34.31,-16.13),Pull (-23.18,-20.53) (-12.05,-16.13),Pull (-11.21,-19.77) (-7.976,-20.22),Pull (-5.194,-20.12) (-2.411,-17.62),Pull (-1.211,-15.58) (-2.411,-13.54),Pull (-6.620,-5.750) (-12.42,2.0405),Pull (-15.02,4.1681) (-17.62,3.8956),Pull (-19.04,0.9971) (-22.07,1.2985),Pull (-22.63,0.1855) (-23.18,-0.927),Pull (-23.74,0) (-24.30,0.9275),Pull (-28.49,1.2115) (-29.49,3.8956)]
  |> filled (rgb 162 200 209) -- the top of the shirt with thw two arms
  ,
  
 curve (-35.43,-18.73) [Pull (-36.91,-22.81) (-38.4,-26.89),Pull (-34.12,-30.53) (-25.04,-30.97),Pull (-24.91,-28.01) (-23.18,-25.04),Pull (-21.64,-27.82) (-21.70,-30.60),Pull (-15.02,-32.53) (-8.347,-27.26),Pull (-9.646,-23.18) (-10.94,-19.10),Pull (-11.31,-18.36) (-11.68,-17.62),Pull (-22.38,-22.42) (-34.68,-17.62),Pull (-35.06,-18.17) (-35.43,-18.73)]
  |> filled (rgb 163 201 210) -- the bottem of the shirt 
  ,
  
 curve (-18.73,6.4927) [Pull (-22.37,4.8231) (-22.81,3.1536),Pull (-22.81,1.4840) (-22.81,-0.185),Pull (-23.37,-2.185) (-23.93,-0.185),Pull (-23.93,1.6695) (-23.93,3.5246),Pull (-26.34,6.0231) (-28.75,6.1217),Pull (-29.52,5.0086) (-29.49,3.8956),Pull (-28.49,0.8115) (-24.30,0.9275),Pull (-23.18,0.9275) (-22.07,0.9275),Pull (-17.04,1.3971) (-17.62,4.2666),Pull (-17.43,5.0086) (-17.25,5.7507),Pull (-18.79,4.9217) (-18.73,6.4927)]
  |> filled (rgb 163 201 210) -- the bottem of the shirt 
  ,
  
 curve (-18.73,6.4927) [Pull (-22.37,4.8231) (-22.81,3.1536),Pull (-22.81,1.4840) (-22.81,-0.185),Pull (-23.37,-2.185) (-23.93,-0.185),Pull (-23.93,1.6695) (-23.93,3.5246),Pull (-26.34,6.0231) (-28.75,6.1217),Pull (-29.52,5.0086) (-29.49,3.8956),Pull (-28.49,0.8115) (-24.30,0.9275),Pull (-23.18,0.9275) (-22.07,0.9275),Pull (-17.04,1.3971) (-17.62,4.2666),Pull (-17.43,5.0086) (-17.25,5.7507),Pull (-18.79,4.9217) (-18.73,6.4927)]
  |> outlined (solid 0.3) white -- the colar of the shirt
  ,
  
 curve (-43.96,-17.99) [Pull (-45.56,-18.15) (-43.96,-19.10),Pull (-42.56,-21.42) (-38.77,-21.33),Pull (-36.77,-20.77) (-38.77,-20.22),Pull (-41.76,-20.30) (-43.96,-17.99)]
  |> filled (rgb 163 201 210) -- the bottem of th left sleeve
  ,
  curve (-2.411,-17.99) [Pull (-1.397,-18.55) (-2.782,-19.10),Pull (-3.994,-21.84) (-7.605,-20.59),Pull (-8.991,-21.20) (-7.976,-20.22),Pull (-4.394,-19.72) (-2.411,-17.99)]
  |> filled (rgb 163 201 210)-- the bottem of the right sleeve
  ,
  
 curve (-34.31,-16.13) [Pull (-34.50,-16.88) (-34.68,-17.62),Pull (-22.38,-22.02) (-11.68,-17.62),Pull (-11.47,-16.69) (-12.05,-15.76),Pull (-22.57,-20.96) (-34.31,-16.13)]
  |> filled (rgb 163 189 202)
  |> addOutline (solid 0.5) (rgb 163 189 202) -- the band on his stomach
  ,
  curve (-25.41,-1.669) [Pull (-27.01,-2.226) (-25.41,-2.782),Pull (-23.55,-2.782) (-21.70,-2.782),Pull (-20.10,-2.226) (-21.70,-1.669),Pull (-23.55,-1.669) (-25.41,-1.669)]
 |> filled (rgb 138 151 160) -- the first button on the shirt
  ,
  -- the second button
  
 curve (-25.04,-3.524) [Pull (-23.84,-4.081) (-25.04,-4.637),Pull (-26.45,-4.081) (-25.04,-3.524)]
 |>filled (rgb 138 151 160)
  ,
  
 curve (-22.07,-3.524) [Pull (-20.68,-4.266) (-21.70,-5.008),Pull (-23.48,-4.266) (-22.07,-3.524)]
 |> filled (rgb 138 151 160)
  ,
  
 curve (-24.30,-3.895) [Pull (-23.55,-3.895) (-22.81,-3.895)]
 |> outlined (solid 0.5) (rgb 138 151 160) -- the string conntecting the circles
  ,
  
 curve (-19.47,-2.411) [Pull (-17.06,-3.182) (-14.65,-3.153),Pull (-14.16,-6.579) (-16.88,-7.605),Pull (-20.97,-5.808) (-19.47,-2.411)]
 |> filled (rgb 218 185 144) -- the badge
 ,
 curve (-36.91,-24.30) [Pull (-35.16,-28.89) (-25.41,-29.49),Pull (-26.27,-26.52) (-23.93,-23.55),Pull (-23.00,-22.94) (-22.07,-23.93),Pull (-20.31,-26.52) (-20.96,-29.12),Pull (-15.02,-30.62) (-9.089,-26.52)]
 |> outlined (solid 0.5) white -- the print on the bottem shirt
 ,
 -- the deatails on the cloths. All the same color
 
 curve (-33.57,-3.895) [Pull (-34.90,-8.347) (-35.43,-12.8),Pull (-36.07,-14.28) (-34.31,-15.76)]
 |> outlined (solid 0.5)(rgb 95 127 138)
  ,
  
 curve (-12.8,-3.524) [Pull (-12.05,-7.976) (-11.31,-12.42),Pull (-11.28,-14.09) (-12.05,-15.76)]
 |> outlined (solid 0.5) (rgb 95 127 138)
  ,
  -- arms
 curve (-40.99,-19.84) [Pull (-39.66,-18.92) (-39.14,-17.99)]
 |> outlined (solid 0.5)(rgb 95 127 138) 
  ,
  
 curve (-43.22,-18.36) [Pull (-43.62,-17.25) (-43.22,-16.13)]
 |> outlined (solid 0.5) (rgb 95 127 138) 
  ,
  curve (-3.895,-18.36) [Pull (-3.281,-16.88) (-4.266,-15.39)]
 |> outlined (solid 0.5) (rgb 95 127 138)
  ,
  curve (-5.379,-19.47) [Pull (-7.478,-18.36) (-7.976,-17.25)]
 |> outlined (solid 0.5) (rgb 95 127 138)
  ,
  
 curve (-17.62,-17.62) [Pull (-15.73,-16.32) (-14.65,-15.02)]
 |> outlined (solid 0.5)(rgb 95 127 138)
  ,
  curve (-29.49,-17.62) [Pull (-31.99,-16.13) (-32.09,-14.65)]
  |> outlined (solid 0.5)(rgb 95 127 138)
 ,
 curve (-14.65,-18.73) [Pull (-14.46,-19.47) (-14.28,-20.22)]
 |> outlined (solid 0.5) (rgb 95 127 138)
  ,
  curve (-31.72,-18.73) [Pull (-32.27,-19.84) (-32.83,-20.96)]
 |> outlined (solid 0.5)(rgb 95 127 138)
  
  ]
  
boots_bOutfit4 = group [
  
 curve (-35.80,-43.96) [Pull (-37.18,-45.82) (-36.17,-47.67),Pull (-30.97,-49.86) (-25.78,-48.04),Pull (-25.35,-46.37) (-26.52,-44.70),Pull (-31.16,-47.53) (-35.80,-43.96)]
  |> filled (rgb 170 137 120)
  |> addOutline (solid 0.5)(rgb 170 137 120)-- the left boots top
  ,
  
 curve (-35.06,-47.67) [Pull (-35.06,-49.90) (-35.06,-52.12),Pull (-38.30,-53.79) (-39.14,-55.46),Pull (-39.22,-56.79) (-36.91,-57.32),Pull (-31.47,-57.80) (-27.64,-55.09),Pull (-27.26,-54.72) (-26.89,-54.35),Pull (-27.08,-51.38) (-27.26,-48.41),Pull (-32.06,-50.01) (-35.06,-47.67)]
  |> filled (rgb 153 128 106) -- the left boots 
  ,
  
 curve (-20.22,-44.33) [Pull (-21.20,-46.19) (-20.59,-48.04),Pull (-15.39,-50.26) (-10.20,-47.67),Pull (-10.17,-46.19) (-10.94,-44.70),Pull (-16.54,-46.89) (-20.22,-44.33)]
  |>  filled (rgb 170 137 120) -- the right boots top
  ,
  
 curve (-19.84,-48.41) [Pull (-19.66,-51.94) (-19.47,-55.46),Pull (-17.71,-57.19) (-13.54,-57.32),Pull (-10.57,-57.53) (-7.605,-56.95),Pull (-6.846,-54.53) (-11.68,-52.12),Pull (-11.68,-50.08) (-11.68,-48.04),Pull (-14.10,-49.80) (-19.84,-48.41)]
  |> filled (rgb 153 128 106)  -- the right boots 
  ,
  
 curve (-39.08,-56.18) [Pull (-39.95,-57.16) (-38.43,-58.13),Pull (-33.05,-59.72) (-27.68,-56.50),Pull (-25.92,-55.69) (-27.35,-54.88),Pull (-34.58,-58.56) (-39.08,-56.18)]
 |> filled (rgb 116 91 87) -- the left boots heel
  ,
  
 curve (-7.491,-57.16) [Pull (-7.431,-57.97) (-9.770,-58.78),Pull (-12.05,-59.18) (-14.33,-58.78),Pull (-18.13,-57.64) (-19.54,-56.50),Pull (-20.57,-55.62) (-19.21,-55.53),Pull (-14.71,-59.38) (-7.491,-57.16)]
 |> filled (rgb 116 91 87)
 |> addOutline (solid 0.8)(rgb 116 91 87) -- the right boots heel
  ,
  
 curve (-36.17,-52.86) [Pull (-34.87,-52.44) (-33.57,-53.61)]
 |> outlined (solid 0.5) (rgb 123 87 71) -- the left boots lace
  ,
  
 curve (-35.06,-52.12) [Pull (-33.57,-51.29) (-32.09,-52.86)]
 |> outlined (solid 0.5) (rgb 123 87 71) -- the left boots lace
  ,
  
 curve (-10.57,-52.86) [Pull (-11.87,-52.62) (-13.17,-53.98)]
 |> outlined (solid 0.5) (rgb 123 87 71) -- the right boots lace
  ,
  curve (-11.68,-52.12) [Pull (-13.17,-51.48) (-14.65,-53.24)]
 |> outlined (solid 0.5) (rgb 123 87 71) -- the right boots lace
  ]
  
unicorn_badge_bOutfit4 =  group [
  
 
  -- face 
  curve (-63.62,35.802) [Pull (-64.18,34.504) (-64.74,33.205),Pull (-65.66,31.907) (-66.59,30.608),Pull (-67.52,30.052) (-68.45,29.495),Pull (-69.19,29.310) (-69.93,29.124),Pull (-70.12,28.568) (-70.30,28.011),Pull (-70.12,27.084) (-69.93,26.156),Pull (-69.19,25.414) (-68.45,24.672),Pull (-67.33,23.744) (-66.22,22.817),Pull (-64.74,22.446) (-63.25,22.075),Pull (-61.95,22.446) (-60.66,22.817),Pull (-56.57,23.188) (-52.49,23.559),Pull (-53.42,23.188) (-54.35,22.817),Pull (-50.27,21.704) (-46.19,20.591),Pull (-46.19,21.704) (-46.19,22.817),Pull (-46.37,24.857) (-46.56,26.898),Pull (-46.19,28.568) (-45.82,30.237),Pull (-45.44,32.278) (-45.07,34.318),Pull (-45.26,36.359) (-45.44,38.4),Pull (-45.82,39.513) (-46.19,40.626),Pull (-46.37,40.440) (-46.56,40.255),Pull (-45.82,41.924) (-45.07,43.594),Pull (-45.44,45.820) (-45.82,48.046),Pull (-46.74,49.530) (-47.67,51.014),Pull (-48.97,49.901) (-50.27,48.788),Pull (-50.64,46.747) (-51.01,44.707),Pull (-50.64,43.408) (-50.27,42.110),Pull (-51.38,43.037) (-52.49,43.965),Pull (-53.05,42.481) (-53.61,40.997),Pull (-53.98,39.884) (-54.35,38.771),Pull (-55.46,37.657) (-56.57,36.544),Pull (-58.24,36.173) (-59.91,35.802),Pull (-60.66,35.802) (-61.40,35.802),Pull (-61.40,35.802) (-63.62,35.802)]
  |> filled (rgb 253 248 237)
  |> addOutline (solid 1) (rgb 253 248 237)
 ,
 -- eye
 curve (-53.61,35.431) [Pull (-52.68,35.988) (-51.75,36.544),Pull (-52.49,35.988) (-53.24,35.431),Pull (-53.24,35.246) (-53.24,35.060),Pull (-52.68,35.060) (-52.12,35.060),Pull (-51.57,35.431) (-51.01,35.802),Pull (-51.75,35.246) (-52.49,34.689),Pull (-52.49,34.689) (-52.49,34.689),Pull (-51.57,34.689) (-50.64,34.689),Pull (-51.57,34.504) (-52.49,34.318),Pull (-52.49,33.947) (-52.49,33.576),Pull (-51.57,33.576) (-50.64,33.576),Pull (-51.57,33.391) (-52.49,33.205),Pull (-51.75,33.020) (-51.01,32.834),Pull (-50.82,32.834) (-50.64,32.834),Pull (-51.38,32.834) (-52.12,32.834),Pull (-52.49,32.278) (-52.86,31.721),Pull (-53.24,30.979) (-53.61,30.237),Pull (-54.72,30.423) (-55.83,30.608),Pull (-56.76,30.608) (-57.69,30.608),Pull (-57.50,30.794) (-57.32,30.979),Pull (-57.32,31.721) (-57.32,32.463),Pull (-57.13,33.205) (-56.95,33.947),Pull (-56.39,34.504) (-55.83,35.060),Pull (-54.72,35.246) (-53.61,35.431)]
  |> filled black
  ,
 -- front hair 
 curve (-44.33,44.707) [Pull (-43.59,44.892) (-42.85,45.078),Pull (-41.73,44.892) (-40.62,44.707),Pull (-39.32,44.150) (-38.02,43.594),Pull (-37.28,42.481) (-36.54,41.368),Pull (-36.54,39.884) (-36.54,38.4),Pull (-36.73,37.472) (-36.91,36.544),Pull (-36.17,34.689) (-35.43,32.834),Pull (-34.68,31.536) (-33.94,30.237),Pull (-34.31,28.011) (-34.68,25.785),Pull (-35.43,24.486) (-36.17,23.188),Pull (-36.91,21.704) (-37.65,20.220),Pull (-37.84,18.365) (-38.02,16.510),Pull (-37.65,15.211) (-37.28,13.913),Pull (-36.17,13.542) (-35.06,13.171),Pull (-34.50,13.542) (-33.94,13.913),Pull (-33.76,14.655) (-33.57,15.397),Pull (-33.39,14.469) (-33.20,13.542),Pull (-33.76,12.8) (-34.31,12.057),Pull (-34.87,11.872) (-35.43,11.686),Pull (-37.28,12.243) (-39.14,12.8),Pull (-40.44,13.913) (-41.73,15.026),Pull (-42.48,16.881) (-43.22,18.736),Pull (-43.59,20.776) (-43.96,22.817),Pull (-44.52,22.260) (-45.07,21.704),Pull (-45.44,21.704) (-45.82,21.704),Pull (-46.00,24.301) (-46.19,26.898),Pull (-46.00,29.124) (-45.82,31.350),Pull (-45.44,33.947) (-45.07,36.544),Pull (-45.63,38.585) (-46.19,40.626),Pull (-46.19,40.811) (-44.33,44.707)]
   |> filled (gradient [ stop (rgb 252 199 244)  0 , stop blue 40, stop blue 200])
  ,
 -- top hair
 curve (-50.27,47.675) [Pull (-51.75,48.973) (-53.24,50.272),Pull (-54.91,50.457) (-56.57,50.643),Pull (-57.50,50.457) (-58.43,50.272),Pull (-60.10,49.159) (-61.77,48.046),Pull (-62.51,47.675) (-63.25,47.304),Pull (-64,46.933) (-64.74,46.562),Pull (-65.11,46.747) (-65.48,46.933),Pull (-65.85,47.675) (-66.22,48.417),Pull (-66.22,48.788) (-66.22,49.159),Pull (-66.59,48.788) (-66.96,48.417),Pull (-66.78,47.304) (-66.59,46.191),Pull (-65.66,46.005) (-64.74,45.820),Pull (-64.18,45.634) (-63.62,45.449),Pull (-64.37,44.707) (-65.11,43.965),Pull (-65.66,43.594) (-66.22,43.223),Pull (-67.33,40.811) (-68.45,38.4),Pull (-69.19,36.544) (-69.93,34.689),Pull (-71.42,33.762) (-72.90,32.834),Pull (-70.86,33.205) (-68.82,33.576),Pull (-66.78,34.875) (-64.74,36.173),Pull (-61.58,35.988) (-58.43,35.802),Pull (-56.76,37.657) (-55.09,39.513),Pull (-53.79,41.368) (-52.49,43.223),Pull (-51.75,43.037) (-51.01,42.852),Pull (-50.82,43.037) (-50.27,47.675)]
  |> filled (gradient [ stop (rgb 252 199 244)  0 , stop blue 40, stop blue 200])
  ,
  
  --smile
  curve (-64.37,25.043) [Pull (-64.55,24.672) (-64.74,24.301),Pull (-65.11,23.930) (-65.48,23.559),Pull (-65.85,23.373) (-66.22,23.188)]
   |> outlined (solid 1) black
   ,
   circle 1 
   |> filled white
   |> move (-54,33.8)
   ,
    circle 0.8
   |> filled white
   |> move (-56,32)
   ,
   oval 2 1
   |> filled pink
   |> move (-55,29) ]
  
  
-- BOY HAIR 1

shadeColor factor col =
  if col == rgb 30 20 10 then rgb (min 255 (30 * factor)) (min 255 (20 * factor)) (min 255 (10 * factor))
  else if col == rgb 80 50 20 then rgb (min 255 (80 * factor)) (min 255 (50 * factor)) (min 255 (20 * factor))
  else if col == rgb 200 170 80 then rgb (min 255 (200 * factor)) (min 255 (170 * factor)) (min 255 (80 * factor))
  else if col == rgb 180 80 40 then rgb (min 255 (180 * factor)) (min 255 (80 * factor)) (min 255 (40 * factor))
  else if col == rgb 190 190 190 then rgb (min 255 (190 * factor)) (min 255 (190 * factor)) (min 255 (190 * factor))
  else if col == rgb 252 163 217 then rgb (min 255 (252 * factor)) (min 255 (163 * factor)) (min 255 (217 * factor))
  else if col == rgb 100 160 230 then rgb (min 255 (100 * factor)) (min 255 (160 * factor)) (min 255 (230 * factor))
  else if col == rgb 200 60 40 then rgb (min 255 (200 * factor)) (min 255 (60 * factor)) (min 255 (40 * factor))
  else col
  
bHair1 hCol  =
  let
    shade factor = shadeColor factor hCol
      
  in 
    group [

     curve (28.3,-53.6) [Pull (31.279,-45.27) (38.9,-42),Pull (42.200,-32.28) (47.301,-22.57),Pull (47.367,-18.90) (48.232,-15.24),Pull (49.570,-15.92) (50.909,-20.36),Pull (52.089,-10.16) (45.789,-6.167),Pull (49.172,-6.039) (51.956,-5.352),Pull (55.974,-1.861) (58.472,1.6290),Pull (56.229,-0.723) (52.305,-1.396),Pull (47.690,-1.005) (44.276,0.4654),Pull (45.090,1.5709) (45.905,2.6763),Pull (50.298,2.3454) (51.490,4.6545),Pull (51.84,6.2254) (52.189,7.7963),Pull (50.800,4.5054) (46.370,4.6545),Pull (52.052,9.6581) (51.374,14.661),Pull (51.867,20.130) (50.56,25.6),Pull (49.370,18.301) (42.181,13.963),Pull (44.107,18.501) (44.392,23.04),Pull (44.020,25.832) (42.647,28.625),Pull (41.321,30.370) (39.156,32.116),Pull (40.832,28.741) (39.389,25.367),Pull (38.710,23.447) (36.712,21.527),Pull (35.992,33.834) (27.752,40.261),Pull (22.623,44.438) (16.814,48.174),Pull (20.352,43.423) (20.770,36.072),Pull (20.538,34.443) (20.305,32.814),Pull (19.374,33.745) (18.443,34.676),Pull (17.770,38.563) (15.418,41.890),Pull (16.194,37.858) (14.370,35.025),Pull (8.0527,42.716) (-2.385,45.847),Pull (3.3290,43.294) (5.6436,37.701),Pull (-5.514,45.234) (-18.79,49.687),Pull (-13.35,45.603) (-11.11,38.4),Pull (-15.66,40.749) (-21.58,41.658),Pull (-28.95,42.338) (-37.41,41.658),Pull (-40.62,41.229) (-42.99,39.68),Pull (-37.49,40.449) (-32.98,37.818),Pull (-35.01,36.405) (-39.15,36.072),Pull (-45.94,34.909) (-53.81,35.025),Pull (-57.08,35.101) (-59.52,36.538),Pull (-56.97,32.872) (-52.30,29.207),Pull (-50.58,28.189) (-48.46,27.810),Pull (-52.13,26.409) (-56.49,26.647),Pull (-61.04,25.636) (-64.52,26.065),Pull (-68.59,27.985) (-70.10,29.905),Pull (-70.19,26.005) (-68.59,20.945),Pull (-66.73,17.594) (-63.70,15.243),Pull (-65.67,14.952) (-67.2,14.661),Pull (-69.54,17.396) (-70.80,20.130),Pull (-70.87,17.396) (-69.99,14.661),Pull (-74.24,14.961) (-78.48,14.661),Pull (-75.46,14.150) (-73.48,12.8),Pull (-71.16,12.072) (-69.41,10.705),Pull (-66.50,10.718) (-63.59,9.8909),Pull (-67.13,8.7309) (-71.38,8.6109),Pull (-78.57,8.7000) (-82.56,11.869),Pull (-82.96,8.8436) (-82.32,5.8181),Pull (-81.55,3.3654) (-79.30,1.5127),Pull (-76.99,-2.620) (-71.85,-5.352),Pull (-74.70,-7.036) (-76.50,-8.96),Pull (-81.79,-12.07) (-86.05,-10.70),Pull (-84.96,-13.03) (-81.28,-15.36),Pull (-76.77,-17.37) (-72.55,-16.75),Pull (-75.62,-19.09) (-77.09,-22.10),Pull (-77.93,-25.36) (-77.78,-28.62),Pull (-77.05,-25.47) (-74.64,-22.92),Pull (-76.48,-28.85) (-73.36,-34.79),Pull (-73.76,-31.94) (-70.80,-29.09),Pull (-71.89,-34.73) (-67.66,-40.37),Pull (-68.43,-37.41) (-67.2,-34.44),Pull (-65.47,-39.62) (-62.19,-44.8),Pull (-57.75,-46.91) (-54.51,-52.94),Pull (-57.24,-44.16) (-56.72,-35.37),Pull (-54.49,-29.96) (-50.90,-24.55),Pull (-52.26,-21.81) (-52.42,-19.08),Pull (-42.50,-11.15) (-30.42,-10.93),Pull (-36.25,-16.17) (-39.27,-22.57),Pull (-36.53,-20.47) (-31.59,-20.13),Pull (-16.72,-15.21) (-3.898,-6.749),Pull (-2.343,-8.129) (-3.549,-13.14),Pull (-1.290,-10.41) (-0.872,-7.68),Pull (0.6890,-6.727) (4.1309,-7.214),Pull (5.2418,-9.729) (4.7127,-12.68),Pull (7.4654,-9.949) (7.7381,-7.214),Pull (9.9999,-6.981) (11.461,-6.749),Pull (18.229,-13.05) (19.956,-24.20),Pull (21.814,-20.18) (21.352,-16.17),Pull (23.954,-22.69) (23.796,-31.41),Pull (26.552,-34.24) (27.869,-38.51),Pull (29.343,-44.91) (28.218,-53.64)]
     |> filled (shade 1.0),

    curve (28.3,-53.6) [Pull (31.279,-45.27) (38.9,-42),Pull (42.200,-32.28) (47.301,-22.57),Pull (47.367,-18.90) (48.232,-15.24),Pull (49.570,-15.92) (50.909,-20.36),Pull (52.089,-10.16) (45.789,-6.167),Pull (49.172,-6.039) (51.956,-5.352),Pull (55.974,-1.861) (58.472,1.6290),Pull (56.229,-0.723) (52.305,-1.396),Pull (47.690,-1.005) (44.276,0.4654),Pull (45.090,1.5709) (45.905,2.6763),Pull (50.298,2.3454) (51.490,4.6545),Pull (51.84,6.2254) (52.189,7.7963),Pull (50.800,4.5054) (46.370,4.6545),Pull (52.052,9.6581) (51.374,14.661),Pull (51.867,20.130) (50.56,25.6),Pull (49.370,18.301) (42.181,13.963),Pull (44.107,18.501) (44.392,23.04),Pull (44.020,25.832) (42.647,28.625),Pull (41.321,30.370) (39.156,32.116),Pull (40.832,28.741) (39.389,25.367),Pull (38.710,23.447) (36.712,21.527),Pull (35.992,33.834) (27.752,40.261),Pull (22.623,44.438) (16.814,48.174),Pull (20.352,43.423) (20.770,36.072),Pull (20.538,34.443) (20.305,32.814),Pull (19.374,33.745) (18.443,34.676),Pull (17.770,38.563) (15.418,41.890),Pull (16.194,37.858) (14.370,35.025),Pull (8.0527,42.716) (-2.385,45.847),Pull (3.3290,43.294) (5.6436,37.701),Pull (-5.514,45.234) (-18.79,49.687),Pull (-13.35,45.603) (-11.11,38.4),Pull (-15.66,40.749) (-21.58,41.658),Pull (-28.95,42.338) (-37.41,41.658),Pull (-40.62,41.229) (-42.99,39.68),Pull (-37.49,40.449) (-32.98,37.818),Pull (-35.01,36.405) (-39.15,36.072),Pull (-45.94,34.909) (-53.81,35.025),Pull (-57.08,35.101) (-59.52,36.538),Pull (-56.97,32.872) (-52.30,29.207),Pull (-50.58,28.189) (-48.46,27.810),Pull (-52.13,26.409) (-56.49,26.647),Pull (-61.04,25.636) (-64.52,26.065),Pull (-68.59,27.985) (-70.10,29.905),Pull (-70.19,26.005) (-68.59,20.945),Pull (-66.73,17.594) (-63.70,15.243),Pull (-65.67,14.952) (-67.2,14.661),Pull (-69.54,17.396) (-70.80,20.130),Pull (-70.87,17.396) (-69.99,14.661),Pull (-74.24,14.961) (-78.48,14.661),Pull (-75.46,14.150) (-73.48,12.8),Pull (-71.16,12.072) (-69.41,10.705),Pull (-66.50,10.718) (-63.59,9.8909),Pull (-67.13,8.7309) (-71.38,8.6109),Pull (-78.57,8.7000) (-82.56,11.869),Pull (-82.96,8.8436) (-82.32,5.8181),Pull (-81.55,3.3654) (-79.30,1.5127),Pull (-76.99,-2.620) (-71.85,-5.352),Pull (-74.70,-7.036) (-76.50,-8.96),Pull (-81.79,-12.07) (-86.05,-10.70),Pull (-84.96,-13.03) (-81.28,-15.36),Pull (-76.77,-17.37) (-72.55,-16.75),Pull (-64.27,-14.48) (-57.19,-10.93),Pull (-52.66,-8.290) (-48.81,-5.003),Pull (-63.58,-7.841) (-70.10,-2.56),Pull (-74.46,1.3454) (-76.74,6.0509),Pull (-68.73,2.3109) (-56.96,2.2109),Pull (-51.16,2.1345) (-46.25,3.2581),Pull (-54.93,8.1200) (-61.73,14.661),Pull (-64.26,19.076) (-65.80,23.970),Pull (-51.13,22.150) (-36.71,25.250),Pull (-43.62,26.560) (-49.04,29.789),Pull (-46.23,30.967) (-43.22,31.185),Pull (-35.41,32.581) (-23.91,30.138),Pull (-26.23,33.283) (-30.42,37.469),Pull (-24.01,37.470) (-14.83,34.792),Pull (-8.329,31.292) (-2.501,24.552),Pull (-6.925,34.600) (-12.50,43.287),Pull (-3.269,40.734) (4.1309,36.421),Pull (10.123,31.749) (13.556,24.436),Pull (16.645,29.009) (16.814,35.141),Pull (18.645,27.752) (17.396,20.363),Pull (22.403,28.101) (23.330,35.84),Pull (23.361,39.098) (21.352,42.356),Pull (27.890,38.300) (30.429,30.603),Pull (33.983,23.565) (33.338,12.567),Pull (33.012,10.470) (31.127,7.2145),Pull (39.569,9.5709) (43.810,12.567),Pull (42.714,6.1545) (39.738,1.8618),Pull (38.880,0.1745) (37.061,-1.512),Pull (40.587,-2.981) (43.112,-3.490),Pull (41.238,-4.690) (37.643,-4.770),Pull (41.518,-8.736) (43.112,-14.66),Pull (40.201,-10.63) (34.850,-8.96),Pull (36.169,-12.74) (34.967,-18.85),Pull (32.701,-12.17) (27.636,-8.261),Pull (29.772,-14.89) (27.869,-21.52),Pull (27.899,-16.05) (25.890,-10.58),Pull (26.134,-18.44) (23.098,-26.29),Pull (25.649,-29.91) (26.24,-35.37),Pull (29.974,-41.39) (27.869,-53.06)]
     |> filled (shade 1.29),

    curve (-1.338,-3.956) [Pull (-10.58,1.7345) (-26.70,0.4654),Pull (-24.25,-2.405) (-19.95,-3.956),Pull (-28.55,-4.338) (-36.71,-7.68),Pull (-47.77,-12.63) (-54.4,-19.78),Pull (-58.54,-22.74) (-59.52,-25.94),Pull (-60.00,-20.77) (-56.49,-15.59),Pull (-55.22,-11.77) (-52.07,-10.24),Pull (-49.77,-6.774) (-45.32,-5.469),Pull (-41.39,-1.658) (-35.54,0.2327),Pull (-30.31,2.0818) (-24.61,3.4909),Pull (-19.07,4.3599) (-12.50,4.1890),Pull (-5.978,2.6818) (-0.407,-3.025),Pull (-4.081,7.4563) (-9.716,14.778),Pull (-12.68,20.074) (-17.04,23.970),Pull (-13.97,23.956) (-9.134,22.341),Pull (-1.778,16.814) (3.8981,10.007),Pull (3.1690,16.814) (-0.64,23.621),Pull (-1.703,26.414) (-4.247,29.207),Pull (0.9145,28.199) (3.3163,24.552),Pull (9.5981,20.072) (12.16,11.752),Pull (14.612,17.147) (12.625,22.341),Pull (17.867,19.372) (18.909,12.683),Pull (18.498,3.4309) (13.207,-1.861),Pull (16.903,5.12) (16,12.101),Pull (15.247,7.1563) (10.414,2.2109),Pull (11.021,9.7745) (6.1090,17.338),Pull (9.8127,6.5745) (5.8763,-4.189),Pull (3.7909,3.4909) (-2.734,11.170),Pull (1.4672,5.7018) (0.9890,0.2327),Pull (0.9709,-1.978) (-0.407,-4.189),Pull (-0.989,-3.723) (-1.570,-3.258)]
    |> filled (shade 1.64),

    curve (3.5490,-4.770) [Pull (1.9727,1.1636) (-1.803,7.0981),Pull (2.2654,5.1090) (4.0145,1.28),Pull (5.4090,-1.570) (5.6436,-4.421),Pull (9.0890,1.5345) (9.1345,9.8909),Pull (10.474,5.9345) (10.414,1.9781),Pull (14.830,6.5163) (15.767,11.054),Pull (14.465,2.9672) (10.763,-5.12),Pull (16.239,-6.589) (18.676,-10.93),Pull (20.463,-16.05) (19.490,-21.17),Pull (19.250,-15.53) (15.650,-9.890),Pull (13.918,-7.787) (10.065,-7.563),Pull (9.1890,-10.98) (5.9927,-12.8),Pull (7.7509,-10.29) (7.3890,-7.796),Pull (4.9290,-6.898) (0.9890,-7.68),Pull (-0.327,-9.818) (-3.083,-10.35),Pull (-0.950,-8.959) (-1.338,-7.563),Pull (-1.679,-6.181) (-3.781,-5.12),Pull (-5.040,-4.189) (-7.738,-3.258),Pull (-2.589,-3.356) (-0.64,-4.654),Pull (2.4909,-5.814) (3.7818,-4.654)]
    |> filled (shade 1.0),

    curve (-24.14,4.4218) [Pull (-37.34,1.4709) (-48.34,5.12),Pull (-56.09,7.9418) (-60.68,13.963),Pull (-59.46,10.312) (-56.49,8.2618),Pull (-52.50,4.3563) (-46.83,2.2109),Pull (-42.25,0.3381) (-35.66,0.4654),Pull (-30.12,1.4399) (-24.37,4.6545)]
    |> filled (shade 1.0),

    curve (-47.88,-5.003) [Pull (-54.59,-7.714) (-62.42,-5.585),Pull (-70.35,-2.385) (-74.88,3.3745),Pull (-73.17,-1.278) (-68.59,-4.770),Pull (-66.50,-6.705) (-62.89,-7.68),Pull (-60.62,-9.381) (-54.86,-8.843),Pull (-50.70,-7.803) (-48.34,-5.003)]
    |> filled (shade 1.0),

    curve (-13.90,-3.723) [Pull (-17.81,-4.721) (-21.23,-7.68),Pull (-25.92,-11.02) (-29.38,-15.24),Pull (-24.26,-15.63) (-20.18,-14.77),Pull (-13.39,-12.69) (-8.552,-8.843),Pull (-7.912,-6.865) (-7.272,-4.887),Pull (-9.132,-3.607) (-13.67,-3.607)]
    |> filled (shade 1.64),

    curve (-9.250,11.985) [Pull (-15.98,15.418) (-25.07,18.850),Pull (-28.02,21.294) (-35.08,23.738),Pull (-38.14,24.727) (-42.64,25.716),Pull (-36.28,24.785) (-31.36,23.854),Pull (-26.18,22.083) (-22.05,19.432),Pull (-14.87,16.269) (-9.018,11.985)]
    |> filled (shade 1.0),

    curve (-10.53,12.683) [Pull (-14.10,15.498) (-20.18,15.592),Pull (-26.78,16.383) (-35.66,14.894),Pull (-38.66,14.850) (-43.46,15.127),Pull (-37.99,12.356) (-31.01,11.985),Pull (-26.29,9.4090) (-21.93,7.9127),Pull (-17.04,6.1090) (-12.16,4.3054),Pull (-5.469,1.9363) (-1.338,-2.792),Pull (-4.354,6.4399) (-10.53,13.032)]
    |> filled (shade 1.38),

    curve (11.927,-2.094) [Pull (17.969,2.9290) (20.770,10.472),Pull (23.079,13.885) (24.029,18.618),Pull (23.469,12.916) (21.469,7.2145),Pull (29.558,15.534) (28.567,23.854),Pull (30.310,15.418) (25.774,6.9818),Pull (23.879,4.3054) (20.305,1.6290),Pull (22.156,1.3345) (24.727,2.56),Pull (32.112,11.112) (33.338,19.665),Pull (32.965,12.043) (30.312,4.4218),Pull (32.923,4.2272) (33.454,5.3527),Pull (32.540,3.84) (29.265,2.3272),Pull (25.256,0.0618) (19.607,-1.163),Pull (15.963,-2.276) (12.16,-1.629)]
    |> filled (shade 1.0),

    curve (15.069,-2.56) [Pull (26.350,-0.325) (32.872,6.7490),Pull (35.240,7.4600) (36.247,9.8909),Pull (37.741,6.2036) (36.596,1.3963),Pull (33.756,-2.029) (28.916,-3.374),Pull (21.252,-3.734) (15.069,-2.094)]
    |> filled (shade 1.38),

    curve (3.5490,7.4472) [Pull (-2.921,18.005) (-14.95,22.923),Pull (-15.86,24.139) (-17.86,24.436),Pull (-5.741,22.359) (0.0581,15.243),Pull (3.7290,12.625) (4.48,7.4472),Pull (4.8236,6.8072) (4.2472,6.1672),Pull (4.4218,6.9236) (3.3163,7.68)]
    |> filled (shade 1.91)

    ]
    
-- BOY HAIR 2
bHair2 hCol = 
  let
        shade factor = shadeColor factor hCol
  in 
    group [
       curve (26.821,-52.24) [Pull (29.118,-43.75) (36.014,-40.26),Pull (42.387,-24.66) (46.72,-9.076),Pull (48.372,-10.95) (48.465,-14.19),Pull (49.803,-9.425) (48.581,-4.654),Pull (47.127,-0.698) (44.392,3.2581),Pull (48.021,4.0000) (48.930,1.8618),Pull (50.821,0.1163) (52.072,-1.629),Pull (51.538,2.2109) (49.163,6.0509),Pull (45.878,12.289) (36.712,13.847),Pull (41.889,14.672) (44.625,17.338),Pull (43.152,17.036) (40.32,17.454),Pull (42.412,25.119) (39.505,28.625),Pull (38.449,31.505) (36.712,33.745),Pull (39.194,26.938) (35.316,20.130),Pull (34.036,32.201) (26.356,38.632),Pull (20.678,45.056) (12.16,48.64),Pull (18.098,45.012) (19.956,37.585),Pull (12.185,47.210) (-3.665,48.756),Pull (1.8581,48.229) (3.7818,44.101),Pull (-5.323,47.481) (-18.90,46.661),Pull (-27.01,45.205) (-33.57,47.709),Pull (-30.52,42.099) (-24.84,40.610),Pull (-33.57,40.876) (-46.13,36.421),Pull (-54.62,35.181) (-62.42,32.581),Pull (-54.55,33.721) (-50.32,31.301),Pull (-58.29,29.689) (-68.01,23.156),Pull (-65.62,23.898) (-64.98,23.04),Pull (-75.44,15.205) (-82.09,3.4909),Pull (-77.97,7.5727) (-70.69,8.4945),Pull (-76.98,3.1563) (-79.76,-5.701),Pull (-80.49,-10.09) (-79.18,-16.52),Pull (-79.02,-8.247) (-72.78,-6.050),Pull (-80.45,-11.51) (-75.69,-27.46),Pull (-76.04,-22.51) (-72.55,-21.41),Pull (-74.60,-24.30) (-70.57,-33.28),Pull (-71.94,-29.41) (-70.10,-28.74),Pull (-65.42,-34.33) (-61.38,-41.77),Pull (-58.72,-45.12) (-57.54,-49.80),Pull (-59.19,-40.45) (-58.00,-33.39),Pull (-58.17,-30.55) (-56.49,-29.55),Pull (-57.51,-24.66) (-56.61,-21.52),Pull (-51.33,-18.25) (-53.46,-22.45),Pull (-47.31,-13.88) (-37.99,-10.24),Pull (-39.52,-17.03) (-44.85,-23.04),Pull (-38.93,-17.14) (-30.77,-13.73),Pull (-31.46,-17.62) (-35.54,-21.52),Pull (-24.12,-19.01) (-16.34,-14.54),Pull (-9.809,-9.774) (-4.829,-5.003),Pull (0.1490,-3.825) (4.2472,-3.607),Pull (5.0909,-5.643) (4.0145,-7.68),Pull (6.7109,-5.934) (8.0872,-4.189),Pull (17.363,-8.507) (19.84,-19.66),Pull (20.745,-21.72) (19.490,-25.94),Pull (22.812,-29.95) (25.774,-34.32),Pull (26.172,-42.70) (25.890,-51.08),Pull (26.819,-51.49) (26.589,-51.89)]
  |> filled (shade 1.29),

  curve (22.865,18.967) [Pull (19.439,25.447) (11.694,27.927),Pull (-2.674,33.334) (-17.16,38.981),Pull (-20.91,39.729) (-23.91,41.076),Pull (-22.79,38.970) (-19.95,37.585),Pull (-13.67,34.609) (-5.992,32.232),Pull (2.8709,30.152) (9.1345,25.832),Pull (20.739,22.890) (22.865,10.589),Pull (19.532,18.369) (12.16,22.109),Pull (16.796,18.676) (17.512,11.403),Pull (14.669,17.229) (8.7854,20.014),Pull (13.758,16.723) (15.650,10.472),Pull (12.765,14.179) (7.04,15.127),Pull (2.4672,18.718) (-4.945,19.549),Pull (-13.30,19.663) (-20.42,21.178),Pull (-27.55,21.918) (-33.57,23.738),Pull (-28.03,20.723) (-21.58,18.269),Pull (-27.97,18.090) (-33.57,16.872),Pull (-25.41,17.467) (-19.25,17.221),Pull (-8.158,17.932) (-0.058,15.243),Pull (7.9890,12.798) (10.996,5.3527),Pull (2.0654,6.8254) (-6.225,7.0981),Pull (-12.90,5.3709) (-18.79,5.0036),Pull (-25.27,4.5545) (-30.42,5.5854),Pull (-38.87,5.2236) (-46.48,5.7018),Pull (-53.54,4.2345) (-59.63,3.6072),Pull (-65.02,-2.750) (-66.96,-9.309),Pull (-62.81,-0.570) (-49.86,2.3272),Pull (-44.84,3.6163) (-37.99,3.0254),Pull (-29.99,3.4981) (-24.84,0.9309),Pull (-31.59,-3.145) (-35.89,-8.261),Pull (-32.54,-5.663) (-27.52,-4.305),Pull (-24.13,-0.094) (-17.86,1.3963),Pull (-11.37,5.3654) (-0.290,4.6545),Pull (0.6272,1.2799) (-1.454,-2.094),Pull (0.4018,-1.580) (1.3381,-0.465),Pull (2.3981,-1.192) (3.8981,-1.28),Pull (5.6963,-1.538) (6.5745,-1.396),Pull (7.6199,-0.785) (7.5054,0.4654),Pull (9.3527,0.1854) (9.6,-0.814),Pull (9.9454,0) (9.2509,0.8145),Pull (11.347,1.4563) (12.043,0.6981),Pull (13.485,0.7872) (14.487,1.3963),Pull (16.979,1.9509) (18.792,3.0254),Pull (20.296,4.0145) (21.12,5.0036),Pull (23.647,4.7181) (24.494,2.7927),Pull (28.019,-0.629) (30.545,-4.770),Pull (30.389,-1.978) (29.032,0.8145),Pull (34.669,-2.316) (36.945,-8.727),Pull (35.218,-3.781) (32.290,1.1636),Pull (38.078,-1.958) (40.785,-6.4),Pull (39.445,-1.803) (35.665,2.7927),Pull (38.541,2.7272) (39.738,1.8618),Pull (37.200,4.9472) (33.221,6.6327),Pull (43.190,6.2654) (49.28,1.9781),Pull (45.121,6.5818) (38.923,9.4254),Pull (35.276,10.163) (30.429,9.5418),Pull (31.476,16.407) (29.963,23.272),Pull (29.887,17.861) (27.170,12.450),Pull (26.809,19.258) (24.727,26.065),Pull (23.389,31.36) (20.770,36.654),Pull (21.507,34.850) (21.003,33.047),Pull (18.356,36.052) (13.789,37.818),Pull (18.323,34.394) (20.538,29.090),Pull (22.641,24.087) (22.865,19.083)]
  |> filled (shade 1.0),

  curve (11.229,5.0036) [Pull (7.2799,16.683) (-8.669,16.523),Pull (-22.97,18.312) (-34.85,13.381),Pull (-48.11,10.525) (-57.89,4.1890),Pull (-50.51,6.4672) (-39.97,5.5854),Pull (-34.53,5.9890) (-28.21,5.3527),Pull (-19.14,6.3163) (-9.716,6.4),Pull (0.6199,7.2181) (10.996,5.2363)]
  |> filled (shade 1.64),

  curve (16.232,8.1454) [Pull (9.2909,14.641) (-0.290,18.618),Pull (-9.460,21.432) (-21.46,21.527),Pull (-32.14,22.107) (-41.01,25.367),Pull (-30.54,26.872) (-20.18,26.298),Pull (-27.85,27.010) (-34.03,29.323),Pull (-41.62,29.745) (-47.53,31.767),Pull (-55.09,33.023) (-60.33,32),Pull (-51.34,34.294) (-39.38,33.629),Pull (-28.00,34.540) (-19.14,32.930),Pull (-7.552,33.407) (0.7563,30.603),Pull (13.087,27.458) (19.258,18.152),Pull (21.299,16.641) (21.701,12.450),Pull (18.578,16.989) (12.974,21.527),Pull (15.912,18.743) (16.930,14.08),Pull (12.545,19.252) (5.76,22.225),Pull (11.070,18.636) (14.021,12.567),Pull (15.647,11.172) (16.232,8.3781)]
  |> filled (shade 1.38),

  curve (22.981,18.967) [Pull (20.187,23.967) (14.952,26.647),Pull (0.5036,34.423) (-17.74,38.4),Pull (-26.47,42.156) (-33.45,47.592),Pull (-20.05,45.381) (-5.294,44.450),Pull (0.1236,42.770) (6.3418,41.890),Pull (1.8363,45.954) (-4.829,48.058),Pull (7.6327,47.620) (16.814,40.261),Pull (18.850,39.216) (19.607,36.770),Pull (17.394,44.914) (11.461,49.338),Pull (21.374,45.758) (27.287,37.818),Pull (32.425,33.765) (33.803,25.832),Pull (34.985,23.518) (34.967,20.363),Pull (39.612,29.718) (35.898,33.512),Pull (44.521,23.881) (35.665,13.730),Pull (44.814,13.296) (47.883,6.9818),Pull (50.820,4.7399) (50.676,-0.581),Pull (48.614,5.8509) (41.832,7.5636),Pull (37.576,10.638) (30.08,10.472),Pull (34.658,15.279) (34.036,18.967),Pull (33.770,16.956) (30.545,15.825),Pull (32.854,24.203) (26.123,32.581),Pull (30.939,22.283) (26.356,11.985),Pull (27.779,24.261) (22.283,36.538),Pull (23.170,35.141) (20.538,33.745),Pull (18.425,37.365) (12.392,38.865),Pull (19.358,34.249) (22.283,25.832),Pull (23.554,22.4) (22.865,18.967)]
  |> filled (shade 1.64),

  curve (1.92,36.421) [Pull (-3.965,40.247) (-11.81,42.472),Pull (-18.37,44.929) (-27.17,45.265),Pull (-16.34,46.576) (-5.876,44.567),Pull (0.2181,43.854) (3.4327,40.261),Pull (1.6327,42.167) (-2.967,41.192),Pull (0.4000,40.056) (1.92,36.421)]
  |> filled (shade 1.91),

  curve (11.578,24.436) [Pull (-2.321,30.323) (-21.70,31.650),Pull (-14.26,33.032) (-8.436,32.814),Pull (4.1490,31.221) (11.694,24.669)]
  |> filled (shade 1.91),

  curve (-4.247,26.298) [Pull (-6.320,28.139) (-11.11,27.461),Pull (-11.02,27.458) (-13.20,26.414),Pull (-14.71,26.032) (-17.74,26.530),Pull (-23.85,26.129) (-31.12,25.367),Pull (-25.71,25.496) (-22.74,23.505),Pull (-19.88,23.705) (-18.21,23.505),Pull (-18.00,24.436) (-19.84,25.367),Pull (-14.74,25.559) (-11.81,24.552),Pull (-10.62,25.483) (-10.88,26.414),Pull (-6.680,27.450) (-4.247,26.298)]
  |> filled (shade 1.64),

  curve (-15.41,14.894) [Pull (-21.16,15.685) (-28.10,15.476),Pull (-27.70,14.952) (-28.21,14.429),Pull (-29.79,14.254) (-32.40,14.08),Pull (-30.10,14.050) (-28.68,13.381),Pull (-29.04,13.063) (-30.19,11.985),Pull (-31.09,11.869) (-32.98,11.752),Pull (-30.20,11.743) (-28.21,11.054),Pull (-23.08,11.529) (-18.79,11.403),Pull (-20.58,12.345) (-22.98,12.567),Pull (-21.47,13.196) (-20.88,13.265),Pull (-19.44,14.716) (-16.11,15.127)]
  |> filled (shade 1.91),

  curve (-31.59,20.247) [Pull (-38.66,22.083) (-44.97,25.6),Pull (-54.86,26.341) (-63.59,21.643),Pull (-73.93,14.825) (-81.16,4.8872),Pull (-74.63,9.5290) (-65.10,11.170),Pull (-57.88,15.756) (-47.53,17.221),Pull (-41.06,19.805) (-31.82,19.549)]
  |> filled (shade 1.64),

  curve (-30.77,20.363) [Pull (-35.60,21.501) (-40.55,20.48),Pull (-39.10,20.570) (-38.69,19.781),Pull (-44.07,20.189) (-48.58,19.316),Pull (-45.61,18.876) (-44.04,18.036),Pull (-38.12,19.958) (-31.01,20.48)]
  |> filled (shade 1.91),

  curve (-40.43,3.2581) [Pull (-46.54,1.2563) (-50.44,-3.025),Pull (-57.94,-10.18) (-60.45,-22.34),Pull (-55.54,-16.13) (-48.11,-12.45),Pull (-42.12,-8.903) (-33.68,-7.796),Pull (-28.81,-4.485) (-26.82,-2.094),Pull (-25.19,-0.232) (-25.77,1.6290),Pull (-33.07,3.9000) (-40.43,3.2581)]
  |> filled (shade 1.38),

  curve (-40.43,0.6981) [Pull (-46.36,0.4290) (-51.60,-5.12),Pull (-58.26,-10.97) (-60.91,-20.82),Pull (-58.58,-16.35) (-53.93,-14.19),Pull (-53.67,-10.15) (-51.60,-7.912),Pull (-48.21,-2.967) (-41.94,-0.581),Pull (-47.41,-2.820) (-48.23,-9.658),Pull (-46.07,-4.489) (-40.66,-2.56),Pull (-40.47,0.0327) (-37.99,0.4654),Pull (-39.68,1.1236) (-40.43,0.6981)]
  |> filled (shade 1.64),

  curve (-48.34,0.6981) [Pull (-57.50,-2.696) (-62.77,-9.890),Pull (-66.44,-14.54) (-67.66,-21.64),Pull (-68.44,-21.33) (-66.50,-23.73),Pull (-65.48,-16.84) (-62.42,-11.98),Pull (-63.68,-14.76) (-62.54,-19.54),Pull (-62.73,-14.82) (-60.91,-10.70),Pull (-59.26,-9.185) (-57.89,-10.70),Pull (-61.13,-14.48) (-61.38,-21.29),Pull (-61.58,-23.04) (-60.10,-25.6),Pull (-60.47,-21.29) (-56.84,-18.15),Pull (-53.57,-14.64) (-49.74,-12.45),Pull (-54.93,-17.21) (-57.07,-24.78),Pull (-58.46,-27.98) (-58.00,-32.69),Pull (-59.82,-29.57) (-60.56,-27.57),Pull (-62.01,-23.95) (-62.54,-21.29),Pull (-64.04,-22.96) (-63.70,-25.71),Pull (-64.39,-27.42) (-63.47,-30.13),Pull (-65.14,-27.48) (-65.57,-25.6),Pull (-68.76,-25.21) (-69.99,-23.50),Pull (-70.09,-19.88) (-68.59,-17.33),Pull (-63.19,-3.521) (-48.23,0.8145)]
  |> filled (shade 1.0),

  curve (15.301,-4.654) [Pull (22.496,-15.80) (25.890,-30.72),Pull (28.499,-34.27) (27.869,-41.07),Pull (27.558,-27.07) (23.447,-16.87),Pull (29.379,-22.34) (30.312,-32.81),Pull (30.719,-23.74) (27.287,-18.38),Pull (31.876,-22.56) (33.105,-29.90),Pull (32.990,-25.21) (31.476,-21.64),Pull (34.789,-24.69) (35.781,-30.02),Pull (35.632,-25.02) (33.803,-21.17),Pull (37.372,-22.23) (38.341,-25.25),Pull (37.189,-20.64) (32.756,-19.2),Pull (31.518,-16.02) (28.8,-14.08),Pull (29.867,-15.01) (29.614,-17.10),Pull (28.545,-12.39) (23.796,-7.68),Pull (27.621,-11.98) (27.287,-16.29),Pull (26.130,-12.62) (23.214,-8.96),Pull (25.385,-12.33) (25.076,-15.70),Pull (23.159,-10.24) (18.443,-4.770),Pull (22.714,-9.890) (22.865,-15.01),Pull (20.425,-9.832) (15.185,-4.654)]
  |> filled (shade 1.38)
    
    
    ]
    
    
-- BOY HAIR 3

bHair3 hCol = 
  let
        shade factor = shadeColor factor hCol
  in 
    group [
      curve (-58.47,-22.45) [Pull (-68.31,-0.482) (-51.75,15.729),Pull (-53.43,4.4627) (-52.95,-7.084),Pull (-49.62,11.446) (-38.54,26.296),Pull (-33.36,27.617) (-27.01,28.217),Pull (-24.65,28.357) (-22.93,28.938),Pull (-21.87,28.297) (-21.97,27.257),Pull (-19.67,27.497) (-18.13,27.737),Pull (-11.76,25.894) (-10.44,19.572),Pull (-8.685,16.029) (-8.045,11.407),Pull (-6.204,8.0448) (-4.923,4.2026),Pull (-4.183,-1.901) (-4.923,-9.485),Pull (-2.880,-2.743) (2.7617,-0.120),Pull (6.1238,10.686) (9.4859,21.493),Pull (10.486,23.054) (10.206,24.615),Pull (11.566,24.214) (11.887,22.694),Pull (12.426,31.297) (7.5647,34.461),Pull (10.205,36.061) (10.446,35.181),Pull (12.587,34.300) (12.607,31.339),Pull (12.805,39.862) (5.8836,41.185),Pull (3.8421,41.725) (1.0806,41.666),Pull (3.1617,44.047) (4.4427,45.508),Pull (1.6412,45.227) (-0.360,42.146),Pull (0.7171,55.331) (-8.765,57.996),Pull (-5.244,56.714) (-5.643,51.512),Pull (-13.00,60.535) (-24.85,62.078),Pull (-52.10,64.015) (-66.40,51.752),Pull (-79.56,43.164) (-84.65,26.536),Pull (-81.33,32.559) (-76.48,37.103),Pull (-83.37,27.695) (-85.85,12.127),Pull (-85.23,12.807) (-83.69,12.607),Pull (-83.89,5.4432) (-79.60,-2.281),Pull (-80.86,3.2420) (-79.60,8.7654),Pull (-79.28,0.2402) (-74.80,-8.045),Pull (-68.02,-15.86) (-59.43,-21.97)]
  |> filled (shade 1.0),

  curve (-66.40,-10.92) [Pull (-68.24,6.2217) (-62.07,16.450),Pull (-56.83,24.254) (-49.59,30.859),Pull (-59.89,21.331) (-62.31,5.1632),Pull (-57.91,14.828) (-49.59,20.532),Pull (-44.78,30.457) (-35.66,36.142),Pull (-49.78,26.612) (-52.23,5.1632),Pull (-47.10,17.229) (-38.06,25.816),Pull (-32.84,34.530) (-22.69,38.285),Pull (-17.51,39.071) (-12.64,36.417),Pull (-13.72,39.612) (-16.80,40.727),Pull (-25.77,42.842) (-31.17,41.158),Pull (-42.67,37.874) (-50.13,30.671)]
  |> filled (shade 1.29),

  curve (-14.07,43.313) [Pull (-32.34,52.754) (-48.41,41.876),Pull (-38.93,52.457) (-14.94,48.197),Pull (-18.15,52.484) (-23.12,52.650),Pull (-17.24,53.829) (-13.64,50.208),Pull (-18.40,56.323) (-27.00,58.397),Pull (-14.42,57.403) (-8.044,50.208),Pull (-12.18,59.499) (-23.84,61.270),Pull (-32.58,62.872) (-45.97,59.833),Pull (-65.61,56.521) (-76.57,40.008),Pull (-73.89,41.938) (-69.81,42.307),Pull (-80.94,34.181) (-82.74,16.736),Pull (-80.55,26.974) (-72.69,31.533),Pull (-74.68,30.736) (-75.27,28.659),Pull (-67.76,37.524) (-55.45,41.589),Pull (-67.16,36.425) (-72.40,24.781),Pull (-75.64,18.608) (-74.55,8.1167),Pull (-73.85,16.680) (-69.67,21.764),Pull (-67.10,26.666) (-62.49,29.809),Pull (-74.10,15.142) (-67.95,-11.56),Pull (-68.34,11.741) (-57.17,23.488),Pull (-48.15,39.392) (-27.29,43.456),Pull (-22.45,44.813) (-14.65,43.169)]
  |> filled (shade 1.38),

  curve (-32.89,29.521) [Pull (-28.45,36.807) (-20.25,38.572),Pull (-17.01,39.547) (-12.49,35.842),Pull (-12.71,38.385) (-13.93,40.008),Pull (-16.55,41.850) (-20.97,41.732),Pull (-26.94,41.028) (-30.59,38.285),Pull (-28.85,40.780) (-25.42,41.876),Pull (-35.44,41.306) (-41.66,37.135),Pull (-36.60,41.440) (-28.87,43.025),Pull (-22.34,44.473) (-14.65,42.882),Pull (-15.94,44.846) (-18.38,45.611),Pull (-23.67,49.018) (-34.47,46.904),Pull (-41.31,45.778) (-47.83,41.732),Pull (-44.59,45.566) (-39.07,46.760),Pull (-34.29,49.453) (-26.72,49.346),Pull (-22.02,50.283) (-15.80,48.341),Pull (-14.15,49.184) (-13.50,48.628),Pull (-18.63,52.395) (-26.72,53.081),Pull (-30.68,54.221) (-36.05,53.800),Pull (-30.62,54.435) (-26.14,54.231),Pull (-20.70,53.761) (-16.66,51.932),Pull (-13.66,51.071) (-11.78,49.490),Pull (-12.66,52.313) (-14.94,53.656),Pull (-20.72,57.047) (-29.30,57.679),Pull (-23.80,57.931) (-20.25,57.104),Pull (-13.76,55.187) (-9.625,51.070),Pull (-6.002,49.429) (-4.740,45.468),Pull (-4.064,43.257) (-5.028,40.727),Pull (-1.247,40.660) (1.2929,39.434),Pull (5.9480,38.558) (8.7631,35.842),Pull (5.1615,37.987) (0,38.572),Pull (5.1514,34.130) (7.1829,26.648),Pull (5.1306,30.917) (0.7182,32.826),Pull (3.7157,30.232) (2.8731,23.919),Pull (2.2154,31.110) (-2.442,34.262),Pull (-3.997,35.644) (-6.751,35.986),Pull (-5.545,35.153) (-5.459,33.400),Pull (-1.963,27.897) (-1.867,19.034),Pull (-2.635,28.662) (-8.763,32.969),Pull (-8.299,32.140) (-8.475,30.671),Pull (-8.530,32.216) (-9.625,32.682),Pull (-11.21,31.855) (-13.36,31.389),Pull (-13.70,31.525) (-14.65,31.102),Pull (-15.50,33.395) (-18.38,33.687),Pull (-19.76,34.783) (-24.13,34.118),Pull (-28.67,32.959) (-32.61,30.240)]
  |> filled (shade 0.83),

  curve (-47.69,57.966) [Pull (-60.38,57.024) (-66.08,49.203),Pull (-63.12,52.429) (-58.61,54.374),Pull (-61.01,53.307) (-62.49,50.639),Pull (-61.15,52.569) (-58.18,52.938),Pull (-60.95,51.882) (-62.20,49.346),Pull (-60.61,51.216) (-57.46,51.645),Pull (-58.70,51.303) (-58.75,49.921),Pull (-58.08,51.039) (-56.88,51.358),Pull (-55.86,51.918) (-53.72,51.358),Pull (-55.20,50.281) (-55.88,48.484),Pull (-55.02,50.105) (-53.44,50.927),Pull (-51.30,51.702) (-48.12,51.358),Pull (-48.46,52.316) (-49.56,52.794),Pull (-47.71,54.076) (-46.25,54.518),Pull (-48.49,54.671) (-49.84,53.943),Pull (-47.96,55.833) (-44.39,56.242),Pull (-48.09,56.359) (-50.56,55.236),Pull (-48.57,57.065) (-45.82,58.253),Pull (-47.19,58.389) (-47.83,57.966)]
  |> filled (shade 1.64),

  curve (-44.67,42.594) [Pull (-52.02,42.289) (-55.02,36.704),Pull (-53.90,38.678) (-50.71,38.572),Pull (-52.84,37.201) (-53.29,34.549),Pull (-52.49,37.298) (-49.84,37.566),Pull (-50.98,36.989) (-50.99,35.411),Pull (-50.56,36.533) (-49.56,37.135),Pull (-48.12,38.477) (-45.68,38.859),Pull (-47.28,39.199) (-48.12,38.859),Pull (-47.40,40.021) (-45.97,40.583),Pull (-47.93,40.656) (-49.13,40.008),Pull (-47.52,41.810) (-44.39,42.451)]
  |> filled (shade 1.64),

  curve (-68.81,31.676) [Pull (-71.61,29.594) (-73.69,26.792),Pull (-73.58,29.247) (-72.83,31.102),Pull (-81.91,22.761) (-81.59,5.0998),Pull (-80.47,17.940) (-73.26,24.781),Pull (-79.76,15.267) (-76.71,-3.806),Pull (-77.53,19.071) (-69.24,31.389)]
  |> filled (shade 0.83)
    
    
    
    ]