import Html exposing (Html, div, text)
import Html.App as HtmlApp
import Html.Attributes exposing (class)

import FilesList
import Header
import ListItem

main = HtmlApp.beginnerProgram { model = model , view = view , update = update }



-- Model

type alias Model =
  { listing: FilesList.Model
  , appTitle: Header.Model
  }

model : Model
model =
  Model { selected = 0, items = FilesList.mockItems } "My app"



-- Update

type Msg
  = FilesListActions FilesList.Msg
  | HeaderActions Header.Msg

update : Msg -> Model -> Model
update msg model =
  case msg of
    FilesListActions focus ->
      { model | listing = FilesList.update focus model.listing }

    HeaderActions x ->
      model




-- View

view : Model -> Html Msg
view model =
  div
    [ ]
    [ HtmlApp.map HeaderActions (Header.view model.appTitle)
    , div
        [ class "container-fluid" ]
        [ div
            [ class "row" ]
            [ HtmlApp.map FilesListActions (FilesList.view model.listing)
            , div
                [ class "col-md-8" ]
                [ text "Hello!" ]
            ]
        ]
    ]
