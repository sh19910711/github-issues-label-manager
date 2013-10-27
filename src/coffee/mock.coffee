define(
  [
    "underscore"
    "app/label"
    "app/labels"
  ]
  (
    _
    Label
    Labels
  )->
    class Mock
      @init: ->
        _(Label.Models.Label::).extend
          urlRoot: ->
            "/mock/api/label"
        _(Labels.Collections.Labels::).extend
          url: ->
            "/mock/api/labels/#{@github_user_id}/#{@github_repo_name}"
)
