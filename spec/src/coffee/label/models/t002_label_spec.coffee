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
        .intercept("/user_name/repo_name", "POST")
        .reply(
          200
          (url, body)->
            type: "post"
        )
      nock("http://localhost:8888")
        .intercept("/user_name/repo_name", "PUT")
        .reply(
          200
          (url, body)->
            type: "put"
        )
      nock("http://localhost:8888")
        .intercept("/user_name/repo_name", "DELETE")
        .reply(
          200
          (url, body)->
            type: "delete"
        )
      @label_url = "http://localhost:8888/user_name/repo_name"
      @spy = sinon.spy()

    it "001: create", (done)->
      label1 = new @Label()
      label1.on "sync", =>
        @spy "sync"
      label1.url = @label_url
      label1.set "name", "category1/child-category1/label1"
      label1.get("name").should.equal "category1/child-category1/label1"
      label1.save(
        {
          name: "category1/child-category2/label1"
        }
        {
          success:
            (model, ret)=>
              setTimeout(
                =>
                  ret.type.should.equal "post"
                  label1.get("name").should.equal "category1/child-category2/label1"
                  @spy.calledWith("sync").should.equal true
                  done()
                0
              )
        }
      )

    it "002: update", (done)->
      label1 = new @Label(
        id: "label1"
      )
      label1.on "sync", =>
        @spy "sync"
      label1.url = @label_url
      label1.set "name", "category1/child-category1/label1"
      label1.get("name").should.equal "category1/child-category1/label1"
      label1.save(
        {
          name: "category1/child-category2/label1"
        }
        {
          success:
            (model, ret)=>
              setTimeout(
                =>
                  ret.type.should.equal "put"
                  label1.get("name").should.equal "category1/child-category2/label1"
                  @spy.calledWith("sync").should.equal true
                  done()
                0
              )
        }
      )

    it "003: delete", (done)->
      label1 = new @Label(
        id: "label1"
      )
      label1.on "sync", =>
        @spy "sync"
      label1.on "destroy", =>
        @spy "destroy"
      label1.url = @label_url
      label1.set "name", "カテゴリ1/子カテゴリ1/ラベル1"
      label1.get("name").should.equal "カテゴリ1/子カテゴリ1/ラベル1"
      label1.destroy(
        success: (model, ret)=>
          setTimeout(
            =>
              ret.type.should.equal "delete"
              @spy.calledWith("sync").should.equal true
              @spy.calledWith("destroy").should.equal true
              done()
            0
          )
      )

  describe "002: color", ->

