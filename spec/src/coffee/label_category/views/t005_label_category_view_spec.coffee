describe "T005: LabelCategory::Views::LabelCategoryView", ->
  beforeEach ->
    @Label = requirejs "app/label"
    @LabelCategory = requirejs "app/label_category"

  context "A001: model watching", ->
    context "B001: simple delete", ->
      beforeEach ->
        @model = new @LabelCategory.Models.LabelCategory(
          name: "this is test"
        )
        @view = new @LabelCategory.Views.LabelCategoryView
          model: @model
        @view.render()

      it "C001: destroy", ->
        @model.destroy()
        @view.$el.html().should.equal ""

    context "B002: model parsing", ->
      beforeEach ->
        @root = new @LabelCategory.Models.LabelCategory
          name: "root"
        @category_view = new @LabelCategory.Views.LabelCategoryView
          model: @root

      it "C001: parse 1", ->
        @label = new @Label.Models.Label(
          name: "A/B/C"
          color: "999999"
        )
        @label_view = new @Label.Views.LabelView(
          model: @label
        )
        console.log @label_view.render().$el.html()
        @root.parse_labels_recursive_func @label.get("name"), @label
        @root.trigger "parsed"
        console.log @category_view.$(".childrens .childrens").html()

