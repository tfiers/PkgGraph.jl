
"""
    deps_as_DOT(pkgname)

Create the dependency graph of `pkgname` and render it as a Graphviz DOT string.

Example output (truncated), for `"Unitful"`:
```
digraph {
    bgcolor = "transparent"
    node [fontname = "sans-serif", style = "filled", fillcolor = "white"]
    edge [arrowsize = 0.88]
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
    to_DOT_str(edges; indent = 4)

Build a string that represents the given directed graph in the
[Graphviz DOT format](https://graphviz.org/doc/info/lang.html).

## Example:

```jldoctest
julia> empty!(PkgGraph.style);

julia> edges = [:A => :B, "yes" => "no"];

julia> PkgGraph.to_DOT_str(edges, indent = 2) |> println
digraph {
  A -> B
  yes -> no
}
```
"""
function to_DOT_str(edges; indent = 4)
    lines = ["digraph {"]  # DIrected graph
    tab = " "^indent
    for line in style
        push!(lines, tab * line)
    end
    for (m, n) in edges
        push!(lines, tab * "$m -> $n")
    end
    push!(lines, "}\n")
    return join(lines, "\n")
end

"""
    style

A list of strings used in constructing the `"digraph"` string in [`to_DOT_str`](@ref). They
are insterted as lines just before the graph edge lines.

To use the default Graphviz style, call:
```
empty!(PkgGraph.style)
```

See [Graphviz Attributes](https://graphviz.org/doc/info/attrs.html) for more info on how dot
graphs can be styled.
"""
const style = [
    "bgcolor = \"transparent\"",
    "node [fontname = \"sans-serif\", style = \"filled\", fillcolor = \"white\"]",
    "edge [arrowsize = 0.88]",
]
