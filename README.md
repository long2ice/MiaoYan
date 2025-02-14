<p align="right"><strong>中文</strong> | <a href="https://github.com/tw93/MiaoYan/blob/master/README_EN.md">English</a></p>
<p align="center">
  <a href="https://miaoyan.app/" target="_blank"><img src=https://gw.alipayobjects.com/zos/k/t0/43.png width=138 /></a>
  <h1 align="center">妙言</h1>
  <div align="center">
    <a href="https://twitter.com/HiTw93" target="_blank">
      <img alt="twitter" src="https://img.shields.io/badge/follow-Tweet-blue?style=flat-square&logo=Twitter"></a>
    <a href="https://t.me/miaoyan" target="_blank">
      <img alt="Telegram" src="https://img.shields.io/badge/chat-Telegram-blueviolet?style=flat-square&logo=Telegram"></a>
     <a href="https://github.com/tw93/MiaoYan/releases" target="_blank">
      <img alt="GitHub closed issues" src="https://img.shields.io/github/downloads/tw93/MiaoYan/total.svg?style=flat-square"></a>
    <a href="https://github.com/tw93/MiaoYan/commits" target="_blank">
      <img alt="GitHub commit" src="https://img.shields.io/github/commit-activity/m/tw93/MiaoYan?style=flat-square"></a>
    <a href="https://github.com/tw93/MiaoYan/issues?q=is%3Aissue+is%3Aclosed" target="_blank">
      <img alt="GitHub closed issues" src="https://img.shields.io/github/issues-closed/tw93/MiaoYan.svg?style=flat-square"></a>
  </div>
  <div align="center">轻灵的 Markdown 笔记本伴你写出妙言~</div>
</p>

<kbd>
  <img src=https://gw.alipayobjects.com/zos/k/4f/ch.gif width=1000>
</kbd>

## 特点

- 🪂 **妙**：纯本地使用、安全、语法高亮、黑暗模式、源文件保存、国际化、演示模式、文档自动排版、图床、LaTeX、Mermaid、PlantUML
- 🐶 **美**：极简的设计风格，文件夹 + 文件列表 + 编辑器方式 3 列模式
- 🏌🏽‍♂️ **快**：使用 Swift5 原生开发，相比 Web 套壳方式性能体验好
- 🩴 **简**：很轻巧，纯编辑器输入体验，众多快捷键助你快人一步

## 为什么要做妙言

- 之前有尝试过众多的笔记应用，大学时期为知笔记、印象笔记，工作时候用过 Ulysses(无预览)、Quiver(多年不更新)、MWeb(功能复杂)、Bear(Markdown 图片等富格式不支持)、Typora(不习惯所见所得模式)，种种原因，没有找到一个好用的 Markdown 应用，才有了做妙言的想法。
- 本职工作为前端开发，会一点 iOS 开发，喜欢折腾，借妙言来玩一下 Swift 以及 macOS 开发，当做一个很愉快的事情。

## 下载

- 从 <a href="https://github.com/tw93/MiaoYan/releases/latest" target="_blank">GitHub Releases</a> 中下载最新的 MiaoYan.dmg 安装包，双击安装即可。
- 如果在国内下载速度很慢，你可以试试 <a href="https://miaoyan.app/Release/MiaoYan.dmg" target="_blank">Vercel</a> 来下载最新版本。

## 使用Brew安装

```shell
brew install miaoyan --cask
```

## 初始化使用

1. 可以在 iCloud 或根目录下创建一个 `MiaoYan` 的文件夹，打开妙言的设置，将默认存储地址修改成这个。
2. 点击妙言左上角新增文件夹的图标，创建好自己的文档分类文件夹，就可以开始使用了。
3. 同样假如你不习惯默认的字体，可以在设置中修改成其他的正常字体。

## 快捷键

#### 窗口操作

- `command + 1`：收起展开目录
- `command + 2`：收起展开文档列表
- `command + 3`：切换编辑和预览
- `command + 4`：切换到演示模式

#### 文件操作

- `command + d`：复制文档
- `command + r`：重命名文档
- `command + i`：在文件中显示文档
- `command + shift + p`：pin 置顶文档
- `command + delete`：删除文档
- `command + shift + l`：自动排版

🏂 此外还有很多快捷键等着爱折腾的你去寻找~

## 支持

- 我有两只猫，一只叫汤圆，一只叫可乐，假如觉得妙言让你生活更美好，可以给汤圆可乐 <a href="https://miaoyan.app/cats.html" target="_blank">喂罐头 🥩🍤</a>。
- 如果你喜欢妙言，可以在 Github Star，更欢迎推荐给你志同道合的朋友使用。

## 感谢

- <a href="https://github.com/KristopherGBaker/libcmark_gfm" target="_blank">KristopherGBaker/libcmark_gfm</a>：适用于 cmark-gfm 的 Swift 兼容框架
- <a href="https://github.com/Remix-Design/RemixIcon" target="_blank">Remix-Design/RemixIcon</a>：简洁的 icon
- <a href="https://github.com/draveness/NightNight" target="_blank">draveness/NightNight</a>：黑暗模式
- <a href="https://github.com/raspu/Highlightr" target="_blank">raspu/Highlightr</a>：语法高亮能力
- <a href="https://github.com/glushchenko/fsnotes" target="_blank">glushchenko/fsnotes</a>：妙言部分初始化代码来源于此
- <a href="https://github.com/shpakovski/MASShortcut" target="_blank">hpakovski/MASShortcut</a>：快捷键插件
- <a href="https://github.com/lxgw/LxgwWenKai" target="_blank">lxgw/LxgwWenKai</a>：一款漂亮的开源中文字体，妙言将其作为默认字体
- <a href="https://github.com/X140Yu/pangu.Swift" target="_blank">X140Yu/pangu.Swift</a>：中文和英文之间没有空格可怎么行？
- <a href="https://github.com/sivan/heti" target="_blank">sivan/heti</a>：专为中文内容展示设计的排版样式增强

# 协议

- 遵循 MIT 协议
- 请自由地享受和参与开源
