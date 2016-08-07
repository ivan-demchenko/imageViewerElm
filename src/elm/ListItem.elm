module ListItem exposing (Model, Msg, view, update, model)

import Html exposing (Html, a, span, i, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)

main = beginnerProgram { model = model , view = view , update = update }



-- Model

type alias Model =
  { label: String
  , focused: Bool
  , oftype: String
  }

model : Model
model =
  Model "Item 1" False "Dir"



-- Update

type Msg = Toggle


update : Msg -> Model -> Model
update msg item =
  case msg of
    Toggle ->
      { item | focused = not item.focused }



-- View

getHtmlClass : Model -> String
getHtmlClass item =
  "list-group-item" ++ (if item.focused then " active" else "")

renderDir : String -> Html Msg
renderDir label =
  span []
    [ i [ class "glyphicon glyphicon-folder-close" ] []
    , text (" " ++ label) ]

renderFile : String -> Html Msg
renderFile label =
  span []
    [ i [ class "glyphicon glyphicon-camera" ] []
    , text (" " ++ label) ]

viewItem : Model -> Html Msg
viewItem item =
  if item.oftype == "Dir"
    then renderDir item.label
    else renderFile item.label

view : Model -> Html Msg
view item =
  a
    [ class (getHtmlClass item)
    , onClick Toggle
    ]
    [ viewItem item ]
