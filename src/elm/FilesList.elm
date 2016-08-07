module FilesList exposing (Model, Msg, init, subscriptions, mockItems, view, update)

import ListItem
import Html exposing (Html, div, text)
import Html.App as App
import Html.Attributes exposing (class)
import Keyboard as KB exposing (..)

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



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

init : (Model, Cmd Msg)
init =
  (Model 0 mockItems, Cmd.none)


-- Update

type Msg
  = Focus Int ListItem.Msg
  | KeyDown KB.KeyCode


setFocusOnItem : Int -> Int -> IndexedItem -> IndexedItem
setFocusOnItem prevSelected targetId {id, listItemModel} =
  IndexedItem id (if (targetId == id) && (prevSelected /= targetId)
    then { listItemModel | focused = True }
    else { listItemModel | focused = False }
    )

getSelectedIndex : Int -> Int -> Int -> Int
getSelectedIndex dir currIdx listLen =
  let
    newIndex =
      currIdx + dir
  in
    if newIndex < 0 then listLen - 1 else (
      if newIndex >= listLen then 0 else newIndex
    )


getFocusDirection : Int -> Int
getFocusDirection keyCode =
  if List.member keyCode [37,38,65,87] then -1 else (
    if List.member keyCode [40,39,68,83] then 1 else 0
  )


update : Msg -> Model -> (Model, Cmd Msg)
update msg {selected, items} =
  case msg of
    Focus idx msg ->
      (Model idx (List.map (setFocusOnItem selected idx) items), Cmd.none)

    KeyDown code ->
      let
        direction = getFocusDirection code
        newIdx = getSelectedIndex direction selected (List.length items)
      in
        (Model newIdx (List.map (setFocusOnItem selected newIdx) items), Cmd.none)



subscriptions : Model -> Sub Msg
subscriptions model =
  KB.ups (\code -> KeyDown code)



-- View

renderItem : IndexedItem -> Html Msg
renderItem {id, listItemModel} =
  App.map (Focus id) (ListItem.view listItemModel)

view : Model -> Html Msg
view {selected, items} =
  div
    [ class "col-md-4" ]
    [
      div
        [ class "list-group" ]
        (List.map renderItem items)
    ]
