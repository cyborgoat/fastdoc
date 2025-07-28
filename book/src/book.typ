#import "lib.typ": *

// Default configuration values
#let default-config = (
  // Typography
  font: "New Computer Modern",
  mono-font: ("SF Mono", "Monaco", "Consolas", "Liberation Mono", "Courier New"),
  font-size: 10pt,
  line-height: 1.1,
  
  // Colors
  accent-color: "#385fb4ff",
  text-color: black,
  gray-light: rgb("#f8f9fa"),
  gray-medium: rgb("#e9ecef"),
  gray-dark: gray.darken(20%),
  chapter-underline-color: "#385fb4ff",
  
  // Spacing
  heading-spacing: (
    above: (chapter: 2em, section: 1.5em, subsection: 1.2em, h4: 1em),
    below: (chapter: 1.5em, section: 1em, subsection: 0.8em, h4: 0.6em),
  ),
  block-spacing: (above: 0.8em, below: 0.8em),
  list-spacing: 0.4em,
  
  // Sizes
  heading-font-size: (
    part: 20pt,
    chapter: 16pt,
    section: 13pt,
    subsection: 11pt,
  ),
  
  // Layout
  paper: "a4",
  margin: (x: 2cm, y: 1.5cm),
  title-margin: (x: 2cm, y: 1cm),
  
  // Code styling
  code-fill: rgb("#f8f9fa"),
  code-stroke: rgb("#dee2e6"),
  code-inset: (inline: (x: 4pt, y: 2pt), block: 12pt),
  code-radius: (inline: 3pt, block: 6pt),
  code-size: 0.85em,
)

// Helper functions for page components
#let create_header() = context {
  if counter(page).get().first() > 1 {
    let current-heading = query(selector(heading.where(level: 1)).before(here())).last()
    align(center)[
      #text(size: 8pt, style: "italic", fill: gray.darken(20%))[
        #current-heading.body
      ]
    ]
  }
}

#let create_footer() = context {
  if counter(page).get().first() > 1 {
    line(length: 100%, stroke: 0.5pt + gray.lighten(40%))
    v(0.3em)
    
    let current-chapter = query(selector(heading.where(level: 1)).before(here())).last()
    let current-section = query(selector(heading.where(level: 2)).before(here())).last()
    
    grid(
      columns: (1fr, auto, 1fr),
      align: (left, center, right),
      column-gutter: 1em,
      
      text(size: 8pt, fill: gray.darken(20%))[
        #if current-chapter != none [#current-chapter.body]
      ],
      text(size: 8pt, fill: gray.darken(20%))[
        #counter(page).display("1")
      ],
      text(size: 8pt, fill: gray.darken(20%))[
        #if current-section != none [#current-section.body]
      ]
    )
  }
}

// Title page creation
#let create_title_page(title, subtitle, authors, version, date, publisher, isbn, cover-image, config) = {
  page(
    margin: config.title-margin,
    header: none,
    footer: none,
    numbering: none,
  )[
    #align(center)[
      #v(2cm)
      
      #if cover-image != none {
        image(cover-image, width: 60%)
        v(1cm)
      }
      
      #text(
        font: config.font,
        size: 32pt,
        weight: "bold",
        fill: rgb(config.accent-color),
      )[#title]
      
      #if subtitle != "" {
        v(0.5cm)
        text(
          font: config.font,
          size: 18pt,
          style: "italic",
        )[#subtitle]
      }
      
      #v(2cm)
      
      #for author in authors {
        text(size: 16pt, weight: "medium")[#author]
        linebreak()
      }
      
      #v(1fr)
      
      #if version != "" {
        text(size: 12pt)[Version #version]
        linebreak()
      }
      
      #text(size: 12pt)[#date.display("[month repr:long] [day], [year]")]
      
      #if publisher != "" {
        linebreak()
        text(size: 12pt, weight: "medium")[#publisher]
      }
      
      #if isbn != "" {
        linebreak()
        text(size: 10pt)[ISBN: #isbn]
      }
    ]
  ]
}

// Copyright page creation
#let create_copyright_page(authors, date, isbn) = {
  page(
    header: none,
    footer: none,
    numbering: none,
  )[
    #v(1fr)
    #align(center)[
      #text(size: 10pt)[
        © #date.year() #authors.join(", ")
        
        #v(0.5cm)
        
        All rights reserved. No part of this publication may be reproduced,
        distributed, or transmitted in any form or by any means, including
        photocopying, recording, or other electronic or mechanical methods,
        without the prior written permission of the publisher.
        
        #if isbn != "" {
          v(0.5cm)
          [ISBN: #isbn]
        }
      ]
    ]
  ]
}

