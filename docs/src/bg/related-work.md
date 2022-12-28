
# Related work



## Related Julia packages

#### [PkgDependency.jl]

Nice and actively maintained package that does a very similar thing to PkgGraphs, and has
no non-Julia dependencies. Prints package dependencies as a tree in the REPL. Because
package dependencies are a DAG and not a tree, there are repeated names in the printout
(those are marked with a `(*)`).

#### [PkgDeps.jl]

Provides a very useful `users(pkg)` function, to see downstream
dependents of a package (instead of upstream like here).
Also has `dependencies(pkg)` and `direct_dependencies(pkg)` functions.

#### [Graphviz.jl]

Bundles the graphviz binaries (including `dot`) (via [JuliaBinaryWrappers/Graphviz_jll][Graphviz_jll]), and provides access in Julia to graphviz's C API.
Provides the `@dot_str` macro to render dot strings in a notebook.

#### [GraphvizDotLang.jl]

Recent package, under active development at the time of writing. A beautiful package to
generate and render dot-strings. Uses Julia's piping syntax. Had I discovered this
package before writing PkgGraphs, I might have used it as a dependency. (Replacing things
like [`PkgGraphs.Internals.to_dot_str`](@ref)).


[PkgDependency.jl]:   https://github.com/peng1999/PkgDependency.jl
[PkgDeps.jl]:         https://github.com/JuliaEcosystem/PkgDeps.jl
[Graphviz.jl]:        https://github.com/JuliaGraphs/GraphViz.jl
[Graphviz_jll]:       https://github.com/JuliaBinaryWrappers/Graphviz_jll.jl
[GraphvizDotLang.jl]: https://github.com/jhidding/GraphvizDotLang.jl



## The Graphs.jl ecosystem

PkgGraphs does not depend on any of the packages from [JuliaGraphs](https://juliagraphs.org/).

However, you can easily convert the list of package dependencies to a type that supports
the [graph interface]. You are then able to use the ecosystem's powerful set of graph analysis tools.

See [`PkgGraphs.depgraph`](@ref) and [`PkgGraphs.vertices`](@ref) for how to obtain the graph edges and vertices, respectively.

For an example of using Graphs.jl functions on a package dependency DAG, see
[`PkgGraphs.jl/test/JuliaGraphs_interop.jl`][gh], where we analyze the dependency graph
of `Tests`:

```@raw html
<img width=400
     src="https://raw.githubusercontent.com/tfiers/PkgGraphs.jl/main/docs/img/Test-deps.svg">
```

Some excerpts from that script:
```julia
edges = PkgGraphs.depgraph(:Test)
packages = PkgGraphs.vertices(edges)

g = MetaGraph(DiGraph())

# [..adding nodes and edges to `g`..]

@test outdegree(g, node(:Test)) == 4
@test indegree(g, node(:Test)) == 0

ds = dijkstra_shortest_paths(g, node(:Test))
# [..plus some wrangling & formatting, and..]
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
[gh]: https://github.com/tfiers/PkgGraphs.jl/blob/main/test/JuliaGraphs_interop.jl
[MetaGraphsNext.jl]: https://github.com/JuliaGraphs/MetaGraphsNext.jl



## Júlio Hoffimann's work

There is a notebook in [JuliaGraphsTutorials], by Júlio Hoffimann, that analyzes the
complete graph of Julia package dependencies: {[nbviewer link]}.

Note that this is older code (Julia 0.6), from back when only 1500 packages were registered (circa 2017).

Júlio also made interactive D3.js visualizations of the dependency graph, and of a world
map of Julians (See the links at the top of the notebook).

[JuliaGraphsTutorials]: https://github.com/JuliaGraphs/JuliaGraphsTutorials
[nbviewer link]: https://nbviewer.org/github/JuliaGraphs/JuliaGraphsTutorials/blob/master/DAG-Julia-Pkgs.ipynb
