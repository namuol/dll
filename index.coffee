class Node
  obj: null # the object reference
  next: null # link to next object in the list
  prev: null # link to previous object in the list
  free: true

class LinkedList
  first: null
  last: null
  length: 0
  objMap: null # a quick lookup list to map linked list nodes to objects

  constructor: ->
    @objMap = Object.create null
    return
  
  _getNode: (obj) ->
    @objMap[obj[idPropertyName]]

  add: (obj) ->
    node = @_getNode(obj)
    if not node?
      node = new Node
      node.obj = obj
      node.prev = null
      node.next = null
      node.free = false
      @objMap[obj[idPropertyName]] = node
    else
      return false  if not node.free

      node.obj = obj
      node.free = false
      node.next = null
      node.prev = null
    
    # append this obj to the end of the list
    if not @first? # is this the first?
      @first = node
      @last = node
      node.next = null # clear just in case
      node.prev = null
    else
      if not @last?
        throw new Error "The list's 'last' property was null or undefined on a non-empty list; this should not happen."
      
      # add this entry to the end of the list
      @last.next = node # current end of list points to the new end
      node.prev = @last
      @last = node # new object to add becomes last in the list
      node.next = null # just in case this was previously set
    @length++
    return obj

  contains: (obj) ->
    node = @_getNode(obj)
    not (not node? or node.free is true)
  
  ###*
  Removes an item from the list
  @param obj The object to remove
  @returns boolean true if the item was removed, false if the item was not on the list
  ###
  remove: (obj) ->
    node = @_getNode(obj)
    return false  if (not node?) or node.free # trying to remove something not there
    
    # pull this object out and tie up the ends
    node.prev?.next = node.next
    node.next?.prev = node.prev
    
    # fix first and last
    # if this was first on the list
    @first = node.next  unless node.prev? # make the next on the list first (can be null)
    # if this was the last
    @last = node.prev  unless node.next? # then this nodes previous becomes last
    node.free = true
    node.prev = null
    node.next = null
    @length--
    return obj
  
  ###*
  Clears the list out
  ###
  clear: ->
    # sweep the list and free all the nodes
    next = @first
    while next?
      next.free = true
      next = next.next
    @first = null
    @length = 0
    return

idPropertyName = '_id'

LinkedList.config = {}
Object.defineProperty LinkedList.config, 'idPropertyName',
  get: -> idPropertyName
  set: (val) -> idPropertyName = val

module.exports = LinkedList
