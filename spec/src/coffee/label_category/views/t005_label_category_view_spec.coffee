describe "T005: LabelCategory::Views::LabelCategoryView", ->
  beforeEach ->
    @LabelCategory = requirejs "app/label_category"

  context "A001: model watching", ->
    context "B001: simple", ->
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

