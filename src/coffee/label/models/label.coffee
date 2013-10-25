define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
  ]
  (
    _
    $
    Backbone
    Common
  )->
    class Label extends Backbone.Model
      urlRoot: "/api/label"
      defaults:
        name: ""
        color: "#333333"

      initialize: (options)->
        console.log "Label#initialize: ", @
        @set "color", @resolve_color_code @get "color"
        @on "change", =>
          @set "color", @resolve_color_code @get "color"
        @on "sync", =>
        @

      validate: ->
        color1 = @get "color"
        unless !! color1.match /^[0-9A-Z]{6}$/
          return "color must be FFFFFF"

      resolve_color_code: (color_code)=>
        obj = color_code
        if typeof color_code == "string"
          color_code = $.trim color_code
          color_code = color_code.toUpperCase()
          if !! color_code.match /^#[0-9A-F]{6}$/
            matches = color_code.match /#([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})/
            obj = {
              r: parseInt(matches[1], 16)
              g: parseInt(matches[2], 16)
              b: parseInt(matches[3], 16)
            }
          else if !! color_code.match /^[0-9A-F]{6}$/
            matches = color_code.match /([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})/
            obj = {
              r: parseInt(matches[1], 16)
              g: parseInt(matches[2], 16)
              b: parseInt(matches[3], 16)
            }
          else if !! color_code.match /^#[0-9A-F]{3}$/
            matches = color_code.match /#([0-9A-F]{1})([0-9A-F]{1})([0-9A-F]{1})/
            obj = {
              r: parseInt(matches[1] + matches[1], 16)
              g: parseInt(matches[2] + matches[2], 16)
              b: parseInt(matches[3] + matches[3], 16)
            }
          else if !! color_code.match /^[0-9A-F]{3}$/
            matches = color_code.match /([0-9A-F]{1})([0-9A-F]{1})([0-9A-F]{1})/
            obj = {
              r: parseInt(matches[1] + matches[1], 16)
              g: parseInt(matches[2] + matches[2], 16)
              b: parseInt(matches[3] + matches[3], 16)
            }
          else
            return ""
        rr = Common.sprintf("%02X", obj.r)
        gg = Common.sprintf("%02X", obj.g)
        bb = Common.sprintf("%02X", obj.b)
        "#{rr}#{gg}#{bb}"

      set_color: (color_code)=>
        @save(
          color: color_code
        )

      get_color: =>
        @get "color"
)
