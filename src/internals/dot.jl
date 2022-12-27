
"""
    deps_as_dot(pkgname; emptymsg = "(\$pkgname has no dependencies)", kw...)

Create the dependency graph of `pkgname` and render it as a Graphviz DOT string.

See [`to_dot_str`](@ref) for keyword arguments.

## Example:

```jldoctest
julia> PkgGraph.deps_as_dot(:Test) |> println
digraph {
    bgcolor = "transparent"
    node [fontname = "sans-serif", style = "filled", fillcolor = "white"]
    edge [arrowsize = 0.88]
    Test -> InteractiveUtils
    InteractiveUtils -> Markdown
    Markdown -> Base64
    Test -> Logging
    Test -> Random
    Random -> SHA
    Random -> Serialization
    Test -> Serialization
}
```
"""
deps_as_dot(
    pkgname;
    emptymsg = "($pkgname has no dependencies)",
    kw...
) = to_dot_str(depgraph(pkgname); emptymsg, kw...)


"""
    to_dot_str(edges; style = default_style, indent = 4, emptymsg = nothing)

Build a string that represents the given directed graph in the
[Graphviz DOT format ↗](https://graphviz.org/doc/info/lang.html).

If there are no `edges`, a single node with `emptymsg` is created.
If `emptymsg` is `nothing` (default), no nodes are created, and
the image rendered from the DOT-string will be empty.

`style` is a list of strings, inserted as lines in the output (just
before the graph edge lines). To use Graphviz's default style, pass
`style = []`. For more on how dot-graphs can be styled, see
[Styling Graphviz output](@ref).

## Example:

```jldoctest
julia> edges = [:A => :B, "yes" => "no"];

julia> style = ["node [color = \\"red\\"]"];

julia> using PkgGraph.Internals

julia> to_dot_str(edges; style, indent = 2) |> println
digraph {
  node [color = "red"]
  A -> B
  yes -> no
}

julia> to_dot_str([], style=[], emptymsg="(empty graph)") |> println
digraph {
    onlynode [label = \" (empty graph) \", shape = \"plaintext\"]
}
```

See also [`default_style`](@ref).
"""
function to_dot_str(edges; style = default_style, indent = 4, emptymsg = nothing)
    lines = ["digraph {"]  # DIrected graph
    tab = " "^indent
    for line in style
        push!(lines, tab * line)
    end
    for (m, n) in edges
        push!(lines, tab * "$m -> $n")
    end
    if !isnothing(emptymsg) && isempty(edges)
        push!(lines, tab * single_node(emptymsg))
    end
    push!(lines, "}")
    return join(lines, "\n") * "\n"
end

single_node(text) = "onlynode [label = \" $text \", shape = \"plaintext\"]"
# ↪ the extra spaces around the text are for some padding in the output png (eg)

const default_style = [
    "bgcolor = \"transparent\"",
    "node [fontname = \"sans-serif\", style = \"filled\", fillcolor = \"white\"]",
    "edge [arrowsize = 0.88]",
]
@doc(
"""
The default style used by [`to_dot_str`](@ref):

""" * join("`$l`\\\n" for l in default_style),
default_style)
