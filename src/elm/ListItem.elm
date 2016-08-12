module ListItem exposing (Model, Msg, view, update)

import Html exposing (Html, a, span, i, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)

-- Model

type alias Model =
  { label: String
  , path: String
  , focused: Bool
  , oftype: String
  }


-- Update

type Msg = Select String


update : Msg -> Model -> Model
update msg item =
  case msg of
    Select itemPath ->
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
    , onClick (Select item.path)
    ]
    [ viewItem item ]


--- Etc

main : Program Never
main = beginnerProgram { model = model , view = view , update = update }

model : Model
model =
  { label = "Item 1"
  , path = "http://www.islands.com/sites/islands.com/files/styles/large_1x_/public/images/2016/01/shutterstock_230057017.jpg?itok=Z0Cqa_rc"
  , focused = False
  , oftype = "Dir"
  }
