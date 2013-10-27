module Server
  module MockUserPage
    def self.registered app
      app.get "/mock/repos/sh19910711/js2ch" do
        @github_user_id = "sh19910711"
        @github_repo_name = "js2ch"
        haml_pjax :user_repo
      end

      app.get "/mock/api/labels/sh19910711/js2ch" do
        '[{"id":"526b81c305a91451ea000002","name":"report/\u30d0\u30b0","color":"fc2929"},{"id":"526b81c305a91451ea000003","name":"report/\u91cd\u8907","color":"cccccc"},{"id":"526b81c305a91451ea000004","name":"work/\u6a5f\u80fd\u8ffd\u52a0","color":"84b6eb"},{"id":"526b81c305a91451ea000005","name":"report/\u8cea\u554f","color":"cccccc"},{"id":"526b81c305a91451ea000006","name":"report/\u69d8\u5b50\u898b","color":"cccccc"},{"id":"526b81c305a91451ea000007","name":"phase/03-\u5b9f\u88c5\u4e2d","color":"fbca04"},{"id":"526b81c305a91451ea000008","name":"lib/http-lib","color":"e7e7f7"},{"id":"526b81c305a91451ea000009","name":"lib/buffer-lib","color":"e7e7f7"},{"id":"526b81c305a91451ea00000a","name":"lib/client","color":"e7e7f7"},{"id":"526b81c305a91451ea00000b","name":"lib/index","color":"e7e7f7"},{"id":"526b81c305a91451ea00000c","name":"lib/socket","color":"e7e7f7"},{"id":"526b81c305a91451ea00000d","name":"lib/storage","color":"e7e7f7"},{"id":"526b81c305a91451ea00000e","name":"platform/chromium","color":"e7f7e7"},{"id":"526b81c305a91451ea00000f","name":"platform/node-js","color":"e7f7e7"},{"id":"526b81c305a91451ea000010","name":"phase/01-\u8abf\u67fb\u4e2d","color":"fbca04"},{"id":"526b81c305a91451ea000011","name":"work/\u6539\u5584","color":"84b6eb"},{"id":"526b81c305a91451ea000012","name":"site/2ch","color":"f7e7e7"},{"id":"526b81c305a91451ea000013","name":"lib/**","color":"e7e7f7"},{"id":"526b81c305a91451ea000014","name":"phase/02-\u5b9f\u9a13\u4e2d","color":"fbca04"},{"id":"526b81c305a91451ea000015","name":"work/\u30c6\u30b9\u30c8","color":"84b6eb"},{"id":"526b81c305a91451ea000016","name":"lib/parser","color":"e7e7f7"},{"id":"526b81c305a91451ea000017","name":"lib/cookie-manager","color":"e7e7f7"},{"id":"526b81c305a91451ea000018","name":"version/0.0.x","color":"e7f7e7"},{"id":"526b81c305a91451ea000019","name":"level/01-easy","color":"84b6eb"},{"id":"526b81c305a91451ea00001a","name":"level/02-medium","color":"84b6eb"},{"id":"526b81c305a91451ea00001b","name":"level/03-hard","color":"84b6eb"},{"id":"526b81c305a91451ea00001c","name":"lib/util-lib","color":"e7e7f7"}]'
      end
    end
  end
end
