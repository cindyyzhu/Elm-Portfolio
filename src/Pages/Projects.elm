module Pages.Projects exposing (page)

import Html exposing (..)
import Html.Attributes exposing (..)
import View exposing (View)


type alias Project =
    { name : String
    , slug : String
    , description : String
    , tags : List String
    }


projects : List Project
projects =
    [ { name = "New Years Mystery"
      , slug = "newyearsmystery"
      , description = "A mystery game built for New Year's. Explore clues and solve the puzzle before midnight."
      , tags = [ "game", "interactive" ]
      }
    , { name = "Paint by Numbers"
      , slug = "paintbynumbers"
      , description = "A paint-by-numbers app where you fill in a grid to reveal a hidden picture."
      , tags = [ "art", "puzzle" ]
      }
    , { name = "Unicorn"
      , slug = "unicorn"
      , description = "A whimsical Elm experiment. Click around and see what happens."
      , tags = [ "animation", "fun" ]
      }
    ]


page : View msg
page =
    { title = "Projects — Elm Portfolio"
    , body = [ view ]
    }


view : Html msg
view =
    div [ class "page projects" ]
        [ div [ class "projects-header" ]
            [ a [ href "/", class "back-link" ] [ text "← Home" ]
            , h1 [] [ text "Projects" ]
            , p [] [ text "Click any project to explore it and try the live demo." ]
            ]
        , div [ class "project-grid" ]
            (List.map projectCard projects)
        ]


projectCard : Project -> Html msg
projectCard project =
    a [ href ("/projects/" ++ project.slug), class "project-card" ]
        [ div [ class "card-top" ]
            [ h2 [] [ text project.name ] ]
        , p [ class "card-desc" ] [ text project.description ]
        , div [ class "card-tags" ]
            (List.map (\tag -> span [ class "tag" ] [ text tag ]) project.tags)
        , div [ class "card-cta" ] [ text "Open demo →" ]
        ]
