define(
  [
    "com/backbone/backbone"
    "com/underscore/underscore"
    "app/utils"
    "app/models/issues_label"
  ]
  (Backbone, _, Utils, IssuesLabel)->
    class IssuesLabels extends Backbone.Collection
      model: IssuesLabel

      initialize: (options)->
        @github_user_id = options["github_user_id"]
        @github_repo_name = options["github_repo_name"]

      fetch_labels: ()->
        self = @
        @fetch(
          type: "post"
          data:
            github_user_id: @github_user_id
            github_repo_name: @github_repo_name
            csrf_token: Utils.get_csrf_token()
          url: "/api/get_issues_labels"
          dataType: "json"
        ).done(
          (labels)->
            self.reset()
            _(labels).each(
              (label)->
                self.add label
            )
            self.trigger "fetch-end"
        ).fail(
          ()->
            throw new Error "fail on IssuesLabels#fetch_labels"
        )

      fetch_new_labels: ()->
        self = @
        @trigger "fetch-start"
        @fetch(
          type: "post"
          data:
            github_user_id: @github_user_id
            github_repo_name: @github_repo_name
            csrf_token: Utils.get_csrf_token()
          url: "/api/get_new_issues_labels"
          dataType: "json"
        ).done(
          (labels)->
            self.reset()
            _(labels).each(
              (label)->
                self.add label
            )
            self.trigger "fetch-end"
        ).fail(
          ()->
            throw new Error "fail on IssuesLabels#fetch_new_labels"
        )
)
