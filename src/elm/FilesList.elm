module FilesList exposing (Model, Msg, init, subscriptions, mockItems, view, update)

import ListItem
import Html exposing (Html, div, text)
import Html.App as App
import Html.Attributes exposing (class)
import Keyboard as KB exposing (..)


-- MODEL

type alias IndexedItem =
  { id: Int
  , listItemModel: ListItem.Model
  }

type alias Model =
  { selected : Int
  , currPath : String
  , items : List IndexedItem
  }

mockItems : List IndexedItem
mockItems =
  [ IndexedItem 0 (ListItem.Model "dir 1" "" False "Dir")
  , IndexedItem 1 (ListItem.Model "file 1" "http://www.islands.com/sites/islands.com/files/styles/large_1x_/public/islamorada1666_copy.jpg?itok=tL01RE47" False "File")
  , IndexedItem 2 (ListItem.Model "file 1" "http://www.islands.com/sites/islands.com/files/styles/large_1x_/public/images/2016/01/virgin_islands_national_park.jpg?itok=TcfQ0Cfz" False "File")
  , IndexedItem 3 (ListItem.Model "file 1" "http://www.islands.com/sites/islands.com/files/styles/large_1x_/public/images/2016/01/shutterstock_230057017.jpg?itok=Z0Cqa_rc" False "File")
  ]

init : (Model, Cmd Msg)
init =
  (Model 0 "" mockItems, Cmd.none)


-- UPDATE

type Msg
  = Select Int String ListItem.Msg
  | Highlight KB.KeyCode


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
update msg {selected, currPath, items} =
  case msg of
    Select idx selectedPath msg ->
      (Model idx selectedPath (List.map (setFocusOnItem selected idx) items), Cmd.none)

    Highlight keyCode ->
      let
        direction = getFocusDirection keyCode
        newIdx = getSelectedIndex direction selected (List.length items)
      in
        (Model newIdx currPath (List.map (setFocusOnItem selected newIdx) items), Cmd.none)



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  KB.ups Highlight



-- VIEW

renderItem : IndexedItem -> Html Msg
renderItem {id, listItemModel} =
  App.map (Select id listItemModel.path) (ListItem.view listItemModel)


view : Model -> Html Msg
view {selected, items} =
  div
    [ class "col-md-4" ]
    [
      div
        [ class "list-group" ]
        (List.map renderItem items)
    ]


-- ETC

main : Program Never
main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
