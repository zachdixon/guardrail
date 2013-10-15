assert = require("assert")
suite "Apps", ->
  test "insert app", (done, server) ->
    server.eval ->
      Apps.insert name: "Test App"
      docs = Apps.find().fetch()
      emit "docs", docs

    server.once "docs", (docs) ->
      assert.equal docs.length, 1
      done()