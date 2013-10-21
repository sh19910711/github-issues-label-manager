define(
  [
    "com/backbone/backbone"
    "com/underscore/underscore"
    "app/collections/repositories"
  ]
  (Backbone, _, Repositories)->
    class RepositoriesView extends Backbone.View
      tagName: "table"
      className: "table table-striped"

      initialize: (options)->
        _.bindAll @, "render"
        @collection.on(
          "add"
          (repo)->
            @$el.append(
              "<tr data-repo-id=\"#{repo.get('id')}\"><td>" +
              "<a class='pjaxable' href=\"/repos/#{repo.get('full_name')}\">" +
              "#{repo.get('name')}" +
              "</a></></tr>"
            )
          @
        )

      render: ()->
        @
)
