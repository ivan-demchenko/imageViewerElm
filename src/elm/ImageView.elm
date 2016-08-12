module ImageView exposing (..)

import Html.App as App
import Html exposing (Html, div, img)
import Html.Attributes exposing (class, src)



init : String -> (Model, Cmd Msg)
init url = (url, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none




-- Model

type alias Model =
  String



-- Update

type Msg =
  ImageSelected String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ImageSelected newURL ->
      (newURL, Cmd.none)



-- View

view : Model -> Html Msg
view model =
  div
    [ class "col-md-8" ]
    [ img
      [ src model
      , class "img-responsive"]
      []
    ]


-- Etc

main =
  App.program
    { init = init "http://weknowyourdreams.com/images/island/island-01.jpg"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
