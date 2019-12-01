---
title: 翻译 | 代数效应（Algebraic Effects）
date: 2019-11-20 09:44:23
tags: [ 'Translate', 'React', 'Javascript' ]
categories: 
- Front-end
no-emoji: true
---
> 英文原文：[Algebraic Effects for the Rest of Us](https://https://overreacted.io/algebraic-effects-for-the-rest-of-us/)

你之前听过说“代数效应”（Algebraic Effects）吗？

我之前曾尝试着去搞清楚什么是代数效应以及我们为什么需要关注它，但是失败了。我找到了一些[pdf](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/08/algeff-tr-2016-v2.pdf)，但是这些东反而让我更迷惑了。（有一些学校的pdf看的我想睡觉）

但是我的同事 Sebastian 一直推荐把它作为在开发React时的心智模型。（Sebastian在React团队工作并且想出了很多ideas，包括Hooks和Suspense）从某些点来说，它已经变成了React团队内的一个梗，我们很多的对话都会以下图结束：

<!-- more -->

<div align="center">

![running joke](https://s2.ax1x.com/2019/11/20/MWSbVO.jpg)

</div>

结果是代数效应并不像我一开始看到那些pdf的时候以为那么吓人，反而是一个很酷的概念。**如果你只是单纯使用React的话，其实不需要了解它 ---- 但如果你像我一样对它很好奇的话，请继续往下读。**

## 生产环境还不能使用哦

代数效应是一个理论性的功能。这意味着它不像 `if` ，函数，甚至 `async / await` 那样，**你可能不能在生产环境真正使用它。**它只被少数为了探索该想法而创建的[语言](https://www.microsoft.com/en-us/research/project/koka/)所支持。OCaml在使其能在生产环境中使用有所进展，但也只是“[仍在进行中...](https://github.com/ocaml-multicore/ocaml-multicore/wiki)”。换句话说就是[你不能用呗](https://www.youtube.com/watch?v=otCpCn0l4Wo)。

> 笔者：有些人提到LISP语言提供了一些[类似的特性](https://overreacted.io/algebraic-effects-for-the-rest-of-us/#learn-more)，所以如果你在使用LISP的话，你可以将其用在生产环境上。

## 我为什么要关注代数效应？

想象你现在正在使用 `goto` 关键字编写程序，然后某个人向你展示了 `if` 和 `for` 语句。或者可能你正在回调地狱中无法自拔，某个人却突然告诉你有 `async / await`！很酷对吧？

如果你是那种喜欢在某种编程想法成为主流的前几年就开始学习它的人，现在可能就是你对代数效应开好奇的最好时机。但也不用觉得你非得学不可。它其实有点像在1999年去思考 `async / await`。

## 那什么是代数效应（Algebraic Effects）呢？

光看名字可能有一点吓人，但其实它的思想挺简单的。如果你对 `try / catch` 块很熟悉的话，你会很快搞清楚代数效应的。

首先让我们概括下 `try / catch`。假设你有一个函数抛出了异常。可能在该函数和 `catch` 块之间还有一些函数：

```javascript
function getName(user) {
  let name = user.name;
  if (name === null) {
  	throw new Error('A girl has no name');
  }
  return name;
}

function makeFriends(user1, user2) {
  user1.friendNames.add(getName(user2));
  user2.friendNames.add(getName(user1));
}

const arya = { name: null };
const gendry = { name: 'Gendry' };
try {
  makeFriends(arya, gendry);
} catch (err) {
  console.log("Oops, that didn't work out: ", err);
}
```

我们在 `getName` 里面抛出异常，但是该异常通过 `makeFriends` “冒泡”被最近的 `catch` 块捕获，这是 `try / catch` 的一个重要作用。**在中间的部分不需要自己去考虑怎么处理error。**

不像C语言中处理error的代码，通过 `try / catch`，你不需要因为害怕丢失error而在每一个中间层手动的传递它们。他们自己会自动地进行传递。

## 这与代数效应有什么关系？

上面的例子中，一旦出现错误，程序将不再继续执行。当 `catch` 块中的代码执行完之后，没有任何办法能让我们继续执行处处出错时的代码。

我们能做的就是从错误中恢复过来并使用某种方法重试我们之前想要做的，却不能魔法般地“回到”我们发生错误的时刻去做一些和之前不同的事儿。但是有了代数效应，We can！

下面时一个用假设的javascript伪代码编写的例子（让我们娱乐性的将其称为ES2025的语法），该语法让我们可以从丢失 `user.name` 的时刻恢复：

```js
function getName(user) {
  let name = user.name;
  if (name === null) {
  	name = perform 'ask_name'; // important
  }
  return name;
}

function makeFriends(user1, user2) {
  user1.friendNames.add(getName(user2));
  user2.friendNames.add(getName(user1));
}

const arya = { name: null };
const gendry = { name: 'Gendry' };
try {
  makeFriends(arya, gendry);
} handle (effect) {
  if (effect === 'ask_name') { // important
  	resume with 'Arya Stark'; // important
  }
}
```

（我向所有在2025年通过搜索“ES2025”关键字找到这篇文章的读者道歉，如果代数效应到时候已经称为JavaScript的一部分，我将很乐意去更新该文章！）

我们使用了一个假设的关键字 `perform` 去替代 `throw`，类似的，使用假设的 `try / handle` 替代 `try / catch` 。**该语法的准确写法在这里并不重要 ---- 我只是想通过某些东西去解释代数效应的思想。**

所以会发生什么呢？让我们仔细看一下。

我们 `perform` 了一个效应（effect）而不是抛出一个错误（error）。就像我们可以抛出任何值一样，我们也可以传递任何值给 `perform`。在这个例子中，我传递是一个字符串，但你完全可以传递一个对象或任何其他的数据类型：

```js
function getName(user) {
  let name = user.name;
  if (name === null) {
  	name = perform 'ask_name'; // important
  }
  return name;
}
```

当我们抛出一个错误的时候，引擎会通过调用栈去查找最近的一个 `try / catch` 异常处理块。我们 `perform` 一个效应的时候也是一样，引擎将会在调用栈中搜索最近的 `try / handle` 效应处理块：

```js
try {
  makeFriends(arya, gendry);
} handle (effect) { // important
  if (effect === 'ask_name') {
  	resume with 'Arya Stark';
  }
}
```

这个 `effect` 可以让我们自己决定怎么去处理姓名丢失的情况，有趣的地方在于假定的 `resume with`（相较于异常来说）：

```js
try {
  makeFriends(arya, gendry);
} handle (effect) {
  if (effect === 'ask_name') {
  	resume with 'Arya Stark'; // important
  }
}
```

这是 `try / catch` 所做不到的。它使我们**跳回我们perform效应的时刻，并从handler传递一些内容给它。** {% github_emoji hushed %}

```js
function getName(user) {
  let name = user.name;
  if (name === null) {
  	// 1. 我们在这儿perform了一个效应
  	name = perform 'ask_name';
  	// 4. ...handler代码执行结束之后会回到这儿，现在 name 的值为'Arya Stark'
  }
  return name;
}

// ...

try {
  makeFriends(arya, gendry);
} handle (effect) {
  // 2. 通过引擎找到最近的 try / handle，我们将跳到这里（就像 try / catch 的逻辑一样）
  if (effect === 'ask_name') {
  	// 3. 和 try / catch 不同的是，我们可以通过resume恢复，并向其传递一些值
  	resume with 'Arya Stark';
  }
}
```

需要一点时间去适应这些变化，但从概念上来讲它和可恢复的 `try / catch` 真的没多大的区别。

需要注意的是，**代数效应比 try / catch 要灵活太多了，并且“错误恢复”只是它众多可能的使用场景中的一个。**我以“错误恢复”为例只是因为我觉得它比较容易囊括我关于它想要描述的东西。

## 函数没有“颜色”

代数效应对于异步代码来说有着有趣的含义。

对于拥有 `async / await` 语法的编程语言来说，[函数通常有“颜色”](https://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/)。举个栗子，在JavaScript中，我们无法在不感染 `makeFriends` 函数及其调用者，使其成为异步函数的情况下将 `getName` 函数修改为异步函数。这在某些代码需要同步，而另一些代码需要异步的时候真的很痛苦。

```js
// 如果你想把该函数改为异步函数的话
async getName(user) {
  // ...
}

// 这个函数也得修改为异步函数
async function makeFriends(user1, user2) {
  user1.friendNames.add(await getName(user2));
  user2.friendNames.add(await getName(user1));
}

// makeFriends 函数的调用者也是如此
```

JavaScript generators也是[类似](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*)的：如果你使用了generators，那么中间相关的东西也需要注意generators。

那么，这又和代数效应有什么关系呢？

让我们忘掉 `async / await` 回到我们的例子中：

```js
function getName(user) {
  let name = user.name;
  if (name === null) {
  	name = perform 'ask_name'; // important
  }
  return name;
}

function makeFriends(user1, user2) {
  user1.friendNames.add(getName(user2));
  user2.friendNames.add(getName(user1));
}

const arya = { name: null };
const gendry = { name: 'Gendry' };
try {
  makeFriends(arya, gendry);
} handle (effect) {
  if (effect === 'ask_name') { // important
  	resume with 'Arya Stark'; // important
  }
}
```

如果effect handler不能同步地知道“备用姓名”怎么办？如果我们想要从某个数据库中获取姓名呢？

结果是，我们可以在effect handler中异步地调用 `resume with` 并且不需要对 `getName` 或 `nakeFriends` 函数做任何的改动：

```js
function getName(user) {
  let name = user.name;
  if (name === null) {
  	name = perform 'ask_name';
  }
  return name;
}

function makeFriends(user1, user2) {
  user1.friendNames.add(getName(user2));
  user2.friendNames.add(getName(user1));
}

const arya = { name: null };
const gendry = { name: 'Gendry' };
try {
  makeFriends(arya, gendry);
} handle (effect) {
  if (effect === 'ask_name') { // important
  	setTimeout(() => { // important
      resume with 'Arya Stark'; // important
  	}, 1000); // important
  }
}
```

在这个例子中，我们在一秒钟之后才调用 `resume with`。你可以把 `resume with` 想象成值调用一次的回调函数。（你也可以将其称作“one-shot delimited continuation”给你的朋友留下深刻印象。~~翻译无能~~）

现在，代数效应的工作原理应该更清晰一些了。当我们抛出一个错误的时候，JavaScript引擎会“释放栈”，从进程中销毁本地变量。而当我们 `perfofm` 一个效应的时候，我们假定的引擎将会创建一个包含我们余下函数的回调，并通过 `resume with` 调用它。

**再次强调一下：本文中使用的任何关于代数效应的语法和关键字都是虚构的，它们并不是关键点，关键点在于代数效应的思想及工作原理。**

## 关于“纯”

值得注意的是，代数效应概念来自于函数式编程研究，所以它解决的某些问题是特定于纯函数编程的。举个栗子，在不允许任何副作用的编程语言中（如Haskell），你需要通过使用像Monads一类的额概念来编写函数，如果你以前阅读过Monads的教程的话，你应该知道它的概念是有一点难理解的。而代数效应能在较少的代价下实现类似的东西。

这也正是很多关于代数效应的讨论对我来说难以理解的原因。（我[不了解](https://overreacted.io/things-i-dont-know-as-of-2018/)Haskell和朋友~~（？）~~）但不管怎么说，我还是觉得即便是在像JavaScript这样不那么“纯”的编程语言中，**代数效应也是在代码中分类内容和方法的强大工具。**

它使得你能够更专注于你正在做的事情：

```js
function enumerateFiles(dir) {
  const contents = perform OpenDirectory(dir); // important
  perform Log('Enumerating files in ', dir); // important
  for (let file of contents.files) {
  	perform HandleFile(file); // important
  }
  perform Log('Enumerating subdirectories in ', dir); // important
  for (let directory of contents.dir) {
  	// 我们可以使用递归或其他带有效应的函数
  	enumerateFiles(directory);
  }
  perform Log('Done'); // important
}
```

然后再用具体怎么去处理的方法包裹它：

```js
let files = [];
try {
  enumerateFiles('C:\\');
} handle (effect) {
  if (effect instanceof Log) {
  	myLoggingLibrary.log(effect.message); // important
  	resume; // // important
  } else if (effect instanceof OpenDirectory) {
  	myFileSystemImpl.openDir(effect.dirName, (contents) => { // important
      resume with contents; // important
  	}); // important
  } else if (effect instanceof HandleFile) {
    files.push(effect.fileName); // important
    resume; // important
  }
}
// 'files' 数组现在包含了所有的文件
```

这意味着这些处理片段甚至可以类库化：

```js
import { withMyLoggingLibrary } from 'my-log';
import { withMyFileSystem } from 'my-fs';

function ourProgram() {
  enumerateFiles('C:\\');
}

withMyLoggingLibrary(() => {
  withMyFileSystem(() => {
    ourProgram();
  });
});
```

和 `async / await` 或 Generators 不太一样的是，代数效应并不需要复杂的“中间”函数。我们可以在 `onProgram` 函数的任何层级调用我们定义的 `enumerateFiles` 函数，只要在上层任意地方有一个effect handler，那么每一个effect就都会被perform，我们的代码就可以正常运作。

Effect handler让程序逻辑在不花费太多代价或编写样板代码的情况下与它实际的effect实现解耦。比如，我们可以在测试中使用虚拟的文件系统去完全重写保留log的行为，而不是仅仅把它们打印到控制台。

```js
import { withFakeFileSystem } from 'fake-fs';

function withLogSnapshot(fn) {
  let logs = [];
  try {
  	fn();
  } handle (effect) {
  	if (effect instanceof Log) {
  	  logs.push(effect.message);
  	  resume;
  	}
  }
  // Snapshot emitted logs.
  expect(logs).toMatchSnapshot();
}

test('my program', () => {
  const fakeFiles = [/* ... */];
  withFakeFileSystem(fakeFiles, () => { // important
  	withLogSnapshot(() => { // important
	  ourProgram(); // important
  	}); // important
  }); // important
});
```

因为这里没有任何的“函数标志”（中间的代码不需要在意effects）并且effect handler是可组合的（你可以嵌套他们），所以你可以用它们来创建极具表现力的抽象函数。

## 关于类型

因为代数效应源自于静态类型语言，所以关于它的很多争论都围绕着它在类型中的表达方式。这肯定是毫无疑问的，但同时也使得掌握它的概念成为了一种挑战。也正是由于这个原因，所以这篇文章完全没有提到类型。但是！我需要提醒你的是，事实上一个可以执行效果的函数都会被编码成它的类型签名。因此你不应该陷入effects随机发生并且你无法确定它从哪儿出现的情况。~~（不懂）~~

你可能会争论说代数效应技术上来说在静态类型语言中是给函数打上“标记”了的，因为effect正式类型签名的一部分！这样的说法是正确的，但是修复中间函数的类型注释以包括新的效果本身并不是语义上的更改 ---- 与添加 `async` 或将一个函数转换为 `generator` 不同。结论也可以帮助避免级联更改。一个重要的区别是，你可以通过提供一个noop或一个虚拟的实现去“增强”effect（例如同步的去调用一个异步函数），这使你可以在必要时阻止其到达外部代码，或将其转换为不同的effect。

> 未完待续
