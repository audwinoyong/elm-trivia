module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- APP


main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type Page
  = WelcomePage
  | QuestionPage


type alias Model =
  { currentPage: Page }


model : Model
model =
  { currentPage = WelcomePage }



-- UPDATE


type Msg
  = StartTrivia


update : Msg -> Model -> Model
update msg model =
  case msg of
    StartTrivia ->
      { model | currentPage = QuestionPage }



-- VIEW


view : Model -> Html Msg
view model =
  div
    [ class "container" ]
    [ contentView model ]


contentView : Model -> Html Msg
contentView model =
  case model.currentPage of
    WelcomePage ->
      welcomeView

    QuestionPage ->
      welcomeView


welcomeView : Html Msg
welcomeView =
  div
    []
    [ h1 [] [ text "Trivia Game" ]
    , button [ onClick StartTrivia ] [ text "START" ]
    ]