// Table of contents creation
#let create_outline() = {
  page(
    header: none,
    footer: context {
      align(center)[
        #text(size: 9pt)[
          #counter(page).display("i")
        ]
      ]
    },
    numbering: "i",
  )[
    #outline(
      title: [Table of Contents],
      depth: 3,
      indent: 1em,
    )
  ]
}

// Main book template function
#let book(
  title: "",
  subtitle: "",
  authors: (),
  version: "",
  date: datetime.today(),
  publisher: "",
  isbn: "",
  cover-image: none,
  accent-color: default-config.accent-color,
  chapter-underline-color: default-config.chapter-underline-color,
  font: default-config.font,
  body-font: default-config.font,
  mono-font: default-config.mono-font,
  paper: default-config.paper,
  margin: default-config.margin,
  line-height: default-config.line-height,
  font-size: default-config.font-size,
  heading-font-size: default-config.heading-font-size,
  show-outline: true,
  show-bibliography: true,
  body,
) = {
  // Merge user config with defaults
  let config = default-config
  config.accent-color = accent-color
  config.chapter-underline-color = chapter-underline-color
  config.font = font
  config.body-font = body-font
  config.mono-font = mono-font
  config.paper = paper
  config.margin = margin
  config.line-height = line-height
  config.font-size = font-size
  config.heading-font-size = heading-font-size

  // Document metadata
  set document(title: title, author: authors, date: date)

  // Page setup with header and footer
  set page(
    paper: config.paper,
    margin: config.margin,
    numbering: "1",
    header: create_header(),
    footer: create_footer(),
  )

  // Typography settings
  set text(
    font: config.body-font,
    size: config.font-size,
    lang: "en",
  )

  set par(
    justify: true,
    leading: config.line-height * 1em,
    first-line-indent: 1.2em,
  )

  // Configure headings
  set heading(numbering: "1.1.1.1")
  
  // Apply heading styles directly
  let accent = rgb(config.accent-color)
  let underline-color = rgb(config.chapter-underline-color)
  let spacing = config.heading-spacing
  let sizes = config.heading-font-size
  
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(
      font: config.font,
      size: sizes.chapter,
      weight: "bold",
      fill: accent.darken(25%),
    )
    block(above: spacing.above.chapter, below: spacing.below.chapter)[
      #if it.numbering != none {
        text(weight: "bold")[Chapter #counter(heading).display(): #it.body]
      } else {
        text(weight: "bold")[#it.body]
      }
      #v(0.4em)
      #line(length: 100%, stroke: 2.5pt + underline-color.lighten(10%))
    ]
  }

  show heading.where(level: 2): it => {
    set text(
      font: config.font,
      size: sizes.section,
      weight: "semibold",
      fill: accent.darken(15%),
    )
    block(above: spacing.above.section, below: spacing.below.section)[
      #if it.numbering != none {
        counter(heading).display() + " "
      }
      #it.body
    ]
  }

  show heading.where(level: 3): it => {
    set text(
      font: config.font,
      size: sizes.subsection,
      weight: "semibold",
      fill: accent.darken(10%),
    )
    block(above: spacing.above.subsection, below: spacing.below.subsection)[
      #if it.numbering != none {
        counter(heading).display() + " "
      }
      #it.body
    ]
  }

  show heading.where(level: 4): it => {
    set text(
      font: config.font,
      size: config.font-size * 1.1,
      weight: "semibold",
      style: "italic",
      fill: accent.darken(5%),
    )
    block(above: spacing.above.h4, below: spacing.below.h4)[
      #if it.numbering != none {
        counter(heading).display() + " "
      }
      #it.body
    ]
  }
  
  // Apply code styles directly
  show raw.where(block: false): it => {
    box(
      fill: config.code-fill,
      stroke: 1pt + config.code-stroke,
      inset: config.code-inset.inline,
      outset: (y: 2pt),
      radius: config.code-radius.inline,
    )[
      #text(font: config.mono-font, size: config.code-size, fill: rgb("#2d3748"))[#it]
    ]
  }

  show raw.where(block: true): it => {
    block(
      fill: config.gray-light,
      stroke: 1.5pt + config.gray-dark.lighten(40%),
      radius: config.code-radius.block,
      inset: config.code-inset.block,
      width: 100%,
      above: config.block-spacing.above,
      below: config.block-spacing.below,
    )[
      #set text(font: config.mono-font, size: config.code-size, fill: rgb("#2d3748"))
      #it
    ]
  }
  
  // Apply other styles directly
  show link: it => {
    set text(fill: accent.lighten(10%))
    underline(it)
  }

  show quote: it => {
    block(
      fill: config.gray-light,
      stroke: (left: 4pt + accent),
      radius: (right: 4pt),
      inset: (x: 12pt, y: 8pt),
    )[
      #set text(style: "italic")
      #it
    ]
  }

  show figure: it => {
    block(above: 1em, below: 1em)[
      #align(center)[#it.body]
      #if it.caption != none {
        v(0.3em)
        align(center)[
          #text(size: 0.85em, weight: "semibold", fill: config.gray-dark)[
            #it.supplement
            #if it.numbering != none [
              #[ ]#it.counter.display(it.numbering)
            ]
            #if it.caption != none [
              #[: ]#it.caption
            ]
          ]
        ]
      }
    ]
  }

  show table: it => {
    block(above: 1em, below: 1em)[
      #align(center)[#it]
    ]
  }

  show bibliography: it => {
    pagebreak(weak: true)
    set heading(numbering: none)
    it
  }
  
  // Apply list styles
  set list(indent: 1em, spacing: config.list-spacing)
  set enum(indent: 1em, spacing: config.list-spacing)

  // Generate title and copyright pages
  create_title_page(title, subtitle, authors, version, date, publisher, isbn, cover-image, config)
  create_copyright_page(authors, date, isbn)
  
  // Generate table of contents if requested
  if show-outline {
    create_outline()
  }

  // Reset page numbering for main content
  counter(page).update(1)

  // Main content
  body
}

