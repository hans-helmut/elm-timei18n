module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Task
import Time
import TimeI18n



-- MAIN


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { zonename : Time.ZoneName
    , time : Time.Posix
    , lang : String
    }


init : { lang : String } -> ( Model, Cmd Msg )
init flags =
    ( Model (Time.Name "") (Time.millisToPosix 0) flags.lang
    , Task.perform AdjustTimeZoneName Time.getZoneName
    )



-- UPDATE


type Msg
    = Tick Time.Posix
    | AdjustTimeZoneName Time.ZoneName


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )

        AdjustTimeZoneName newZone ->
            ( { model | zonename = newZone }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        longformat =
            [ TimeI18n.Year TimeI18n.Numeric
            , TimeI18n.Month (TimeI18n.Text TimeI18n.Long)
            , TimeI18n.Day TimeI18n.TwoDigit
            , TimeI18n.Weekday TimeI18n.Long
            , TimeI18n.Hour TimeI18n.Numeric
            , TimeI18n.Minute TimeI18n.TwoDigit
            , TimeI18n.Second TimeI18n.TwoDigit
            , TimeI18n.TimeZoneName TimeI18n.Long
            ]

        shortformat =
            [ TimeI18n.Year TimeI18n.Numeric
            , TimeI18n.Month (TimeI18n.Num TimeI18n.TwoDigit)
            , TimeI18n.Day TimeI18n.TwoDigit
            , TimeI18n.Weekday TimeI18n.Short
            , TimeI18n.Hour TimeI18n.Numeric
            , TimeI18n.Minute TimeI18n.TwoDigit
            , TimeI18n.Second TimeI18n.TwoDigit
            , TimeI18n.TimeZoneName TimeI18n.Short
            ]

        timeformat =
            [ TimeI18n.Hour TimeI18n.TwoDigit
            , TimeI18n.Minute TimeI18n.TwoDigit
            , TimeI18n.Second TimeI18n.TwoDigit
            ]
    in
    div []
        [ h1 [] [ text "World time" ]
        , h2
            []
            [ text
                ("Current date and time in your zone ("
                    ++ (case model.zonename of
                            Time.Name s ->
                                s

                            Time.Offset i ->
                                ""
                       )
                    ++ ") and language ("
                    ++ model.lang
                    ++ "): "
                )
            , TimeI18n.view
                model.time
                model.zonename
                model.lang
                longformat
            ]
        , h2
            []
            [ text
                ("Current date and time in your zone ("
                    ++ (case model.zonename of
                            Time.Name s ->
                                s

                            Time.Offset i ->
                                ""
                       )
                    ++ ") and language ("
                    ++ model.lang
                    ++ "): "
                )
            , TimeI18n.view
                model.time
                model.zonename
                model.lang
                shortformat
            ]
        , h2
            []
            [ text
                ("Current time (only) in your zone ("
                    ++ (case model.zonename of
                            Time.Name s ->
                                s

                            Time.Offset i ->
                                ""
                       )
                    ++ ") and language ("
                    ++ model.lang
                    ++ "): "
                )
            , TimeI18n.view
                model.time
                model.zonename
                model.lang
                timeformat
            ]
        , h2
            []
            [ text "Current date and time in Australia/Sydney: "
            , TimeI18n.view
                model.time
                (Time.Name "Australia/Sydney")
                "en-AU"
                longformat
            ]
        , h2
            []
            [ text "Current date and time in Asia/Shanghai: "
            , TimeI18n.view
                model.time
                (Time.Name "Asia/Shanghai")
                "zh-CN"
                longformat
            ]
        , h2
            []
            [ text "Current date and time in Asia/Kolkata: "
            , TimeI18n.view
                model.time
                (Time.Name "Asia/Kolkata")
                "en-IN"
                longformat
            ]
        , h2
            []
            [ text "Current date and time in Europa/Moscow: "
            , TimeI18n.view
                model.time
                (Time.Name "Europe/Moscow")
                "ru-RU"
                longformat
            ]
        , h2
            []
            [ text "Current date and time in Europa/Warsaw: "
            , TimeI18n.view
                model.time
                (Time.Name "Europe/Warsaw")
                "pl-PL"
                longformat
            ]
        , h2
            []
            [ text "Current date and time in Europa/Berlin: "
            , TimeI18n.view
                model.time
                (Time.Name "Europe/Berlin")
                "de-DE"
                longformat
            ]
        , h2
            []
            [ text "Current date and time in Europa/Lisbon: "
            , TimeI18n.view
                model.time
                (Time.Name "Europe/Lisbon")
                "pt-PT"
                longformat
            ]
        , h2
            []
            [ text "Current date and time in Europe/London: "
            , TimeI18n.view
                model.time
                (Time.Name "Europe/London")
                "en-GB"
                longformat
            ]
        , h2
            []
            [ text "Current date and time in America/New_York: "
            , TimeI18n.view
                model.time
                (Time.Name "America/New_York")
                "en-US"
                longformat
            ]
        ]
