-- Your shapes go here!
myShapes model =
  [square 200  --bg
   |>filled black
   ,
    frog
  ]
frog = group 
      [ circle 25
    |> filled (hsl (degrees 109) 0.995 0.336)
    |> move (3,0)
   
    ,
    circle 7
    |> filled white
    |> move (-17,15)
    ,
     circle 7
    |> filled white
    |> move (23,15) 
    ,
     circle 4
    |> filled black
    |> move (23,15)
    ,
     circle 4
    |> filled black
    |> move (-17,15)
    ,
    text "____"
    |> filled black
    |> move (-9,2.5)
    |> scaleY 3
    ,
      oval 24 12
    |> filled (hsl (degrees 109) 0.995 0.336)
    |> rotate (degrees 35)
    |> move (-18,-25)
    ,
    oval 25 13
    |> filled (hsl (degrees 109) 0.995 0.336)
    |> rotate (degrees -35)
    |> move (25,-25)
    ,
    oval 15 13
    |> filled (hsl (degrees 109) 0.995 0.336)
    |> move (35,-30)
    ,
     oval 15 13
    |> filled (hsl (degrees 109) 0.995 0.336)
    |> move (-30,-31)
    ,
     wedge 15 0.5
    |> filled white
    |> rotate (degrees -90)
    |> move (3,-10)
    |> scaleX 1.27]