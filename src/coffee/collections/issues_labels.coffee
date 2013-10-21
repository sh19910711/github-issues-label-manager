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
        @github_user_id = options["github_user_id"]
        @github_repo_name = options["github_repo_name"]
        @

      fetch_labels: ()->
        self = @
        @fetch(
          cache: true
          type: "get"
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

      fetch_new_labels: ()->
        self = @
        @fetch(
          type: "put"
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
