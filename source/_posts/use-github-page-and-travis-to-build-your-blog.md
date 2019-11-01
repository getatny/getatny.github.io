---
title: 使用Github page + Travis构建你的个人博客
date: 2019-10-31 15:58:12
tags: [ 'github page', 'Travis' ]
---
在公司上班的时候，遇到棘手问题被解决，就会想要随手记录一下解决办法。但是由于公司网络限制，并不是所有网站我都可以访问，这中间就包括我个人的博客。一直以来我都用印象笔记的网页端来记录问题，总的来说印象笔记用来记笔记或者纯文字文档很不错，但是像编程类文章并不是很适合。一方面，印象笔记不支持代码高亮，另一方面图文排版也是一个问题。于是我萌生了使用github写博客的想法。

> Github page并不是一个新事物，所以本文也不是所谓的技术文，更多的，算是我的一个学习笔记吧。

没怎么对比选择了Hexo作为博客的框架，在大概了解了github page的逻辑之后，我个人觉得其实本质上来说就是静态文件，所以理论上你甚至可以使用`Gatsbyjs`之类的工具来构建你的GitHub page。

# 准备工作

下面简短说一下怎么开通自己的github page：

1. 注册一个[github](https://github.com)账号
2. 新建一个Repo，名字命名为：<username>.github.io，这里的username就是你github账号的用户名，后面的部分是固定的，组成的这个域名也是你github page生成之后对外的访问域名。

完成以上工作之后，进入你新建的Repo，打开Settings，拉到底部能够看到`GitHub Pages`这个部分，证明你的github page已经生效了。你可以点击`choose theme`切换一个由github提供的主题体验github page，也可以像我一样，迅速通过使用某个静态博客框架生成自己的博客页面。

# Hexo

[Hexo](https://hexo.io/zh-cn/)的介绍和优缺点我就不多说了，想要详细了解的可以去官网查看详情。前面也说了，github page其实就是帮我们host了一个静态的网页，使其能够在公网上访问，所以我们是可以上传多个html（样式相同或不同）作为展示页或文章页的，但这样重复的工作就会特别多，Hexo帮我们解决了这个问题，我们只需要专注于写作（markdown），其他的则由Hexo自动为我们完成。

想要使用Hexo，需要在本地环境装载`Nodejs`，可以通过下面的命令查看本机是否已经存在`Nodejs`：

```bash
node -v
```

确定已有Node之后，就可以使用npm在本地全局安装Hexo的CLI工具了

```bash
npm i hexo-cli -g
```

> npm安装失败或者慢的话，清自行将npm的registry更换为阿里镜像

Hexo-cli安装成功之后，便可以在你工作的文件夹下创建`hexo`文件夹并运行`hexo init`初始化一个hexo博客。在hexo初始化结束之后，运行`hexo g`便可生成你博客需要的静态文件（public文件夹下），之后你也可以运行`hexo s`可以在本地4000端口启动一个Hexo自带的server体验你刚生成的博客。 

# 如何通过github page访问？

在文章开始已经说过，github page托管的就是你博客的静态文件，所以想要通过github page访问你的博客，你需要做的就是将你的通过`hexo g`生成的静态文件push到你创建的`<username>.github.io`Repo的master branch下。