<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/hero-dark.png">
  <img src="docs/hero.png" alt="GraphPapers — a similarity graph built around the GW150914 detection paper">
</picture>

[한국어](README.ko.md)

<sub>Built around the 2016 detection of GW150914. Live data, as the app always shows it.</sub>

# GraphPapers

**v1.1** · [Open it in a browser](https://oddthumb.github.io/GraphPapers/)

A free, single-file paper-graph tool. Enter a paper, get a graph of the forty works most related to it — then go where following citations cannot take you.

Tools of this kind show you the neighbourhood of one paper. These two are why this one exists:

- **Quantum Jump** — moves to a paper with *no citation link* to the one you are reading, found four different ways, leaving a trail you can retrace and evidence for every step.
- **Bridge** — give it two papers and it finds the chain connecting them, or tells you plainly that there isn't one.

No install. No account. No API key. No backend. One HTML file, on a desktop or a phone.

### Your first thirty seconds

The fastest way in is the **?** button next to the legend, at the top right of the graph. Pick one of four short tracks and the app dims everything except the control you need next, tells you what it does, and waits while you press the real thing — the graph, Quantum Jump, Bridge, and getting results out each get their own. A written manual sits behind the same button if you would rather read.

Or find your own way:

1. Open the link and type a paper title — or press **Surprise me** and take whatever comes.
2. Click any node to read its abstract, or to rebuild the graph around it.
3. Press **Story prompt**, copy the text, paste it into any LLM. You get a written history of that research line, at no cost.

Then try **Quantum Jump!**, or **Bridge to another paper** with a second paper in mind. Everything below is reference — read it when you want to know why a line is drawn where it is.

---

## Running it

Open it at **https://oddthumb.github.io/GraphPapers/**, or download `index.html` and double-click it. Either way works, and both are the whole procedure.

Everything the app needs to run is inside that file, including the d3 graph library. The only thing it fetches from the network is the paper data itself, live from [OpenAlex](https://openalex.org) — a free, open catalogue of 250M+ works that needs no key and imposes no cost.

Sharing it means sending a link, or one file. Either way the recipient is working immediately.

---

## What it does

### Similarity graph

Enter a title, DOI, or OpenAlex ID. **Surprise me** picks a paper at random instead — from anywhere in OpenAlex, which in practice means anywhere in science. The draw asks only for a bibliography, since that is what a graph is built from; it does not ask for citations, which would quietly exclude everything published recently. The app pulls the seed paper's references and the works citing it, then scores every candidate against the seed using the same two measures Connected Papers uses:

- **Bibliographic coupling** — two papers that cite many of the same works are
probably about the same thing.
- **Co-citation** — two papers that are frequently cited together are probably
about the same thing.

Both measures are standard bibliometrics, not anyone's proprietary method — bibliographic coupling is Kessler (1963), co-citation is Small (1973).

Or drop a PDF of an already-published paper — anywhere on the page, or via the 📎 button next to the search box — and the app reads the DOI (or, failing that, an arXiv id) straight out of the file's own bytes and searches for it exactly as if you had typed the title; if it can't find one, or OpenAlex doesn't know it, it says so and leaves the search box focused so you can type the title instead.

The 40 highest-scoring papers become the graph. Each node connects to its three nearest neighbours, so clusters emerge on their own.

**An edge means similarity, not citation.** Two papers are joined because they cite the same works or are cited together — they need not cite each other at all. Where a real citation does exist between two joined papers, the edge carries an arrowhead pointing at the older work. To see citations on their own terms, tick **Citation links**: that overlays every real citation between the papers on screen, on top of the similarity layout, without moving anything.

| Encoding | Meaning |
|---|---|
| Node size | Citation count |
| Node colour | Publication year — pale (older) to dark (newer) |
| Accent ring | The seed paper |
| Edge weight | Similarity between the two papers |
| Edge colour | Distance from the seed — the accent, fading with each hop |

Hover an edge for a moment and a card explains why the two papers it joins are linked: the papers that cite both of them, and the references they share, listed by title — deliberately, since a reader can check "these 7 papers cite both" and cannot check "0.34." The card waits a beat before appearing, so it does not flicker as the pointer crosses the graph; it is a similarity-graph feature only, not the bridge view.

Everything that changes the graph lives in one panel at its top-left; everything that only reads from it — **Story prompt**, **Export citations** — stays in the tab bar. The **i** button at the top-right opens the full legend.

Drag nodes, scroll to zoom, and use the **Spacing** slider to loosen or tighten the layout, or open **Advanced** for the four forces underneath it — link distance, pull, push and collision gap, each slider centred on the value the layout was tuned to.

**Reshuffle** throws the nodes to new starting positions and lets the layout settle again — a force layout falls into whichever arrangement its start positions lead to, so a tangled graph often untangles on the second try. **Timeline** stacks the papers by year instead, oldest at the top, so citation arrows all point upward into the past; each year that actually occurs gets an equal band, so a single old reference cannot squash the recent decade into a sliver. Four colour palettes sit in the header, in two pairs — Editorial and Dark are the soft ones, Ink and Noir the high-contrast ones — plus System, which follows your operating system.

Click a node to pin its neighbourhood; click empty canvas to release it. Click any node to see its abstract, authors, and DOI — and to rebuild the whole graph around it.

The **camera** button next to **?** and **i** saves the graph as a PNG, in this view or the bridge view. It captures the full layout, not just whatever is currently zoomed into view, so zooming in never crops the export; in Timeline mode the year grid is redrawn for the exported width. Chrome and Edge let you choose where to save the file; Safari and Firefox lack that browser capability and just download it — that is expected, not a bug.

### Prior and derivative works

Two tabs beside the graph list what the seed paper cites and what cites it, ranked by citation count.

### Quantum Jump

Following citations keeps you inside one conversation. **Quantum Jump!** leaves it: it moves the graph to a paper that has *no citation link* to the current one, and draws a trail back to where you came from, so the path stays visible however far you wander.

Four ways of finding those papers, chosen with **Find by**:

| | It looks for | It cannot see |
|---|---|---|
| **Read together** | Papers other researchers cite alongside this one, though the two never cite each other | Papers too recent for anyone to have cited them yet |
| **Shared foundations** | Papers that cite the same *rare* works this one cites | Work built on a different literature |
| **Same ideas** | Papers tagged with subjects you choose, and no bibliometric tie at all | Work OpenAlex has tagged differently |
| **Linked through a third paper** | Papers with no link to yours, both strongly tied to some intermediate — Swanson's 1986 method, which connected fish oil to Raynaud's disease through blood viscosity | Pairs with no intermediate in common |

**Same ideas** hands you the seed's own subject tags and lets you pick which to combine. The choice decides the reach: keeping the object terms holds you inside the field, while picking a measurement term — *spectral analysis*, say — reaches work in medicine or engineering doing the same kind of analysis. OpenAlex does not mark which tags are which, and only the person reading knows which axis matters.

The four routes returned no overlapping candidates at all in testing, on either seed.

Rarity is what makes the second one work. Sharing a field's standard catalogue with someone is no evidence of anything; sharing a paper cited eight times means you are looking at nearly the same problem.

Both are corrected for fame — a raw count of shared citations just returns whichever papers everyone cites. Both drop candidates already drawn, so pressing the button again gives you somewhere new; **Undo jump** steps back, and **Reset draws** starts over. **Field** narrows the search to the same discipline, or restricts it to a different one.

Hover the trail to see why two papers were linked: the works that cite them both, or the references they share.

### Bridge between two papers

Quantum Jump leaves one conversation for another. **Bridge** asks the opposite question: given two particular papers, how are they connected at all?

Press **Bridge to another paper**, then enter a second paper — or press **Surprise me** to draw one at random. The app searches outward from both papers at once and returns the chain of papers linking them, drawn as two clusters with the route running between.

Two ways to choose the route, because "closest" has two meanings:

| | It returns |
|---|---|
| **Fewest steps** | The shortest chain, counting papers |
| **Strongest link** | The chain whose links are strongest, even when it is longer |

Strongest link charges each step as 1/similarity and takes the cheapest total, so a long chain of tight links can beat a short chain of weak ones — while every step still costs something, so length is never free. Fewest steps is the same calculation with every step costing exactly 1.

The search stops at five steps. If nothing is found by then, the two papers have no path through the citation record — which is an answer in itself.

The route stays highlighted and everything else stays dimmed; that is the resting state, not a hover effect. Click any dimmed paper to bring it and its neighbours forward without losing the route. Route edges carry no arrowhead: each step's citation may point either way, so the path has no single direction.

If the second paper is one the first already cites, the app says so — there is no intermediate paper to find, and both modes return the same answer.

While it searches, a bundle of field lines runs between the two papers, blooming outward and then narrowing as the candidate routes narrow. It is driven by the search itself rather than a timer, so what you see is how much is still undecided.

The left-hand control panel adapts: Layout, Spacing, Advanced and Reshuffle stay and act on the bridge graph, while the filters and the citation overlay are hidden — a filter that hid a paper on the route would remove the only thing this view exists to show.

**Timeline** works here too, and shows more than it does on a single graph: year runs down the screen while the two papers keep their own sides, so you can see whether the route runs back through an older common ancestor or forward through recent work.

**Export citations** gains a **Route only** scope — the intermediate papers are the evidence for the connection — alongside everything on screen. **Story prompt** switches too: instead of a chronological history it asks what each research line does not know about the other, why each intermediate paper ties to both, what question an actual link would pose, and — explicitly — whether the connection is spurious, so the model is invited to say no.

### Every reference

The **Prior works** tab lists the whole bibliography, not a sample of it. The graph is built from the first hundred references, since that is enough to score similarity; opening the tab fetches the rest and the tab label carries the real total, so you can see the list is complete. Where OpenAlex has no record for a cited id — deleted or merged entries happen — the footer says how many could not be retrieved, rather than leaving a silent gap.

### Citation export

**Export citations** writes the papers out as BibTeX, RIS, APA, MLA, or Chicago — one paper, everything the filters currently show, all 40, or every reference the paper cites — the last is the one to use when auditing a manuscript's bibliography. Copy it, or download a `.bib` / `.ris` file and drag it straight into Zotero, EndNote, or Overleaf.

Author names come from OpenAlex as single strings, so the family name is taken as everything after the last space. That is right for most Western names and wrong for some; check the names before submitting.

### Filtering

In the same left-hand panel: keyword (title and authors), year range, minimum citations, open access, and journal impact. The journal filter uses OpenAlex's 2-year mean citedness, ranked among the journals present in the current graph — it is **not** a JCR quartile, which is not open data. Filtering hides papers without moving the layout, and resets whenever you build a new graph.

### LLM story prompt

The **Story prompt** button assembles a prompt describing the graph — every paper grouped as prior, later, or related, with its year, first author, citation count, and distance from the centre in graph hops.

Copy it into ChatGPT, Claude, Gemini, or anything else, and you get a written history of the research line: what problem the centre paper solved, what led to it, and what it produced.

| Depth | Papers | Use it for |
|---|---|---|
| 1 | about 10 | A tight story about the paper's immediate neighbourhood |
| 2 | about 25 | The default — enough context to see a lineage |
| 3 | about 37 | The whole field around the paper |
| All | 39 | Everything in the graph |

Output language is switchable between English and Korean, independently of the interface language: reading the app in Korean does not force a Korean prompt.

The app builds this text itself — it never calls an LLM, so this step costs nothing, needs no key, and works instantly. Which model reads it is entirely your choice.

---

### Language

The interface is available in English and Korean, chosen in the header and remembered between visits. Paper titles, authors and abstracts stay as OpenAlex supplies them, and citation output keeps its academic format — those are data, not interface.

## Data freshness

There is no local cache and no database. Every lookup goes straight to OpenAlex, so what you see is what OpenAlex holds at that moment. The bottom-right corner always shows the time of the current fetch and the date OpenAlex last updated the seed record, so you know exactly what you are looking at.

The cost of that guarantee is that **the app needs an internet connection**. Without one it opens and renders, but cannot fetch papers, and says so.

OpenAlex allows 1,000 requests a day, counted per IP address — your own, not shared with anyone else using GraphPapers. A graph costs four to eight requests, a Quantum Jump one to six, and a bridge search six to twelve, so the ceiling is somewhere above a hundred graphs a day and most people will never approach it. The bottom-right corner shows a thin bar with the count beside it, such as `934 / 1000`, and turns the count accent-coloured as it runs low; hover it for the full sentence, including when it resets — so the limit is visible before it is reached rather than arriving as an unexplained failure.

---

## Requirements

A modern browser. That is all.

### Collapsible panels

On desktop, a small arrow button straddles the inner edge of the control panel and the detail panel; press it to fold that panel to a slim tab — a sliders icon on the left, **Detail** on the right — and press the tab to bring the panel back. Each panel remembers whether you left it collapsed, between visits.

### On a phone

The layout rearranges below 760px rather than scaling down. The graph and the detail panel stop sitting side by side and the panel becomes a sheet that slides up when you tap a node, since a strip under a full-height graph cannot be read and cannot be scrolled to — dragging over the canvas pans the graph. The control panel folds behind a button so it does not cover what it controls, and the header wraps to give the search box a full row. Pinch to zoom and drag nodes work on touch.

Google Fonts is the only other external reference; if it is unreachable the app falls back to system fonts and works normally.

---

## Credits

Sangin Kim — <kimsanginn@gmail.com> Sehwan Cheon — <thousandsh2@gmail.com>

Ideas, bug reports, and pull requests are welcome; contributors are credited in the app, under the Acknowledgements link in the bottom-right corner.

Paper data from [OpenAlex](https://openalex.org). Graph layout by [d3](https://d3js.org).

Licensed under the [MIT License](LICENSE). Free to use, modify, and sell, provided the copyright notice is kept.

1.0 means the shape has settled, not that the work is finished. Everything described here has been used, not just built. What comes next is written above the line, not below it — a bibliography audit against your own `.bib`, and better answers to questions the citation record alone cannot settle.

GraphPapers is an independent project. It is not affiliated with, endorsed by, or derived from the code or design of Connected Papers; the comparison in this document is descriptive only.
