
# Graphs.jl interop

PkgGraph does not depend on any of the packages from [JuliaGraphs](https://juliagraphs.org/).

However, you can easily convert the list of package dependencies to a type that supports
the [graph interface]. You are then able to use the ecosystem's powerful set of graph analysis tools.

Use [`PkgGraph.depgraph`](@ref) and [`PkgGraph.vertices`](@ref) to obtain the graph edges and vertices, respectively.

[graph interface]: https://juliagraphs.org/Graphs.jl/dev/ecosystem/interface/



## Example

For an example of using Graphs.jl functions on a package dependency DAG, see
[`test/JuliaGraphs_interop.jl`][gh], where we analyze the dependency graph
of `Tests`:

```@raw html
<img width=400
     src="https://raw.githubusercontent.com/tfiers/PkgGraph.jl/main/docs/img/Test-deps.svg">
```
[gh]: https://github.com/tfiers/PkgGraph.jl/blob/main/test/JuliaGraphs_interop.jl


This is a summary of that file:

```julia
using Graphs

edges = PkgGraph.depgraph("Test")
packages = PkgGraph.vertices(edges)

g = DiGraph(length(packages))

# Graphs.jl needs nodes to be integers
nodes = Dict(pkg => i for (i, pkg) in enumerate(packages))
node(pkg) = nodes[pkg]

for (pkg, dep) in edges
    add_edge!(g, node(pkg), node(dep))
end

@test outdegree(g, node("Test")) == 4
@test indegree(g, node("Test")) == 0

ds = dijkstra_shortest_paths(g, node("Test"))
# ..plus some wrangling & formatting, and we get:
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
