
# Working with Graphs.jl

PkgGraph does not depend on any of the packages from [JuliaGraphs](https://juliagraphs.org/).

However, you can easily convert the list of package dependencies to a type that supports
the [Graphs.jl interface]. You are then able to use the ecosystem's powerful set of graph analysis tools. See [`PkgGraph.as_graphsjl_input`](@ref).

[Graphs.jl interface]: https://juliagraphs.org/Graphs.jl/dev/ecosystem/interface/



## Example

For an example of using Graphs.jl functions on a package dependency DAG, see
[`test/graphsjl_interop.jl`][gh], where we analyze the dependency graph
of `Tests`:

```@raw html
<img width=400
     src="https://raw.githubusercontent.com/tfiers/PkgGraph.jl/main/docs/img/Test-deps.svg">
```
[gh]: https://github.com/tfiers/PkgGraph.jl/blob/main/test/graphsjl_interop.jl


This is a summary of that file:

```julia
using Graphs

edges = PkgGraph.depgraph("Test")

packages = PkgGraph.vertices(edges)
node     = PkgGraph.node_index(edges)
A        = PkgGraph.adjacency_matrix(edges)

# Or, more efficiently:
packages, node, A = PkgGraph.as_graphsjl_input(edges)

g = DiGraph(A)

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
