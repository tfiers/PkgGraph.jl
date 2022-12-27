
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
    to_dot_str(edges; indent = 4, emptymsg = nothing, style = default_style)

Build a string that represents the given directed graph in the
[Graphviz DOT format ↗](https://graphviz.org/doc/info/lang.html).

If there are no `edges`, a single node with `emptymsg` is created.
If `emptymsg` is `nothing` (default), no nodes are created, and
the image rendered from the DOT-string will be empty.

`style` is a list of strings, inserted as lines in the output (just
before the graph edge lines). To use Graphviz's default style, pass
`style = []`. For more on how dot-graphs can be styled, see
['Graphviz Attributes' ↗](https://graphviz.org/doc/info/attrs.html)

## Example:

```jldoctest
julia> using PkgGraph.Internals

julia> edges = [:A => :B, "yes" => "no"];

julia> to_dot_str(edges, indent=2) |> println
digraph {
  bgcolor = "transparent"
  node [fontname = "sans-serif", style = "filled", fillcolor = "white"]
  edge [arrowsize = 0.88]
  A -> B
  yes -> no
}

julia> to_dot_str([], emptymsg="(empty graph)", style=[]) |> println
digraph {
    onlynode [label = \" (empty graph) \", shape = \"plaintext\"]
}
```
"""
function to_dot_str(edges; indent = 4, emptymsg = nothing, style = default_style)
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
