#import "../rochelimit/drift-zh.typ": *

// 每位作者使用字典，必填 name（字符串或内容）；
// department、organization、location、email 均为可选字段。
// date 和 version 默认为 none，仅在提供时显示。

#show: rl-content.with(
  title: [RocheLimit（Drift）模板中文排版示例],
  authors: (
    (
      name: "Limity'roChen",
      department: [Core Dev],
      organization: [Project Hazelita],
      location: [LyRiverse],
      email: "LyCecilion@outlook.com",
    ),
  ),
  date: datetime(year: 2024, month: 2, day: 15),
  version: [0.1.0],
  rl-header: [
    #h(-2em)
    悟已往之不谏，知来者之可追。
    #line(length: 100%)
  ],
)

RocheLimit 是洛汐（Limity'roChen）创作的一套 typst 模板，用于洛汐的日常排版需求。RocheLimit 共有 2 个版本——Drift 和 Surge。该《RocheLimit（Drift）模板中文排版示例》（以下简称《示例》）使用了 Drift 排版。

RocheLimit 采取类 #m-jaxon.render("\Large \LaTeX", inline: true) 排版物的风格，选择了 TeX Gyre Schola 和思源宋体等衬线字体，微调了页边距、行间距和段间距等，以满足日常或正式的排版所需。RocheLimit 的 2 个版本分别用于短 / 长篇幅的正式文档的排版。Drift 没有实现文档和小节的封面，确保在排版短幅内容时不会显得冗长。

《示例》将演示 typst 的基础功能以及 RocheLimit 扩展的功能。

#figure(
  placement: none,
  image("../assets/perlica.jpg", width: 80%),
  caption: [*佩丽卡。*游戏《明日方舟：终末地》及其衍生作品的登场角色。终末地工业的监督和官方发言人，主要负责管理和推进协议源石技术的开发和应用，同时也承担帝江号的管理工作。],
) <perlica>

该模板和示例均于 #link("https://github.com/LyCecilion/RocheLimit")[GitHub: LyCecilion/RocheLimit] 遵循 MIT License 开源。

编译该文档使用的 typst 版本为 #sys.version，编译参数为 #sys.inputs。

#pagebreak()

= 模板功能演示 <template-presentation>

== typst 基础语法

typst 共有三种模式：标记模式（markup）、数学模式（math）和代码模式（code）。不同的模式具有不同的语法。这些语法大多与 #m-jaxon.render("\Large \LaTeX", inline: true) 和 Markdown 相似，是容易上手的。

=== 标记模式（markup mode）

在标记模式下，你可以 *着重强调（strong emphasis）* 或 _强调（emphasis）_ 文本，打印 `原始文本 (raw text)`、行内代码块 ```sh printf "TGltaXR5J3JvQ2hlbg==" | base64 -d``` 或行内数学公式 $D(x_0) = {d in RR | f(x_0 + d) > f(x_0)}$。你也可以插入链接（例如，在官方文档 #link("https://typst.app/docs/reference/syntax/")[Syntax - Typst Documentation] 查看 typst 三种模式的语法）或引用标签（例如，引用 @perlica）。

你可以 #highlight[强调（highlight）]一段文本、为一段文本添加 #overline[上划线（overline）] 或 #underline[下划线（underline）]，或添加 #super[上标（superscript）] 或 #sub[下标（subscript）]。

typst 支持下面三种列表：无序列表、有序列表和术语列表。

#columns(3)[
  - 你可以
  - 输入
  - 无序列表（bullet list）
  #colbreak()
  + 也可以
  + 输入
  + 有序列表（numbered list）
  #colbreak()
  / 或者: 你也可以
  / 像这样: 输入
  / 一个: 术语列表（term list）
]

=== 数学模式（math mode）

数学模式是特殊的标记模式。typst 的数学公式使用 `$` 包裹：若要键入行内数学公式，则 `$` 与公式紧贴（例如 `$1$`）；若要键入行间数学公式，则 `$` 与公式之间空一格（例如 `$ 1 $`）。下面给出数学模式的一个示例，该示例中包含了行内和行间数学公式。

#h(-2em) #box(stroke: black, inset: 0.8em, width: 100%)[
  #set par(first-line-indent: 0em)
  设 $bold(A)$ 是一个 $20,000 times 20,000$ 的矩阵。矩阵的元素除了以下两处之外，其余全为 $0$：

  - 主对角线上的元素为前 $20,000$ 个素数：$2, 3, 5, 7, ..., 224737$；
  - 所有满足
    $ |i - j| = 1, 2, 4, 8, ..., 16384 $
    的位置 $a_(i j)$ 上的元素均为 $1$。

  设 $bold(A)^(-1)$ 的 $(1, 1)$ 的值为 $h_3$。求 $h_3$ 和 $3009 h_3 - 58 e$ 的值。
]

#strike[这道题目的答案#footnote[事实上，$3009 h_3 - 58 e approx 2024.1004$，这即 Project Hazelita 的立项日期（2024 年 10 月 04 日）。]是显然的，这里留作习题。]

