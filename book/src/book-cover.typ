// Professional book cover template

#let book-cover(
  title: "",
  subtitle: "",
  authors: (),
  version: "",
  publisher: "",
  logo-path: none,
  accent-color: "#000000ff",
) = {
  set page(
    paper: "a4",
    margin: 0pt,
    numbering: none,
    header: none,
    footer: none,
  )
  
  // Background with gradient
  place(
    top + left,
    rect(
      width: 100%,
      height: 100%,
      fill: gradient.linear(
        (rgb("#1e293b"), 0%),
        (rgb(accent-color).darken(30%), 30%),
        (rgb(accent-color), 70%),
        (rgb(accent-color).lighten(20%), 100%),
        angle: 135deg
      )
    )
  )
  
  // Decorative elements
  place(
    top + right,
    dx: -2cm,
    dy: 3cm,
    rotate(45deg,
      rect(
        width: 6cm,
        height: 6cm,
        fill: white.transparentize(90%),
        radius: 1cm,
      )
    )
  )
  
  place(
    bottom + left,
    dx: 1cm,
    dy: -4cm,
    rotate(-30deg,
      rect(
        width: 8cm,
        height: 8cm,
        fill: white.transparentize(95%),
        radius: 2cm,
      )
    )
  )
  
  // Logo section
  if logo-path != none {
    place(
      top + center,
      dy: 13cm,
      box(
        fill: white.transparentize(85%),
        inset: 0.5cm,
        radius: 0.5cm,
        stroke: 0.5pt + white.transparentize(70%)
      )[
        #image(logo-path, width: 2.5cm)
      ]
    )
  }
  
  // Title section
  place(
    center,
    dy: if logo-path != none { 4.5cm } else { -2cm },
    align(center)[
      #text(
        size: 36pt,
        weight: "bold",
        fill: white,
        font: "New Computer Modern",
      )[#title]
      
      #v(1.5cm)
      
      #line(
        length: 8cm,
        stroke: 3pt + white.transparentize(30%)
      )
      
      #v(1cm)
      
      #if subtitle != "" {
        text(
          size: 16pt,
          weight: "light",
          fill: white.darken(5%),
          style: "italic",
          font: "New Computer Modern",
        )[#subtitle]
      }
    ]
  )
  
  // Author and publication info at bottom
  place(
    bottom + center,
    dy: -4cm,
    align(center)[
      #line(
        length: 6cm,
        stroke: 2pt + white.transparentize(40%)
      )
      
      #v(1cm)
      
      #text(
        size: 18pt,
        weight: "medium",
        fill: white,
        font: "New Computer Modern",
      )[#authors.join(" • ")]
      
      #v(1.5cm)
      
      #box(
        fill: white.transparentize(90%),
        inset: (x: 2cm, y: 1cm),
        radius: 8pt,
        stroke: 1pt + white.transparentize(60%)
      )[
        #if version != "" {
          text(
            size: 11pt,
            weight: "regular", 
            fill: white.darken(10%),
          )[Version #version]
          if publisher != "" [ \ ]
        }
        
        #if publisher != "" {
          text(
            size: 13pt,
            weight: "medium",
            fill: white,
          )[#publisher]
        }
      ]
    ]
  )
}
