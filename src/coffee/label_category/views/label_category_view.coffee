
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
            @build_dom()
        )
        @model.on(
          "destroy"
          =>
            unless _(@model.get("childrens")).keys().length > 0
              @$el.empty()
              @remove()
            else
              @render()
        )

      has_cid: (cid)->
        !! @$el.find("[data-label-category-cid=\"#{cid}\"]").length

      build_dom: =>
        childrens = @model.get "childrens"
        if _(childrens).keys().length
          childrens_element = @$el.children(".childrens")
          if ! @$el.children(".childrens").length
            childrens_element = $("<div class='childrens'></div>")
            # set sortable
            childrens_element.sortable
              connectWith: ".childrens"
              cursor: "move"
              opacity: 1
              update: (e, ui)=>
                moved_view = $(ui.item[0])
                category_cid = moved_view.attr "data-label-category-cid"
                moved_model = @model.root().get_by_cid category_cid
                console.log "update"
                if moved_model
                  # has label
                  if moved_model.get "label"
                    category_names = []
                    cur = moved_view
                    while cur.parents(".label-category-view").size()
                      category_names.push cur.children().first().children(".name").text()
                      cur = cur.parents(".label-category-view").first()
                    new_label_name = category_names.reverse().join("/")
                    old_label_name = moved_model.get("label").get("name")
                    console.log "new = #{new_label_name} / old = #{old_label_name}"
                    label_model = moved_model.get("label")
                    label_model.save
                      name: new_label_name

              helper: (a, b)->
                res = $(b).clone()
                $(res).css
                  "position": "absolute"
                  "right": "36px"
                  "top": "100px"
                res
              axis: "y"
              placeholder: "ui-sortable-dummy"
            childrens_element.disableSelection()
            @$el.append childrens_element

          childrens_element.empty()
          _(childrens).each (child_model)=>
            child_label = child_model.get("label")
            unless @has_cid child_model.cid
              child_view = new LabelCategoryView(
                model: child_model
              )
              child_element = child_view.render().$el
              childrens_element.append child_element
              child_element.data "view", child_view
            child_view = @$el.find("[data-label-category-cid=\"#{child_model.cid}\"]").data "view"
            child_view.build_dom()

      render: =>
        if $("[data-label-category-cid=\"#{@model.cid}\"]").size()
          unless @model.get("label")
            unless @$el.children(".category").size()
              @$el.prepend(
                "<div class='category'>" +
                "<div class='name'>#{@model.get "name"}</div>" +
                "<div class='controllers'>#{@render_controllers()}</div>" +
                "<div class='clearfix'></div>" +
                "</div>"
              )
        else
          @$el.attr "data-label-category-cid", @model.cid
          if @model.get("label")
            label = @model.get("label")
            unless @$el.find("[data-label-cid=\"#{label.cid}\"]").length
              label_view = new Label.Views.LabelView(
                model: label
              )
              @$el.append label_view.render().el
          else
            @$el.prepend(
              "<div class='category'>" +
              "<div class='name'>#{@model.get "name"}</div>" +
              "<div class='controllers'>#{@render_controllers()}</div>" +
              "<div class='clearfix'></div>" +
              "</div>"
            )
        @

      render_controllers: ->
        "<button class='btn btn-xs btn-warning disabled'>edit</button> " +
        "<button class='btn btn-xs btn-danger disabled'>remove</button>"
)
