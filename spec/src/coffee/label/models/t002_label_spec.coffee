describe "T002", ->

  before (done)->
    requirejs(
      [
        "app/label/models/label"
      ]
      (
        Label
      )=>
        @label = Label
        done()
    )

  describe "001", ->
    it "001", ()->
      label = new @label(
        name: "test1"
        color: "#FF0000"
      )
      label.get("name").should.equal "test1"
    it "002", ()->
      label = new @label(
        name: "test2"
        color: "#00FF00"
      )
      label.get("name").should.equal "test2"

