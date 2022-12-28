
# Background

Explanation of choices and tradeoffs, discussion of alternatives, and other
PkgGraph-related trivia.



## Local vs 'online' rendering

('Online' is in quotes, because the ([`PkgGraph.webapps`](@ref))
use wasm-compiled versions of graphviz. I.e. in the end, graphviz does run on your local
computer. Though, alas, you do need an active internet connection to access these web-apps).

The advantage of the web-apps over local rendering is that they provide a nice
interactive editor, for if you want to tweak your output.

Magnus Jacobsson's [magjac.com/graphviz-visual-editor][mj] is especially good for
this, as it provides a GUI interface for adding new nodes and changing styles.
(It is also the renderer linked from the official [graphviz.org] website,
and [its repository][gh] is receiving active updates at the time of writing).

You can use Magnus's app by providing the following as second argument to
[`PkgGraph.open`](@ref):

```jldoctest; setup=:( using PkgGraph )
julia> base_url = PkgGraph.webapps[2]
"http://magjac.com/graphviz-visual-editor/?dot="

julia> # PkgGraph.open(:Test, base_url)
```

[mj]: http://magjac.com/graphviz-visual-editor
[gh]: https://github.com/magjac/graphviz-visual-editor
[graphviz.org]: https://graphviz.org



## Styling Graphviz output

The fastest way to find how to do something with the Graphviz DOT language is probably to look at [graphviz.org/gallery][1], and find an example that does something similar to what you want. Every example comes with the DOT source that produced it.

You could also take a look at the [Attributes documentation][2].

