module Question exposing (..)

import Html exposing (..)



-- MODEL


type alias Question =
  { content: String
  , choices: List Choice
  , correctChoice: String
  , state: QuestionState
  }


type alias Choice =
  String


type Result
  = Correct Choice
  | Incorrect Choice
  | Empty


type QuestionState
  = NotAnswered
  | Answered Choice
  | Validated Result



-- HELPER


setSelectedChoice : Choice -> Question -> Question
setSelectedChoice selectedChoice question =
  { question | state = Answered selectedChoice }


isSelectedChoice : Choice -> QuestionState -> Bool
isSelectedChoice choice state =
  case state of
    Answered selectedChoice ->
      choice == selectedChoice

    Validated (Correct selectedChoice) ->
      choice == selectedChoice

    Validated (Incorrect selectedChoice) ->
      choice == selectedChoice

    _ ->
      False


validateQuestion : Question -> Question
validateQuestion question =
  case question.state of
    Answered choice ->
      { question | state = Validated (checkAnswer question) }

    _ ->
      { question | state = Validated Empty }


checkAnswer : Question -> Result
checkAnswer question =
  case question.state of
    Answered choice ->
      if choice == question.correctChoice then
        Correct choice

      else
        Incorrect choice

    _ ->
      Empty



-- VIEW


showResult : Question -> Html msg
showResult question =
  let
    result =
      case question.state of
        Validated (Correct answer) ->
          "Correct!"

        Validated (Incorrect answer) ->
          "Incorrect! Please try again."

        Validated Empty ->
          "Please select an answer!"

        _ ->
          ""
  in
    h3 [] [ text result ]
