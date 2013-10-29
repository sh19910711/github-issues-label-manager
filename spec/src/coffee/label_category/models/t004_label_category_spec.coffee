should = require "should"

describe "T004: LabelCategory::Models::LabelCategory", ->
  before ->
    @LabelCategory = requirejs "app/label_category"
    @Label         = requirejs "app/label"

  context "A001: parsing", ->
    beforeEach ->
      # set root node
      @root = new @LabelCategory.Models.LabelCategory
      @fake_label =
        set:  sinon.spy()
        on:   sinon.spy()

    context "B001: test1/test2/test3", ->
      beforeEach ->
        @root.parse_labels_recursive_func "test1/test2/test3", @fake_label

      it "C001: check name", ->
        @root.get("childrens")["test1"].get("name").should.equal "test1"
        @root.get("childrens")["test1"].get("childrens")["test2"].get("name").should.equal "test2"
        @root.get("childrens")["test1"].get("childrens")["test2"].get("childrens")["test3"].get("name").should.equal "test3"

      it "C002: check childrens", ->
        _(@root.get("childrens")).keys().length.should.equal 1
        _(@root.get("childrens")["test1"].get("childrens")).keys().length.should.equal 1
        _(@root.get("childrens")["test1"].get("childrens")["test2"].get("childrens")).keys().length.should.equal 1
        _(@root.get("childrens")["test1"].get("childrens")["test2"].get("childrens")["test3"].get("childrens")).keys().length.should.equal 0

      it "C003: check label", ->
        should.strictEqual @root.get("childrens")["test1"].get("label"), undefined
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test2"].get("label"), undefined
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test2"].get("childrens")["test3"].get("label"), @fake_label

    context "B002: multi test1/test*/test3", ->
      beforeEach ->
        _([3..200]).each (v)=>
          @root.parse_labels_recursive_func "test1/test#{v}/test3", @fake_label

      it "C001: check name", ->
        _([3..200]).each (v)=>
          @root.get("childrens")["test1"].get("childrens")["test#{v}"].get("name").should.equal "test#{v}"

      it "C002: check childrens", ->
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test1"], undefined
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test2"], undefined
        should.strictEqual @root.get("childrens")["test1"].get("childrens")["test201"], undefined
        _(@root.get("childrens")["test1"].get("childrens")).keys().length.should.equal 200 - 2

    context "B003: multi a/a/a a/a/b a/b/a a/b/c b/a/a", ->
      beforeEach ->
        @root.parse_labels_recursive_func "a/a/a", @fake_label
        @root.parse_labels_recursive_func "a/a/b", @fake_label
        @root.parse_labels_recursive_func "a/b/a", @fake_label
        @root.parse_labels_recursive_func "a/b/c", @fake_label
        @root.parse_labels_recursive_func "b/a/a", @fake_label

      it "C001: check name", ->
        @root.get("childrens")["a"].get("childrens")["a"].get("childrens")["a"].get("name").should.equal "a"
        @root.get("childrens")["a"].get("childrens")["a"].get("childrens")["b"].get("name").should.equal "b"
        @root.get("childrens")["a"].get("childrens")["b"].get("childrens")["a"].get("name").should.equal "a"
        @root.get("childrens")["a"].get("childrens")["b"].get("childrens")["c"].get("name").should.equal "c"
        @root.get("childrens")["b"].get("childrens")["a"].get("childrens")["a"].get("name").should.equal "a"

  context "A002: properties", ->
    beforeEach ->
      @root = new @LabelCategory.Models.LabelCategory

    context "B001: root", ->
      beforeEach ->
        @root.set "name", "this is root"

      it "C001: get name", ->
        @root.get("name").should.equal "this is root"

  context "A003: label watching", ->
    beforeEach ->
      @label = new @Label.Models.Label(
        name: "this is label"
        color: "777777"
      )
      @root = new @LabelCategory.Models.LabelCategory()

    context "B001: destroy", ->
      it "C001: destroy with label", ->
        destroy_event_spy = sinon.spy()
        @root.set_label @label
        @label.destroy()
        should.strictEqual @root.get("label"), undefined

  context "A004: #get_label_text()", ->
    beforeEach ->
      @root = new @LabelCategory.Models.LabelCategory()
      @fake_label =
        set:  sinon.spy()
        on:   sinon.spy()

    context "B001: A/B/C/D/E/F/G", ->
      beforeEach ->
        @root.parse_labels_recursive_func "A/B/C/D/E/F/G", @fake_label

      it "C001: simple", ->
        @root.get_label_text().should.equal ""
        @root.get("childrens")["A"].get_label_text().should.equal "A"
        @root.get("childrens")["A"].get("childrens")["B"].get_label_text().should.equal "A/B"
        @root.get("childrens")["A"].get("childrens")["B"].get("childrens")["C"].get_label_text().should.equal "A/B/C"

      it "C002: use parent", ->
        @root
          .get("childrens")["A"]
          .get("childrens")["B"]
          .get("childrens")["C"]
          .get("childrens")["D"]
          .get("parent")
          .get_label_text().should.equal "A/B/C"
        @root
          .get("childrens")["A"]
          .get("childrens")["B"]
          .get("childrens")["C"]
          .get("childrens")["D"]
          .get("parent")
          .get("childrens")["D"]
          .get("childrens")["E"]
          .get("childrens")["F"]
          .get("childrens")["G"]
          .get_label_text().should.equal "A/B/C/D/E/F/G"

  context "A005: #children()", ->
    beforeEach ->
      @root = new @LabelCategory.Models.LabelCategory
      @fake_label =
        set: sinon.spy()
        on:  sinon.spy()

    context "B001: A/B/C/D/E", ->
      beforeEach ->
        @root.parse_labels_recursive_func "A/B/C/D/E", @fake_label

      it "C001: get target category", ->
        @root.children("A").get("name").should.equal "A"
        @root.children("A").children("B").get("name").should.equal "B"
        @root.children("A").children("B").children("C").get("name").should.equal "C"
        @root.children("A").children("B").children("C").children("D").get("name").should.equal "D"
        @root.children("A").children("B").children("C").children("D").children("E").get("name").should.equal "E"

      it "C002: is not found", ->
        should.strictEqual @root.children("B"), undefined

  context "A006: #parent()", ->
    beforeEach ->
      @root = new @LabelCategory.Models.LabelCategory
      @fake_label =
        spy: sinon.spy()
        on:  sinon.spy()

    context "B001: A/B/C/D/E", ->
      beforeEach ->
        @root.parse_labels_recursive_func "A/B/C/D/E", @fake_label
        
      it "C001: #parent", ->
        @root.children("A").parent().children("A").get("name").should.equal "A"
        @root.children("A").children("B").children("C").parent().parent().get("name").should.equal "A"
        @root
          .children("A")
          .children("B")
          .children("C")
          .children("D")
          .children("E")
          .parent()
          .parent()
          .parent()
          .parent()
          .children("C")
          .children("D")
          .children("E")
          .parent()
          .get("name").should.equal "D"

      it "C002: root's parent is undefined", ->
        should.strictEqual @root.parent(), undefined

  context "A007: childrens watching", ->
    beforeEach ->
      @root = new @LabelCategory.Models.LabelCategory
      @fake_label =
        spy: sinon.spy()
        on:  sinon.spy()

    context "B001: destroy with no child", ->
      beforeEach ->
        @root.parse_labels_recursive_func "1/1/1", @fake_label
        @root.parse_labels_recursive_func "1/1/2", @fake_label
        @root.parse_labels_recursive_func "1/1/3", @fake_label
        @root.parse_labels_recursive_func "1/1/4", @fake_label
        @root.parse_labels_recursive_func "1/1/5", @fake_label
        # TODO: can it check fake_labels' destroy count?

      it "C001: check", ->
        destroy_event_spy = sinon.spy()
        @root.on "destroy", destroy_event_spy
        @root.children("1").children("1").children("1").destroy()
        @root.children("1").children("1").children("2").destroy()
        @root.children("1").children("1").children("3").destroy()
        @root.children("1").children("1").children("4").destroy()
        @root.children("1").children("1").children("5").destroy()
        destroy_event_spy.called.should.equal true


