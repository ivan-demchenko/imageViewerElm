import Html exposing (Html, div, text)
import Html.App as App
import Html.Attributes exposing (class)

import FilesList
import Header
import ImageView

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL

type alias Model =
  { filesList: FilesList.Model
  , appTitle: Header.Model
  , currImage: ImageView.Model
  }

init : (Model, Cmd Msg)
init =
  let
    ( filesListModel, flFx ) =
      FilesList.init

    ( headerModel, headerFx ) =
      Header.init "Image Viewer"

    ( imageViewModel, imageViewFx ) =
      ImageView.init ""
  in
    ( Model filesListModel headerModel imageViewModel
    , Cmd.batch
      [ Cmd.map FilesListMsg flFx
      , Cmd.map HeaderMsg headerFx
      , Cmd.map ImageViewMsg imageViewFx
      ]
    )



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map FilesListMsg (FilesList.subscriptions model.filesList)
    , Sub.map HeaderMsg (Header.subscriptions model.appTitle)
    ]



-- UPDATE

type Msg
  = FilesListMsg FilesList.Msg
  | HeaderMsg Header.Msg
  | ImageViewMsg ImageView.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg appModel =
  case msg of
    FilesListMsg filesListMsg ->
      let
        (flModel, flCmds) =
          FilesList.update filesListMsg appModel.filesList
      in
        ( { appModel | filesList = flModel }
        , Cmd.map (FilesListMsg) flCmds
        )

    HeaderMsg x ->
      (appModel, Cmd.none)

    ImageViewMsg imageViewMsg ->
      let
        (newImgURL, imageViewCmds) =
          ImageView.update imageViewMsg appModel.currImage
      in
        ( appModel
        , Cmd.map ImageViewMsg imageViewCmds
        )



-- VIEW

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
            , App.map ImageViewMsg (ImageView.view filesList.currPath)
            ]
        ]
    ]
