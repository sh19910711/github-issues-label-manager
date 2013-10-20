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
              ]
              (Application)->
                app = new Application(
                  side_id: "#side"
                  container_id: "#container"
                )
            )
        )
    )
)
