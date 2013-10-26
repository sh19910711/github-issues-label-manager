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
    class RepositoryView extends Backbone.View
      tagName: "tr"
      initialize: (options)->
        _.bindAll @, "render"
      render: ->
        @$el.append =>
          repo_name = @model.get "name"
          repo_full_name = @model.get "full_name"
          "<td><a data-repo-id='#{@model.id}' class='pjaxable' href='/repos/#{repo_full_name}'>#{repo_name}</a></td>"
        @
)
