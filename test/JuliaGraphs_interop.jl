
"""
NOTE: When updating this script, make sure the distillation in
docs/related-work.md is up-to-date too.
"""

using PkgGraph
using Test

println("Loading Graphs")
using Graphs
println(" … done")

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

io = IOBuffer()
println(io, "Distance from Test to …")
for (i, pkg) in enumerate(packages)
    dist = ds.dists[i]
    print(io, lpad(pkg, maximum(length, packages) + 2))
    println(io, ": ", Int(dist))
end
printed = String(take!(io))
if VERSION ≥ v"1.7"
    expected = """
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
else
    expected = """
    Distance from Test to …
                  Test: 0
      InteractiveUtils: 1
              Markdown: 2
                Random: 1
                Base64: 3
               Logging: 1
         Serialization: 1
    """
    # Random added SHA dependency apparently in 1.7
end
@test printed == expected
