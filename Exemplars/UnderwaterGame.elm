module UnderwaterGame exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)

import Html
import Html.Attributes as HA

fractionalModBy m x = x - m * toFloat (floor (x / m))

repeatDistance speed start end t =
  start + fractionalModBy (end - start) (speed * t)

myShapes model =
    case model.state of
        Welcome  ->
            [ background
            , sharks model
            , sand
            , bubbles |> move (1*cos(3*model.time),3*sin(model.time))
            , seaweeds1 model
            , fishes model
              -- put ahead of the fishes, it'll look more natural
            , seaweed |> scale 0.75 |> move (50,-30) |> move (5*cos(model.time),0)
            , seaweed |> scale 0.75 |> move (-70,-30) |> move (5*cos(model.time),0)
            , seaweed |> scale 0.75 |> move (-10,-30) |> move (5*cos(model.time),0)
            , intro |> scale 1.25 |> move (0,10)
            , playbutton |> scale 2 |> move (0,-30) |> notifyTap Play
            ]
            
        CharactersPage  ->
            [ background,
              sharks model,
              sand,
              bubbles |> move (1*cos(3*model.time),3*sin(model.time)),
              seaweeds2 model,
              text "Introduction to the Characters!" |> bold |> centered |> filled white |> move (0,50),
              you,
              ruler,
              storytimebutton |> notifyTap Storytime
            ]
            
        Storyline1  ->
            [     background1 model,
                  sharks model,
                  scuba |> scale 0.7 |> move (-40, sin model.time*8),
                  ruler1 |> move (0, cos model.time*3) ,
                  text "You meet your best friend and they need to your help!" |> size 6 |> bold |> centered |> filled white |> move (0,55),
                  text "They want you to find the 3 missing gems of their crown." |> size 6 |> bold |> centered |> filled white |> move (0,48),
                  text "Without the gems, A-ventura is in grave danger!" |> size 6 |> bold |> centered |> filled white |> move (0,41),
                  next1button |> notifyTap Next1
            ]
            
        Storyline2  ->
            [ background1 model,
              sharks model,
              scuba |> scale 0.8 |> move (-10*model.time,0),
              fishes2 model |> move (0,-20),
              text "After your coversation with the ruler, you explore" |> size 6 |> bold |> centered |> filled white |> move (0,55),
              text "the underwater city in search of the 3 allure crown gems." |> size 6 |> bold |> centered |> filled white |> move (0,48),
              next2button |> notifyTap Next2
            ]
            
        Storyline3  ->
            [ background1 model,
              sharks model,
              text "You find a mysterious cave!" |> size 6 |> bold |> centered |> filled white |> move (0,55),
              text "~ Something was shining inside it ~" |> size 6 |> bold |> centered |> filled white |> move (0,48),
              text "You decide to go explore the cave!" |> size 6 |> bold |> centered |> filled white |> move (0,-48),
              ngon 5 10 |> filled black |> rotate (degrees 18) |> scale 4 |> move (-98,-18),
              sparkle |> scale 0.1 |> scale (0.5*sin(model.time)) |> move (-85,-10),
              scuba |> scale 0.8 |> move (-10*model.time,0),
              next3button |> notifyTap Next3
            ]
            
        HollowCave  ->
            [ rect 200 150 |> filled black,
              background2,
              hollowintro,
              enterbutton |> scale 2 |> move(0,-20) |> notifyTap Enter
            ]
            
        Instructions  ->
            [ rect 200 150 |> filled black,
              background2,
              instructions,
              next4button |> scale 2 |> move(0,-40) |> notifyTap Next5
            ]
            
        GamesList  ->
            [ background
            , sharks1 model
            , sharks1 model |> move (20*model.time,20)
            , sand
            , listofgames |> scale 1.25 |> move (0,10)
            , gototask1button |> scale 1.5 |> move (60,-55) |> notifyTap GotoTask1
            ]
            
        Task1  ->
            [ backgroundtask1 |> notifyTap Backgroundtask1,
              text "Find the seashell!" |> size 12 |> bold |> underline |> centered |> filled white |> move (0,50),
              seashellbutton |> notifyTap Seashell
            ]
            
        Task2  ->
            [ backgroundtask2,
              text "How many dolphins are there?" |> size 12 |> bold |> underline |> centered |> filled white |> move (0,50),
              groupDolphins,
              wrong1button |> notifyTap Wrong1,
              wrong2button |> notifyTap Wrong2,
              rightbutton |> notifyTap Righttask2    
            ]
            
        Task3  ->
            [ backgroundtask3,
              text "Riddle me this" |> size 12 |> bold |> underline |> centered |> filled white |> move (0,50),
              text "What did the ocean say to the other ocean?" |> size 8 |> bold |> centered |> filled white |> move (0,10),
              wrong3button |> notifyTap Wrong3,
              rightbuttontask3 |> notifyTap Righttask3       
            ]
            
        Fail  ->
            [ rect 200 150 |> filled black,
              background2,
              failmsg,
              returntasksbutton |> move(0,-20) |> notifyTap Returntasks
            ]
            
        Success1  ->
            [ rect 200 150 |> filled black,
              background2,
              successmsg1,
              gem1,
              returntasks1button |> move(0,-20) |> notifyTap Returntasks1
            ]
            
        Success2  ->
            [ rect 200 150 |> filled black,
              background2,
              successmsg2,
              gem2,
              returntasks2button |> move(0,-20) |> notifyTap Returntasks2
            ] 
            
        Success3  ->
            [ rect 200 150 |> filled black,
              background2,
              successmsg3,
              gem3,
              returntasks3button |> move(0,-20) |> notifyTap Returntasks3
            ]
            
        GamesListTask1  ->
            [ background
            , sharks1 model
            , sharks1 model |> move (20*model.time,20)
            , sand
            , listofgames1 |> scale 1.25 |> move (0,10)
            , tickmark |> scale 0.75 |> move (-45,30)
            , gototask2button |> scale 1.5 |> move (60,-55) |> notifyTap Gototask2
            ]
            
        GamesListTask2  ->
            [ background
            , sharks1 model
            , sharks1 model |> move (20*model.time,20)
            , sand
            , listofgames2 |> scale 1.25 |> move (0,10)
            , tickmark |> scale 0.75 |> move (-45,30)
            , tickmark |> scale 0.75 |> move (-45,5)
            , gototask3button |> scale 1.5 |> move (60,-55) |> notifyTap Gototask3
            ]
            
        GamesListTask3  ->
            [ background
            , sharks1 model
            , sharks1 model |> move (20*model.time,20)
            , sand
            , listofgames3 |> scale 1.25 |> move (0,10)
            , tickmark |> scale 0.75 |> move (-45,30)
            , tickmark |> scale 0.75 |> move (-45,5)
            , tickmark |> scale 0.75 |> move (-45,-20)
            , rulerbutton |> scale 1.5 |> move (60,-55) |> notifyTap Gotoruler
            ]
            
        StoryEnd  ->
            [ background1 model,
              sharks model,
              mermaid |> scale 0.7 |> move (-40, sin model.time*8),
              ruler1 |> move (0, cos model.time*3) ,
              text "Congratulations on finding the 3 gems!" |> size 6 |> bold |> centered |> filled white |> move (0,55),
              text "The ruler thanks you for your service and" |> size 6 |> bold |> centered |> filled white |> move (0,48),
              text "as a reward, you gain the ability to turn into a mer-human!" |> size 6 |> bold |> centered |> filled white |> move (0,41),
              gameresetButton |> notifyTap Restart
            ]