=== 代码模式（code mode）

typst 的代码模式功能丰富，敬请参阅 typst 官方文档中 #link("https://typst.app/docs/reference/syntax/#code")[Code mode] 小节。

== 引用文献（bibliography）

typst 通过 `bibliography` 函数管理参考文献：准备好 BibTeX（`.bib`）或 Hayagriva（`.yml`）格式的文献数据库后，即可在正文中引用其中的条目，并在合适的位置生成文献列表。

这里，《示例》使用同目录下的 `bibliography.bib` 作为数据库。引用一条文献最简单的写法是直接书写 `@key`（`key` 为条目的标识符），例如使用 `@fedora-debugging` 引用 @fedora-debugging 一文；也可以改用 `cite` 函数获得更多控制，例如以叙述形式（`#cite(<typst-bibliography>, form: "prose", supplement: [官方文档])`）输出 #cite(<typst-bibliography>, form: "prose", supplement: [官方文档])，并通过 `supplement` 参数附加补充说明。

在适当的位置，可以使用 ```typst #bibliography()``` 函数生成参考文献列表。例如，我们使用

```typst
#bibliography("bibliography.bib")
```

#h(-2em) 可以获得：

#box(stroke: black, inset: 0.8em, width: 100%)[
  #bibliography("bibliography.bib")
]

== 脚注（footnote）

`footnote` 函数用于生成脚注：将内容写在方括号里，typst 会为其自动编号，并将内容排到当前页面的页脚，就像这样#footnote[编号格式可通过 `numbering` 参数调整。]。若后文需要再次指向同一条脚注，可以为第一个脚注附加标签，之后以 `#footnote(<label>)` 的形式复用，复用处会显示相同的编号：

```typ
// 为脚注设置标签
typst 会为脚注编号#footnote[这是一条可复用的脚注。] <fn-demo>

// 复用时沿用原编号
再次指向这条脚注#footnote(<fn-demo>)
```

实际效果：这是带标签的脚注#footnote[这是一条可复用的脚注。] <fn-demo>，而这一处#footnote(<fn-demo>)复用了它的编号。在页末可以看到当页的脚注。

== 表格（table）

typst 具有表格功能。RocheLimit 对表格进行了默认值配置，内边距（inset）默认为 `7pt`，且表格默认水平居中（`horizon`）。RocheLimit 并没有对表格进行过量的样式配置。

#figure(
  caption: [《示例》使用的字体],
  table(
    columns: 3,
    table.header([场景], [字体], [说明]),
    [正文], [TeX Gyre Schola], [西文主字体],
    [正文], [Noto Serif CJK SC], [中文字体],
    [代码], [Latin Modern Mono 8], [代码块内的西文字体],
    [代码], [LXGW WenKai Mono], [代码块内的中文字体],
  ),
)

== RocheLimit 扩展语法

=== Flag

RocheLimit 提供了 Flag 块，以适配 CTF 场景。例如

```typst
#flag[`hzlt{4ND_1N_7H47_116H7-1_F1ND_D311V3r4NC3}`]
```

#h(-2em) 会得到

#flag[`hzlt{4ND_1N_7H47_116H7-1_F1ND_D311V3r4NC3}`]

=== Callout

RocheLimit 提供 Callout 块，以还原 Markdown 的习惯用法。`callout` 函数的两个参数 `title` 和 `body` 均须传入；不显示标题时，须显式传入空块，例如 `#callout[][正文]`。下面的示例同时给出了 `title` 和 `body`：

```typst
#callout[注意][hzlt!Game 2027 将于 2026 年 12 月 25 日开始。]
```

#h(-2em) 将会得到

#callout[注意][hzlt!Game 2027 将于 2026 年 12 月 25 日开始。]

而下面的示例则留空了 `title`：

```typst
#callout[][
  人类将大数据编成罗网 / 俘虏了全世界诸多信仰 / 所以建构了晶片的辉煌 / 所以行凶后别逃离现场\
  外太空令人神往 / 所以宇宙的神经将延展 / 所以我们回到母语家乡 / 所以请陪我一起等旭阳
  #align(right)[——罗大佑《所以》]
]
```

#h(-2em) 这将会得到

#callout[][
  人类将大数据编成罗网 / 俘虏了全世界诸多信仰 / 所以建构了晶片的辉煌 / 所以行凶后别逃离现场\
  外太空令人神往 / 所以宇宙的神经将延展 / 所以我们回到母语家乡 / 所以请陪我一起等旭阳
  #align(right)[——罗大佑《所以》]
]

=== 目录

RocheLimit 为 `outline` 块提供样式和本地化的默认标题。使用 `outline(title: [自定义目录])` 覆盖标题，或用 `outline(title: none)` 隐藏标题。例如，在页首，你可以直接使用

```typst
outline()
```

#h(-2em) 得到一个目录：

#outline()
