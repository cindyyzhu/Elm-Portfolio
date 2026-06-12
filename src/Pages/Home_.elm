module Pages.Home_ exposing (Model, Msg, page)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Page exposing (Page)
import View exposing (View)


page : Page Model Msg
page =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { fullscreen : Maybe String
    }


init : Model
init =
    { fullscreen = Nothing
    }



-- UPDATE


type Msg
    = OpenExemplar String
    | CloseExemplar


update : Msg -> Model -> Model
update msg model =
    case msg of
        OpenExemplar name ->
            { model | fullscreen = Just name }

        CloseExemplar ->
            { model | fullscreen = Nothing }



-- EXEMPLARS
-- Replace these with your actual .elm filenames (without the .elm extension)


exemplars : List String
exemplars : List String
exemplars =
    [ "AnglerFish"
    , "AnimationPiecesExit"
    , "CrabInSpace"
    , "CurveCreator"
    , "DiversityMatters"
    , "ElmAnimations"
    , "FoxInForest"
    , "Mermaid"
    , "PolygonCreator"
    , "PredatorPrey"
    , "RobotDance"
    , "SELena"
    , "SinCosTan"
    , "SnowingSnowman"
    , "StarfishGradient"
    , "Turtle"
    , "UnderwaterGame"
    , "WhaleWiggle"
    , "WordByHues"
    ]



-- VIEW


view : Model -> View Msg
view model =
    { title = "Elm Portfolio"
    , body =
        [ case model.fullscreen of
            Just name ->
                viewFullscreen name

            Nothing ->
                viewMain
        ]
    }


viewMain : Html Msg
viewMain =
    div [ class "page home" ]
        [ header [ class "hero" ]
            [ div [ class "hero-inner" ]
                [ div [ class "hero-tag" ] [ text "Built with Elm" ]
                , h1 [] [ text "Elm Projects" ]
                , p [ class "hero-sub" ]
                    [ text "A collection of interactive apps and experiments made with "
                    , a [ href "https://elm-lang.org", target "_blank" ] [ text "Elm" ]
                    , text " — a functional language for the web."
                    ]
                , a [ href "/projects", class "btn" ] [ text "View Projects →" ]
                ]
            ]
        , section [ class "about" ]
            [ div [ class "about-inner" ]
                [ h2 [] [ text "About" ]
                , p []
                    [ text "These projects were built while learning Elm — "
                    , text "exploring its type system, the Elm Architecture, and "
                    , text "what it means to write UI code that doesn't crash at runtime."
                    ]
                ]
            ]
        , section [ class "exemplars" ]
            [ div [ class "exemplars-inner" ]
                [ h2 [] [ text "Exemplars" ]
                , div [ class "exemplars-grid" ]
                    (List.map viewCard exemplars)
                ]
            ]
        ]


viewCard : String -> Html Msg
viewCard name =
    div
        [ class "exemplar-card"
        , onClick (OpenExemplar name)
        , style "cursor" "pointer"
        ]
        [ iframe
            [ src ("/exemplars-built/" ++ name ++ "/index.html")
            , style "width" "100%"
            , style "height" "300px"
            , style "border" "none"
            , style "pointer-events" "none"
            , attribute "scrolling" "no"
            ] []
        , p [ class "exemplar-label" ] [ text name ]
        ]


viewFullscreen : String -> Html Msg
viewFullscreen name =
    div
        [ style "position" "fixed"
        , style "inset" "0"
        , style "background" "#000"
        , style "z-index" "100"
        ]
        [ button
            [ onClick CloseExemplar
            , style "position" "absolute"
            , style "top" "16px"
            , style "left" "16px"
            , style "z-index" "101"
            , style "padding" "8px 16px"
            , style "cursor" "pointer"
            ]
            [ text "← Back" ]
        , iframe
            [ src ("/exemplars-built/" ++ name ++ "/index.html")
            , style "width" "100%"
            , style "height" "100%"
            , style "border" "none"
            ] []
        ]