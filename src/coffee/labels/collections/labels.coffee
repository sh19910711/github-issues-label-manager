define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/label"
    "com/backbone/backbone-fetch-cache"
  ]
  (
    _
    $
    Backbone
    Common
    Label
  )->
    class Labels extends Backbone.Collection
      model: Label.Models.Label

      initialize: (options)->
        _.bindAll(
          @
          'add_label'
          'fetch_labels'
        )
        @github_user_id = options["github_user_id"]
        @github_repo_name = options["github_repo_name"]
        @url = "/api/issues_label/#{@github_user_id}/#{@github_repo_name}"
        @

      add_label: (label_info)=>
        @create(
          {
            label_name: label_info.name
            label_color: label_info.color
            csrf_token: Common.Utils.get_csrf_token()
          }
          {
            success: ()=>
              key = Backbone.fetchCache.getCacheKey(@)
              Backbone.fetchCache.clearItem key
              @fetch_labels()
          }
        )

      fetch_labels: ()=>
        @fetch(
          cache: true
          data:
            csrf_token: Common.Utils.get_csrf_token()
          url: "/api/issues_labels/#{@github_user_id}/#{@github_repo_name}"
          dataType: "json"
        ).done(
          (labels)=>
            _(labels).each(
              (label)=>
                @add label
            )
            @trigger "fetch-end"
        )

    Labels
)
