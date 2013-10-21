define(
  [
    "backbone"
    "underscore"
    "com/backbone/backbone-fetch-cache"
    "app/utils"
    "app/models/issues_label"
  ]
  (Backbone, _, dummy1, Utils, IssuesLabel)->
    class IssuesLabels extends Backbone.Collection
      model: IssuesLabel

      initialize: (options)->
        _.bindAll @, 'add_label', 'fetch_labels'
        @github_user_id = options["github_user_id"]
        @github_repo_name = options["github_repo_name"]
        @url = "/api/issues_label/#{@github_user_id}/#{@github_repo_name}"
        @

      add_label: (label_info)=>
        self = @
        @create(
          {
            label_name: label_info.name
            label_color: label_info.color
            csrf_token: Utils.get_csrf_token()
          }
          {
            success: ()->
              key = Backbone.fetchCache.getCacheKey(@)
              Backbone.fetchCache.clearItem key
              self.fetch_labels()
          }
        )

      fetch_labels: ()=>
        self = @
        @fetch(
          cache: true
          data:
            csrf_token: Utils.get_csrf_token()
          url: "/api/issues_labels/#{@github_user_id}/#{@github_repo_name}"
          dataType: "json"
        ).done(
          (labels)->
            _(labels).each(
              (label)->
                self.add label
            )
            self.trigger "fetch-end"
        )
)
