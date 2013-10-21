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
        "app/utils"
      ]
      ($, dummy1, Application, Utils)->
        $(
          ->
            root = Utils.get_root()
            root.application = new Application(
              side_id: "#side"
              container_id: "#container"
            )
        )
    )
)
