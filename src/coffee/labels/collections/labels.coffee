define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/label"
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
      url: ->
        "/api/labels/#{@github_user_id}/#{@github_repo_name}"

      initialize: (models, options)->
        @github_user_id = options["github_user_id"]
        @github_repo_name = options["github_repo_name"]
        @

      add_label: (label_info)->
        new_label = @create(
          {
            github_user_id: @github_user_id
            github_repo_name: @github_repo_name
            name: label_info.name
            color: label_info.color
          }
        )

    Labels
)
