should = require "should"

describe "T004: LabelCategory::Models::LabelCategory", ->
  beforeEach ->
    @LabelCategory = requirejs "app/label_category"
    @Label         = requirejs "app/label"

    # set root node
    @root = new @LabelCategory.Models.LabelCategory
    @fake_label =
      set:  sinon.spy()
      on:   sinon.spy()

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

    context "002: multi test1/test*/test3", ->
      beforeEach ->
        _([3..200]).each (v)=>
          @root.parse_labels_recursive_func "test1/test#{v}/test3", @fake_label

      it "001: check name", ->
        _([3..200]).each (v)=>
          @root.get("childrens")["test1"].get("childrens")["test#{v}"].get("name").should.equal "test#{v}"

      it "002: check childrens", ->
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test1"], undefined
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test2"], undefined
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test201"], undefined
        _(@root.get("childrens")["test1"].get("childrens")).keys().length.should.equal 200 - 2

  context "002: properties", ->
    context "001: root", ->
      beforeEach ->
        @root.set "name", "this is root"

      it "001 get name", ->
        @root.get("name").should.equal "this is root"

