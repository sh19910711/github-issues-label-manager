define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/label"
    "app/labels"
    "app/common"
    "com/backbone/backbone-localstorage"
  ]
  (
    _
    $
    Backbone
    Label
    Labels
    Common
  )->
    class Mock
      @init: (user_repo_page)->
        real_version = Common.Utils.get_server_version()
        current_version = localStorage.getItem("mock-version")
        _(Label.Models.Label::).extend
          urlRoot: ->
            "/mock/api/label"
        _(Labels.Collections.Labels::).extend
          url: ->
            "/mock/api/labels/#{@github_user_id}/#{@github_repo_name}"
          localStorage: new Backbone.LocalStorage("mock/labels")
        user_repo_page.$el.prepend "<p class='text-danger'>This is an application demo page. The data will be saved on local only.</p>"
        user_repo_page.labels = new Labels.Collections.Labels(
          [
          ]
          {
            github_user_id: "sh19910711"
            github_repo_name: "js2ch"
          }
        )
        labels = user_repo_page.labels
        labels.on(
          "sync"
          ()->
            user_repo_page.label_category.parse_labels labels
        )
        setTimeout(
          ->
            if ( ! current_version ) || Common.Utils.compare_version(current_version, real_version)
              # init storage
              update_func = ->
                labels.off "sync", update_func
                deferreds = labels.map (label)->
                  deferred = new $.Deferred()
                  setTimeout(
                    ->
                      label.destroy(
                        success: deferred.resolve
                      )
                    0
                  )
                  deferred.promise()
                $.when.apply(null, deferreds).done ->
                  json_obj = [
                    {"id":"526b81c305a91451ea000002","name":"report/\u30d0\u30b0","color":"fc2929"}
                    {"id":"526b81c305a91451ea000003","name":"report/\u91cd\u8907","color":"cccccc"}
                    {"id":"526b81c305a91451ea000004","name":"work/\u6a5f\u80fd\u8ffd\u52a0","color":"84b6eb"}
                    {"id":"526b81c305a91451ea000005","name":"report/\u8cea\u554f","color":"cccccc"}
                    {"id":"526b81c305a91451ea000006","name":"report/\u69d8\u5b50\u898b","color":"cccccc"}
                    {"id":"526b81c305a91451ea00000e","name":"platform/chromium","color":"e7f7e7"}
                    {"id":"526b81c305a91451ea00000f","name":"platform/node-js","color":"e7f7e7"}
                    {"id":"526b81c305a91451ea000011","name":"work/\u6539\u5584","color":"84b6eb"}
                    {"id":"526b81c305a91451ea000012","name":"site/2ch","color":"f7e7e7"}
                    {"id":"526b81c305a91451ea000015","name":"work/\u30c6\u30b9\u30c8","color":"84b6eb"}
                  ]
                  loop_func = ->
                    if json_obj.length
                      labels.create(
                        new Label.Models.Label json_obj.shift()
                      )
                      setTimeout loop_func, 250
                    else
                      localStorage.setItem "mock-version", real_version
                  setTimeout loop_func, 0
              labels.on(
                "sync"
                update_func
              )
            labels.fetch()
          0
        )
)
