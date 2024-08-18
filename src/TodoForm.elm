module TodoForm exposing (..)

import Browser
import Html exposing (Html, button, div, input, text, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Html exposing (s)


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
    , todos = ["Wake up", "Eat breakfast"]
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
    div containerStyle
        [ Html.h1 titleStyle [ text "Your todos" ]
        , div formStyle
            [ input (inputStyle ++ [ placeholder "Enter a todo", value model.todo, onInput TodoInput ]) []
            , button (buttonStyle ++ [ onClick AddTodo ]) [ text "Add todo" ]
            , todoFormValidation model
            ]
        , div todoListStyle
            [ viewTodos model.todos
            ]
        ]


viewTodos : List String -> Html Msg
viewTodos todos =
    ul uiStyle
        (List.map (\todo -> li liStyle [ text todo ]) todos)

todoFormValidation : Model -> Html msg
todoFormValidation model =
    if model.errorMsg /= "" then
        div [ style "color" "red" ] [ text model.errorMsg ]
    else
        div [] []
        
containerStyle : List (Html.Attribute msg)
containerStyle =
    [ style "padding" "20px"
    , style "width" "400px"
    , style "margin" "24px auto"
    , style "background-color" "#fafafa"
    , style "border" "1px solid #ddd"
    , style "border-radius" "8px"
    , style "font-family" "Roboto, sans-serif"
    ]

titleStyle : List (Html.Attribute msg)
titleStyle =
    [ style "font-size" "32px"
    , style "margin-bottom" "20px"
    , style "text-align" "center"
    , style "color" "#333"
    ]

formStyle : List (Html.Attribute msg)
formStyle =
    [ style "margin-bottom" "20px"
    , style "padding" "10px"
    , style "background-color" "#fff"
    , style "border-radius" "8px"
    , style "box-shadow" "0px 2px 5px rgba(0,0,0,0.2)"
    , style "display" "flex"
    ]

inputStyle : List (Html.Attribute msg)
inputStyle =
    [ style "padding" "10px"
    , style "width" "100%"
    , style "border" "1px solid #ccc"
    , style "border-radius" "4px"
    , style "box-sizing" "border-box"
    ]

buttonStyle : List (Html.Attribute msg)
buttonStyle =
    [ style "padding" "10px 15px"
    , style "border" "none"
    , style "border-radius" "4px"
    , style "background-color" "#00796b"
    , style "color" "white"
    , style "cursor" "pointer"
    , style "font-size" "16px"
    , style "margin-left" "10px"
    , style "width" "150px"
    , style "transition" "background-color 300ms ease"
    ]

todoListStyle : List (Html.Attribute msg)
todoListStyle =
    [ style "padding" "10px"
    , style "background-color" "#fff"
    , style "border-radius" "8px"
    , style "box-shadow" "0px 2px 5px rgba(0,0,0,0.2)"
    ]

uiStyle : List (Html.Attribute msg)
uiStyle =
    [ style "list-style-type" "none"
    , style "padding" "0"
    ]

liStyle : List (Html.Attribute msg)
liStyle =
    [ style "padding" "8px"
    , style "border-bottom" "1px solid #ddd"
    , style "margin-bottom" "4px"
    , style "font-size" "18px"
    ]