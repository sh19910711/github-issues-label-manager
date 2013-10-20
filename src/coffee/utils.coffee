define(
  [
    "com/jquery/jquery"
    "com/backbone/backbone"
  ]
  ($)->
    class Utils
      @get_csrf_token: ->
        $("meta[data-csrf-token]").data("csrf-token")
      @get_root: ->
        window
)
