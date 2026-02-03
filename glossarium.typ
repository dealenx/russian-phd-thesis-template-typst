// this source code was obtained and corrected from: https://github.com/ENIB-Community/glossarium

// glossarium figure kind
#let __glossarium_figure = "glossarium_entry"
// prefix of label for references query
#let __glossary_label_prefix = "glossary:"
// global state containing the glossary entry and their location
#let __glossary_entries = state("__glossary_entries", (:))

#let __query_labels_with_key(key, before: false) = {
  let target = label(__glossary_label_prefix + key)
  let results = query(target)
  if before {
    let loc = here()
    results.filter(it => {
      let it_pos = it.location().position()
      let loc_pos = loc.position()
      it_pos.page < loc_pos.page or (it_pos.page == loc_pos.page and it_pos.y < loc_pos.y)
    })
  } else {
    results
  }
}

// Reference a term
#let gls(key, long: none, display: none) = context {
  let loc = here()
  let __glossary_entries = __glossary_entries.final()
  if key in __glossary_entries {
    let entry = __glossary_entries.at(key)

    let gloss = __query_labels_with_key(key, before: true)

    let is_first = gloss == ()
    let entlong = entry.at("long", default: "")
    let textLink = if display != none {
      [#display]
    } else if (is_first or long == true) and entlong != [] and entlong != "" and long != false {
      [#entry.short (#entlong)]
    } else {
      [#entry.short]
    }

    [#link(label(entry.key), textLink)#label(__glossary_label_prefix + entry.key)]
  } else {
    text(fill: red, "Glossary entry not found: " + key)
  }
}

// reference to symbol
#let sym(key) = context {
  let loc = here()
  let __glossary_entries = __glossary_entries.final()
  if key in __glossary_entries {
    let entry = __glossary_entries.at(key)

    [#link(label(entry.key), [#entry.short])#label(__glossary_label_prefix + entry.key)]
  } else {
    text(fill: red, "Symbol entry not found: " + key)
  }
}
// equation include symbols
#let print-eq-sym(..keys) = {
  "где"
  linebreak()
  for key in keys.pos() {
    context {
      let loc = here()
      let __glossary_entries = __glossary_entries.final()
      if key in __glossary_entries {
        let entry = __glossary_entries.at(key)

        let desc = if entry.desc != [] and entry.desc != none {
          [#entry.desc]
        } else {
          []
        }
        let linkText = [#h(2.5em)#entry.short --- #entry.long, #desc #linebreak()]
        [#link(label(entry.key), linkText)#label(__glossary_label_prefix + entry.key)]
      } else {
        text(fill: red, "Symbol entry not found: " + key)
      }
    }
  }
}

// show rule to make the references for glossarium
#let make-glossary(body) = {
  show ref: r => {
    if r.element != none and r.element.func() == figure and r.element.kind == __glossarium_figure {
      // call to the general citing function
      gls(str(r.target))
    } else {
      r
    }
  }
  body
}

#let print-glossary(entries, show-all: false, disable-back-references: false) = {
  __glossary_entries.update(
    x => {
      for entry in entries {
        x.insert(
          entry.key,
          (
            key: entry.key,
            short: entry.short,
            long: entry.at("long", default: ""),
            desc: entry.at("desc", default: ""),
          ),
        )
      }

      x
    },
  )

  for entry in entries.sorted(key: x => x.key) {
    let desc = entry.at("desc", default: "")
    let long = entry.at("long", default: "")
    let hasLong = long != "" and long != []
    let hasDesc = desc != "" and desc != []

    let title = if hasLong {
      text(weight: 600, emph(entry.short) + [ -- ] + entry.long)
    } else {
      text(weight: 600, emph(entry.short))
    }

    let description = if hasDesc [: #desc] else [.]

    context {
      let term_references = __query_labels_with_key(entry.key)
      let should_show = term_references.len() != 0 or show-all

      let back_refs = if disable-back-references != true and should_show {
        [ ]
        term_references
          .map(x => x.location())
          .sorted(key: x => x.page())
          .fold(
            (values: (), pages: ()),
            ((values, pages), x) => if pages.contains(x.page()) {
              (values: values, pages: pages)
            } else {
              values.push(x)
              pages.push(x.page())
              (values: values, pages: pages)
            },
          )
          .values
          .map(
            x => link(
              x,
            )[#numbering(x.page-numbering(), ..counter(page).at(x))],
          )
          .join(", ")
      }

      // Невидимая figure для создания метки
      [#hide[#figure(supplement: "", kind: __glossarium_figure, numbering: none, caption: none)[] #label(entry.key)]]

      if should_show {
        par(hanging-indent: 1em, first-line-indent: 0em)[
          #title#description#back_refs
        ]
      }
    }
  }
};
