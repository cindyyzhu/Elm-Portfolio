module Pages.Home_ exposing (page)

import Html exposing (..)
import Html.Attributes exposing (..)
import View exposing (View)


page : View msg
page =
    { title = "Elm Portfolio"
    , body = [ view ]
    }


view : Html msg
view =
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
        ]
