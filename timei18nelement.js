// Display a Posix time as human time, honoring the localisation
// https://developer.mozilla.org/en-US/docs/Web/API/CustomElementRegistry/define
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat
'use strict'

class TimeI18n extends HTMLElement {

  update() {
    const shadow = this.shadowRoot;
    let childNodes = shadow.childNodes;
    if (this.options.timeZone) {
      for(var i = 0; i < childNodes.length; i++) {
        if(childNodes[i].nodeName === 'SPAN') {
          childNodes[i].textContent = new Intl.DateTimeFormat(this.locales, this.options).format(new Date(this.posixtime));
        }
      }
    }
  }

  static get observedAttributes() { return [
        "posix-time"
      , "locale"
      , "locale-matcher"
      , "time-zone"
      , "hour-12"
      , "hour-cycle"
      , "format-matcher"
      , "weekday"
      , "era"
      , "year"
      , "month"
      , "day"
      , "hour"
      , "minute"
      , "second"
      , "time-zone-name"
      ];
  }

  constructor() {
    // console.log("constuctor");
    super()

    if (this.hasAttribute('posix-time')) {
      this.posixtime = parseInt(this.getAttribute('posix-time'))
    }
    else {
      this.posixtime = 0
    }
    
    // console.log("posixtime: ", this.posixtime, typeof posixtime)
    
    let locales // See locales at https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat#Parameter
    if (this.hasAttribute("locale")) {
      this.locales = this.getAttribute("locale")
    }
    else {
      this.locales = "en-GB" // "C" does not work
    }
    
    this.options = {}

    if (this.hasAttribute("locale-matcher")) {
      this.options.localeMatcher = this.getAttribute("localematcher")
    }
  
    if (this.hasAttribute("time-zone")) {
      this.options.timeZone = this.getAttribute("time-zone")
     
    }
    else {
      this.options.timeZone = "UTC"
    }
   
    if (this.hasAttribute("hour-12")) {
      this.options.hour12 = this.getAttribute("hour-12")
    }

    if (this.hasAttribute("hour-cycle")) {
      this.options.hourCycle = this.getAttribute("hour-cycle")
    }

    if (this.hasAttribute("format-matcher")) {
      this.options.formatMatcher = this.getAttribute("format-matcher")
    }

    if (this.hasAttribute("weekday")) {
      this.options.weekday = this.getAttribute("weekday")
    }

     if (this.hasAttribute("era")) {
      this.options.era = this.getAttribute("era")
    }

    if (this.hasAttribute("year")) {
      this.options.year = this.getAttribute("year")
    }

    if (this.hasAttribute("month")) {
      this.options.month = this.getAttribute("month")
    }

    if (this.hasAttribute("day")) {
      this.options.day = this.getAttribute("day")
    }

    if (this.hasAttribute("hour")) {
      this.options.hour = this.getAttribute("hour")
    }

    if (this.hasAttribute("minute")) {
      this.options.minute = this.getAttribute("minute")
    }

    if (this.hasAttribute("second")) {
      this.options.second = this.getAttribute("second")
    }

    if (this.hasAttribute("timezonename")) {
      this.options.timeZoneName = this.getAttribute("time-zone-name")
    }

    // console.log ( "options: ", this.options)

    const shadow = this.attachShadow({mode: "open"})
    const el = document.createElement("span")
    shadow.appendChild(el);

    this.update()
  
  }

  connectedCallback() {
    // console.log("connectedCallback")
  }

  disconnectedCallback() {
    // console.log("disconnectedCallback")
  }

  adoptedCallback() {
    // console.log("adoptedCallback")
  }

  attributeChangedCallback(name, oldValue, newValue) {
    // console.log("attributeChangedCallback", "name: ", name, "oldvalue", oldValue, "newvalue", newValue)

    if (name === "posix-time") {
      this.posixtime = parseInt(newValue)
    }
    else if (name === "locale") {
      this.locales = newValue
    }
    else if (name === "locale-matcher") {
      this.options.localeMatcher = newValue
    }
    else if (name === "time-zone") {
      this.options.timeZone = newValue
    }
    else if (name === "hour-12") {
      this.options.hour12 = newValue
    }
    else if (name === "hour-cycle") {
      this.options.hourCycle = newValue
    }
    else if (name === "format-matcher") {
      this.options.formatMatcher = newValue
    }
    else if (name === "weekday") {
      this.options.weekday = newValue
    }
    else if (name === "era") {
      this.options.era = newValue
    }
    else if (name === "year") {
      this.options.year = newValue
    }
    else if (name === "month") {
      this.options.month = newValue
    }
    else if (name === "day") {
      this.options.day = newValue
    }
    else if (name === "hour") {
      this.options.hour= newValue
    }
    else if (name === "minute") {
      this.options.minute = newValue
    }
    else if (name === "second") {
      this.options.second = newValue
    }
    else if (name === "time-zone-name") {
      this.options.timeZoneName = newValue
    }
    else {
      conslole.log("\"" + name + "\" as attribute is not supported")
    }
  
    this.update()
    
  }


}
  
customElements.define('time-i18n', TimeI18n);    
  
  

  