type Msg = Tick Float GetKeyState
         | Play 
         | Storytime 
         | Next1 
         | Next2 
         | Next3 
         | Enter 
         | Next5 
         | GotoTask1 
         | Seashell 
         | Backgroundtask1 
         | Returntasks1 
         | Returntasks2 
         | Gototask2 
         | Righttask2 
         | Returntasks 
         | Wrong1 
         | Wrong2 
         | Gototask3 
         | Righttask3 
         | Wrong3 
         | Returntasks3 
         | Gotoruler 
         | Restart 

type State = Welcome 
           | CharactersPage 
           | Storyline1 
           | Storyline2 
           | Storyline3 
           | HollowCave 
           | Instructions 
           | GamesList 
           | Task1 
           | Task2 
           | Task3 
           | Fail 
           | Success1 
           | Success2 
           | Success3 
           | GamesListTask1 
           | GamesListTask2 
           | GamesListTask3 
           | StoryEnd 

update msg model =
    case msg of
        Tick t _ ->
            { model | time = t }
        Play  ->
            case model.state of
                Welcome  ->
                    { model | state = CharactersPage  }

                otherwise ->
                    model
        Storytime  ->
            case model.state of
                CharactersPage  ->
                    { model | state = Storyline1  }

                otherwise ->
                    model
        Next1  ->
            case model.state of
                Storyline1  ->
                    { model | state = Storyline2  }

                otherwise ->
                    model
        Next2  ->
            case model.state of
                Storyline2  ->
                    { model | state = Storyline3  }

                otherwise ->
                    model
        Next3  ->
            case model.state of
                Storyline3  ->
                    { model | state = HollowCave  }

                otherwise ->
                    model
        Enter  ->
            case model.state of
                HollowCave  ->
                    { model | state = Instructions  }

                otherwise ->
                    model
        Next5  ->
            case model.state of
                Instructions  ->
                    { model | state = GamesList  }

                otherwise ->
                    model
        GotoTask1  ->
            case model.state of
                GamesList  ->
                    { model | state = Task1  }

                otherwise ->
                    model
        Seashell  ->
            case model.state of
                Task1  ->
                    { model | state = Success1  }

                otherwise ->
                    model
        Backgroundtask1  ->
            case model.state of
                Task1  ->
                    { model | state = Fail  }

                otherwise ->
                    model
        Returntasks1  ->
            case model.state of
                Success1  ->
                    { model | state = GamesListTask1  }

                otherwise ->
                    model
        Returntasks2  ->
            case model.state of
                Success2  ->
                    { model | state = GamesListTask2  }

                otherwise ->
                    model
        Gototask2  ->
            case model.state of
                GamesListTask1  ->
                    { model | state = Task2  }

                otherwise ->
                    model
        Righttask2  ->
            case model.state of
                Task2  ->
                    { model | state = Success2  }

                otherwise ->
                    model
        Returntasks  ->
            case model.state of
                Fail  ->
                    { model | state = GamesList  }

                otherwise ->
                    model
        Wrong1  ->
            case model.state of
                Task2  ->
                    { model | state = Fail  }

                otherwise ->
                    model
        Wrong2  ->
            case model.state of
                Task2  ->
                    { model | state = Fail  }

                otherwise ->
                    model
        Gototask3  ->
            case model.state of
                GamesListTask2  ->
                    { model | state = Task3  }

                otherwise ->
                    model
        Righttask3  ->
            case model.state of
                Task3  ->
                    { model | state = Success3  }

                otherwise ->
                    model
        Wrong3  ->
            case model.state of
                Task3  ->
                    { model | state = Fail  }

                otherwise ->
                    model
        Returntasks3  ->
            case model.state of
                Success3  ->
                    { model | state = GamesListTask3  }

                otherwise ->
                    model
        Gotoruler  ->
            case model.state of
                GamesListTask3  ->
                    { model | state = StoryEnd  }

                otherwise ->
                    model
        Restart  ->
            case model.state of
                StoryEnd  ->
                    { model | state = Welcome  }

                otherwise ->
                    model

