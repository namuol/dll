# dll

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

## Caveats

- Only objects are supported. No primitives.
- Objects must have a unique ID property (default is `_id`, but it can be changed with [`dll.config.idPropertyName`](#api-config-idPropertyName)).
- Duplicate items are not supported.

## License

Apache 2.0

## Install

```bash
npm install dll --save
```
