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
        _.bindAll this, "render"
        @collection.on(
          "add"
          (repo)->
            @$el.append "<tr data-repo-id=\"#{repo.get('id')}\"><td>#{repo.get('name')}</></tr>"
          @
        )
      render: ()->
        @
)
