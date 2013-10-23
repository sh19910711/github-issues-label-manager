describe "T002: Label", ->
  beforeEach (done)->
    requirejs(
      [
        "app/label/models/label"
      ]
      (
        Label
      )=>
        @Label = Label
        nock("http://localhost:8888")
          .intercept("/api/label", "POST")
          .reply(
            200
            (url, body)->
              type: "post"
          )
        nock("http://localhost:8888")
          .intercept("/api/label", "PUT")
          .reply(
            200
            (url, body)->
              type: "put"
          )
        nock("http://localhost:8888")
          .intercept("/api/label", "DELETE")
          .reply(
            200
            (url, body)->
              type: "delete"
          )
        nock("http://localhost:8888")
          .filteringPath(/\/api\/label\/.*?$/g, "/api/label/label_id")
          .intercept("/api/label/label_id", "POST")
          .reply(
            200
            (url, body)->
              type: "post"
          )
        nock("http://localhost:8888")
          .filteringPath(/\/api\/label\/.*?$/g, "/api/label/label_id")
          .intercept("/api/label/label_id", "PUT")
          .reply(
            200
            (url, body)->
              type: "put"
          )
        nock("http://localhost:8888")
          .filteringPath(/\/api\/label\/.*?$/g, "/api/label/label_id")
          .intercept("/api/label/label_id", "DELETE")
          .reply(
            200
            (url, body)->
              type: "delete"
          )
        done()
    )
    backbone.ajax = ->
      args = Array.prototype.slice.call arguments
      args[0].url = "http://localhost:8888#{args[0].url}"
      jQuery.ajax.apply @, args

  describe "001: name", ->
    describe "001: event", ->
      beforeEach ->
        @spy = sinon.spy()

      it "001: create", (done)->
        label1 = new @Label()
        label1.on "sync", =>
          @spy "sync"
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
    describe "001: event", ->
      beforeEach ->
        @spy = sinon.spy()

      it "001: validation: #FF0000", (done)->
        label1 = new @Label()
        label1.set_color("#FF0000").done(
          ()=>
            setTimeout(
              ()=>
                label1.get_color().should.equal "#FF0000"
                done()
              100
            )
        )

      it "002: validation: {r: 255, g: 0, b: 0}", (done)->
        label1 = new @Label()
        label1.on "sync", =>
          @spy "sync"
        label1.set_color(
          r: 255
          g: 0
          b: 0
        )
        label1.save(
          {
          }
          {
            success: =>
              setTimeout(
                =>
                  label1.get_color().should.equal "#FF0000"
                  @spy.calledWith("sync").should.equal true
                  done()
                0
              )
          }
        )

      it "003: validation: FF0000 -> #FF0000", (done)->
        label1 = new @Label()
        label1.on "sync", =>
          @spy "sync"
        label1.save(
          {
            color: "FF0000"
          }
          {
            success: =>
              setTimeout(
                =>
                  label1.get_color().should.equal "#FF0000"
                  @spy.calledWith("sync").should.equal true
                  done()
                0
              )
          }
        )

      it "004: invalidation: FF00000", (done)->
        label1 = new @Label()
        label1.on "sync", =>
          @spy "sync"
        label1.on "invalid", =>
          @spy "invalid"
        label1.save(
          color: "FF00000"
        ).always(
          ()=>
            setTimeout(
              =>
                @spy.calledWith("sync").should.equal false
                @spy.calledWith("invalid").should.equal true
                done()
              0
            )
        )

      it "005: validation: F00 -> #FF0000", (done)->
        label1 = new @Label()
        label1.on "sync", =>
          @spy "sync"
        label1.save(
          {
            color: "F00"
          }
          {
            success: =>
              setTimeout(
                =>
                  label1.get_color().should.equal "#FF0000"
                  @spy.calledWith("sync").should.equal true
                  done()
                0
              )
          }
        )

      it "006: validation: #F00 -> #FF0000", (done)->
        label1 = new @Label()
        label1.on "sync", =>
          @spy "sync"
        label1.save(
          {
            color: "#F00"
          }
          {
            success: =>
              setTimeout(
                =>
                  label1.get_color().should.equal "#FF0000"
                  @spy.calledWith("sync").should.equal true
                  done()
                0
              )
          }
        )


