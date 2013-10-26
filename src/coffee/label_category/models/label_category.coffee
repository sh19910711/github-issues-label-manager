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
      defaults:
        name: ""
        childrens: {}
        flag_leaf: false
        label_model: undefined

      is_leaf: ()->
        @get "flag_leaf"

      initialize: ->

      parse_labels: (labels)->
        labels.each (label)=>
          @parse_labels_recursive_func label.get("name"), label
        labels.on(
          "sync"
          (target)=>
            if target instanceof labels.model
              @parse_labels_recursive_func target.get("name"), target
              @trigger "parsed"
        )
        @trigger "parsed"

      parse_labels_recursive_func: (label_name, label)->
        childrens = @get "childrens"

        # label_name example: "category/..."
        category_name = if /\//.test(label_name) then label_name.match(/([^\/]*)\//)[1] else label_name
        next_label_name = label_name.substring category_name.length + 1

        # create new node
        unless _(childrens).has(category_name)
          childrens[category_name] = new LabelCategory(
            name: category_name
            childrens: {}
            flag_leaf: ! /\//.test label_name
          )
          @set "childrens", childrens

        # is leaf
        unless /\//.test label_name
          childrens[category_name].set "label_model", label
          return null

        # rec
        childrens[category_name].parse_labels_recursive_func next_label_name, label

)

