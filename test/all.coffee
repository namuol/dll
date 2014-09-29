tape = require 'tape'
LinkedList = require '../index'

id = 0
newObj = ->
  obj = {_id: id}
  id += 1
  return obj

describe = (item, cb) ->
  it = (capability, test) ->
    tape.test item + ' ' + capability, (t) ->
      # reset id counter for each test
      id = 0
      test(t)

  cb it

describe 'linked lists', (it) ->
  it 'starts out empty', (t) ->
    t.equal (new LinkedList).length, 0
    t.end()

  it 'have a length of one after a single element has been added', (t) ->
    list = new LinkedList
    list.add newObj()
    t.equal list.length, 1
    t.end()

  it 'have a length of 2 after a 2 elements have been added', (t) ->
    list = new LinkedList
    count = 0
    while count < 2
      list.add newObj()
      count += 1
    t.equal list.length, 2
    t.end()

  it 'have a length of 3 after a 3 elements have been added', (t) ->
    list = new LinkedList
    count = 0
    while count < 3
      list.add newObj()
      count += 1
    t.equal list.length, 3
    t.end()

  it 'should have a first and last element pointing to the same object when the length is 1', (t) ->
    list = new LinkedList
    obj = newObj()
    list.add obj
    t.equal list.first, list.last
    t.end()

  it 'have a length of zero after a single element has been added, and removed', (t) ->
    list = new LinkedList
    obj = newObj()
    list.add obj
    list.remove obj
    t.equal list.length, 0
    t.end()

  it 'have a length of zero after a single element has been added, then clear() is called', (t) ->
    list = new LinkedList
    obj = newObj()
    list.add obj
    list.clear()
    t.equal list.length, 0
    t.end()
  
  it 'have a length of zero after 2 elements are added, and then clear() is called', (t) ->
    list = new LinkedList
    count = 0
    while count < 2
      list.add newObj()
      count += 1
    list.clear()
    t.equal list.length, 0
    t.end()
  
  it 'know when they contain a specific object', (t) ->
    list = new LinkedList
    obj = newObj()
    list.add obj
    t.true list.contains obj
    t.end()

  it 'know when they do not have a specific object', (t) ->
    list = new LinkedList
    obj = newObj()
    obj2 = newObj()
    list.add obj
    t.false list.contains obj2
    t.end()

  it 'return obj when add(obj) is called and obj is not part of the list', (t) ->
    list = new LinkedList
    obj = newObj()
    t.equal list.add(obj), obj
    t.end()

  it 'return obj when add(obj) is called and obj is already part of the list', (t) ->
    list = new LinkedList
    obj = newObj()
    list.add obj
    t.equal list.add(obj), obj
    t.end()

  it 'return obj when remove(obj) is called and obj is part of the list', (t) ->
    list = new LinkedList
    obj = newObj()
    list.add obj
    t.equal list.remove(obj), obj
    t.end()

  it 'return false when remove(obj) is called and obj is not part of the list', (t) ->
    list = new LinkedList
    obj = newObj()
    t.equal list.remove(obj), false
    t.end()

  it 'should allow you to iterate over the entire list with ".each()"', (t) ->
    list = new LinkedList
    objs = []
    for i in [0..3]
      obj = newObj()
      objs.push obj
      list.add obj

    idx = 0
    
    list.each (e) ->
      t.equal e, objs[idx]
      idx += 1

    t.end()
  