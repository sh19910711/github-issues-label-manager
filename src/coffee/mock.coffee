define(
  [
    "underscore"
    "backbone"
    "app/label"
    "app/labels"
    "app/common"
    "com/backbone/backbone-localstorage"
  ]
  (
    _
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
            if ( ! current_version ) || ( parseFloat(current_version) < parseFloat(real_version) )
              # init storage
              update_func = ->
                labels.off "sync", update_func
                labels.each (label)->
                  label.destroy()
                json_obj = [
                  {"id":"526b81c305a91451ea000002","name":"report/\u30d0\u30b0","color":"fc2929"}
                  {"id":"526b81c305a91451ea000003","name":"report/\u91cd\u8907","color":"cccccc"}
                  {"id":"526b81c305a91451ea000004","name":"work/\u6a5f\u80fd\u8ffd\u52a0","color":"84b6eb"}
                  {"id":"526b81c305a91451ea000005","name":"report/\u8cea\u554f","color":"cccccc"}
                  {"id":"526b81c305a91451ea000006","name":"report/\u69d8\u5b50\u898b","color":"cccccc"}
                  {"id":"526b81c305a91451ea000007","name":"phase/03-\u5b9f\u88c5\u4e2d","color":"fbca04"}
                  {"id":"526b81c305a91451ea000008","name":"lib/http-lib","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea000009","name":"lib/buffer-lib","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea00000a","name":"lib/client","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea00000b","name":"lib/index","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea00000c","name":"lib/socket","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea00000d","name":"lib/storage","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea00000e","name":"platform/chromium","color":"e7f7e7"}
                  {"id":"526b81c305a91451ea00000f","name":"platform/node-js","color":"e7f7e7"}
                  {"id":"526b81c305a91451ea000010","name":"phase/01-\u8abf\u67fb\u4e2d","color":"fbca04"}
                  {"id":"526b81c305a91451ea000011","name":"work/\u6539\u5584","color":"84b6eb"}
                  {"id":"526b81c305a91451ea000012","name":"site/2ch","color":"f7e7e7"}
                  {"id":"526b81c305a91451ea000013","name":"lib/**","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea000014","name":"phase/02-\u5b9f\u9a13\u4e2d","color":"fbca04"}
                  {"id":"526b81c305a91451ea000015","name":"work/\u30c6\u30b9\u30c8","color":"84b6eb"}
                  {"id":"526b81c305a91451ea000016","name":"lib/parser","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea000017","name":"lib/cookie-manager","color":"e7e7f7"}
                  {"id":"526b81c305a91451ea000018","name":"version/0.0.x","color":"e7f7e7"}
                  {"id":"526b81c305a91451ea000019","name":"level/01-easy","color":"84b6eb"}
                  {"id":"526b81c305a91451ea00001a","name":"level/02-medium","color":"84b6eb"}
                  {"id":"526b81c305a91451ea00001b","name":"level/03-hard","color":"84b6eb"}
                  {"id":"526b81c305a91451ea00001c","name":"lib/util-lib","color":"e7e7f7"}
                ]
                loop_func = ->
                  if json_obj.length
                    labels.create(
                      new Label.Models.Label json_obj.shift()
                    )
                    setTimeout loop_func, 100
                  else
                    localStorage.setItem "mock-version", real_version
                setTimeout loop_func, 10
              labels.on(
                "sync"
                update_func
              )
            labels.fetch()
          0
        )
)
