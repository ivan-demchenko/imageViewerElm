module FilesList exposing (Model, Msg, mockItems, view, update, model)

import ListItem
import Html exposing (Html, div, text)
import Html.App as HtmlApp
import Html.Attributes exposing (class)

main = HtmlApp.beginnerProgram { model = model , view = view , update = update }



-- Model

type alias IndexedItem =
  { id: Int
  , listItemModel: ListItem.Model
  }

type alias Model =
  { selected: Int
  , items: List IndexedItem
  }

mockItems : List IndexedItem
mockItems =
  [ IndexedItem 0 (ListItem.Model "dir 1" False "Dir")
  , IndexedItem 1 (ListItem.Model "file 1" False "File")
  , IndexedItem 2 (ListItem.Model "file 1" False "File")
  , IndexedItem 3 (ListItem.Model "file 1" False "File")
  ]

model : Model
model =
  { selected = -1
  , items = mockItems
  }


-- Update

type Msg =
  Focus Int ListItem.Msg


setFocus : Int -> Int -> ListItem.Msg -> IndexedItem -> IndexedItem
setFocus prevSelected targetId msg {id, listItemModel} =
  IndexedItem id (if (targetId == id) && (prevSelected /= targetId)
    then { listItemModel | focused = True }
    else { listItemModel | focused = False }
    )


update : Msg -> Model -> Model
update msg {selected, items} =
  case msg of
    Focus idx msg ->
      { selected = idx
      , items = (List.map (setFocus selected idx msg) items)
      }



-- View

renderItem : IndexedItem -> Html Msg
renderItem {id, listItemModel} =
  HtmlApp.map (Focus id) (ListItem.view listItemModel)

view : Model -> Html Msg
view {selected, items} =
  div
    [ class "col-md-4" ]
    [
      div
        [ class "list-group" ]
        (List.map renderItem items)
    ]
