# dll [![Build Status](https://drone.io/github.com/namuol/dll/status.png)](https://drone.io/github.com/namuol/dll/latest) [![devDependency Status](https://david-dm.org/namuol/dll/dev-status.svg?style=flat-square)](https://david-dm.org/namuol/dll#info=devDependencies)

A lightweight, fast & flexible doubly linked list for JavaScript.

```js
var currentID = 0;

function Food (name) {
  this.name = name;

  // a unique id field is required:
  this._id = currentID;
  currentID += 1;
}

var entityA = new Food('Bacon'),
    entityB = new Food('Brocolli'),
    entityC = new Food('Sausage'),
    entityD = new Food('Steak');

var LinkedList = require('dll');
var list = new LinkedList();

list.add(entityA);
list.add(entityB);
list.add(entityC);
list.add(entityD);

console.log(list.length); // "4"

// Iterating is easy:
var itr = list.first;
while (itr) {
  console.log(itr.obj.name);
  itr = itr.next;
}
// Output:
//   Bacon
//   Brocolli
//   Sausage
//   Steak

assert( list.contains(entityC) === true );

list.remove(entityC);

assert( list.contains(entityC) === false );

// Iterating backwards is easy:
itr = list.last;
while (itr) {
  console.log(itr.obj.name);
  itr = itr.prev;
}
// Output:
//   Steak
//   Sausage
//   Bacon

list.clear();
console.log(list.length); // "0"
```

### Caveats

- Only objects are supported. No primitives.
- Objects must have a unique ID property (default is `_id`, but it can be changed with [`dll.config.idPropertyName`](#api-config-idPropertyName)).
- Duplicate items are not supported.

### API

```js
var LinkedList = require('dll');
```

<a name='api-config-idPropertyName'></a>
#### LinkedList.config.idPropertyName

*Type:* **String** *Default: `"_id"`*

The name of the property used to uniquely identify objects.

You are required to have a unique ID property on any objects that
are added to a linked list, but you can call it whatever you want by
changing the string value of this property.

<a name='api-new'></a>
#### new LinkedList()

Create a new linked list.

<a name='api-first'></a>
#### list.first

*Type:* [**Node**](#api-node)

The first node in the list.

If the list is empty, `list.first` will be `null`.

<a name='api-last'></a>
#### list.last

*Type:* [**Node**](#api-node)

The last node in the list.

If the list is empty, `list.last` will be `null`.

<a name='api-length'></a>
#### list.length

The number of objects in the list.

<a name='api-add'></a>
#### list.add(obj)

Add an object to a list. If a list already contains the object,
this will have no effect on the list.

**Always returns `obj`**

<a name='api-remove'></a>
#### list.remove(obj)

Remove an object from the list.

**Returns `obj` if the object was removed, `false` if it was not part of the list**

<a name='api-clear'></a>
#### list.clear(obj)

Removes all objects from the list and sets its length to zero.

<a name='api-node'></a>
#### Node

A container representing a location within the list.

<a name='api-node-obj'></a>
#### Node.obj

*Type:* **Object**

The object that is at this location in the list.

<a name='api-node-next'></a>
#### Node.next

*Type:* [**Node**](#api-node)

The node that follows this node.

If this is the last node in the list, `next` will be `null`.

<a name='api-node-prev'></a>
#### Node.prev

*Type:* [**Node**](#api-node)

The node that precedes this node.

If this is the first node in the list, `prev` will be `null`.

## License

Apache 2.0

## Install

```bash
npm install dll --save
```
