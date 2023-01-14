
"""
    as_graphsjl_input(edges)

Obtain the outputs of, respectively
- [`vertices(edges)`](@ref)
- [`node_index(edges)`](@ref)
- [`adjacency_matrix(edges)`](@ref)

..but without unnecessary repeat computation.

Useful when converting the output of [`depgraph`](@ref) to a `Graphs.jl`
graph;\\
See the example script in [Working with Graphs.jl](@ref).
"""
function as_graphsjl_input(edges)
    verts = vertices(edges)
    f = node_index(verts)
    edges = as_int_pairs(edges, f)
    A = adjacency_matrix(edges, N = length(verts))
    return (;
        vertices = verts,
        indexof = f,
        adjacency_matrix = A,
    )
end

"""
    vertices(edges)

Extract the unique nodes from the given list of edges.

## Example:

```jldoctest
julia> using PkgGraph.DepGraph

julia> edges = depgraph(:Test);

julia> vertices(edges)
8-element Vector{String}:
 "Test"
 "InteractiveUtils"
 "Markdown"
 "Random"
 "Base64"
 "Logging"
 "SHA"
 "Serialization"
```
"""
vertices(edges) = [first.(edges); last.(edges)] |> unique!

const Edge = Union{Pair{I,I}, Tuple{I,I}} where I
const EdgeList = AbstractVector{<:Edge{I}} where I

"""
    node_index(edges)
    node_index(vertices)

Create a function that returns the index of a given vertex.

This is useful because Graphs.jl requires vertices to be integers.

## Example:

```jldoctest
julia> using PkgGraph.DepGraph

julia> edges = ["A"=>"B", "B"=>"C"];

julia> node = node_index(edges);

julia> node("C")
3
```
"""
node_index(edges::EdgeList) = node_index(vertices(edges))
node_index(vertices) = begin
    nodes = Dict(v => i for (i, v) in enumerate(vertices))
    node(v) = nodes[v]
end

as_int_pairs(edges, f = node_index(edges)) =
    [f(src) => f(dst) for (src, dst) in edges]

"""
    adjacency_matrix(edges)

A square bitmatrix `A` that is `0` everywhere except at `A[i,j]` when there
is a connection _from_ the node with index `i` to the node with index `j`.

## Example:
```jldoctest
julia> using PkgGraph.DepGraph

julia> edges = [
           :A => :A
           :A => :B
           :B => :C
       ];

julia> adjacency_matrix(edges)
3×3 BitMatrix:
 1  1  0
 0  0  1
 0  0  0
```
"""
adjacency_matrix(edges) = adjacency_matrix(as_int_pairs(edges))
adjacency_matrix(
    edges::EdgeList{<:Integer};
    N = length(vertices(edges))
) = begin
    A = falses(N, N)
    for (i, j) in edges
        A[i, j] = true
    end
    A
end
