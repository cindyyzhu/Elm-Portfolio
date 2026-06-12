-- Your shapes go here!
myShapes model =
  [
    
  whole
 ]
 
whole = group
 [
     coins
 |>scale 1
 |>move(16,34)
 ,
 curve (-50.4, 17.7) [Pull (-85.4, 0.1) (-49.5, -25.8), Pull (-46.8, -25.7) (-44.7, -29.8), Pull (-34.1, -16.9) (-16.3, -22.6), Pull (-16.6, -19.8) (-17.0, -17.0), Pull (-23.2, -11.6) (-29.3, -6.2), Pull (-27.2, -1.2) (-25.1, 3.8), Pull (-27.6, 13.0) (-35.5, 15.6), Pull (-37.9, 23.5) (-43.4, 30.3), Pull (-50.3, 24.5) (-48.2, 15.4), Pull (-49.5, 16.6) (-50.7, 17.9)]
  |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink --outline face
 ,
 curve (-48.9, -24.6) [Pull (-57.5, -2.8) (-33.3, -17.0)]
 |>outlined (solid 3) black -- nose
 ,
 curve (-43.2, 14.7) [Pull (-46.1, 21.2) (-43.2, 24.9), Pull (-42.1, 23.5) (-41.1, 22.1), Pull (-44.0, 19.4) (-43.0, 14.5)]
 |>outlined (solid 2) black -- Rear
 ,
 curve (-65.8, 8.1) [Pull (-74.0, 7.6) (-79.0, 3.9), Pull (-74.0, -0.4) (-68.1, -1.2), Pull (-66.9, 3.8) (-65.8, 7.9)]
  |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink --Lear
 ,
 eye 
 |>subtract (triangle 4 |>filled blank |>move(-56,-5)) 
 |>subtract (triangle 4 |>filled blank |>move(-43,5)) 
 ,
  oval 3 6 --Lnose
 |>filled black
 |>move(-47,17)
 |>rotate (degrees 45)
 ,
   oval 3 6 --Rnose
 |>filled black
 |>move(-41,17)
 |>rotate (degrees 45)
 ,
 brokenPieces
 

 
 ]
eye = group
 [
 oval 5 7 --Leye
 |>filled black
 |>rotate (degrees 45)
 |>move(-58,-8.5)
 ,
  oval 5 7
 |>filled black --Reye
 |>rotate (degrees 45)
 |>move(-46,1.5)
 ]
