requirejs(
  [
    "./config"
  ]
  ->
    requirejs(
      [
        "jquery"
        "com/bootstrap/bootstrap"
        "app/application"
        "app/common"
      ]
      ($, dummy1, Application, Common)->
        $(
          ->
            root = Common.Utils.get_root()
            root.application = new Application()
        )
    )
)
