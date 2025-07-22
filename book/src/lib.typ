// Book template library functions and utilities

// Helper function for consistent spacing
#let vspace(amount) = v(amount)

// Helper function for horizontal line separators
#let separator(width: 100%, stroke: 0.5pt, color: gray) = {
  line(length: width, stroke: stroke + color)
}

// Helper function for code blocks with syntax highlighting
#let code-block(
  content,
  lang: none,
  caption: none,
) = {
  block(
    fill: rgb("#f8f9fa"),
    stroke: 0.5pt + rgb("#e9ecef"),
    radius: 4pt,
    inset: 12pt,
    width: 100%,
  )[
    #if caption != none [
      #text(size: 9pt, weight: "semibold")[#caption]
      #v(6pt)
    ]
    #if lang != none [
      #raw(content, lang: lang, block: true)
    ] else [
      #raw(content, block: true)
    ]
  ]
}

// Helper function for callout boxes with compact styling
#let callout(
  content,
  type: "info",
  title: none,
) = {
  let colors = (
    info: (border: rgb("#0ea5e9").lighten(20%), bg: rgb("#f0f9ff")),
    warning: (border: rgb("#f59e0b").lighten(20%), bg: rgb("#fffbeb")),
    danger: (border: rgb("#ef4444").lighten(20%), bg: rgb("#fef2f2")),
    success: (border: rgb("#10b981").lighten(20%), bg: rgb("#f0fdf4")),
    note: (border: rgb("#6366f1").lighten(20%), bg: rgb("#f1f5f9")),
  )
  
  let color-scheme = colors.at(type, default: colors.info)
  
  block(
    fill: color-scheme.bg,
    stroke: (left: 3pt + color-scheme.border),
    radius: 3pt,
    inset: 8pt,
    width: 100%,
    above: 0.8em,
    below: 0.8em,
  )[
    #if title != none [
      #text(weight: "semibold", fill: color-scheme.border.darken(10%), size: 0.9em)[#title]
      #v(4pt)
    ]
    #text(size: 0.95em)[#content]
  ]
}

// Helper function for figures with captions
#let figure-with-caption(
  content,
  caption: none,
  label: none,
) = {
  let fig = figure(
    content,
    caption: caption,
    supplement: [Figure],
  )
  
  if label != none {
    [#fig #label(label)]
  } else {
    fig
  }
}

// Helper function for tables with styling
#let styled-table(..args) = {
  table(
    stroke: (x, y) => {
      if y == 0 { (bottom: 1pt + black) }
      else { (top: 0.5pt + gray.lighten(50%)) }
    },
    fill: (x, y) => {
      if y == 0 { gray.lighten(90%) }
      else if calc.odd(y) { gray.lighten(95%) }
    },
    ..args
  )
}
