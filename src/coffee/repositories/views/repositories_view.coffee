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
    class RepositoriesView extends Backbone.View
      tagName: "table"
      className: "table table-striped"

      initialize: (options)->
        _.bindAll @, ["render"]
        @collection.on(
          "fetch-end"
          ()->
            @render()
          @
        )
        @collection.fetch_repos()
        @

      render: ()->
        @$el.empty()
        @collection.each(
          (repo)->
            @$el.append(
              "<tr data-repo-id=\"#{repo.get('id')}\"><td>" +
              "<a class='pjaxable' href=\"/repos/#{repo.get('full_name')}\">" +
              "#{repo.get('name')}" +
              "</a></></tr>"
            )
          @
        )
        @
)