// Specialized components for technical books

// Enhanced callout component with consistent styling
#let callout(
  type: "info",
  title: "",
  accent-color: default-config.accent-color,
  content,
) = {
  let colors = (
    info: (fill: rgb("#e1f5fe"), stroke: rgb("#0288d1")),
    success: (fill: rgb("#e8f5e8"), stroke: rgb("#4caf50")),
    warning: (fill: rgb("#fff3e0"), stroke: rgb("#ff9800")),
    danger: (fill: rgb("#ffebee"), stroke: rgb("#f44336")),
    note: (fill: rgb("#f3e5f5"), stroke: rgb("#9c27b0")),
  )
  
  let color-scheme = colors.at(type, default: colors.info)
  
  block(
    fill: color-scheme.fill,
    stroke: (left: 4pt + color-scheme.stroke),
    radius: (right: 4pt),
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    above: 1em,
    below: 1em,
  )[
    #if title != "" {
      text(weight: "bold", fill: color-scheme.stroke)[#title]
      v(0.5em)
    }
    #content
  ]
}

// Styled table component
#let styled-table(
  columns: 2,
  stroke: 0.5pt + gray.lighten(40%),
  fill: (white, rgb("#f8f9fa")),
  ..content
) = {
  table(
    columns: columns,
    stroke: stroke,
    fill: fill,
    inset: 8pt,
    ..content
  )
}

// API reference component with enhanced styling
#let api-reference(
  name: "",
  signature: "",
  description: "",
  parameters: (),
  returns: none,
  examples: (),
  accent-color: default-config.accent-color,
) = {
  block(
    fill: default-config.gray-light,
    stroke: 1pt + default-config.gray-medium,
    radius: 6pt,
    inset: 16pt,
    width: 100%,
    above: 1em,
    below: 1em,
  )[
    #text(size: 14pt, weight: "bold", fill: rgb(accent-color))[#name]
    
    #if signature != "" {
      v(0.5em)
      raw(signature, lang: "python", block: true)
    }
    
    #if description != "" {
      v(0.8em)
      description
    }
    
    #if parameters.len() > 0 {
      v(0.8em)
      text(weight: "semibold")[Parameters:]
      for param in parameters {
        v(0.3em)
        [• *#param.name* (#text(style: "italic")[#param.type]): #param.description]
      }
    }
    
    #if returns != none {
      v(0.8em)
      text(weight: "semibold")[Returns: ]
      text(style: "italic")[#returns]
    }
    
    #if examples.len() > 0 {
      v(0.8em)
      text(weight: "semibold")[Examples:]
      for example in examples {
        v(0.5em)
        raw(example, lang: "python", block: true)
      }
    }
  ]
}

// Step-by-step tutorial component with theme integration
#let tutorial-step(
  number: 1,
  title: "",
  accent-color: default-config.accent-color,
  content,
) = {
  block(above: 1.5em, below: 1em)[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      [
        #circle(
          radius: 1.2em,
          fill: rgb(accent-color),
          text(fill: white, weight: "bold")[#number]
        )
      ],
      [
        #text(size: 13pt, weight: "semibold")[#title]
        #v(0.5em)
        #content
      ]
    )
  ]
}
