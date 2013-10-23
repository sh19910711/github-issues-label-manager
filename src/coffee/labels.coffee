define(
  [
    "./labels/collections"
    "./labels/views"
  ]
  (Collections, Views)->
    class Labels
      @Collections: Collections
      @Views: Views
)
