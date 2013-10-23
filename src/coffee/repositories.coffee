define(
  [
    "./repositories/collections"
    "./repositories/views"
  ]
  (Collections, Views)->
    class Repositories
      @Collections: Collections
      @Views: Views
)
