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
    class LabelCategory extends Backbone.Model
      defaults:
        name: ""
        childrens: {}

      initialize: ->
        console.log "LabelCategory#initialize"

      parse_labels: (labels)->
        console.log labels
        labels.each (label)=>
          @parse_labels_recursive_func label.get "name"
        @trigger "parsed"

      parse_labels_recursive_func: (label_name)->
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
          @set "childrens", childrens
        # no rec
        return null unless /\//.test label_name
        # rec
        childrens[category_name].parse_labels_recursive_func next_label_name
)

