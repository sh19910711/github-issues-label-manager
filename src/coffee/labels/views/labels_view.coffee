define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
  ]
  (
    _
    $
    Backbone
    Common
  )->
    class IssuesLabelsView extends Backbone.View
      tagName: "table"
      className: "table table-striped"

      initialize: (options)->
        _.bindAll @, ["render"]
        @collection.on(
          "fetch-end"
          ()->
            @render()
          @
        )
        @collection.fetch_labels()
        @

      render: ()->
        @$el.empty()
        @collection.each(
          (label)->
            @$el.append(
              "<tr>" +
              "<td>" +
              "#{label.get("name")}" +
              "</td>" +
              "</tr>"
            )
          @
        )
        @
)
