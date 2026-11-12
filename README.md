# RocheLimit

RocheLimit 是洛汐（Limity'roChen）为日常写作制作的一套 [Typst](https://typst.app/) 排版模板：采用偏向 LaTeX 文档的衬线字体风格，为中英文短文、公告、技术笔记和 CTF Writeup 提供开箱即用的版式。

当前仓库提供 **Drift** 的中文和英文版本。Drift 不设独立封面，着重于轻量的短篇文档排版；长篇出版物不在它的主要适用范围内。项目示例中提到的 Surge 尚未包含在当前仓库中。

## 特性

- **中英文版式**：分别配置语言、段首缩进、日期格式和目录标题。
- **简洁的文档信息区**：支持标题、多作者、单位、邮箱、日期、版本及自定义页眉；作者每行最多三位。
- **统一的正文样式**：A4 页面、页码、两端对齐，以及标题、图表、脚注、链接和目录的样式配置。
- **代码排版**：集成 Codly 与语言配置，设置中西文等宽字体。
- **轻量扩展**：提供适合提示信息的 Callout 块和面向 CTF 场景的 Flag 块。
- **完整示例**：演示数学公式、代码、分栏、图表、参考文献及可复用脚注。

## 环境与依赖

需要安装 [Typst CLI](https://github.com/typst/typst)；当前模板已在 **Typst 0.15.1** 上验证。

模板使用以下字体，建议安装后再编译，以获得预期效果：

| 用途 | 字体 |
| --- | --- |
| 西文正文 | TeX Gyre Schola |
| 中文正文 | Noto Serif CJK SC |
| 西文代码 | Latin Modern Mono 8 |
| 中文代码 | LXGW WenKai Mono |

字体缺失时可能出现警告或使用替代字体，版面也可能与预期不同。可用 `typst fonts` 检查可用字体；非系统字体目录可通过编译命令的 `--font-path` 参数指定。

模板还会导入以下 Typst Universe 包，首次使用时需要联网下载；离线使用前请先准备好相应包缓存：

- `@preview/m-jaxon:0.1.2`
- `@preview/codly:1.3.0`
- `@preview/codly-languages:0.1.1`

## 快速开始

获取本仓库后，在仓库根目录新建 `main.typ`：

```typst
#import "rochelimit/drift-zh.typ": *

#show: rl-content.with(
  title: [我的第一篇 RocheLimit 文档],
  authors: (
    (
      name: [作者姓名],
      organization: [所属组织],
      email: "author@example.com",
    ),
  ),
  date: datetime(year: 2026, month: 11, day: 12),
  version: [0.1.0],
)

#outline()

= 开始写作

这里是正文。可以直接使用 Typst 的数学公式、列表、图表和引用。

#callout[提示][日期和版本都可以省略。]

== 一个公式

$ e^(i pi) + 1 = 0 $
```

在仓库根目录运行：

```sh
typst compile main.typ
```

生成的文档为 `main.pdf`。写作时也可以使用 `typst watch main.typ` 持续编译。

英文文档只需将导入路径换为 `rochelimit/drift-en.typ`，其余接口相同。若将模板复制到其他项目，请相应调整导入路径，并确保模板文件处于 Typst 的项目根目录范围内。

## 文档参数

通过 `#show: rl-content.with(...)` 配置文档，后续正文由 show 规则自动传入。

| 参数 | 默认值 | 说明 |
| --- | --- | --- |
| `title` | `none` | 文档标题；省略时不显示标题 |
| `authors` | `()` | 作者字典组成的数组；省略时不显示作者信息 |
| `date` | `none` | `datetime` 日期；如需当天日期，可传入 `datetime.today()` |
| `version` | `none` | 版本文字，例如 `[0.1.0]` |
| `rl-header` | `none` | 自定义页眉内容 |

日期和版本独立可选：只提供其中一项时仅显示该项，两项均省略时不显示这一行。标题、作者姓名和日期也会用于 PDF 文档元数据。

### 作者信息

每位作者都使用字典，`name` 为必填字段，接受字符串或 Typst 内容。`department`、`organization`、`location` 和 `email` 均可省略。字符串形式的邮箱会自动生成 `mailto:` 链接。

例如，最简的单作者配置是：

```typst
#show: rl-content.with(
  authors: ((name: "Alice"),),
)
```

注意外层数组的尾逗号。多位作者在外层数组中依次添加字典即可，不要直接传入姓名字符串数组。

### 自定义页眉

```typst
#show: rl-content.with(
  rl-header: [
    #set par(first-line-indent: 0em)
    我的技术笔记
    #line(length: 100%)
  ],
)
```

这些配置是不同用法的示例；实际文档中请将所需参数合并到同一次 `rl-content.with(...)` 调用中。

## 扩展用法

以下用法均放在应用模板后的正文中。

### Callout

`callout` 的标题和正文两个参数都必须传入。不显示标题时，应显式传入空块 `[]`。

```typst
#callout[注意][这是一条有标题的提示。]

#callout[][这是一条没有标题的提示。]
```

### Flag

```typst
#flag[`flag{hello_rochelimit}`]
```

### 目录

目录默认使用本地化标题（中文为“目录”，英文为“Table of Contents”），也可以覆盖或隐藏标题：

```typst
#outline()

#outline(title: [本文内容])

#outline(title: none)
```

以上是三种可选写法，通常只需使用其中一种。

## 查看完整示例

在仓库根目录运行：

```sh
typst compile --root . examples/example-drift-zh.typ example-drift-zh.pdf
typst compile --root . examples/example-drift-en.typ example-drift-en.pdf
```

这里的 `--root .` 允许示例读取同级目录中的模板和图片。示例还会使用 `examples/bibliography.bib` 中的参考文献数据。

- [中文示例](examples/example-drift-zh.typ)
- [英文示例](examples/example-drift-en.typ)

## 项目结构

```text
rochelimit/
  drift-zh.typ              中文 Drift 模板
  drift-en.typ              英文 Drift 模板
examples/
  example-drift-zh.typ      中文排版示例
  example-drift-en.typ      英文排版示例
  bibliography.bib         示例参考文献
assets/
  perlica.jpg              示例配图
```

## 调整样式

字体、字号、标题字重、段首缩进和日期格式等配置集中在两个模板文件顶部的 `rl-*` 常量中。需要改变模板默认风格时，可直接编辑所用语言的模板文件；这些常量不是 `rl-content.with(...)` 的配置参数。
