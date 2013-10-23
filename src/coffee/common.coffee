define(
  [
    "./common/utils"
    "com/sprintf/sprintf"
  ]
  (Utils, sprintf)->
    class Common
      @Utils: Utils
      @sprintf: sprintf
)
