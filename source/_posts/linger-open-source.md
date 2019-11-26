---
title: Linger - 又一个音乐文字类微信小程序
date: 2019-11-25 21:57:27
tags: [ 'mini-program', 'open source' ]
categories: 
- Project
---
> 我没有不惑，只求在回望中结果，谁为我们生造矛盾这么多？ ---- 《弥留》

<!-- more -->

## 又一个音乐文字类微信小程序？

距离我上一个小程序开源已经过去一年多了，10 Mississippi开源之后就几乎没有再维护过，一方面因为没能上线当时确实觉得写了这么久的小程序白费了，另一方面去年的那个时候我正面临着找实习+开始毕业论文的紧张时期，也确实没有太多时间去做维护了。之后有点时间之后也想过把10 Mississippi完善一下，可笑的是，太长时间没有管它，再想去完善有点找不到当时的逻辑了。（主要当时代码写的真的太乱了）

Anyway，最近看到一些小程序新的开源框架就有点手痒，思来想去决定开始动手。开发个什么类型的小程序呢？想来想去自己也就喜欢听听歌，偶尔看看鸡汤这点兴趣了。所以最后还是选择了音乐文字这一类别。~~（没有上线打算）~~ 这一次选择了[Tarojs]( https://taro-docs.jd.com/taro/docs/README.html ) 这个小程序框架，相比一年前，感觉开发起来也更轻松了，得益于小程序的日渐完善，以前的一些功能实现起来也更加容易了（也有可能是自己之前没仔细看文档）。前前后后从项目创建到有了雏形，差不多用了两个月时间（总工作时间可能就两三天吧，我实在太能拖了）。终于在昨天，开发完文章详细页面之后，小程序集齐了六张程序截图，所以我今天就迫不及待要把他“裱”在博客里！

## 为什么是Linger？

Linger的意思是停留，但叫Linger不是我的本意。在写这个小程序那段时间，我一直在循环听《弥留》这首歌，觉得这首歌无论歌词和调都是我喜欢的类型，所以当时就给这个小程序取名叫“弥留”。但是之后小程序注册的时候，要上传Logo，中文的Logo实在是太难做了，我急需一个英文名字好直接套字体做Logo，才给这个小程序取名Linger弥留。（推荐大家听一听《弥留》这首歌）

## 关于小程序设计

我是有学前端啦，但是页面设计真的烂到没话说，这次小程序的设计也是和前作水平旗鼓相当。尽管我已经很克制的希望做出来的小程序不要和前作太过相似，但多少还是有点影子。不过好在我心态够好，直接坦然接受了 {% github_emoji frowning %}

## 程序截图

是的，没有错，又到了我最最喜欢的6图时刻！

<img src="https://s2.ax1x.com/2019/11/17/MD7YE4.md.jpg" width="30%" style="margin-right: 10px; border: 1px solid #000; float: left;" /><img src="https://s2.ax1x.com/2019/11/17/MD7tUJ.md.jpg" width="30%" style="margin-right: 10px; border: 1px solid #000; float: left;" /><img src="https://s2.ax1x.com/2019/11/24/MXNTjH.md.png" width="30%" style="margin-right: 10px; border: 1px solid #000; float: left;" />

<img src="https://s2.ax1x.com/2019/11/20/Mh80AK.md.png" width="30%" style="margin-right: 10px; border: 1px solid #000; float: left;" /><img src="https://s2.ax1x.com/2019/11/24/MXNoge.md.png" width="30%" style="margin-right: 10px; border: 1px solid #000; float: left;" /><img src="https://s2.ax1x.com/2019/11/17/MD7N59.md.png" width="30%" style="margin-right: 10px; border: 1px solid #000; float: left;" />

<div style="clear: both;"></div>

## 怎么运行？

克隆本项目：[https://github.com/getatny/linger](https://github.com/getatny/linger)，执行：

```bash
npm install && npm run dev:weapp
```

或

```bash
yarn install && yarn dev:weapp
```
