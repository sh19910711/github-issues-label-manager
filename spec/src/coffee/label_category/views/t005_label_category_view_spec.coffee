describe "T005: LabelCategory::Views::LabelCategoryView", ->
  beforeEach ->
    @LabelCategory = requirejs "app/label_category"

  context "A001: model watching", ->
    context "B001: simple", ->
      beforeEach ->
        @model = new @LabelCategory.Models.LabelCategory
        @view = new @LabelCategory.Views.LabelCategoryView
          model: @model

      it "C001: destroy", ->
        destroy_event_spy = sinon.spy()
        @view.on "destroy", destroy_event_spy
        @model.destroy()
        destroy_event_spy.called.should.equal true

