define(
  [
    "./label/models"
    "./label/views"
  ]
  (Models, Views)->
    class Label
      @Models: Models
      @Views: Views
)
