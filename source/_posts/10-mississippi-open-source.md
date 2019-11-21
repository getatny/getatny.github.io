---
title: 10 Mississippi - 音乐文字类小程序开源
date: 2018-06-18 11:17:22
tags: [ 'mini-program', 'open source' ]
categories: 
- Project
top: 1
---
{% fi https://s2.ax1x.com/2019/11/16/MBkYqJ.png, cover, 10 Mississippi - 音乐文字类小程序开源 %}

## 关于 10 Mississippi

10 Mississippi 是一款基于 Wepy 框架开发的音乐文学类小程序。

创作该小程序的初衷原本是自己想要有一个能够推荐自己喜欢的音乐的小程序，有了这样的想法之后，就开始着手一边设计一边看小程序api码代码。经历了写写停停差不多两个月的时间终于前后端都到了可以发beta版的时候，突然发现微信开放平台个人账户是没办法发布和音乐有关的小程序的。 内心崩溃之余想了想决定开源，本来也不是什么特别高端的小程序，如果能给大家在实际开发中带来一点点灵感就很满足了。

<!-- more -->

## 小程序截图

以下图片均可点击预览大图

<img style="margin-right: 10px; border: 1px solid #000; float: left;" src="https://raw.githubusercontent.com/wiki/getatny/10mississippi/1.png" width="30%" />
<img style="margin-right: 10px; border: 1px solid #000; float: left;" src="https://raw.githubusercontent.com/wiki/getatny/10mississippi/2.png" width="30%" />
<img style="margin-right: 10px; border: 1px solid #000; float: left;" src="https://raw.githubusercontent.com/wiki/getatny/10mississippi/3.png" width="30%" />
<img style="margin-right: 10px; border: 1px solid #000; float: left;" src="https://raw.githubusercontent.com/wiki/getatny/10mississippi/4.png" width="30%" />
<img style="margin-right: 10px; border: 1px solid #000; float: left;" src="https://raw.githubusercontent.com/wiki/getatny/10mississippi/5.png" width="30%" />
<img style="margin-right: 10px; border: 1px solid #000; float: left;" src="https://raw.githubusercontent.com/wiki/getatny/10mississippi/6.png" width="30%" />
<div style="clear: both;"></div>

---

## 项目地址

PS：喜欢的话，希望能给这个项目点个star，谢谢！！如果在使用上有任何问题欢迎留言或发issue给我。

[https://github.com/getatny/10mississippi](https://github.com/getatny/10mississippi)

## 如何运行？

该小程序使用 wepy 框架敏捷开发，不同于原生微信小程序开发，该框架引入了webpack对代码和资源进行打包。所以首先你需要确保你的电脑上已经安装了Node。

Node安装成功之后，你的电脑上应该同时安装了npm，你可以使用以下代码验证（之后请安装wepy-cli，具体请上wepy官网查看）：

```bash
node -v && npm -v
```

确认Node及npm安装成功之后，在命令行中将目录切换到你clone的小程序的项目根目录下。执行以下代码

```bash
npm i
```

P.S 由于一些你懂的原因，在你执行以上代码之后，可能会出现长时间未响应的情况。请自行百度npm淘宝镜像安装cnpm。在该项目相关的依赖安装完成之后，在项目根目录执行：

```bash
npm run dev
```

之后打开微信小程序开发工具，加载该项目即可看到小程序运行效果。
