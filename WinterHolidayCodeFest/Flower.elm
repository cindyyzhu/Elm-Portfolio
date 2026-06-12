module WinterHolidayCodeFest.Flower exposing (..)


-- Made by MerryGoldfish

word = "flower"
myShapes t = [
  flower
    |> move (-12, 50)
    |> rotate (degrees 7*sin t)
    |> move (10, -51)
  ]

flower = group [ stem, petal, core ]

hsl_d_core = 50
hsl_d_petal = 0
hsl_d_stem = 100

stem = group
  [
    curve (0,0) [Pull (40,0) (50,-10)]
      |> outlined (solid 1.75) (hsl (degrees hsl_d_stem) 0.5 0.5)
      |> rotate (degrees -65)
    ,
    oval 10 20
      |> filled (hsl (degrees hsl_d_stem) 0.5 0.5)
      |> move (35,-6)
      |> rotate (degrees -45)
    ,
    oval 10 20
      |> filled (hsl (degrees hsl_d_stem) 0.5 0.5)
      |> move (-25,-20)
      |> rotate (degrees 60)
    ,
    curve (12,-35) [Pull (0,-30) (-3,-26)]
      |> outlined (solid 1) (hsl (degrees hsl_d_stem) 0.3 0.5)
    ,
    curve (14,-35) [Pull (15,-35) (27,-22)]
      |> outlined (solid 1) (hsl (degrees hsl_d_stem) 0.3 0.5)
  ]
  
petal = group
  [
    oval 15 20
      |> filled (hsl (degrees hsl_d_petal) 0.5 0.5)
      |> move (0,17)
      |> rotate (degrees -45)
    ,
    oval 15 20
      |> filled (hsl (degrees hsl_d_petal) 0.5 0.5)
      |> move (0,17)
    ,
    oval 15 20
      |> filled (hsl (degrees hsl_d_petal) 0.5 0.5)
      |> move (0,-17)
      |> rotate (degrees 90)
    ,
    oval 15 20
      |> filled (hsl (degrees hsl_d_petal) 0.5 0.5)
      |> move (0,-17)
      |> rotate (degrees -45)
    ,
    oval 15 20
      |> filled (hsl (degrees hsl_d_petal) 0.5 0.5)
      |> move (0,-17)
    ,
    oval 15 20
      |> filled (hsl (degrees hsl_d_petal) 0.5 0.5)
      |> move (0,17)
      |> rotate (degrees 90)
    ,
    oval 15 20
      |> filled (hsl (degrees hsl_d_petal) 0.5 0.5)
      |> move (0,-17)
      |> rotate (degrees 45)
    ,
    oval 15 20
      |> filled (hsl (degrees hsl_d_petal) 0.5 0.5)
      |> move (0,17)
      |> rotate (degrees 45)
  ]
  
core = group
  [
    circle 10
      |> filled (hsl (degrees hsl_d_core) 0.5 0.5)
  ]
