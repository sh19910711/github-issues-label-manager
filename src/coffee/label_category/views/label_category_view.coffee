
define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/label"
  ]
  (
    _
    $
    Backbone
    Common
    Label
  )->
    class LabelCategoryView extends Backbone.View
      tagName: "div"
      className: "label-category-view"

      initialize: ->
        @model.on(
          "parsed"
          =>
            @render()
        )

      has_cid: (cid)->
        !! @$el.find("[data-label-category-cid=\"#{cid}\"]").length

      render: ->
        unless @has_cid(@model.cid)
          if @model.is_leaf()
            label_view = new Label.Views.LabelView(
              model: @model.get "label_model"
            )
            @$el.append(
              "<div " +
              "data-label-category-cid='#{@model.cid}' " +
              ">" +
              "</div>"
            )
            @$el.find("[data-label-category-cid='#{@model.cid}']").append label_view.render().el
          else
            @$el.append(
              "<div " +
              "data-label-category-cid='#{@model.cid}' " +
              "class='label-child-category-view'" +
              ">" +
              "<div class='category'>" +
              "<div class='name'>#{@model.get("name")}</div> " +
              "<div class='controllers'>" + @render_controllers() + "</div> " +
              "<div class='clearfix'></div>"
              "</div>" +
              "</div>"
            )
            base_element = @$el.find "[data-label-category-cid=\"#{@model.cid}\"]"
            childrens = @model.get "childrens"
            _(childrens).each (child_model)=>
              unless !! base_element.find("[data-label-category-cid=\"#{child_model.cid}\"]").length
                child_view = new LabelCategoryView(
                  model: child_model
                )
                base_element.append child_view.render().el
        @

      render_controllers: ->
        "<div>" +
        "<button class='btn btn-xs btn-warning disabled'>edit</button> " +
        "<button class='btn btn-xs btn-danger disabled'>remove</button>" +
        "</div>"
)