brokenPieces = group
 [
     coins
 |>scale 0.7
 |>move(38,48)
 ,

 
 curve (-32.1, 17.1) [Pull (-28.6, 16.9) (-25.0, 16.6), Pull (-23.8, 22.0) (-20.7, 24.9), Pull (-17.4, 18.8) (-19.5, 14.5), Pull (-12.3, 11.9) (-5.4, 13.0), Pull (-4.5, 14.5) (-3.7, 15.9), Pull (-7.2, 15.8) (-10.8, 15.8), Pull (-12.3, 17.5) (-13.8, 19.3), Pull (-9.2, 22.0) (-4.6, 24.6), Pull (-2.3, 22.1) (0.0, 19.5), Pull (3.7, 21.4) (7.4, 23.3), Pull (3.5, 16.2) (-0.3, 9.1), Pull (-6.1, 9.2) (-11.9, 9.4), Pull (-12.6, 8.0) (-13.2, 6.5), Pull (-12.1, 5.5) (-11.0, 4.4), Pull (-14.5, 1.7) (-22.3, 4.4), Pull (-25.5, 11.7) (-32.4, 17.2)]
  |>filled (hsl (degrees 29) 0.607 0.649)
 |>addOutline (solid 2) black
 ,
 curve (-23.4, 3.6) [Pull (-24.1, 2.2) (-24.9, 0.9), Pull (-15.2, -2.4) (-9.8, -0.3), Pull (-9.2, 0.2) (-10.6, 3.1), Pull (-16.8, 1.0) (-23.1, 3.6)]
 |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink
 ,
 curve (7.8, 24.9) [Pull (12.0, 11.7) (5.7, 4.7), Pull (4.5, 4.4) (-0.0, 8.5), Pull (5.0, 13.6) (7.2, 25.0)]
 |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink
 ,
 curve (-12.6, 8.4) [Pull (-6.1, 3.4) (-12.3, -14.0), Pull (-9.8, -16.0) (-7.4, -18.0), Pull (-8.6, -19.3) (-8.1, -22.6), Pull (-3.6, -22.9) (0.9, -23.2), Pull (4.8, 0.9) (13.6, -18.7), Pull (16.7, -17.9) (19.9, -17.2), Pull (18.2, -14.1) (16.5, -10.9), Pull (18.6, -7.7) (20.8, -4.4), Pull (15.7, -2.9) (10.7, -1.4), Pull (-2.2, 13.0) (-12.2, 8.3)]
 |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink
 ,
 curve (21.0, -4.5) [Pull (19.6, -3.1) (18.0, -2.3), Pull (18.8, -1.0) (19.5, 0.2), Pull (26.5, 1.1) (30.2, 1.0), Pull (32.2, 6.2) (34.2, 11.5), Pull (37.9, 11.0) (41.6, 10.6), Pull (45.4, 17.3) (45.3, 24.7), Pull (65.6, 6.4) (46.8, -10.5), Pull (34.6, -19.9) (19.3, -12.3), Pull (17.1, -8.2) (21.5, -4.7)]
 |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink
 ,
 curve (24.3, 23.4) [Pull (20.0, 20.0) (29.4, 26.4), Pull (32.3, 24.4) (35.2, 22.4), Pull (28.6, 19.7) (24.8, 22.6)]
 |>filled (hsl (degrees 29) 0.607 0.649)
 |>addOutline (solid 2) black
 ,
 curve (-26.4, -30.6) [Pull (-19.3, -32.8) (-11.1, -29.4), Pull (-8.8, -32.9) (-6.5, -36.4), Pull (-18.8, -40.6) (-26.8, -30.7)]
 |>filled (hsl (degrees 29) 0.607 0.649)
 |>addOutline (solid 2) black
 ,
 curve (-6.9, -36.4) [Pull (-6.9, -38.7) (-6.4, -39.1), Pull (-18.8, -40.6) (-25.8, -35.7), Pull (-26.8, -34.3) (-26.1, -31.2), Pull (-17.6, -38.0) (-6.8, -36.4)]
 |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink
 ,
 curve (23.7, 23.4) [Pull (20.0, 20.0) (22.2, 20.7), Pull (29.7, 16.5) (37.6, 20.6), Pull (36.1, 21.5) (34.7, 22.9), Pull (29.8, 19.8) (23.6, 22.7)]
 |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink
 ,
 broken
 |>scale 0.7
 |>move(-60,3)
 ,
 coins
 ,
 coins
 |>scale 0.7
 |>move(-34,-3)
 ,
 coins
 |>scale 0.7
 |>move(28,-14)
 ,
   coins
 |>scale 1
 |>move(48,8)
 ,
  coins
 |>scale 0.7
 |>move(76,2)
 ,
    coins
 |>scale 0.7
 |>move(52,42)
 ,
     coins
 |>scale 0.8
 |>move(48,38)
 ,
 oval 10 15
 |>filled (hsl (degrees 50) 1.0 0.42) --standingcoin
 |>move(7,-18)
 |>addOutline (solid 2) black
 

 ]
broken = group
 [
   curve (-26.4, -30.6) [Pull (-19.3, -32.8) (-11.1, -29.4), Pull (-8.8, -32.9) (-6.5, -36.4), Pull (-18.8, -40.6) (-26.8, -30.7)]
 |>filled (hsl (degrees 29) 0.607 0.649)
 |>addOutline (solid 2) black
 ,
 curve (-6.9, -36.4) [Pull (-6.9, -38.7) (-6.4, -39.1), Pull (-18.8, -40.6) (-25.8, -35.7), Pull (-26.8, -34.3) (-26.1, -31.2), Pull (-17.6, -38.0) (-6.8, -36.4)]
 |>filled (hsl (degrees 312) 0.688 0.753)
 |>addOutline (solid 2) black --pink
 ]
coins = group
 [
  oval 15 6
  |>filled black
  |>move(-38.2,-42)
  ,
 oval 15 6
 |>filled (hsl (degrees 50) 1.0 0.42)
 |>addOutline (solid 1) black 
 |>move(-38,-40)
 
 ]
