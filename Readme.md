# Displaying localised Date or Time in Elm

I publish this, to get some feedback, to help others and to place some points, I miss in Elm.

I had a long list, where I want to display date or time-values in the local language and timezone. I don't want to reinvent the wheel, as the [ICU-Project](http://site.icu-project.org/) has alread done it and the integration in the web-browsers has started. My problem is solved by the Javascript method Intl.DateTimeFormat().format()

To get this in Elm, I found ports to complicated to use, due to the mass of values, so I decided to create a HTML custom element.

I would have prefered a function giving a `String`, like

`toLocalTime : Time.Posix -> Time.ZoneName -> String -> List Option -> String`

but a `Html msg`, resulting from the custom element, works also:

`view : Time.Posix -> Time.ZoneName -> String -> List Option -> Html.Html msg`

As it uses custom elements, you have to enable them in Firefox in [`about:config`](about:config) by setting `dom.webcomponents.customelements.enabled` and `dom.webcomponents.shadowdom.enabled` to `true`

I named my variables after the [Javascript options to the used method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat)

For some usage-examples see Main.elm, which is based on the Elm [time example](https://guide.elm-lang.org/effects/time.html), but displays times from some different counties, where I have never been and in languages I do not understand.

You can build everything by running build.sh and open [index.html](./index.html). Or open it [direct on Github](http://htmlpreview.github.io/?https://github.com/hans-helmut/elm-timei18n/blob/master/index.html)

Please feel free, to comment the code.

The code also show some things I miss in Elm, or I have not understood:

* The possibility to call pure (only) Javascript functions/methods direct, at least the ones form the core language.

* I would prefer to use `Dict`s instead of some case structs for handling the options, but custom types are not sortable in Elm, which is a requirement for using them as a key in Dicts.

* Combining custom types to a new flat type (as you can union sets)


