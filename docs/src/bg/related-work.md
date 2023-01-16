
# Related work


## Julia packages

#### [PkgDependency.jl]

Nice and actively maintained package that does a very similar thing to PkgGraph, and has
no non-stdlib dependencies.\
Prints package dependencies as a tree in the REPL. Because package dependencies are a DAG 
and not a tree, there are repeated names in the printout (those are marked with a `(*)`).\
For each dependency, shows the version, and optionally compat info and the repository link.

#### [PkgDeps.jl]

Provides a very useful `users(pkg)` function, to see downstream
dependents of a package (instead of upstream like here).
Also has `dependencies(pkg)` and `direct_dependencies(pkg)` functions.

#### [Graphviz.jl]

Bundles the graphviz binaries (including `dot`) (via [JuliaBinaryWrappers/Graphviz_jll][Graphviz_jll]),
and provides access in Julia to graphviz's C API.
Provides the `@dot_str` macro to render dot strings in a notebook.

#### [GraphvizDotLang.jl]

Recent package, under active development at the time of writing. A beautiful package to
generate and render dot-strings. Uses Julia's piping syntax. Had I discovered this
package before writing PkgGraph, I might have used it as a dependency. (Replacing things
like [`PkgGraph.to_dot_str`](@ref)).


[PkgDependency.jl]:   https://github.com/peng1999/PkgDependency.jl
[PkgDeps.jl]:         https://github.com/JuliaEcosystem/PkgDeps.jl
[Graphviz.jl]:        https://github.com/JuliaGraphs/GraphViz.jl
[Graphviz_jll]:       https://github.com/JuliaBinaryWrappers/Graphviz_jll.jl
[GraphvizDotLang.jl]: https://github.com/jhidding/GraphvizDotLang.jl



## Júlio Hoffimann's work

There is a notebook in [JuliaGraphsTutorials], by Júlio Hoffimann, that analyzes the
complete graph of Julia package dependencies: {[nbviewer link]}.

Note that this is older code (Julia 0.6), from back when only 1500 packages were registered (circa 2017).

Júlio also made interactive D3.js visualizations of the dependency graph, and of a world
map of Julians (See the links at the top of the notebook).

[JuliaGraphsTutorials]: https://github.com/JuliaGraphs/JuliaGraphsTutorials
[nbviewer link]: https://nbviewer.org/github/JuliaGraphs/JuliaGraphsTutorials/blob/master/DAG-Julia-Pkgs.ipynb
