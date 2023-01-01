
using PkgGraph
using Test

print("Loading Graphs, MetaGraphsNext … ")
using Graphs, MetaGraphsNext
println("done")

edges = PkgGraph.depgraph(:Test)

packages = PkgGraph.vertices(edges)

g = MetaGraph(DiGraph())

# Nodes must be created before edges can be added
for pkg in packages
    g[Symbol(pkg)] = nothing
end

for (pkg, dep) in edges
    g[Symbol(pkg), Symbol(dep)] = nothing
end

node(s) = code_for(g, s)

@test outdegree(g, node(:Test)) == 4
@test indegree(g, node(:Test)) == 0

ds = dijkstra_shortest_paths(g, node(:Test))

io = IOBuffer()
println(io, "Distance from Test to …")
for i in Graphs.vertices(g)
    pkg = label_for(g, i)
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
