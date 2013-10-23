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
      defaults:
        name: ""
        color:
          r: 0
          g: 0
          b: 0

      initialize: (options)->
        @on "change", =>
          @set "color", @resolve_color_code @get "color"
        @

      validate: ->
        color1 = @get "color"
        unless color1 && _(color1).has("r") && _(color1).has("g") && _(color1).has("b")
          return "color must have r, g, b props"

      resolve_color_code: (color_code)=>
        if typeof color_code == "string"
          color_code = $.trim color_code
          if !! color_code.match /^#[0-9A-F]{6}$/
            matches = color_code.match /#([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})/
            return {
              r: parseInt(matches[1], 16)
              g: parseInt(matches[2], 16)
              b: parseInt(matches[3], 16)
            }
          else if !! color_code.match /^[0-9A-F]{6}$/
            matches = color_code.match /([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})/
            return {
              r: parseInt(matches[1], 16)
              g: parseInt(matches[2], 16)
              b: parseInt(matches[3], 16)
            }
          else if !! color_code.match /^#[0-9A-F]{3}$/
            matches = color_code.match /#([0-9A-F]{1})([0-9A-F]{1})([0-9A-F]{1})/
            return {
              r: parseInt(matches[1] + matches[1], 16)
              g: parseInt(matches[2] + matches[2], 16)
              b: parseInt(matches[3] + matches[3], 16)
            }
          else if !! color_code.match /^[0-9A-F]{3}$/
            matches = color_code.match /([0-9A-F]{1})([0-9A-F]{1})([0-9A-F]{1})/
            return {
              r: parseInt(matches[1] + matches[1], 16)
              g: parseInt(matches[2] + matches[2], 16)
              b: parseInt(matches[3] + matches[3], 16)
            }
        else
          return color_code

      set_color: (color_code)=>
        @set "color", color_code

      get_color: =>
        color1 = @get "color"
        rr = Common.sprintf("%02X", color1.r)
        gg = Common.sprintf("%02X", color1.g)
        bb = Common.sprintf("%02X", color1.b)
        "##{rr}#{gg}#{bb}"
)