-------------------------------------- welcome page --------------------------------------
playbutton = group [
                     roundedRect 20 10 2 |> filled lightPurple,
                     text "PLAY" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
intro = group [
                text "WELCOME TO THE" |> size 10 |> bold |> centered |> filled white |> move (0,12)
              , text "UNDERWATER CITY" |> size 10 |> bold |> centered |> filled white
              , text "A-VENTURA!" |> size 10 |> bold |> centered |> filled white |> move (0,-12)
              ]

sharks model = group [shark |> scale 0.4 |> move (repeatDistance 10 280 120 -model.time, -10)
  , shark |> scale 0.4 |> move (repeatDistance 20 300 150 -model.time, 30) 
  , shark |> scale 0.1 |> move (repeatDistance 40 260 100 -model.time, 10)]
  
seaweeds1 model = group [ seaweed |> scale 0.5 |> move (-90,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.25 |> move (-50,-40) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.5 |> move (-30,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.25 |> move (10,-40) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.5 |> move (30,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.25 |> move (70,-40) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.5 |> move (90,-30) |> move (5*cos(model.time),0)]              
                   
fishes model = group [
                fish (rgb 230 125 50) darkOrange |> scale 0.3 |> move (repeatDistance 20 240 -120 model.time, 0)
              , fish lightBlue darkBlue          |> scale 0.3 |> move (repeatDistance 40 260 -120 model.time, 20)
              , fish lightPurple darkPurple      |> scale 0.3 |> move (repeatDistance 10 280 -120 model.time, 30)
              , fish lightGreen darkGreen        |> scale 0.3 |> move (repeatDistance 30 240 -120 model.time, -30)
              , fish pink hotPink                |> scale 0.3 |> move (repeatDistance 50 280 -120 model.time, -20)
              , fish lightYellow darkYellow      |> scale 0.3 |> move (repeatDistance 20 240 -120 model.time, 50)
              ]


fish color color2 = group [ triangle 15
                |> outlined (solid 1) black
                |> rotate (degrees 120)
                |> move (-35,0)
              , triangle 15
                |> filled color
                |> rotate (degrees 120)
                |> move (-35,0)
              , curve (-49.26,-36.17) [Pull (-49.26,-36.17) (-49.26,-36.17) ,Pull (-49.26,-36.17) (-49.26,-36.17) 
                                      ,Pull (-48.77,-36.01) (-48.28,-35.84) ,Pull (-47.79,-35.35) (-47.30,-34.86) 
                                      ,Pull (-46.97,-34.53) (-46.64,-34.20) ,Pull (-46.32,-34.37) (-45.99,-34.53) 
                                      ,Pull (-45.50,-34.70) (-45.01,-34.86) ,Pull (-44.68,-34.86) (-44.35,-34.86)
                                      ,Pull (-43.86,-34.53) (-43.37,-34.20) ,Pull (-43.04,-33.71) (-42.72,-33.22) 
                                      ,Pull (-41.73,-33.39) (-40.75,-33.55) ,Pull (-40.26,-33.55) (-39.77,-33.55)
                                      ,Pull (-39.61,-33.71) (-39.44,-33.88) ,Pull (-38.95,-34.20) (-38.46,-34.53) 
                                      ,Pull (-37.64,-33.55) (-36.82,-32.57) ,Pull (-36.17,-32.57) (-35.51,-32.57) 
                                      ,Pull (-35.35,-32.73) (-35.19,-32.90) ,Pull (-34.86,-33.39) (-34.53,-33.88) 
                                      ,Pull (-34.86,-34.37) (-35.19,-34.86) ,Pull (-42.23,-35.68) (-49.26,-36.17)]
                |> filled color2
                |> addOutline (solid 0.25) black
                |> move (41,41)
                |> scale 3
              , oval 40 65
                |> filled color
                |> rotate (degrees 90)
              , oval 40 65
                |> outlined (solid 1) black
                |> rotate (degrees 90)
              , circle 3
                |> filled black
                |> move (20, 10)
              , curve (0,0) [Pull (7,0) (10,-5)]
                |> filled black
                |> rotate (degrees 210)
                |> move (33, 0)
              , triangle 10
                |> filled color2
                |> rotate (degrees 120)
              , triangle 10
                |> outlined (solid 1) black
                |> rotate (degrees 120)
             
                ]

background = group [rect 200 150
                    |> filled (rgb 50 100 200)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (-90,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (-70,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (-50,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (-30,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (-10,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (10,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (30,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (50,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (70,-60)
                  , oval 50 30
                    |> filled lightBrown
                    |> move (90,-60)                     
                   ]
                    
sand = group [oval 50 30
                    |> filled darkBrown
                    |> move (-90,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (-70,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (-50,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (-30,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (-10,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (10,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (30,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (50,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (70,-70)
                  , oval 50 30
                    |> filled darkBrown
                    |> move (90,-70) 
                    
                   ] 
                   
bubbles = group [circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (30,40)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (-30,-40)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (15,20)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (50,-10)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (-25,46)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (50,-25)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (5,-20)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (-60,0)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (-50,50)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (-70,20)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (-90,-30)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (70,50)
               , circle 2
                   |> outlined (solid 1) white
                   |> makeTransparent 0.5
                   |> move (70,20)   
                ]
              
seaweed = group [polygon [(0,73),(1,-34),(6,10)]
                 |> filled (rgb 50 150 0)        
                 ]
                 
                 
shark = curve (-79.71,-2.127) [Pull (-77.74,-0.982) (-75.78,0.1636),Pull (-70.71,2.1278) (-65.63,4.0920)
                              ,Pull (-63.50,5.0741) (-61.38,6.0562),Pull (-58.59,6.8746) (-55.81,7.6930)
                              ,Pull (-52.37,8.6751) (-48.94,9.6572),Pull (-45.34,10.312) (-41.73,10.966)
                              ,Pull (-37.81,11.948) (-33.88,12.930),Pull (-29.62,13.421) (-25.37,13.913)
                              ,Pull (-20.29,14.404) (-15.22,14.895),Pull (-12.60,14.895) (-9.984,14.895)
                              ,Pull (-4.583,15.222) (0.8184,15.549),Pull (1.9641,15.713) (3.1099,15.877)
                              ,Pull (5.4015,19.314) (7.6930,22.751),Pull (10.639,27.335) (13.585,31.918)
                              ,Pull (15.386,34.700) (17.186,37.483),Pull (18.005,38.138) (18.823,38.792)
                              ,Pull (19.314,38.465) (19.805,38.138),Pull (19.969,37.483) (20.132,36.828)
                              ,Pull (20.460,34.864) (20.787,32.900),Pull (21.278,30.772) (21.769,28.644)
                              ,Pull (22.097,26.516) (22.424,24.388),Pull (23.079,22.751) (23.734,21.115)
                              ,Pull (24.552,19.478) (25.370,17.841),Pull (25.861,16.859) (26.352,15.877)
                              ,Pull (27.498,14.240) (28.644,12.603),Pull (29.135,11.621) (29.626,10.639)
                              ,Pull (30.936,10.148) (32.245,9.6572),Pull (34.373,9.1662) (36.501,8.6751)
                              ,Pull (39.283,8.5115) (42.066,8.3478),Pull (42.393,8.1841) (42.721,8.0204)
                              ,Pull (44.849,7.3657) (46.976,6.7109),Pull (48.122,6.7109) (49.268,6.7109)
                              ,Pull (51.396,6.0562) (53.524,5.4015),Pull (54.833,5.4015) (56.143,5.4015)
                              ,Pull (57.289,5.0741) (58.434,4.7468),Pull (60.562,6.2199) (62.690,7.6930)
                              ,Pull (63.017,5.8925) (63.345,4.0920),Pull (65.145,4.0920) (66.946,4.0920)
                              ,Pull (68.746,4.0920) (70.547,4.0920),Pull (73.984,12.603) (77.421,21.115)
                              ,Pull (78.404,24.061) (79.386,27.007),Pull (80.531,29.135) (81.677,31.263)
                              ,Pull (82.987,32.409) (84.296,33.554),Pull (85.278,34.864) (86.260,36.173)
                              ,Pull (87.242,37.156) (88.225,38.138),Pull (88.225,34.864) (88.225,31.590)
                              ,Pull (87.570,30.445) (86.915,29.299),Pull (85.442,17.677) (83.969,6.0562)
                              ,Pull (88.552,-7.856) (93.135,-21.76),Pull (88.879,-19.64) (84.624,-17.51)
                              ,Pull (82.332,-14.89) (80.040,-12.27),Pull (77.094,-8.511) (74.148,-4.746)
                              ,Pull (72.020,-5.401) (69.892,-6.056),Pull (70.547,-8.347) (71.202,-10.63)
                              ,Pull (68.419,-9.820) (65.636,-9.002),Pull (60.890,-11.94) (56.143,-14.89)
                              ,Pull (58.434,-18.00) (60.726,-21.11),Pull (53.851,-19.31) (46.976,-17.51)
                              ,Pull (44.194,-20.13) (41.411,-22.75),Pull (39.938,-21.60) (38.465,-20.46)
                              ,Pull (30.772,-22.09) (23.079,-23.73),Pull (15.222,-24.71) (7.3657,-25.69)
                              ,Pull (9.0025,-29.29) (10.639,-32.90),Pull (11.948,-34.20) (13.258,-35.51)
                              ,Pull (8.5115,-36.17) (3.7647,-36.82),Pull (1.1457,-36.33) (-1.473,-35.84)
                              ,Pull (-3.764,-34.70) (-6.056,-33.55),Pull (-7.529,-32.90) (-9.002,-32.24)
                              ,Pull (-10.63,-32.40) (-12.27,-32.57),Pull (-14.24,-31.09) (-16.20,-29.62)
                              ,Pull (-17.51,-28.15) (-18.82,-26.68),Pull (-19.47,-26.18) (-20.13,-25.69)
                              ,Pull (-33.06,-23.89) (-45.99,-22.09),Pull (-53.03,-19.96) (-60.07,-17.84)
                              ,Pull (-61.21,-17.18) (-62.36,-16.53),Pull (-63.50,-15.38) (-64.65,-14.24)
                              ,Pull (-64,-13.25) (-63.34,-12.27),Pull (-66.94,-11.13) (-70.54,-9.984)
                              ,Pull (-73.82,-8.838) (-77.09,-7.693),Pull (-78.40,-6.383) (-79.71,-5.074)
                              ,Pull (-79.71,-4.419) (-79.71,-2.127)]
                              |> filled darkCharcoal
                              |> makeTransparent 0.3

-------------------------------------- welcome page end --------------------------------------


-------------------------------------- characters page --------------------------------------

storytimebutton = group [
                         roundedRect 40 10 2 |> filled darkGreen |> move (0,-55),
                         text "Story Time" |> size 6 |> bold |> centered |> filled white |> move (0,-56.5)
                         ]

you = group [
                text "YOU" |> size 8 |> bold |> centered |> filled white |> move (-40,-30),
                text "Species: Human" |> size 6 |> centered |> filled white |> move (-40,-36),
                text "Relation: Best Friend of the Ruler" |> size 6 |> centered |> filled white |> move (-40,-42),
                scubadiver |> scale 0.7 |> move (-40,10)
            ]

ruler = group [
                 html 192 128
                ( Html.img [HA.width 192, HA.height 128
                           , HA.align "centered"
                           , HA.src "https://www.pngall.com/wp-content/uploads/5/King-Triton-Trident-PNG-Free-Image.png"]
                           []
                 ) |> move (0,80) |> scale 0.5,
                text "Ruler A-ventura" |> size 8 |> bold |> centered |> filled white |> move (40,-30),
                text "Species: Underwater Being" |> size 6 |> centered |> filled white |> move (40,-36),
                text "Relation: Your Best Friend" |> size 6 |> centered |> filled white |> move (40,-42)
            ]
          

scubadiver = group [
                    circle 10
                      |> filled (rgb 224 172 105)
                      |> move (-7.5,20),
                    roundedRect 20 25 5
                      |> filled darkCharcoal
                      |> rotate (degrees 20),
                    circle 4
                      |> filled darkCharcoal
                      |> move (-35,5),
                    circle 4
                      |> filled darkCharcoal
                      |> move (-32,-12),
                    roundedRect 25 7.5 2
                      |> filled darkCharcoal
                      |> move (-20,5),
                    roundedRect 25 7.5 2
                      |> filled darkCharcoal
                      |> rotate (degrees 30)
                      |> move (-20,-5),
                    roundedRect 10 30 2
                      |> filled darkCharcoal
                      |> rotate (degrees 20)
                      |> move (10,-15),
                    roundedRect 10 30 2
                      |> filled darkCharcoal
                      |> rotate (degrees -10)
                      |> move (0,-15),
                    roundedRect 7 20 2
                      |> filled darkCharcoal
                      |> rotate (degrees 90)
                      |> move (20,-28),
                    roundedRect 7 20 2
                      |> filled darkCharcoal
                      |> rotate (degrees 60)
                      |> move (2,-31),
                    curve (18,-6) [Pull (67,-1) (35,-27), Pull (-7,-26) (0,0) ]
                      |> filled (rgb 250 150 0)
                      |> addOutline (solid 0.75) black
                      |> scale 0.5
                      |> move (25,-20),
                    curve (18,-6) [Pull (67,-1) (35,-27), Pull (-7,-26) (0,0) ]
                      |> filled (rgb 250 150 0)
                      |> addOutline (solid 0.75) black
                      |> scale 0.5
                      |> move (7,-30),
                    roundedRect 15 7 2
                      |> filled darkGreen
                      |> addOutline (solid 1) black
                      |> makeTransparent 0.75
                      |> move (-7.5,22)
                   ]
                   
  
seaweeds2 model = group [ seaweed |> scale 0.5 |> move (-90,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.25 |> move (-50,-40) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.5 |> move (-30,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.25 |> move (10,-40) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.5 |> move (30,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.25 |> move (70,-40) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.5 |> move (90,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.75 |> move (50,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.75 |> move (-70,-30) |> move (5*cos(model.time),0)
  , seaweed |> scale 0.75 |> move (-10,-30) |> move (5*cos(model.time),0)]              

-------------------------------------- characters page end --------------------------------------

-------------------------------------- Story line 1 page --------------------------------------
ruler1 = group [
                 html 192 128
                ( Html.img [HA.width 192, HA.height 128
                           , HA.align "centered"
                           , HA.src "https://www.pngall.com/wp-content/uploads/5/King-Triton-Trident-PNG-Free-Image.png"]
                           []
                 ) |> move (-120,60) |> scale 0.6
                 ]
            
background1 model = group [
                     rect 200 150 |> filled (rgb 50 100 200),
                     rect 200 20 |> filled darkBrown |> move (0,-60),
                     fishes1 model
                   ]

next1button = group [
                    roundedRect 20 10 2 |> filled darkGreen |> move (0,-57),
                    text "Next" |> size 6 |> bold |> centered |> filled white |> move (0,-58.5)
                    ]
                    
scuba = scubadiver |> move (100,0)
                   
fishes1 model = group [
                fish black black |> scale 0.1 |> move (repeatDistance 20 240 -120 model.time, 0) |> makeTransparent 0.75
              , fish black black |> scale 0.1 |> move (repeatDistance 40 260 -120 model.time, 20) |> makeTransparent 0.75
              , fish black black |> scale 0.1 |> move (repeatDistance 10 280 -120 model.time, 30) |> makeTransparent 0.75
              , fish black darkCharcoal |> scale 0.1 |> move (repeatDistance 30 240 -120 model.time, -30) |> makeTransparent 0.75
              , fish black lightCharcoal |> scale 0.1 |> move (repeatDistance 50 280 -120 model.time, -20) |> makeTransparent 0.75
              , fish black lightCharcoal |> scale 0.1 |> move (repeatDistance 20 240 -120 model.time, 50) |> makeTransparent 0.75
              , fish black black |> scale 0.1 |> move (repeatDistance 5 300 -120 model.time, 40) |> makeTransparent 0.75
              , fish black black |> scale 0.1 |> move (repeatDistance 15 260 -120 model.time, 20) |> makeTransparent 0.75
              , fish black black |> scale 0.1 |> move (repeatDistance 35 280 -120 model.time, 30) |> makeTransparent 0.75
              , fish black darkCharcoal |> scale 0.1 |> move (repeatDistance 45 280 -120 model.time, -30) |> makeTransparent 0.75
              , fish black lightCharcoal |> scale 0.1 |> move (repeatDistance 10 300 -120 model.time, -20) |> makeTransparent 0.75
              , fish black lightCharcoal |> scale 0.1 |> move (repeatDistance 20 240 -120 model.time, -25) |> makeTransparent 0.75
              ]

fishes2 model = group [
                fish black black |> scale 0.1 |> move (repeatDistance 30 240 -120 model.time, 0)
              , fish black black |> scale 0.1 |> move (repeatDistance 20 260 -120 model.time, 20)
              , fish black black |> scale 0.1 |> move (repeatDistance 60 280 -120 model.time, 30)
              , fish black darkCharcoal |> scale 0.1 |> move (repeatDistance 50 240 -120 model.time, -30)
              , fish black lightCharcoal |> scale 0.1 |> move (repeatDistance 15 280 -120 model.time, -20)
              , fish black lightCharcoal |> scale 0.1 |> move (repeatDistance 7 240 -120 model.time, 50)
              , fish black black |> scale 0.1 |> move (repeatDistance 4 300 -120 model.time, 40)
              , fish black black |> scale 0.1 |> move (repeatDistance 10 260 -120 model.time, 20)
              , fish black black |> scale 0.1 |> move (repeatDistance 25 280 -120 model.time, 30)
              , fish black darkCharcoal |> scale 0.1 |> move (repeatDistance 30 280 -120 model.time, -30)
              , fish black lightCharcoal |> scale 0.1 |> move (repeatDistance 45 300 -120 model.time, -20)
              , fish black lightCharcoal |> scale 0.1 |> move (repeatDistance 9 240 -120 model.time, -25)
              ]



-------------------------------------- Story line 1 page end --------------------------------------

-------------------------------------- Story line 2 page --------------------------------------

next2button = group [
                    roundedRect 20 10 2 |> filled darkGreen |> move (0,-57),
                    text "Next" |> size 6 |> bold |> centered |> filled white |> move (0,-58.5)
                    ]

-------------------------------------- Story line 2 page end --------------------------------------

-------------------------------------- Story line 3 page --------------------------------------

sparkle = html 170 128
                ( Html.img [HA.width 192, HA.height 128
                           , HA.align "centered"
                           , HA.src "https://clipart.world/wp-content/uploads/2021/06/Sparkle-clipart-transparent.png"]
                           []
                 ) 

next3button = group [
                    roundedRect 20 10 2 |> filled darkGreen |> move (0,-57),
                    text "Next" |> size 6 |> bold |> centered |> filled white |> move (0,-58.5)
                    ]
  
scuba2 = scubadiver |> move (100,-10)


-------------------------------------- Story line 3 page end --------------------------------------

-------------------------------------- Hollow cave --------------------------------------

background2 = html 170 128
                ( Html.img [HA.width 192, HA.height 128
                           , HA.align "centered"
                           , HA.src "https://adventuretourcenter.com/wp-content/uploads/2018/08/Cenote2OjosATCScubaDiving.jpg"]
                           []
                 ) |> move (-95,60)
                 
                 
enterbutton = group [
                     roundedRect 25 10 2 |> filled darkGreen,
                     text "ENTER" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
hollowintro = group [
                text "WELCOME TO THE" |> size 12 |> bold |> centered |> filled white |> move (0,12)
              , text "HOLLOW'S CAVE" |> size 12 |> bold |> centered |> filled white
              ]      

-------------------------------------- Hollow cave end --------------------------------------

-------------------------------------- Instructions ----------------------------------------             
                 
next4button = group [
                     roundedRect 25 10 2 |> filled darkGreen,
                     text "NEXT" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
instructions = group [
                text "INSTRUCTIONS" |> size 12 |> bold |> underline|> centered |> filled white |> move (0,40)
              , text "1. Complete the tasks/games in order to obtain the gems!" |> size 8 |> centered |> filled white |> move (0,20)
              , text "2. If failed to complete one of the task/game, you will" |> size 8 |> centered |> filled white
              , text "have to redo all the tasks/games" |> size 8 |> centered |> filled white |> move (0,-10)
              
              ]  

-------------------------------------- Instructions end -----------------------------------------

-------------------------------------- GamesList ----------------------------------------             
                 
gototask1button = group [
                     roundedRect 40 10 2 |> filled black,
                     text "Go to Task 1" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
listofgames = group [
                text "Tasks to complete:" |> size 12 |> bold |> centered |> filled white |> move (0,30)
              , square 10 |> outlined (solid 2) darkGreen |> move (-40,15)
              , text "Find the Seashells!" |> size 8 |> bold |> centered |> filled white |> move (5,12.5)
              , square 10 |> outlined (solid 2) darkGreen |> move (-40,-5)
              , text "How many are there?" |> size 8 |> bold |> centered |> filled white |> move (10,-7.5)
              , square 10 |> outlined (solid 2) darkGreen |> move (-40,-25)
              , text "Riddle me this" |> size 8 |> bold |> centered |> filled white |> move (-2.5,-27.5)
              ]

sharks1 model = group [shark |> scale 0.4 |> move (repeatDistance 10 280 120 -model.time, -10)
  , shark |> scale 0.4 |> move (repeatDistance 20 300 150 -model.time, 30) 
  , shark |> scale 0.1 |> move (repeatDistance 40 260 100 -model.time, 10)
  , shark |> scale 0.2 |> move (repeatDistance 10 280 120 -model.time, 40)
  , shark |> scale 0.1 |> move (repeatDistance 50 240 90 -model.time, -20)]      

                 
-------------------------------------- GamesList end -----------------------------------------

-------------------------------------- Task 1 ----------------------------------------             

backgroundtask1 = group [
                 html 600 425
                ( Html.img [HA.width 600, HA.height 425
                           , HA.align "centered"
                           , HA.src "https://scx2.b-cdn.net/gfx/news/2021/study-remote-ocean-wil.jpg"]
                           []
                 ) |> scale 0.5 |> move (-120,100)
                 ]

seashellbutton = group [
                 html 200 180
                ( Html.img [HA.width 200, HA.height 180
                           , HA.align "centered"
                           , HA.src "https://www.seekpng.com/png/full/49-490779_svg-free-stock-clam-clipart-transparent-background-shell.png"]
                           []
                 ) |> scale 0.02 |> move (55,-40)
                 ]

-------------------------------------- Task 1 end ----------------------------------------             

-------------------------------------- Task 2 ----------------------------------------             

backgroundtask2 = group [
                 html 600 425
                ( Html.img [HA.width 600, HA.height 425
                           , HA.align "centered"
                           , HA.src "https://www.state.gov/wp-content/uploads/2022/04/shutterstock_1044142519-scaled.jpg"]
                           []
                 ) |> scale 0.5 |> move (-120,100)
                 ]

groupDolphins = group [
                        dolphin,
                        dolphin |> move (0,-40),
                        dolphin |> scale 0.5 |> move (60,-50),
                        dolphin |> scale 0.8 |> move (-60,-50),
                        dolphin |> scale 0.4 |> move (-60,-30),
                        dolphin |> scale 0.3 |> move (70,-20)

                      ]
dolphin = group [
                 html 200 125
                ( Html.img [HA.width 200, HA.height 125
                           , HA.align "centered"
                           , HA.src "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/41407/cartoon-dolphin-clipart-xl.png"]
                           []
                 ) |> scale 0.1
                 ]
                 
wrong1button = group [
                     roundedRect 20 10 2 |> filled black,
                     text "9" |> size 8 |> bold |> centered |> filled white |> move (0,-2)
                   ] |> move (-40,30)

rightbutton = group [
                     roundedRect 20 10 2 |> filled black,
                     text "6" |> size 8 |> bold |> centered |> filled white |> move (0,-2)
                   ] |> move (0,30)
                   
wrong2button = group [
                     roundedRect 20 10 2 |> filled black,
                     text "5" |> size 8 |> bold |> centered |> filled white |> move (0,-2)
                   ] |> move (40,30)

-------------------------------------- Task 2 end ----------------------------------------   

-------------------------------------- Task 3 ----------------------------------------             

backgroundtask3 = group [
                 html 600 425
                ( Html.img [HA.width 600, HA.height 425
                           , HA.align "centered"
                           , HA.src "https://i.ytimg.com/vi/w94ZB0VJUp4/maxresdefault.jpg"]
                           []
                 ) |> scale 0.5 |> move (-120,100)
                 ]

rightbuttontask3 = group [
                     roundedRect 70 10 2 |> filled darkGreen,
                     text "Nothing, they just waved!" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ] |> move (-40,-20)

wrong3button = group [
                     roundedRect 70 10 2 |> filled darkGreen,
                     text "Where are you here?" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ] |> move (40,-20)


-------------------------------------- Task 3 end ----------------------------------------   

-------------------------------------- Fail ----------------------------------------             
                             
returntasksbutton = group [
                     roundedRect 45 10 2 |> filled red,
                     text "Return to Tasks" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
failmsg = group [
                text "Failed to Completed the Task" |> size 12 |> bold |> centered |> filled red |> move (0,12)
              , text "~ Please return to redo the tasks ~" |> size 10 |> bold |> centered |> filled white
              ]   


-------------------------------------- Fail end ----------------------------------------  

-------------------------------------- Success 1 ----------------------------------------             

returntasks1button = group [
                     roundedRect 45 10 2 |> filled darkGreen,
                     text "Return to Tasks" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
successmsg1 = group [
                text "Congratulations!" |> size 12 |> bold |> centered |> filled white |> move (0,12)  
              , text "You have completed Task 1!" |> size 12 |> bold |> centered |> filled white
                ]

-------------------------------------- Success 1 end ---------------------------------------- 

-------------------------------------- Success 2 ----------------------------------------             

returntasks2button = group [
                     roundedRect 45 10 2 |> filled darkGreen,
                     text "Return to Tasks" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
successmsg2 = group [
                text "Congratulations!" |> size 12 |> bold |> centered |> filled white |> move (0,12)  
              , text "You have completed Task 2!" |> size 12 |> bold |> centered |> filled white
                ]


-------------------------------------- Success 2 end ---------------------------------------- 

-------------------------------------- Success 3 ----------------------------------------             

returntasks3button = group [
                     roundedRect 45 10 2 |> filled darkGreen,
                     text "Return to Tasks" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
successmsg3 = group [
                text "Congratulations!" |> size 12 |> bold |> centered |> filled white |> move (0,12)  
              , text "You have completed Task 3!" |> size 12 |> bold |> centered |> filled white
                ]

-------------------------------------- Success 3 end ---------------------------------------- 

-------------------------------------- GamesList Task 1 Completed ----------------------------------------             


gototask2button = group [
                     roundedRect 40 10 2 |> filled black,
                     text "Go to Task 2" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]
                   
tickmark = group [
                  rect 10 5 |> filled darkGreen |> rotate (degrees -45) |> move (-8.5,-5),
                  rect 20 5 |> filled darkGreen |> rotate (degrees 45)
                 ] |> addOutline (solid 0.5) black

listofgames1 = group [
                text "Tasks to complete:" |> size 12 |> bold |> centered |> filled white |> move (0,30)
              , square 10 |> outlined (solid 2) black |> move (-40,15)
              , text "Find the Seashell!" |> size 8 |> bold |> centered |> filled white |> move (5,12.5)
              , square 10 |> outlined (solid 2) darkGreen |> move (-40,-5)
              , text "How many are there?" |> size 8 |> bold |> centered |> filled white |> move (10,-7.5)
              , square 10 |> outlined (solid 2) darkGreen |> move (-40,-25)
              , text "Riddle me this" |> size 8 |> bold |> centered |> filled white |> move (-2.5,-27.5)
              ]


-------------------------------------- GamesList Task 1 Completed end ----------------------------------------             

-------------------------------------- GamesList Task 2 Completed ----------------------------------------             

gototask3button = group [
                     roundedRect 40 10 2 |> filled black,
                     text "Go to Task 3" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]

listofgames2 = group [
                text "Tasks to complete:" |> size 12 |> bold |> centered |> filled white |> move (0,30)
              , square 10 |> outlined (solid 2) black |> move (-40,15)
              , text "Find the Seashell!" |> size 8 |> bold |> centered |> filled white |> move (5,12.5)
              , square 10 |> outlined (solid 2) black |> move (-40,-5)
              , text "How many are there?" |> size 8 |> bold |> centered |> filled white |> move (10,-7.5)
              , square 10 |> outlined (solid 2) darkGreen |> move (-40,-25)
              , text "Riddle me this" |> size 8 |> bold |> centered |> filled white |> move (-2.5,-27.5)
              ]



-------------------------------------- GamesList Task 2 Completed end ----------------------------------------             

-------------------------------------- GamesList Task 3 Completed ----------------------------------------             

rulerbutton = group [
                     roundedRect 40 10 2 |> filled black,
                     text "Go to the ruler" |> size 6 |> bold |> centered |> filled white |> move (0,-1.5)
                   ]

listofgames3 = group [
                text "Tasks to complete:" |> size 12 |> bold |> centered |> filled white |> move (0,30)
              , square 10 |> outlined (solid 2) black |> move (-40,15)
              , text "Find the Seashell!" |> size 8 |> bold |> centered |> filled white |> move (5,12.5)
              , square 10 |> outlined (solid 2) black |> move (-40,-5)
              , text "How many are there?" |> size 8 |> bold |> centered |> filled white |> move (10,-7.5)
              , square 10 |> outlined (solid 2) black |> move (-40,-25)
              , text "Riddle me this" |> size 8 |> bold |> centered |> filled white |> move (-2.5,-27.5)
              ]


-------------------------------------- GamesList Task 3 Completed end ----------------------------------------             

-------------------------------------- Story End ----------------------------------------             

mermaid = group [
                 html 150 170
                ( Html.img [HA.width 150, HA.height 170
                           , HA.align "centered"
                           , HA.src "https://clipart.world/wp-content/uploads/2020/10/Brunette-Mermaid-clipart-transparent.png"]
                           []
                 ) |> move (120,60) |> scale 0.6
                 ]


gameresetButton = group [
                    roundedRect 30 10 2 |> filled darkGreen |> move (0,-57),
                    text "Restart" |> size 6 |> bold |> centered |> filled white |> move (0,-58.5)
                    ]


-------------------------------------- Story End ----------------------------------------             

-------------------------------------- gems ---------------------------------------------

gem1 = group [
                 html 150 170
                ( Html.img [HA.width 150, HA.height 170
                           , HA.align "centered"
                           , HA.src "https://www.pngall.com/wp-content/uploads/6/Gem-PNG-HD-Image.png"]
                           []
                 ) |> scale 0.1 |> move (-10,50),
                 text "x1 gem obtained!" |> size 5 |> bold |> centered |> filled green |> move (-2,28)
                 
                 ]

gem2 = group [
                 html 150 170
                ( Html.img [HA.width 150, HA.height 170
                           , HA.align "centered"
                           , HA.src "https://www.pngmart.com/files/7/Gems-Transparent-Images-PNG.png"]
                           []
                 ) |> scale 0.1 |> move (-10,50),
                 text "x1 gem obtained!" |> size 5 |> bold |> centered |> filled green |> move (-2,28)
                 
                 ]

gem3 = group [
                 html 150 170
                ( Html.img [HA.width 150, HA.height 170
                           , HA.align "centered"
                           , HA.src "https://www.pngmart.com/files/7/Ruby-PNG-File.png"]
                           []
                 ) |> scale 0.15 |> move (-15,55),
                 text "x1 gem obtained!" |> size 5 |> bold |> centered |> filled green |> move (-2,28)
                 
                 ]

-------------------------------------- gems end ---------------------------------------------

{-
-- repeat an animation for a given duration
-- repeatDuration : Float -> Int -> Float -> Float -> Float
repeatDuration speed duration startPosition time =
  speed * (time - toFloat duration * toFloat (floor time // duration)) + startPosition

-- repeat an animation for a given distance
-- repeatDistance : Float -> Float -> Float -> Float -> Float
repeatDistance speed distance startPosition time =
  repeatDuration speed (round <| distance / speed) startPosition time

-- sequence a series of animation pieces together into one
-- animationPieces : List (Float, Float -> anytype) -> (Float -> anytype) -> Float -> anytype
animationPieces intervals finalAnimation time =
  case intervals of
    (duration, animation) :: rest ->
        if time <= duration then
          animation time
        else
          animationPieces rest finalAnimation (time - duration)
    [] ->
        finalAnimation time
-}
type alias Point = (Float, Float)

type alias Model =
    { time : Float
    , state : State
    }

init : Model
init = { time = 0 
       , state = Welcome
       }


main = gameApp Tick { model = init, view = view, update = update, title = "Game Slot" }

view model = collage 192 128 (myShapes model)
    
