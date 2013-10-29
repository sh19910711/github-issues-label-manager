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
    class LabelCategory extends Backbone.Model
      defaults: ->
        name: ""
        childrens: {}
        label: undefined

      initialize: ->

      parse_labels: (labels)->
        labels.each (label)=>
          @parse_labels_recursive_func label.get("name"), label
        @trigger "parsed"

      parse_labels_recursive_func: (label_name, label)=>
        childrens = @get "childrens"

        # label_name example: "category/..."
        category_name = if /\//.test(label_name) then label_name.match(/([^\/]*)\//)[1] else label_name
        next_label_name = label_name.substring category_name.length + 1

        # create new node
        unless _(childrens).has(category_name)
          childrens[category_name] = new LabelCategory(
            name: category_name
            childrens: {}
          )
          childrens[category_name].on(
            "destroy"
            =>
              delete childrens[category_name]
              unless _(childrens).keys().length || @get("label")
                @destroy()
          )
          @set "childrens", childrens

        # is leaf
        unless /\//.test label_name
          childrens[category_name].set "label", label
          label.set "label_category", childrens[category_name]
          label.on(
            "change"
            (target)=>
              delete childrens[category_name]
          )
          label.on(
            "remove"
            =>
              childrens[category_name].destroy() if childrens[category_name]?
          )
          return null

        # rec
        childrens[category_name].parse_labels_recursive_func.call childrens[category_name], next_label_name, label

      set_label: (label)->
        @set "label", label
        label.on(
          "destroy"
          =>
            childrens = @get "childrens"
            unless _(childrens).keys().length
              @destroy()
            @set "label", undefined
        )

)

