define(
  [
    "./repository/models"
    "./repository/views"
  ]
  (
    Models
    Views
  )->
    class Repository
      @Models: Models
      @Views: Views
)
