module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Modules.Question exposing (..)



-- APP


main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type Page
  = WelcomePage
  | QuestionPage


type alias Model =
  { currentPage: Page
  , question: Question
  }


model : Model
model =
  { currentPage = WelcomePage
  , question =
      Question "Which one of these is a CSS preprocessor?"
        [ "HTML", "SASS", "React", "Angular" ]
        "SASS"
        Modules.Question.NotAnswered
  }



-- UPDATE


type Msg
  = StartTrivia
  | Select Choice
  | CheckAnswer


update : Msg -> Model -> Model
update msg model =
  case msg of
    StartTrivia ->
      { model | currentPage = QuestionPage }

    Select choice ->
      { model | question = setSelectedChoice choice model.question }

    CheckAnswer ->
      { model | question = validateQuestion model.question }



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
      questionView model


welcomeView : Html Msg
welcomeView =
  div
    [ class "triviaContainer" ]
    [ triviaTitle "Trivia Game"
    , startButton
    ]


startButton : Html Msg
startButton =
  button
  [ class "checkButton"
  , onClick StartTrivia
  ]
  [ text "START" ]


questionView : Model -> Html Msg
questionView model =
  div
    [ class "triviaContainer" ]
    [ triviaTitle model.question.content
    , div [ class "choices" ] <| List.map (\choice -> choiceButton choice model.question.state) model.question.choices
    , checkButton model.question.state
    , showResult model.question
    ]


triviaTitle : String -> Html Msg
triviaTitle title =
  h1
    [ class "question" ]
    [ text title ]


choiceButton : Choice -> QuestionState -> Html Msg
choiceButton choice state =
  li
    [ class "choiceButton"
    , classList [ ( "active", isSelectedChoice choice state ) ]
    , onClick ( Select choice )
    ]
    [ text choice ]


checkButton : QuestionState -> Html Msg
checkButton state =
  button
    [ class "checkButton"
    , classList [ ( "disabled", state == NotAnswered ) ]
    , onClick CheckAnswer
    ]
    [ text "CHECK" ]
