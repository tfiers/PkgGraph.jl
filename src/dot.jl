
"""
    deps_as_DOT(pkgname)

Create the dependency graph of `pkgname` and render it as a Graphviz DOT string.

Example output (truncated), for `"Unitful"`:
```
digraph {
    Unitful -> ConstructionBase
    ConstructionBase -> LinearAlgebra
    LinearAlgebra -> Libdl
    ⋮
    Unitful -> Random
    Random -> SHA
    Random -> Serialization
}
```
For more info, see [`depgraph`](@ref) and [`to_DOT_str`](@ref).
"""
deps_as_DOT(pkgname) = depgraph(pkgname) |> to_DOT_str


"""
    to_DOT_str(edges)

Build a string that represents the given directed graph in the
[Graphviz DOT format](https://graphviz.org/doc/info/lang.html).

## Example:

```jldoctest
julia> using PkgGraph: to_DOT_str

julia> edges = [:A => :B, "yes" => "no"];

julia> to_DOT_str(edges) |> println
digraph {
    A -> B
    yes -> no
}
```
"""
function to_DOT_str(edges)
    lines = ["digraph {"]  # DIrected graph
    for (m, n) in edges
        push!(lines, "    $m -> $n")
    end
    push!(lines, "}\n")
    return join(lines, "\n")
end
