![GraphPapers](docs/hero.png)

<sub>Illustrative data — the papers above are placeholders, so the screenshot stays
stable between releases. The live app reads real records from OpenAlex.</sub>

# GraphPapers

**v1.3** · [Open it in a browser](https://oddthumb.github.io/GraphPapers/)

A free, single-file alternative to Connected Papers. Enter a paper, get a
force-directed graph of the ~40 works most related to it, then export a ready-made
prompt that turns that graph into a narrative history — in your own LLM, at no cost.

No install. No account. No API key. No backend. One HTML file.

---

## Running it

Open it at **https://oddthumb.github.io/GraphPapers/**, or download `index.html`
and double-click it. Either way works, and both are the whole procedure.

Everything the app needs to run is inside that file, including the d3 graph library.
The only thing it fetches from the network is the paper data itself, live from
[OpenAlex](https://openalex.org) — a free, open catalogue of 250M+ works that needs
no key and imposes no cost.

Sharing it means sending a link, or one file. Either way the recipient is working immediately.

---

## What it does

### Similarity graph

Enter a title, DOI, or OpenAlex ID. The app pulls the seed paper's references and
the works citing it, then scores every candidate against the seed using the same
two measures Connected Papers uses:

- **Bibliographic coupling** — two papers that cite many of the same works are
  probably about the same thing.
- **Co-citation** — two papers that are frequently cited together are probably
  about the same thing.

Both measures are standard bibliometrics, not anyone's proprietary method — bibliographic
coupling is Kessler (1963), co-citation is Small (1973).

The 40 highest-scoring papers become the graph. Each node connects to its three
nearest neighbours, so clusters emerge on their own.

**An edge means similarity, not citation.** Two papers are joined because they cite
the same works or are cited together — they need not cite each other at all. Where a
real citation does exist between two joined papers, the edge carries an arrowhead
pointing at the older work. To see citations on their own terms, tick **Citation links**:
that overlays every real citation between the papers on screen, on top of the
similarity layout, without moving anything.

| Encoding | Meaning |
|---|---|
| Node size | Citation count |
| Node colour | Publication year — pale (older) to dark (newer) |
| Accent ring | The seed paper |
| Edge weight | Similarity between the two papers |
| Edge colour | Distance from the seed — the accent, fading with each hop |

Everything that changes the graph lives in one panel at its top-left; everything that
only reads from it — **Story prompt**, **Export citations** — stays in the tab bar. The
**i** button at the top-right opens the full legend.

Drag nodes, scroll to zoom, and use the **Spacing** slider to loosen or tighten the
layout. **Reshuffle** throws the nodes to new starting positions and lets the layout
settle again — a force layout falls into whichever arrangement its start positions
lead to, so a tangled graph often untangles on the second try. **Timeline** stacks the
papers by year instead, oldest at the top, so citation arrows all point upward into
the past; each year that actually occurs gets an equal band, so a single old reference
cannot squash the recent decade into a sliver. Three colour palettes sit in the header.

Click a node to pin its neighbourhood; click empty canvas to release it. Click any node to see its abstract, authors, and DOI — and to rebuild the
whole graph around it.

### Prior and derivative works

Two tabs beside the graph list what the seed paper cites and what cites it, ranked
by citation count.

### Citation export

**Export citations** writes the papers out as BibTeX, RIS, APA, MLA, or Chicago —
one paper, everything the filters currently show, or all 40. Copy it, or download a
`.bib` / `.ris` file and drag it straight into Zotero, EndNote, or Overleaf.

Author names come from OpenAlex as single strings, so the family name is taken as
everything after the last space. That is right for most Western names and wrong for
some; check the names before submitting.

### Filtering

In the same left-hand panel: keyword (title and authors), year range, minimum
citations, open access, and journal impact. The journal filter uses OpenAlex's 2-year mean citedness, ranked among the
journals present in the current graph — it is **not** a JCR quartile, which is not
open data. Filtering hides papers without moving the layout, and resets whenever you
build a new graph.

### LLM story prompt

The **Story prompt** button assembles a prompt describing the graph — every paper
grouped as prior, later, or related, with its year, first author, citation count,
and distance from the centre in graph hops.

Copy it into ChatGPT, Claude, Gemini, or anything else, and you get a written
history of the research line: what problem the centre paper solved, what led to it,
and what it produced.

| Depth | Papers | Use it for |
|---|---|---|
| 1 | ~10 | A tight story about the paper's immediate neighbourhood |
| 2 | ~25 | The default — enough context to see a lineage |
| 3 | ~37 | The whole field around the paper |
| All | 39 | Everything in the graph |

Output language is switchable between English and Korean.

The app builds this text itself — it never calls an LLM, so this step costs nothing,
needs no key, and works instantly. Which model reads it is entirely your choice.

---

## Data freshness

There is no local cache and no database. Every lookup goes straight to OpenAlex, so
what you see is what OpenAlex holds at that moment. The bottom-right corner always
shows the time of the current fetch and the date OpenAlex last updated the seed
record, so you know exactly what you are looking at.

The cost of that guarantee is that **the app needs an internet connection**. Without
one it opens and renders, but cannot fetch papers, and says so.

---

## Requirements

A modern browser. That is all.

The layout adapts below 760px: the graph and the detail panel stack instead of sitting
side by side, and the control panel collapses behind a button so it does not cover the
graph. Pinch to zoom and drag nodes work on touch.

Google Fonts is the only other external reference; if it is unreachable the app
falls back to system fonts and works normally.

---

## Credits

Sangin Kim — <kimsanginn@gmail.com>  
Sehwan Cheon — <thousandsh2@gmail.com>

Ideas, bug reports, and pull requests are welcome; contributors are credited in the
app, under the Acknowledgements link in the bottom-right corner.

Paper data from [OpenAlex](https://openalex.org). Graph layout by
[d3](https://d3js.org).

Licensed under the [MIT License](LICENSE). Free to use, modify, and sell, provided
the copyright notice is kept.

GraphPapers is an independent project. It is not affiliated with, endorsed by, or
derived from the code or design of Connected Papers; the comparison in this document
is descriptive only.
