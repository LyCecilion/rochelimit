// RocheLimit (Drift) for zh-CN
// This typst template is designed for shorter articles and announcements, and is not suitable for large publications, etc.

#import "@preview/m-jaxon:0.1.2"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let rl-font = (
  "TeX Gyre Schola",
  "Noto Serif CJK SC",
)
#let rl-lang = "zh"
#let rl-region = "cn"

#let rl-text-size = 10pt
#let rl-text-weight = "medium"

#let rl-title-size = 17pt
#let rl-heading-size = 13pt
#let rl-subhead-size = 11pt
#let rl-heading-weight = "extrabold"

#let rl-just-limits = (tracking: (min: -0.01em, max: 0.01em))
#let rl-fl-indent = (amount: 2em, all: true)

#let rl-date-display = "[year] 年 [month] 月 [day] 日"
#let rl-ver-display = "版本"
#let rl-outline-title = [目录]

#let rl-plain-text(it) = {
  if type(it) == str {
    it
  } else if it.has("text") {
    it.text
  } else if it.func() == [ ].func() or it.func() == linebreak or it.func() == parbreak {
    " "
  } else if it.has("body") {
    rl-plain-text(it.body)
  } else if it.has("child") {
    rl-plain-text(it.child)
  } else if it.has("children") {
    it.children.map(rl-plain-text).join("")
  } else {
    ""
  }
}

#let flag(body) = {
  block(
    fill: rgb("#f9f9f9"),
    stroke: 1pt + luma(200),
    inset: (x: 1em, y: 1em),
    width: 100%,
    radius: 4pt,
    spacing: 1.2em,
    breakable: true,
  )[
    #text(weight: "bold", fill: rgb("#2d9c58"))[Flag] #h(0.5em) #body
  ]
}

#let callout(title, body) = {
  block(
    fill: rgb("#e8f4fd"),
    stroke: (left: 4pt + rgb("576A8F")),
    inset: (x: 1em, y: 1em),
    width: 100%,
    radius: 2pt,
    spacing: 1.2em,
    breakable: true,
  )[
    #set par(first-line-indent: 0em)
    #if title != [] [#text(weight: "bold", fill: rgb("576A8F"))[#title \ ]]
    #body
  ]
}

#let rl-content(
  title: none,
  authors: (),
  date: none,
  version: none,
  rl-header: none,
  body,
) = {
  let rl-author-names = authors.map(author => rl-plain-text(author.name))
  set document(
    title: title,
    author: rl-author-names,
    date: date,
  )
  set text(font: rl-font, size: rl-text-size, weight: rl-text-weight, lang: rl-lang, region: rl-region)
  set page(paper: "a4", numbering: "1", header: rl-header)
  set par(leading: 0.85em, spacing: 0.85em, justify: true, first-line-indent: rl-fl-indent)

  show: codly-init.with()
  codly(languages: codly-languages)

  if title != none {
    text(font: rl-font, size: rl-title-size, weight: rl-heading-weight)[#h(-2em) #title]
    parbreak()
  }

  v(1em)

  for i in range(calc.ceil(authors.len() / 3)) {
    let end = calc.min((i + 1) * 3, authors.len())
    let is-last = authors.len() == end
    let slice = authors.slice(i * 3, end)
    grid(
      columns: slice.len() * (1fr,),
      gutter: 12pt,
      ..slice.map(author => align(center, {
        text(size: rl-text-size, author.name)
        if "department" in author [
          \ #emph(author.department)
        ]
        if "organization" in author [
          \ #emph(author.organization)
        ]
        if "location" in author [
          \ #author.location
        ]
        if "email" in author [
          #if type(author.email) == str [
            \ #link("mailto:" + author.email)
          ] else [
            \ #author.email
          ]
        ]
      }))
    )

    v(16pt, weak: true)
  }

  let details = ()
  if date != none { details.push(date.display(rl-date-display)) }
  if version != none { details.push([#rl-ver-display #version]) }
  if details.len() > 0 {
    v(10pt, weak: true)
    align(center, details.join([，]))
  }

  set heading(numbering: "1. ")
  show heading: set block(below: 1em, above: 1.5em)
  show heading.where(level: 1): it => {
    align(center)[#text(weight: rl-heading-weight, size: rl-heading-size, it)]
    v(1em, weak: true)
  }
  show heading.where(level: 2): set text(weight: rl-heading-weight, size: rl-subhead-size)
  show heading.where(level: 2): set block(below: 1em, above: 2.2em)

  set figure(gap: 1em)
  show figure: set place(clearance: 1em)
  show figure.where(placement: none): it => block(above: 1.5em, below: 2em, it)

  show columns: it => block(above: 1.5em, below: 1.5em, it)

  show raw: set text(
    font: (
      (name: "Latin Modern Mono 8", covers: "latin-in-cjk"),
      "LXGW WenKai Mono",
    ),
    size: 1em / 0.85,
  )

  show link: set text(blue.darken(10%))
  show ref: set text(blue.darken(10%))

  set table(align: horizon, inset: 7pt)

  show footnote.entry: it => {
    let loc = it.note.location()
    super(counter(footnote).display(at: loc, "1"))
    [ ]
    it.note.body
  }

  set outline(title: rl-outline-title)
  show outline: it => block(fill: luma(245), inset: 1em, width: 100%, radius: 5pt)[
    #set par(first-line-indent: 0em)
    #v(.2em)
    #it
  ]

  show divider: set line(stroke: 1pt)
  show divider: it => block(above: 1.5em, below: 1.5em, it)

  v(1em)
  body
}
