## 变量提升

### 变量提升（Hoisting）

```javascript
var myname = '极客时间'
```
这段代码你可以把它看成是两行代码组成的：

```javascript
var myname    //声明部分
myname = '极客时间'  //赋值部分
```

![img](https://static001.geekbang.org/resource/image/ec/3c/ec882f2d9deec26ce168b409f274533c.png?wh=1142*439)

**所谓的变量提升，是指在 JavaScript 代码执行过程中，JavaScript 引擎把变量的声明部分和函数的声明部分提升到代码开头的“行为”。变量被提升后，会给变量设置默认值，这个默认值就是我们熟悉的 undefined。**

![img](https://static001.geekbang.org/resource/image/ce/d5/cefe564dbff729e735a834fd9e3bd0d5.png?wh=1142*528)

### JavaScript 代码的执行流程

**实际上变量和函数声明在代码里的位置是不会改变的，而且是在编译阶段被 JavaScript 引擎放入内存中**

![img](https://static001.geekbang.org/resource/image/64/1e/649c6e3b5509ffd40e13ce9c91b3d91e.png?wh=1142*203)

1. 编译阶段

**第一部分：变量提升部分的代码。**

```javascript
var myname = undefined
function showName() {
    console.log('函数showName被执行');
}
```

**第二部分：执行部分的代码。**

```javascript
showName()
console.log(myname)
myname = '极客时间'
```

![img](https://static001.geekbang.org/resource/image/06/13/0655d18ec347a95dfbf843969a921a13.png?wh=1142*634)


2. 执行阶段

JavaScript 的执行机制：**先编译，再执行**。


## 调用栈

哪些情况下代码才算是“一段”代码，才会在执行之前就进行编译并创建执行上下文。一般说来，有这么三种情况：

1. 当 JavaScript 执行全局代码的时候，会编译全局代码并创建全局执行上下文，而且在整个页面的生存周期内，全局执行上下文只有一份。
2. 当调用一个函数的时候，函数体内的代码会被编译，并创建函数执行上下文，一般情况下，函数执行结束之后，创建的函数执行上下文会被销毁。
3. 当使用 eval 函数的时候，eval 的代码也会被编译，并创建执行上下文。

### 什么是函数调用

```js
var a = 2
function add(){
var b = 10
return  a+b
}
add()
```

![img](https://static001.geekbang.org/resource/image/53/ca/537efd9e96771dc50737117e615533ca.png?wh=1142*558)

**JavaScript 引擎通过一种叫栈的数据结构来管理这些执行上下文**


### 什么是栈

关于栈，你可以结合这么一个贴切的例子来理解，一条单车道的单行线，一端被堵住了，而另一端入口处没有任何提示信息，堵住之后就只能后进去的车子先出来，这时这个堵住的单行线就可以被看作是一个**栈容器**，车子开进单行线的操作叫做**入栈**，车子倒出去的操作叫做**出栈**。

栈中的元素满足**后进先出**的特点

![img](https://static001.geekbang.org/resource/image/5e/05/5e2bb65019053abfd5e7710e41d1b405.png?wh=1142*667)


### 什么是调用栈

JavaScript 引擎正是利用栈的这种结构来管理执行上下文的。在执行上下文创建好后，JavaScript 引擎会将执行上下文压入栈中，通常把这种用来管理执行上下文的栈称为**执行上下文栈**，又称**调用栈**。

``` javascript
var a = 2
function add(b,c){
  return b+c
}
function addAll(b,c){
var d = 10
result = add(b,c)
return  a+result+d
}
addAll(3,6)
```

**第一步，创建全局上下文，并将其压入栈底**

![img](https://static001.geekbang.org/resource/image/a5/1d/a5d7ec1f8f296412acc045835b85431d.png?wh=1142*765)
![img](https://static001.geekbang.org/resource/image/1d/1d/1d50269dbc5b4c69f83662ecdd977b1d.png?wh=1142*383)

**第二步是调用 addAll 函数**

当调用该函数时，JavaScript 引擎会编译该函数，并为其创建一个执行上下文，最后还将该函数的执行上下文压入栈中

![img](https://static001.geekbang.org/resource/image/7d/52/7d6c4c45db4ef9b900678092e6c53652.png?wh=1142*794)

**第三步，当执行到 add 函数**

同样会为其创建执行上下文，并将其压入调用栈

![img](https://static001.geekbang.org/resource/image/cc/37/ccfe41d906040031a7df1e4f1bce5837.png?wh=1142*843)

当 add 函数返回时，该函数的执行上下文就会从栈顶弹出，并将 result 的值设置为 add 函数的返回值，也就是 9。如下图所示：

![img](https://static001.geekbang.org/resource/image/03/96/03ca801a5372f941bf17d6088fee0f96.png?wh=1142*863)

紧接着 addAll 执行最后一个相加操作后并返回，addAll 的执行上下文也会从栈顶部弹出，此时调用栈中就只剩下全局上下文了。最终如下图所示：

![img](https://static001.geekbang.org/resource/image/d0/7b/d0ac1d6e77735338fa97cc9a3f6c717b.png?wh=1142*641)

**调用栈是 JavaScript 引擎追踪函数执行的一个机制**


### 在开发中，如何利用好调用栈

1. 如何利用浏览器查看调用栈的信息

![img](https://static001.geekbang.org/resource/image/c0/a2/c0d303a289a535b87a6c445ba7f34fa2.png?wh=1142*636)

![img](https://static001.geekbang.org/resource/image/ab/ce/abfba06cd23a7704a6eb148cff443ece.png?wh=1142*832)

2. 栈溢出（Stack Overflow）

**调用栈是有大小的**，当入栈的执行上下文超过一定数目，JavaScript 引擎就会报错，我们把这种错误叫做**栈溢出**。



## 块级作用域

**由于 JavaScript 存在变量提升这种特性，从而导致了很多与直觉不符的代码，这也是 JavaScript 的一个重要设计缺陷**

### 作用域

**作用域是指在程序中定义变量的区域，该位置决定了变量的生命周期。通俗地理解，作用域就是变量与函数的可访问范围，即作用域控制着变量和函数的可见性和生命周期。**


## 变量提升所带来的问题

1. 变量容易在不被察觉的情况下被覆盖掉

2. 本应销毁的变量没有被销毁


## JavaScript 是如何支持块级作用域的

```javascript
function foo(){
    var a = 1
    let b = 2
    {
      let b = 3
      var c = 4
      let d = 5
      console.log(a)
      console.log(b)
    }
    console.log(b) 
    console.log(c)
    console.log(d)
}   
foo()
```

**第一步是编译并创建执行上下文**

![img](https://static001.geekbang.org/resource/image/f9/67/f9f67f2f53437218baef9dc724bd4c67.png?wh=1142*647)

* 函数内部通过 var 声明的变量，在编译阶段全都被存放到变量环境里面了。
* 通过 let 声明的变量，在编译阶段会被存放到词法环境（Lexical Environment）中。
* 在函数的作用域块内部，通过 let 声明的变量并没有被存放到词法环境中。

**第二步继续执行代码**
![img](https://static001.geekbang.org/resource/image/7e/fa/7e0f7bc362e0dea21d27dc5fb08d06fa.png?wh=1142*654)

在词法环境内部，维护了一个小型栈结构，栈底是函数最外层的变量，进入一个作用域块后，就会把该作用域块内部的变量压到栈顶；当作用域执行完成之后，该作用域的信息就会从栈顶弹出，这就是词法环境的结构

![img](https://static001.geekbang.org/resource/image/06/08/06c06a756632acb12aa97b3be57bb908.png?wh=1142*557)

块级作用域就是通过词法环境的栈结构来实现的，而变量提升是通过变量环境来实现，通过这两者的结合，JavaScript 引擎也就同时支持了变量提升和块级作用域了。



## 作用域链和闭包

### 作用域链

其实在每个执行上下文的变量环境中，都包含了一个外部引用，用来指向外部的执行上下文，我们把这个外部引用称为 **outer**。

```javascript
function bar() {
    console.log(myName)
}
function foo() {
    var myName = "极客邦"
    bar()
}
var myName = "极客时间"
foo()
```

![img](https://static001.geekbang.org/resource/image/20/a7/20a832656434264db47c93e657e346a7.png?wh=1142*797)

从图中可以看出，bar 函数和 foo 函数的 outer 都是指向全局上下文的，这也就意味着如果在 bar 函数或者 foo 函数中使用了外部变量，那么 JavaScript 引擎会去全局执行上下文中查找。我们把这个查找的链条就称为作用域链。

在 JavaScript 执行过程中，其作用域链是由**词法作用域**决定的。


### 词法作用域

**词法作用域就是指作用域是由代码中函数声明的位置来决定的，所以词法作用域是静态的作用域，通过它就能够预测代码在执行过程中如何查找标识符。**

![img](https://static001.geekbang.org/resource/image/21/39/216433d2d0c64149a731d84ba1a07739.png?wh=1142*864)

**词法作用域是代码编译阶段就决定好的，和函数是怎么调用的没有关系。**



### 闭包

```js
function foo() {
    var myName = "极客时间"
    let test1 = 1
    const test2 = 2
    var innerBar = {
        getName:function(){
            console.log(test1)
            return myName
        },
        setName:function(newName){
            myName = newName
        }
    }
    return innerBar
}
var bar = foo()
bar.setName("极客邦")
bar.getName()
console.log(bar.getName())
```

![img](https://static001.geekbang.org/resource/image/d5/ef/d5587b76427a56c5f0b0571e4264b7ef.png?wh=1142*660)

**根据词法作用域的规则，内部函数 getName 和 setName 总是可以访问它们的外部函数 foo 中的变量**

当 foo 函数执行完成之后，其整个调用栈的状态如下图所示：

![img](https://static001.geekbang.org/resource/image/ee/3f/ee7c1ca481875ad4bdeb4383bd1f883f.png?wh=1142*607)

从上图可以看出，foo 函数执行完成之后，其执行上下文从栈顶弹出了，但是由于返回的 setName 和 getName 方法中使用了 foo 函数内部的变量 myName 和 test1，所以这两个变量依然保存在内存中。这像极了 setName 和 getName 方法背的一个专属背包，无论在哪里调用了 setName 和 getName 方法，它们都会背着这个 foo 函数的专属背包。

之所以是**专属**背包，是因为除了 setName 和 getName 函数之外，其他任何地方都是无法访问该背包的，我们就可以把这个背包称为 foo 函数的**闭包**。

**在 JavaScript 中，根据词法作用域的规则，内部函数总是可以访问其外部函数中声明的变量，当通过调用一个外部函数返回一个内部函数后，即使该外部函数已经执行结束了，但是内部函数引用外部函数的变量依然保存在内存中，我们就把这些变量的集合称为闭包。比如外部函数是 foo，那么这些变量的集合就称为 foo 函数的闭包。**

那这些闭包是如何使用的呢？当执行到 bar.setName 方法中的myName = "极客邦"这句代码时，JavaScript 引擎会沿着“当前执行上下文–>foo 函数闭包–> 全局执行上下文”的顺序来查找 myName 变量，你可以参考下面的调用栈状态图：

![img](https://static001.geekbang.org/resource/image/50/46/50e4ba60fc7e420e83b35b95e379b246.png?wh=1142*845)

你也可以通过“开发者工具”来看看闭包的情况，打开 Chrome 的“开发者工具”，在 bar 函数任意地方打上断点，然后刷新页面，可以看到如下内容：

![img](https://static001.geekbang.org/resource/image/40/a8/40b8840480a5df4f43ad5f4e7907e3a8.png?wh=1142*694)

从图中可以看出来，当调用 bar.getName 的时候，右边 Scope 项就体现出了作用域链的情况：Local 就是当前的 getName 函数的作用域，Closure(foo) 是指 foo 函数的闭包，最下面的 Global 就是指全局作用域，从“Local–>Closure(foo)–>Global”就是一个完整的作用域链。

#### 闭包是怎么回收的

通常，如果引用闭包的函数是一个全局变量，那么闭包会一直存在直到页面关闭；但如果这个闭包以后不再使用的话，就会造成内存泄漏。

如果引用闭包的函数是个局部变量，等函数销毁后，在下次 JavaScript 引擎执行垃圾回收时，判断闭包这块内容如果已经不再被使用了，那么 JavaScript 引擎的垃圾回收器就会回收这块内存。
所以在使用闭包的时候，你要尽量注意一个原则：**如果该闭包会一直使用，那么它可以作为全局变量而存在；但如果使用频率不高，而且占用内存又比较大的话，那就尽量让它成为一个局部变量。**

## this

在**对象内部的方法中使用对象内部的属性是一个非常普遍的需求**。但是 JavaScript 的作用域机制并不支持这一点，基于这个需求，JavaScript 又搞出来另外一套**this 机制**。

**作用域链**和 **this** 是两套不同的系统，它们之间基本没太多联系。


### JavaScript 中的 this 是什么

![img](https://static001.geekbang.org/resource/image/b3/8d/b398610fd8060b381d33afc9b86f988d.png?wh=1142*615)

从图中可以看出，**this 是和执行上下文绑定的**，也就是说每个执行上下文中都有一个 this。执行上下文主要分为三种——全局执行上下文、函数执行上下文和 eval 执行上下文，所以对应的 this 也只有这三种——全局执行上下文中的 this、函数中的 this 和 eval 中的 this


### 全局执行上下文中的 this

全局执行上下文中的 this 是指向 window 对象的。这也是 this 和作用域链的唯一交点，作用域链的最底端包含了 window 对象，全局执行上下文中的 this 也是指向 window 对象。

### 函数执行上下文中的 this

```js
function foo(){
  console.log(this)
}
foo()
```

我们在 foo 函数内部打印出来 this 值，执行这段代码，打印出来的也是 window 对象，这说明在默认情况下调用一个函数，其执行上下文中的 this 也是指向 window 对象的。估计你会好奇，那能不能设置执行上下文中的 this 来指向其他对象呢？答案是肯定的。通常情况下，有下面三种方式来设置函数执行上下文中的 this 值。

**1. 通过函数的 call 方法设置**

```js
let bar = {
  myName : "极客邦",
  test1 : 1
}
function foo(){
  this.myName = "极客时间"
}
foo.call(bar)
console.log(bar)
console.log(myName)
```

其实除了 call 方法，你还可以使用 bind 和 apply 方法来设置函数执行上下文中的 this


**2. 通过对象调用方法设置**

```js
var myObj = {
  name : "极客时间", 
  showThis: function(){
    console.log(this)
  }
}
myObj.showThis()
```

**使用对象来调用其内部的一个方法，该方法的 this 是指向对象本身的**

接下来我们稍微改变下调用方式，把 showThis 赋给一个全局对象，然后再调用该对象，代码如下所示：

```js
var myObj = {
  name : "极客时间",
  showThis: function(){
    this.name = "极客邦"
    console.log(this)
  }
}
var foo = myObj.showThis
foo()
```

**在全局环境中调用一个函数，函数内部的 this 指向的是全局变量 window。**
**通过一个对象来调用其内部的一个方法，该方法的执行上下文中的 this 指向对象本身。**


**3. 通过构造函数中设置**

```js
function CreateObj(){
  this.name = "极客时间"
}
var myObj = new CreateObj()
```

其实，当执行 new CreateObj() 的时候，JavaScript 引擎做了如下四件事：
* 首先创建了一个空对象 tempObj；
* 接着调用 CreateObj.call 方法，并将 tempObj 作为 call 方法的参数，这样当 CreateObj 的执行上下文创建时，它的 this 就指向了 tempObj 对象；
* 然后执行 CreateObj 函数，此时的 CreateObj 函数执行上下文中的 this 指向了 tempObj 对象；
* 最后返回 tempObj 对象。

```js
  var tempObj = {}
  CreateObj.call(tempObj)
  return tempObj
```

### this 的设计缺陷以及应对方案

1. 嵌套函数中的 this 不会从外层函数中继承

```js
var myObj = {
  name : "极客时间", 
  showThis: function(){
    console.log(this)
    function bar(){console.log(this)}
    bar()
  }
}
myObj.showThis()
```

函数 bar 中的 this 指向的是全局 window 对象，而函数 showThis 中的 this 指向的是 myObj 对象


你可以通过一个小技巧来解决这个问题，比如在 showThis 函数中声明一个变量 self 用来保存 this

```js
var myObj = {
  name : "极客时间", 
  showThis: function(){
    console.log(this)
    var self = this
    function bar(){
      self.name = "极客邦"
    }
    bar()
  }
}
myObj.showThis()
console.log(myObj.name)
console.log(window.name)
```

其实，这个方法的的本质是**把 this 体系转换为了作用域的体系**。

你也可以使用 ES6 中的箭头函数来解决这个问题

```js
var myObj = {
  name : "极客时间", 
  showThis: function(){
    console.log(this)
    var bar = ()=>{
      this.name = "极客邦"
      console.log(this)
    }
    bar()
  }
}
myObj.showThis()
console.log(myObj.name)
console.log(window.name)
```

因为 ES6 中的箭头函数并不会创建其自身的执行上下文，所以箭头函数中的 this 取决于它的外部函数。


2. 普通函数中的 this 默认指向全局对象 window

在默认情况下调用一个函数，其执行上下文中的 this 是默认指向全局对象 window 的。




