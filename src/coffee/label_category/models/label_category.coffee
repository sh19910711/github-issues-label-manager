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
        console.log "LabelCategory#initialize"

      parse_labels: (labels)->
        console.log labels
        labels.each (label)=>
          console.log "@parse_labels: name = #{label.get("name")}"
          @parse_labels_recursive_func label.get("name"), label
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
          console.log "is leaf ! ", label.cid, label_name
          childrens[category_name].set "label_model", label
          return null
        # rec
        childrens[category_name].parse_labels_recursive_func next_label_name, label
)

