
"""
NOTE: When updating this script, make sure the distillation in
docs/bg/graphsjl.md is up-to-date too.
"""

using PkgGraph
using Test

println("Loading Graphs")
using Graphs: DiGraph,
              outdegree,
              indegree,
              dijkstra_shortest_paths
println(" … done")
# When running full test suite, `vertices` is still loaded from another
# test file, and we get a "conflict" warning if we just do `using
# Graphs`. Hence this specific list of names.

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

io = IOBuffer()
println(io, "Distance from Test to …")
for (i, pkg) in enumerate(packages)
    dist = ds.dists[i]
    print(io, lpad(pkg, maximum(length, packages) + 2))
    println(io, ": ", Int(dist))
end
printed = String(take!(io))
@test printed == """
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
