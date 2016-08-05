module Header exposing (Model, Msg, view, update)

import Html exposing (Html, a, div, h1, nav, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, href)

main = beginnerProgram { model = "My App" , view = view , update = update }



type alias Model = String

type Msg = Toggle



update : Msg -> Model -> Model
update msg model = model



view : Model -> Html Msg
view appTitle =
  nav
    [ class "navbar navbar-default" ]
    [ div
      [ class "container-fluid" ]
      [
        div
          [ class "navbar-header" ]
          [
            a
              [ class "navbar-brand"
              , href "#"
              ]
              [ text appTitle ]
          ]
      ]
    ]
