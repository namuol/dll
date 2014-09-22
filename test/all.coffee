assert = require 'assert'
tape = require 'tape'
LinkedList = require '../index'

describe = (item, cb) ->
  it = (capability, test) ->
    tape.test item + ' ' + capability, test

  cb it

describe 'a linked list', (it) ->
  it 'starts out empty', (t) ->
    t.equal (new LinkedList).length, 0
    t.end()

  it 'has a length of one after a single element has been added', (t) ->
    list = new LinkedList
    list.add {_id:0}
    t.equal list.length, 1
    t.end()

  it 'has a length of zero after a single element has been added, and removed', (t) ->
    list = new LinkedList
    obj = {_id:0}
    list.add obj
    list.remove obj
    t.equal list.length, 0
    t.end()
  