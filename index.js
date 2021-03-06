// Generated by CoffeeScript 1.8.0
(function() {
  var LinkedList, Node, idPropertyName;

  Node = (function() {
    function Node() {}

    Node.prototype.obj = null;

    Node.prototype.next = null;

    Node.prototype.prev = null;

    Node.prototype.free = true;

    return Node;

  })();

  LinkedList = (function() {
    LinkedList.prototype.first = null;

    LinkedList.prototype.last = null;

    LinkedList.prototype.length = 0;

    LinkedList.prototype.objMap = null;

    function LinkedList() {
      this.objMap = Object.create(null);
      return;
    }

    LinkedList.prototype._getNode = function(obj) {
      return this.objMap[obj[idPropertyName]];
    };

    LinkedList.prototype.add = function(obj) {
      var node;
      node = this._getNode(obj);
      if (node == null) {
        node = new Node;
        node.obj = obj;
        node.prev = null;
        node.next = null;
        node.free = false;
        this.objMap[obj[idPropertyName]] = node;
      } else {
        if (!node.free) {
          return obj;
        }
        node.obj = obj;
        node.free = false;
        node.next = null;
        node.prev = null;
      }
      if (this.first == null) {
        this.first = node;
        this.last = node;
        node.next = null;
        node.prev = null;
      } else {
        if (this.last == null) {
          throw new Error("The list's 'last' property was null or undefined on a non-empty list; this should not happen.");
        }
        this.last.next = node;
        node.prev = this.last;
        this.last = node;
        node.next = null;
      }
      this.length++;
      return obj;
    };

    LinkedList.prototype.contains = function(obj) {
      var node;
      node = this._getNode(obj);
      return !((node == null) || node.free === true);
    };

    LinkedList.prototype.remove = function(obj) {
      var node, _ref, _ref1;
      node = this._getNode(obj);
      if ((node == null) || node.free) {
        return false;
      }
      if ((_ref = node.prev) != null) {
        _ref.next = node.next;
      }
      if ((_ref1 = node.next) != null) {
        _ref1.prev = node.prev;
      }
      if (node.prev == null) {
        this.first = node.next;
      }
      if (node.next == null) {
        this.last = node.prev;
      }
      node.free = true;
      node.prev = null;
      node.next = null;
      this.length--;
      return obj;
    };

    LinkedList.prototype.clear = function() {
      var next;
      next = this.first;
      while (next != null) {
        next.free = true;
        next = next.next;
      }
      this.first = null;
      this.length = 0;
    };

    LinkedList.prototype.each = function(f) {
      var next;
      next = this.first;
      while (next != null) {
        f(next.obj);
        next = next.next;
      }
    };

    return LinkedList;

  })();

  idPropertyName = '_id';

  LinkedList.config = {};

  Object.defineProperty(LinkedList.config, 'idPropertyName', {
    get: function() {
      return idPropertyName;
    },
    set: function(val) {
      return idPropertyName = val;
    }
  });

  module.exports = LinkedList;

}).call(this);
