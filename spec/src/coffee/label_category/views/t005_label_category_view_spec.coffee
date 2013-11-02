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
        @root.parse_labels_recursive_func @label.get("name"), @label
        @category_view.$(".childrens .childrens .childrens .name").text().should.equal "C"

  context "A002: destroy", ->
    context "B001: has child", ->
      beforeEach ->
        @root = new @LabelCategory.Models.LabelCategory(
          name: "root"
        )
        @view = new @LabelCategory.Views.LabelCategoryView(
          model: @root
        )
        @label1 = new @Label.Models.Label(
          name: "1/1"
        )
        @label2 = new @Label.Models.Label(
          name: "1/1/1"
        )
        @label3 = new @Label.Models.Label(
          name: "1/1/2"
        )
        @label4 = new @Label.Models.Label(
          name: "1/1/3"
        )
        @label5 = new @Label.Models.Label(
          name: "1/2"
        )
        @root.parse_labels_recursive_func @label1.get("name"), @label1
        @root.parse_labels_recursive_func @label2.get("name"), @label2
        @root.parse_labels_recursive_func @label3.get("name"), @label3
        @root.parse_labels_recursive_func @label4.get("name"), @label4
        @root.parse_labels_recursive_func @label5.get("name"), @label5

      it "C001: destroy 1/1", ->
        @root.children("1").children("1").destroy()
        @root.children("1").get("name").should.equal "1"
        @root.children("1").children("1").children("1").get("name").should.equal "1"
        @root.children("1").children("1").children("2").get("name").should.equal "2"
        @root.children("1").children("1").children("3").get("name").should.equal "3"

    context "B002: has child child", ->
      beforeEach ->
        @root = new @LabelCategory.Models.LabelCategory(
          name: "root"
        )
        @view = new @LabelCategory.Views.LabelCategoryView(
          model: @root
        )
        @label1 = new @Label.Models.Label(
          name: "1/2"
          color: "CCCCCC"
        )
        @label2 = new @Label.Models.Label(
          name: "1/2/3/4"
          color: "CCCCCC"
        )
        @root.parse_labels_recursive_func @label1.get("name"), @label1
        @root.parse_labels_recursive_func @label2.get("name"), @label2

      it "C001: destroy 1/2, remain 1/2/3/4", ->
        @root.children("1").children("2").destroy()
        @view.$(".label-view").size().should.equal 1
        @view.$(".label-view").children(".name").text().should.equal "4"

