should = require "should"

describe "T004: LabelCategory::Models::LabelCategory", ->
  beforeEach (done)->
    requirejs(
      [
        "app/label_category"
        "app/label"
      ]
      (
        LabelCategory
        Label
      )=>
        @LabelCategory = LabelCategory
        @Label = Label

        # set root node
        @root = new @LabelCategory.Models.LabelCategory
        @fake_label =
          set: sinon.spy()
          on: sinon.spy()

        done()
    )

  context "001: parsing", ->
    context "001: test1/test2/test3", ->
      beforeEach ->
        @root.parse_labels_recursive_func "test1/test2/test3", @fake_label

      it "001: check name", ->
        @root.get("childrens")["test1"].get("name").should.equal "test1"
        @root.get("childrens")["test1"].get("childrens")["test2"].get("name").should.equal "test2"
        @root.get("childrens")["test1"].get("childrens")["test2"].get("childrens")["test3"].get("name").should.equal "test3"

      it "002: check childrens", ->
        _(@root.get("childrens")).keys().length.should.equal 1
        _(@root.get("childrens")["test1"].get("childrens")).keys().length.should.equal 1
        _(@root.get("childrens")["test1"].get("childrens")["test2"].get("childrens")).keys().length.should.equal 1
        _(@root.get("childrens")["test1"].get("childrens")["test2"].get("childrens")["test3"].get("childrens")).keys().length.should.equal 0

      it "003: check label", ->
        should.strictEqual @root.get("childrens")["test1"].get("label"), undefined
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test2"].get("label"), undefined
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test2"].get("childrens")["test3"].get("label"), @fake_label

  context "002: properties", ->
    context "001: root", ->
      beforeEach ->
        @root.set "name", "this is root"
      it "001 get name", ->
        @root.get("name").should.equal "this is root"

