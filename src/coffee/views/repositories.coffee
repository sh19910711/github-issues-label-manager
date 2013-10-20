define(
  [
    "com/backbone/backbone"
    "com/underscore/underscore"
    "app/collections/repositories"
  ]
  (Backbone, _, Repositories)->
    class RepositoriesView extends Backbone.View
      tagName: "table"
      initialize: (options)->
        _.bindAll this, "render"
      render: ()->
        @collection.each (repo)->
          console.log "repo = ", repo
        @
)
