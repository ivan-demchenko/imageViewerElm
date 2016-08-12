module Header exposing (Model, Msg, subscriptions, init, view, update)

import Html exposing (Html, a, div, h1, nav, text)
import Html.App as App
import Html.Attributes exposing (class, href)

main : Program Never
main =
  App.program
    { init = init "Test app"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


type alias Model = String

type Msg = ToggleMenu


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


init : String -> (Model, Cmd Msg)
init title =
  (title, Cmd.none)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (model, Cmd.none)



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
