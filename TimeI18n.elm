module TimeI18n exposing
    ( H(..)
    , LBB(..)
    , M(..)
    , NSL(..)
    , NT(..)
    , Option(..)
    , view
    )

import Html
import Html.Attributes
import Time



{--https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat#Parameter --}


type LBB
    = Lookup
    | BestFit
    | Basic


type H
    = H11
    | H12
    | H23
    | H24


type NSL
    = Narrow
    | Short
    | Long


type NT
    = Numeric
    | TwoDigit


type M
    = Num NT
    | Text NSL


type Option
    = LocaleMatcher LBB -- No Basic possible
    | Hour12 Bool
    | HourCycle H
    | FormatMatcher LBB -- No Lookup possible
    | Weekday NSL
    | Era NSL
    | Year NT
    | Month M
    | Day NT
    | Hour NT
    | Minute NT
    | Second NT
    | TimeZoneName NSL -- No Narrow possible


lbbToString : LBB -> String
lbbToString l =
    case l of
        Lookup ->
            "lookup"

        BestFit ->
            "best fit"

        Basic ->
            "basic"


hToString : H -> String
hToString h =
    case h of
        H11 ->
            "h11"

        H12 ->
            "h12"

        H23 ->
            "h23"

        H24 ->
            "h24"


nslToString : NSL -> String
nslToString n =
    case n of
        Narrow ->
            "narrow"

        Short ->
            "short"

        Long ->
            "long"


ntToString : NT -> String
ntToString n =
    case n of
        Numeric ->
            "numeric"

        TwoDigit ->
            "2-digit"


mToString : M -> String
mToString m =
    case m of
        Text n ->
            nslToString n

        Num n ->
            ntToString n


fromBool : Bool -> String
fromBool b =
    if b then
        "true"

    else
        "false"


optionToAttribute : Option -> Html.Attribute msg
optionToAttribute o =
    case o of
        LocaleMatcher lbb ->
            Html.Attributes.attribute "locale-matcher" (lbbToString lbb)

        Hour12 b ->
            Html.Attributes.attribute "hour-12" (fromBool b)

        HourCycle h ->
            Html.Attributes.attribute "hour-cycle" (hToString h)

        FormatMatcher lbb ->
            Html.Attributes.attribute "format-matcher" (lbbToString lbb)

        Weekday nsl ->
            Html.Attributes.attribute "weekday" (nslToString nsl)

        Era nsl ->
            Html.Attributes.attribute "era" (nslToString nsl)

        Year nt ->
            Html.Attributes.attribute "year" (ntToString nt)

        Month m ->
            Html.Attributes.attribute "month" (mToString m)

        Day nt ->
            Html.Attributes.attribute "day" (ntToString nt)

        Hour nt ->
            Html.Attributes.attribute "hour" (ntToString nt)

        Minute nt ->
            Html.Attributes.attribute "minute" (ntToString nt)

        Second nt ->
            Html.Attributes.attribute "second" (ntToString nt)

        TimeZoneName nsl ->
            Html.Attributes.attribute "time-zone-name" (nslToString nsl)


view : Time.Posix -> Time.ZoneName -> String -> List Option -> Html.Html msg
view t z l o =
    Html.node "time-i18n"
        (List.append
            [ Html.Attributes.attribute "posix-time" (String.fromInt (Time.posixToMillis t))
            , Html.Attributes.attribute "locale" l
            , Html.Attributes.attribute "time-zone"
                (case z of
                    Time.Name s ->
                        s

                    Time.Offset i ->
                        (if i > 0 then
                            "UTC+"

                         else
                            "UTC"
                        )
                            ++ String.fromInt i
                )
            ]
            (List.map
                optionToAttribute
                o
            )
        )
        []
