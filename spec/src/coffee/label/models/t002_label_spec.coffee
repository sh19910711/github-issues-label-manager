describe "T002: Label", ->
  before (done)->
    requirejs(
      [
        "app/label/models/label"
      ]
      (
        Label
      )=>
        @Label = Label
        done()
    )
    backbone.ajax = jQuery.ajax

  describe "001: name", ->
    beforeEach ->
      nock("http://localhost:8888")
        .post("/repo_name/user_name")
        .reply(200, {result: "OK"})
      @label = new @Label()
      @label_url = "http://localhost:8888/repo_name/user_name"
      @label.url = @label_url
    it "001: #set", (done)->
      @label.set "name", "category1/child-category1/label1"
      @label.get("name").should.equal "category1/child-category1/label1"
      @label.save().done(
        ->
          done()
      )
    it "002: #set", (done)->
      @label.set "name", "カテゴリ1/子カテゴリ1/ラベル1"
      @label.get("name").should.equal "カテゴリ1/子カテゴリ1/ラベル1"
      @label.save().done(
        ->
          done()
      )

  describe "002: color", ->

