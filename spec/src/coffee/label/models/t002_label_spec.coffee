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
            console.log "HTTP POST"
            type: "post"
        )
      nock("http://localhost:8888")
        .intercept("/user_name/repo_name", "PUT")
        .reply(
          200
          (url, body)->
            console.log "HTTP PUT"
            type: "post"
        )
      nock("http://localhost:8888")
        .intercept("/user_name/repo_name", "DELETE")
        .reply(
          200
          (url, body)->
            console.log "HTTP DELETE"
            type: "delete"
        )
    it "001: #set, #save", (done)->
      @label = new @Label(
      )
      @label_url = "http://localhost:8888/user_name/repo_name"
      @label.url = @label_url
      @label.set "name", "category1/child-category1/label1"
      @label.get("name").should.equal "category1/child-category1/label1"
      @label.save(
        {
          name: "category1/child-category2/label1"
        }
        {
          success:
            (ret)=>
              console.log arguments
              ret.get("type").should.equal "post"
              @label.get("name").should.equal "category1/child-category2/label1"
              done()
        }
      )
    it "002: #set, #destroy", (done)->
      @label = new @Label(
        id: "label1"
      )
      @label_url = "http://localhost:8888/user_name/repo_name"
      @label.url = @label_url
      @label.set "name", "カテゴリ1/子カテゴリ1/ラベル1"
      @label.get("name").should.equal "カテゴリ1/子カテゴリ1/ラベル1"
      @label.destroy(
        success: (model, ret)=>
          console.log "after destroy: ", model
          done()
      )

  describe "002: color", ->

