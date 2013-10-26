define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/repository"
  ]
  (
    _
    $
    Backbone
    Common
    Repository
  )->
    class RepositoriesView extends Backbone.View
      tagName: "table"
      className: "table table-striped table-left-border table-hover"

      initialize: (options)->
        _.bindAll @, ["render"]
        @collection.on(
          "sync"
          ()=>
            @render()
        )
        @collection.fetch
          cache: true
          data:
            csrf_token: Common.Utils.get_csrf_token()
        @

      render: ()->
        @collection.each (repo)=>
          unless !! @$el.find("##{repo.id}").length
            @$el.append =>
              repo_view = new Repository.Views.RepositoryView
                model: repo
              repo_view.render().el
        @
)
