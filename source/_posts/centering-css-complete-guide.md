---
title: 翻译 | CSS居中：完全指南
date: 2018-06-22 10:27:59
tags: [ 'Translate', 'CSS' ]
categories: 
- Front-end
---
{% fi https://s2.ax1x.com/2019/11/16/MBZxAJ.png, cover, 翻译 | CSS居中：完全指南 %}

> 英文原文：[Centering in CSS: A Complete Guide](https://css-tricks.com/centering-css-complete-guide/)

如何使用CSS居中网页中的内容是CSS最典型的被抱怨的地方。为什么CSS居中这么难呢？我觉得，问题的本身不是它代码有多难写，而是有太多不同的方法可以做到居中，在这样的情况下，我们反而很难弄清楚选择哪种方法可以实现我们想要的效果。

所以，今天就让我们来制作一个决策树，希望通过这样的方式能够使CSS居中这件事变得容易一些。

<!-- more -->

---

## 水平居中
### 居中inline或者inline-*的元素？（比如text或links）

你可以在一个块级元素中像这样水平居中行级元素：

```css
.center-children {
    text-align: center;
}
```

这种写法对于`inline`, `inline-block`, `inline-table`, `inline-flex`等都能生效。

### 居中块级元素？

你可以通过给块级元素声明`margin-left`和`margin-right`属性，且值为`auto`（注意该元素需要设定宽度，否则他的宽度和父元素一样宽就没有居中这一说了）。通常我们通过这样的简便写法来实现：

```css
.center-me {
    margin: 0 auto;
}
```

这种写法无论块级元素及其父元素的宽度大小怎样都能实现居中。

注意：你不能通过`float`属性居中元素。

### 多个块级元素居中？

如果你需要在一行里面水平居中两个甚至多个块级元素的话，你需要改变他们的`display`类型。下面分别是一个改变`display`类型为`inline-block`的例子和一个`flexbox`的例子：

<figure><iframe src="//jsrun.net/UXgKp/embedded/all/dark/" width="100%" height="300" allowfullscreen="allowfullscreen"></iframe></figure>

除非你意思是你只是单纯想要把多个块级元素居中，且他们还是按照原本的顺序垂直排列下来。这种情况下值为auto的`margin`仍然可以生效：

<figure><iframe src="//jsrun.net/9XgKp/embedded/all/dark/" width="100%" height="300" allowfullscreen="allowfullscreen"></iframe></figure>

---

## 垂直居中

CSS中实现垂直居中有一点点复杂

### 居中inline或者inline-*的元素？
#### 单独一行？

有时候`inline` / `text`元素可以简单通过给他一个上下相等的`padding`显示为垂直居中。

但是如果你打算居中一些你**经确定不会换行**的文字，且因为某些原因你没有办法使用`padding`的话，有一个小技巧：将`line-height`属性设置的和高度相等，就能实现这些文字的垂直居中。

```css
.center-text-trick {
    height: 100px;
    line-height: 100px;
    white-space: nowrap;
}
```

> 注意：这里所谓的居中指的是在某一个元素中的居中，而不是相对于整个窗口的居中！

#### 多行？

理论上说相等的上下`padding`也可以垂直居中多行文字，但是如果那样的做法没有效果的话，也许我们可以将该文本元素放在表单中，也可以是字面上或通过CSS使得该元素展示的像表单元素（display: table-cell）。在这种情况下，`vertical-align`属性不像通常解决元素在行中对齐那样解决该问题。

如果类似table的方法不能使用的话，也许你可以试试`flexbox`？flex类型的子元素可以很容易的在一个flex类型的父元素中居中。

```css
.flex-center-vertically {
    display: flex;
    justify-content: center;
    flex-direction: column;
    height: 400px;
}
```

记住这种写法只在父元素有固定的高度（px, % 等）时才有实质性的作用，这也是为什么我例子的代码中声明了400px的高度的原因。

如果上面写的两种方法你都不能使用，你可以采用百分百高度的假元素 -- “伪类”去代替父元素容纳子元素的部分，然后文本元素相对于这个伪类垂直居中。~~（译者表示自己都看不懂这种操作！）~~

```css
.ghost-center {
    position: relative;
}

.ghost-center:before {
    content: '';
    display: inline-block;
    height: 100%;
    width: 1%;
    vertical-align: middle;
}

.ghost-center p {
    display: inline-block;
    vertical-align: middle;
}
```

### 居中块级元素？
#### 你知道该元素的高度？

不知道网页布局的高度是很常见的，原因很多：

1. 如果`width`改变，文本重排会改变元素高度；
2. CSS对文本的样式的改变会改变元素高度；
3. 文本数量的改变会改变元素高度；
4. 有着固定宽高比的元素，比如：`image`重置大小时会改变元素高度；
5. ... ...

但是如果你确实知道元素的高度的话，你可以像这样垂直居中：

```css
.parent {
    position: relative;
}

.child {
    position: absolute;
    top: 50%;
    height: 100px;
    margin-top: -50%; /*如果没有使用box-sizing: border-box的话，还需要加上padding和border高度*/
}
```

#### 不知道元素高度？

上面那种通过在将子元素下移父元素50%再向上移动子元素自身高度一半的方法在这种情况下仍然可以使用：

```css
.parent {
    position: relative;
}

.child {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
}
```

> 译者按：transform是CSS3中新增的属性，它的作用其实是用来进行图像2D、3D转换（旋转、缩放、移动和倾斜），这里我们通过translateY来对该元素进行Y轴方向的移动，移动的值为自身Y轴方向数值（即高）的一半。

#### 你可以使用flexbox吗？

通过使用flexbox可以超级轻松的实现垂直居中：

```css
.parent {
    display: flex;
    flex-direction: column;
    justify-content: center;
}
```

---

## 垂直方向水平方向都要居中？

你可以组合以上所说的任何技术来完美的实现两个方向的居中。但是我发现通常来说，使用的都是以下几种方法：

### 该元素是否拥有固定的宽和高？

在你将其设置为top: 50%, left: 50%的绝对位置后将`margin`设置为该元素宽高的负值会实现一个跨浏览器支持较好的居中效果：

```css
.parent {
    position: relative;
}

.child {
    width: 300px;
    height: 100px;
    padding: 20px;

    position: absolute;
    top: 50%;
    left: 50%;

    margin: -70px 0 0 -170px;
}
```

### 该元素宽高未知？

如果你不知道元素的宽高，你可以使用transform属性和两个方向上-50%的translate来实现居中（基于当前元素的宽高来居中）：

```css
.parent {
  position: relative;
}

.child {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```

### 可以使用flex布局吗？

使用flex布局实现两个方向上的居中，你需要使用下面两个居中属性：

```css
.parent {
  display: flex;
  justify-content: center;
  align-items: center;
}
```

### 可以使用grid吗？

这是单个元素两个方向上居中的小技巧（由Lance Janssen提供）：

```css
body, html {
  height: 100%;
  display: grid;
}

span { /* 这里是你要居中的元素 */
  margin: auto;
}
```

---

## 总结

Emmm，作者写了这么多，译者翻译这么久，所以你知道在各种情况下怎么实现居中了吗？
