import Html exposing (Html, div, text)
import Html.App as App
import Html.Attributes exposing (class)

import FilesList
import Header

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- Model

type alias Model =
  { filesList: FilesList.Model
  , appTitle: Header.Model
  }

init : (Model, Cmd Msg)
init =
  let
    ( filesListModel, flFx ) =
      FilesList.init

    ( headerModel, headerFx ) =
      Header.init "My App"
  in
    ( Model filesListModel headerModel
    , Cmd.batch
      [ Cmd.map FilesListMsg flFx
      , Cmd.map HeaderMsg headerFx
      ]
    )


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map FilesListMsg (FilesList.subscriptions model.filesList)
    , Sub.map HeaderMsg (Header.subscriptions model.appTitle)
    ]



-- Update

type Msg
  = FilesListMsg FilesList.Msg
  | HeaderMsg Header.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    FilesListMsg filesListMsg ->
      let (flModel, flCmds) =
        FilesList.update filesListMsg model.filesList
      in
        ( Model flModel model.appTitle
        , Cmd.map FilesListMsg flCmds
        )

    HeaderMsg x ->
      (model, Cmd.none)




-- View

view : Model -> Html Msg
view { appTitle, filesList } =
  div
    [ ]
    [ App.map HeaderMsg (Header.view appTitle)
    , div
        [ class "container-fluid" ]
        [ div
            [ class "row" ]
            [ App.map FilesListMsg (FilesList.view filesList)
            , div
                [ class "col-md-8" ]
                [ text "Hello!" ]
            ]
        ]
    ]
