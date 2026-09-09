# GraphPapers

**v1.1**

A free, single-file alternative to Connected Papers. Enter a paper, get a
force-directed graph of the ~40 works most related to it, then export a ready-made
prompt that turns that graph into a narrative history — in your own LLM, at no cost.

No install. No account. No API key. No backend. One HTML file.

---

## Running it

Double-click `GraphPapers.html`. That is the whole procedure.

Everything the app needs to run is inside that file, including the d3 graph library.
The only thing it fetches from the network is the paper data itself, live from
[OpenAlex](https://openalex.org) — a free, open catalogue of 250M+ works that needs
no key and imposes no cost.

Sharing it means sending one file. The recipient double-clicks it and is working.

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

| Encoding | Meaning |
|---|---|
| Node size | Citation count |
| Node colour | Publication year — silver (older) to blue-slate (newer) |
| Coral ring | The seed paper |
| Edge weight | Similarity between the two papers |

Drag nodes, scroll to zoom, and use the **Spacing** slider to loosen or tighten the
layout. Click any node to see its abstract, authors, and DOI — and to rebuild the
whole graph around it.

### Prior and derivative works

Two tabs beside the graph list what the seed paper cites and what cites it, ranked
by citation count.

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

Google Fonts is the only other external reference; if it is unreachable the app
falls back to system fonts and works normally.

---

## Credits

Sangin Kim — <kimsanginn@gmail.com>

Acknowledgements are listed in the app, under the link in the bottom-right corner.

Paper data from [OpenAlex](https://openalex.org). Graph layout by
[d3](https://d3js.org).

Licensed under the [MIT License](LICENSE). Free to use, modify, and sell, provided
the copyright notice is kept.

GraphPapers is an independent project. It is not affiliated with, endorsed by, or
derived from the code or design of Connected Papers; the comparison in this document
is descriptive only.
