module TodoForm exposing (..)

import Browser
import Html exposing (Html, button, div, input, text, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }


-- MODEL


type alias Model =
    { todo : String
    , todos : List String
    , errorMsg : String
    }


init : Model
init =
    { todo = ""
    , todos = ["Wake up"]
    , errorMsg = ""
    }


-- UPDATE


type Msg
    = TodoInput String
    | AddTodo


update : Msg -> Model -> Model
update msg model =
    case msg of
        TodoInput inputValue ->
            { model | todo = inputValue }

        AddTodo ->
            if model.todo /= "" then
                { model | todos = model.todos ++ [model.todo], todo = "", errorMsg = "" }
            else
                { model | errorMsg = "Please enter a todo" }


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.h1 [] [ text "Your todos" ]
        , input [ placeholder "Enter a todo", value model.todo, onInput TodoInput ] []
        , button [ onClick AddTodo ] [ text "Add todo" ]
        , todoFormValidation model
        , viewTodos model.todos
        ]


viewTodos : List String -> Html Msg
viewTodos todos =
    ul []
        (List.map (\todo -> li [] [ text todo ]) todos)

todoFormValidation : Model -> Html msg
todoFormValidation model =
    if model.errorMsg /= "" then
        div [ style "color" "red" ] [ text model.errorMsg ]
    else
        div [] []