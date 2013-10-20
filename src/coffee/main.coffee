requirejs(
  [
    "./config"
  ]
  ->
    requirejs(
      [
        "com/jquery/jquery"
        "com/bootstrap/bootstrap"
      ]
      ($)->
        $(
          ->
            requirejs(
              [
                "app/application"
                "app/utils"
              ]
              (Application, Utils)->
                root = Utils.get_root()
                root.application = new Application(
                  side_id: "#side"
                  container_id: "#container"
                )
            )
        )
    )
)