Note that it is often hard or not feasible to achieve a particular graphic effect with
Graphviz. (See the quote by one of Graphviz's authors in [Graphviz today](@ref) below).
The better option, if you want a particular style, is probably to import the generated
SVG image into a design program, and then edit that manually; or even to re-create the
graph from scratch.

[1]: https://graphviz.org/gallery
[2]: https://graphviz.org/doc/info/attrs.html



## Related packages

#### [PkgDependency.jl]

Nice and actively maintained package that does a very similar thing to PkgGraph, and has
no non-Julia dependencies. Prints package dependencies as a tree in the REPL. Because
package dependencies are a DAG and not a tree, there are repeated names in the printout
(those are marked with a `(*)`).

#### [PkgDeps.jl]

Provides a very useful `users(pkg)` function, to see downstream
dependents of a package (instead of upstream like here).
Also has `dependencies(pkg)` and `direct_dependencies(pkg)` functions.

#### [Graphviz.jl]

Bundles the `dot` binary (via [JuliaBinaryWrappers/Graphviz_jll][Graphviz_jll]), and
provides access in Julia to graphviz's C API.
Provides the `@dot_str` macro to render dot strings in a notebook.

#### [GraphvizDotLang.jl]

Recent package, under active development at the time of writing. A beautiful package to
generate and render dot-strings. Uses Julia's piping syntax. Had I discovered this
package before writing PkgGraph, I might have used it as a dependency. (Replacing things
like [`PkgGraph.Internals.to_dot_str`](@ref)).


[PkgDependency.jl]:   https://github.com/peng1999/PkgDependency.jl
[PkgDeps.jl]:         https://github.com/JuliaEcosystem/PkgDeps.jl
[Graphviz.jl]:        https://github.com/JuliaGraphs/GraphViz.jl
[Graphviz_jll]:       https://github.com/JuliaBinaryWrappers/Graphviz_jll.jl
[GraphvizDotLang.jl]: https://github.com/jhidding/GraphvizDotLang.jl



## The Graphs.jl ecosystem

PkgGraph does not depend on any of the packages from [JuliaGraphs](https://juliagraphs.org/).

You can easily convert the list of package dependencies to a type that supports
the [graph interface], however. You are then able to use the ecosystem's powerful set of graph analysis tools.

See [`PkgGraph.depgraph`](@ref) and [`PkgGraph.vertices`](@ref) for how to obtain the graph edges and vertices respectively.

See the script [`PkgGraph.jl/test/JuliaGraphs_interop.jl`][gh] for an example,
where we analyze the dependency graph of `Tests`:

```@raw html
<img width=600
     src="https://raw.githubusercontent.com/tfiers/PkgGraph.jl/main/docs/img/Test-deps.svg">
```

Some excerpts from the script:
```julia
@test outdegree(g, node(:Test)) == 4
@test indegree(g, node(:Test)) == 0

dijkstra_shortest_paths(g, node(:Test))
# + some wrangling =
"""
Distance from Test to …
              Test: 0
  InteractiveUtils: 1
          Markdown: 2
            Random: 1
            Base64: 3
           Logging: 1
               SHA: 2
     Serialization: 1
"""
```

Note that we use [MetaGraphsNext.jl] in the script to construct our graph. The
`SimpleDiGraph` from the main package, Graphs.jl, requires nodes to be integers; and we
want text labels.

[graph interface]: https://juliagraphs.org/Graphs.jl/dev/ecosystem/interface/
[gh]: https://github.com/tfiers/PkgGraph.jl/blob/main/test/JuliaGraphs_interop.jl
[MetaGraphsNext.jl]: https://github.com/JuliaGraphs/MetaGraphsNext.jl


## Júlio Hoffimann's notebook

There is a notebook in [JuliaGraphsTutorials] that analyzes the complete graph of Julia package dependencies: [nbviewer link].

Note that this is older code (Julia 0.6), from back when only 1500 packages were registered (circa 2017).

See the links at the top of the notebook for interactive D3.js visualizations of the
dependency graph, and of a world map of Julians.

[JuliaGraphsTutorials]: https://github.com/JuliaGraphs/JuliaGraphsTutorials
[nbviewer link]: https://nbviewer.org/github/JuliaGraphs/JuliaGraphsTutorials/blob/master/DAG-Julia-Pkgs.ipynb



## Alternatives to Graphviz

### Mermaid

'[Mermaid diagrams]' are something more newfangled than [Graphviz].

Mermaid uses the [Dagre.js] library for graph layout.
Dagre.js is in part based on `dot`. From their [wiki]:
> The general skeleton for Dagre comes from
> [Gansner, et al., "A Technique for Drawing Directed Graphs"](@ref Gansner1993), 
> which gives both an excellent high level overview of the phases
> involved in layered drawing as well as diving into the details and problems
> of each of the phases. Besides the basic skeleton, we specifically used
> the technique described in the paper to produce an acyclic graph, 
> and we use the network simplex algorithm for ranking. 
> If there is one paper to start with when learning about layered graph drawing,
> this is it!
(See also [mentions of the paper in Dagre's codebase][mentions]).

Mermaid has prettier default styling than Graphviz.\
But, I find that `dot` does a bit better at graph layout than Mermaid / Dagre.

By choosing Graphviz over Mermaid, we trade-off some styling and style-ability¹ 
for better default DAG layouts.

¹ The default Graphviz style is not awesome, and many effects are infeasible to achieve.
  (See also the critical note in [Styling Graphviz output](@ref) above).

[Mermaid diagrams]: https://mermaid-js.github.io/mermaid
[Graphviz]:         https://graphviz.org
[Dagre.js]:         https://github.com/dagrejs/dagre
[wiki]:             https://github.com/dagrejs/dagre/wiki#recommended-reading
[mentions]:         https://github.com/search?q=repo:dagrejs/dagre%20gansner&type=code


### Julia packages for DAG layout

For graph layout and visualization there are [NetworkLayout.jl] (outputs coordinates)
and [GraphPlot.jl] (outputs images).
Neither work well with long-ish text labels, nor do they have any specific layout algorithms for DAGs.

(See also, [The `dot` algorithm in Julia?](@ref))

[NetworkLayout.jl]: https://github.com/JuliaGraphs/NetworkLayout.jl
[GraphPlot.jl]: https://github.com/JuliaGraphs/GraphPlot.jl



## Graphviz today

My impressions from browsing through the [Graphviz Discourse forum] and [their GitLab]:
- Two of the original creators (Emden R. Gansner and Stephen C. North)
  are still engaged with the project (though they are not writing much code anymore)
- There are new maintainers, actively making edits to the codebase at the time of writing.
- The codebase – though working fantastically still in 2022 –
  seems a bit unwieldy to add new features to. See the following quote.

From a [2020 Hacker News comment] by one of Graphviz's creators (edited):
> We're reluctant to be exposed to too much anger about misfeatures in 20 year old code
> that was basically a prototype that escaped from the lab, [..]
>
> We've gotten a lot of help lately from Magnus Jacobsson, Matthew Fernandez and Mark
> Hansen on cleaning up the website and the code base, even some persistent bugs we
> could never find ourselves.
> 
> Improvements that would benefit the community the most?
> - better default styles that don't look like troff from 1985
> - more expressive graph language with classes or templates
> - better documentation to help people find useful tools or just know what they should be looking for
> - it would be a big effort, but move the core algorithms to a framework that supports interaction with layout generation

[Graphviz Discourse forum]: https://forum.graphviz.org/top?period=all
[their GitLab]:             https://gitlab.com/graphviz/graphviz
[2020 Hacker News comment]: https://news.ycombinator.com/item?id=23475225



## The `dot` algorithm in Julia?

A fun project would be to translate the four-step DAG layout algorithm,
described very well in [the original paper](@ref Gansner1993), to Julia.

The code would probably be shorter, and maybe more maintainable,
than [the current C implementation][1].

[1]: https://gitlab.com/graphviz/graphviz/-/tree/main/lib
<!-- most salient is the 'common/' src dir; contains e.g network simplex code -->



## [The original paper on dot's algorithm](@id Gansner1993)
<!-- Can't have `code format` (here: `dot`) when naming headers like this. boo. -->
<!-- (todo, file this bug in Documenter.jl) -->

> E. R. Gansner, E. Koutsofios, S. C. North and K.-P. Vo,
> "**A technique for drawing directed graphs**,"
> IEEE Transactions on Software Engineering, Mar. 1993.
> [doi: 10.1109/32.221135](https://doi.org/10.1109/32.221135)

An open version of this paper is available via the official Graphviz website:
- [graphviz.org/documentation/TSE93.pdf](https://graphviz.org/documentation/TSE93.pdf)

That version is alas not typeset as nicely as the IEEE-version.\
For those without institutional access, please see the following 
- [copy of the IEEE-typeset version](https://tomasfiers.net/content/Gansner1993IEEE.pdf)

For more publications on Graphviz, see [graphviz.org/theory](https://graphviz.org/theory).

---

For more on Graphviz, see
- The official [website](https://graphviz.org),
- This curated list of Graphviz-related resources: ['Awesome GraphViz'][1]

[1]: https://github.com/CodeFreezr/awesome-graphviz#readme
