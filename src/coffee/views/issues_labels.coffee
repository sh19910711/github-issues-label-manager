define(
  [
    "com/backbone/backbone"
    "com/underscore/underscore"
  ]
  (Backbone, _)->
    class IssuesLabelsView extends Backbone.View
      tagName: "table"
      className: "table table-striped"

      initialize: (options)->
        _.bindAll @, ["render"]
        self = @
        @collection.on(
          "fetch-end"
          ()->
            self.render()
        )
        @collection.fetch_labels()

      render: ()->
        self = @
        @.$el.empty()
        @collection.each (label)->
          self.$el.append(
            "<tr>" +
            "<td>" +
            "#{label.get("name")}" +
            "</td>" +
            "</tr>"
          )
        @
)
