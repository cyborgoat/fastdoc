#import "lib.typ": *

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
  accent-color: "#2563eb",
  font: "New Computer Modern",
  body-font: "New Computer Modern",
  mono-font: ("SF Mono", "Monaco", "Consolas", "Liberation Mono", "Courier New"),
  paper: "a4",
  margin: (x: 2cm, y: 1.5cm),
  line-height: 1.1,
  font-size: 10pt,
  heading-font-size: (
    part: 20pt,
    chapter: 16pt,
    section: 13pt,
    subsection: 11pt,
  ),
  show-outline: true,
  show-bibliography: true,
  body,
) = {

  // Document metadata
  set document(
    title: title,
    author: authors,
    date: date,
  )

  // Page setup
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    header: context {
      if counter(page).get().first() > 1 {
        let current-heading = query(selector(heading.where(level: 1)).before(here())).last()
        align(center)[
          #text(size: 8pt, style: "italic", fill: gray.darken(20%))[
            #current-heading.body
          ]
        ]
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        // Add a line separator at the top of footer
        line(length: 100%, stroke: 0.5pt + gray.lighten(40%))
        v(0.3em)
        
        let current-chapter = query(selector(heading.where(level: 1)).before(here())).last()
        let current-section = query(selector(heading.where(level: 2)).before(here())).last()
        
        grid(
          columns: (1fr, auto, 1fr),
          align: (left, center, right),
          column-gutter: 1em,
          
          // Left: Chapter name
          text(size: 8pt, fill: gray.darken(20%))[
            #if current-chapter != none [
              #current-chapter.body
            ]
          ],
          
          // Center: Page number
          text(size: 8pt, fill: gray.darken(20%))[
            #counter(page).display("1")
          ],
          
          // Right: Section name
          text(size: 8pt, fill: gray.darken(20%))[
            #if current-section != none [
              #current-section.body
            ]
          ]
        )
      }
    }
  )

  // Typography settings
  set text(
    font: body-font,
    size: font-size,
    lang: "en",
  )

  set par(
    justify: true,
    leading: line-height * 1em,
    first-line-indent: 1.2em,
  )

  // Enable heading numbering
  set heading(numbering: "1.1.1.1")

  // Heading styles with reduced contrast and tighter spacing
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(
      font: font,
      size: heading-font-size.chapter,
      weight: "bold",
      fill: rgb(accent-color).lighten(20%),
    )
    block(above: 1.2em, below: 1em)[
      #if it.numbering != none {
        text(weight: "bold")[Chapter #counter(heading).display(): #it.body]
      } else {
        text(weight: "bold")[#it.body]
      }
      #v(0.3em)
      #line(length: 100%, stroke: 1.5pt + rgb(accent-color).lighten(40%))
    ]
  }

  show heading.where(level: 2): it => {
    set text(
      font: font,
      size: heading-font-size.section,
      weight: "semibold",
      fill: rgb(accent-color).lighten(30%),
    )
    block(above: 1em, below: 0.7em)[
      #if it.numbering != none {
        counter(heading).display() + " "
      }
      #it.body
      #v(0.2em)
      #line(length: 25%, stroke: 0.8pt + rgb(accent-color).lighten(50%))
    ]
  }

  show heading.where(level: 3): it => {
    set text(
      font: font,
      size: heading-font-size.subsection,
      weight: "semibold",
      fill: rgb(accent-color).lighten(10%),
    )
    block(above: 0.8em, below: 0.5em)[
      #if it.numbering != none {
        counter(heading).display() + " "
      }
      #it.body
    ]
  }

  show heading.where(level: 4): it => {
    set text(
      font: font,
      size: font-size * 1.1,
      weight: "semibold",
      style: "italic",
    )
    block(above: 1em, below: 0.6em)[
      #if it.numbering != none {
        counter(heading).display() + " "
      }
      #it.body
    ]
  }

  // Code styling - more compact
  show raw.where(block: false): it => {
    box(
      fill: rgb("#f1f5f9"),
      inset: (x: 3pt, y: 1pt),
      outset: (y: 2pt),
      radius: 2pt,
    )[
      #text(font: mono-font, size: 0.85em)[#it]
    ]
  }

  show raw.where(block: true): it => {
    block(
      fill: rgb("#f8f9fa"),
      stroke: 0.5pt + rgb("#e9ecef"),
      radius: 4pt,
      inset: 10pt,
      width: 100%,
      above: 0.8em,
      below: 0.8em,
    )[
      #set text(font: mono-font, size: 0.85em)
      #it
    ]
  }

  // Links styling
  show link: it => {
    set text(fill: rgb(accent-color).lighten(10%))
    underline(it)
  }

  // List styling with tighter spacing
  set list(indent: 1em, spacing: 0.4em)
  set enum(indent: 1em, spacing: 0.4em)

  // Quote styling - improved with better visual hierarchy
  show quote: it => {
    block(
      fill: rgb("#f8f9fa"),
      stroke: (left: 4pt + rgb(accent-color)),
      radius: (right: 4pt),
      inset: (x: 12pt, y: 8pt),
    )[
      #set text(style: "italic")
      #it
    ]
  }

  // Figure styling with more compact spacing
  show figure: it => {
    block(above: 1em, below: 1em)[
      #align(center)[#it.body]
      #if it.caption != none {
        v(0.3em)
        align(center)[
          #text(size: 0.85em, weight: "semibold", fill: gray.darken(20%))[
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

  // Table styling with tighter spacing
  show table: it => {
    block(above: 1em, below: 1em)[
      #align(center)[#it]
    ]
  }

  // Bibliography styling
  show bibliography: it => {
    pagebreak(weak: true)
    set heading(numbering: none)
    it
  }

  // Title page
  page(
    margin: (x: 2cm, y: 3cm),
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
        font: font,
        size: 32pt,
        weight: "bold",
        fill: rgb(accent-color),
      )[#title]
      
      #if subtitle != "" {
        v(0.5cm)
        text(
          font: font,
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

  // Copyright page
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

  // Table of contents
  if show-outline {
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

  // Reset page numbering for main content
  counter(page).update(1)

  // Main content
  body
}

// Specialized components for technical books

// API reference component
#let api-reference(
  name: "",
  signature: "",
  description: "",
  parameters: (),
  returns: none,
  examples: (),
) = {
  block(
    fill: rgb("#f8f9fa"),
    stroke: 1pt + rgb("#e9ecef"),
    radius: 6pt,
    inset: 16pt,
    width: 100%,
  )[
    #text(size: 14pt, weight: "bold")[#name]
    
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

// Step-by-step tutorial component
#let tutorial-step(
  number: 1,
  title: "",
  content,
) = {
  block(above: 1.5em, below: 1em)[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      [
        #circle(
          radius: 1.2em,
          fill: rgb("#2563eb"),
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
