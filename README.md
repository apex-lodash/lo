[![Build Status](https://travis-ci.org/apex-lodash/lo.svg?branch=master)](https://travis-ci.org/apex-lodash/lo)
[![Coverage Status](http://coveralls.io/repos/apex-lodash/lo/badge.svg?branch=master&service=github)](http://coveralls.io/github/apex-lodash/lo?branch=master)

#apex-lodash
This class provides some similar utility methods to that of [lodash](https://lodash.com/).

#Installation
TODO: Add installation guide

#Usage
##Chunk
Takes a given list and breaks it into several list based on a given size
```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd' };
lo.chunk(myList, 2);
// [['a', 'b'], ['c', 'd']]
lo.chunk(myList, 3);
// [['a', 'b', 'c'], ['d']]
lo.chunk(myList, 10);
// [['a', 'b', 'c', 'd']]
```

##Drop
Drops a given number of elements off the "left hand side" of a list

###Single drop
```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd' };
lo.drop(myList);
// ['b', 'c', 'd']
```

###Provided drop count
```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd' };
lo.drop(myList, 2);
// ['c', 'd']
```

##DropRight
Drops a given number of elements off the "right hand side" of a list

###Single drop
```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd' };
lo.dropRight(myList);
// ['a', 'b', 'c']
```

###Provided drop count
```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd' };
lo.dropRight(myList, 2);
// ['a', 'b']
```

##Fill
Fills a list with the given object a given number of times
```java
lo.fill('foo', 3);
// ['foo', 'foo', 'foo']
```

##Last
Gets the last item from a list
```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd' };
lo.last(myList);
// 'd'
```

##Pluck
Used to pluck a list of fields out of a list of objects

###Single object
```java
Account account = ...;
Object lo.pluck(account, 'name');
```

###Single depth
```java
List<Account> accountList = ...;
List<Object> lo.pluck(accountList, 'name');
```

###Multiple depths
```java
List<Case> caseList = ...;
List<Object> lo.pluck(caseList, 'contact.account.name');
```

##Rest
Gets all but the first element of a list

```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd' };
lo.rest(myList);
// ['b', 'c', 'd']
```

##Slice
Gets part of a list

##From given point to end

```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd', 'e' };
lo.slice(myList, 2);
// ['c', 'd', 'e']
```

##From given point to given point

```java
List<String> myList = new List<String>{ 'a', 'b', 'c', 'd', 'e' };
lo.slice(myList, 2,4);
// ['c', 'd']
```

##ToString
Takes a list of Objects and typecasts them to strings

```java
List<Account> accountList = ...;
List<String> lo.toString(lo.pluck(accountList, 'name'));
```