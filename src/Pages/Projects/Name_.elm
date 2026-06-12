module Pages.Projects.Name_ exposing (page)

import Html exposing (..)
import Html.Attributes exposing (..)
import View exposing (View)


type alias ProjectMeta =
    { title : String
    , description : String
    , tags : List String
    }


projectMeta : String -> Maybe ProjectMeta
projectMeta slug =
    case slug of
        "newyearsmystery" ->
            Just
                { title = "New Years Mystery"
                , description = "A mystery game built for New Year's. Explore clues and solve the puzzle before midnight."
                , tags = [ "game", "interactive" ]
                }

        "paintbynumbers" ->
            Just
                { title = "Paint by Numbers"
                , description = "A paint-by-numbers app where you fill in a grid to reveal a hidden picture."
                , tags = [ "art", "puzzle" ]
                }

        "unicorn" ->
            Just
                { title = "Unicorn"
                , description = "A whimsical Elm experiment. Click around and see what happens."
                , tags = [ "animation", "fun" ]
                }

        _ ->
            Nothing


page : { name : String } -> View msg
page params =
    { title = pageTitle params.name
    , body = [ view params.name ]
    }


pageTitle : String -> String
pageTitle slug =
    case projectMeta slug of
        Just meta ->
            meta.title ++ " — Elm Portfolio"

        Nothing ->
            "Project Not Found"


view : String -> Html msg
view slug =
    case projectMeta slug of
        Just meta ->
            div [ class "page project-detail" ]
                [ div [ class "detail-header" ]
                    [ a [ href "/projects", class "back-link" ] [ text "← All Projects" ]
                    , h1 [] [ text meta.title ]
                    , p [ class "detail-desc" ] [ text meta.description ]
                    , div [ class "detail-tags" ]
                        (List.map (\tag -> span [ class "tag" ] [ text tag ]) meta.tags)
                    ]
                , div [ class "demo-wrapper" ]
                    [ iframe
                        [ src ("/" ++ slug ++ "/index.html")
                        , title (meta.title ++ " demo")
                        , attribute "allowfullscreen" ""
                        ]
                        []
                    ]
                ]

        Nothing ->
            div [ class "page not-found" ]
                [ a [ href "/projects", class "back-link" ] [ text "← All Projects" ]
                , h1 [] [ text "Project not found" ]
                , p [] [ text ("No project found with the slug: " ++ slug) ]
                ]
