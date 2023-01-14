```julia
to_dot_str(
    edges;
    dark      = false,
    bg        = "transparent",
    style     = default_style(),
    indent    = 4,
    emptymsg  = nothing,
    faded     = nothing,
    nodeinfo  = nothing,
)
```

Build a string that represents the given directed graph in the
[Graphviz DOT format ↗](https://graphviz.org/doc/info/lang.html).

## Keyword arguments

### `dark`
Default is `false` i.e. light-mode: black lines and black text with
white backgrounds. For `dark = true`, it's white lines and white text,
with black backgrounds. Note that locally-generated SVGs get both
colour-schemes simultaneously, so this option is irrelevant for them.

### `bg`
Background colour for the image.\
Default is `"transparent"`.\
`"white"` (in combination with `dark = false`) might be a sensible
value when you are creating a PNG but do not know on what background it
will be seen. (A light-mode PNG with transparent background looks bad on
a dark background).

### `style`
A list of strings, inserted as lines in the output (after the lines
generated for `dark` and `bg`, and just before the graph edge lines). To
use Graphviz's default style, pass `style = []`. For the default see
[`default_style`](@ref). For more on how dot-graphs can be styled, see
[Styling Graphviz output](@ref).

### `indent`
The number of spaces to indent each line in the "`digraph`" block with.

### `emptymsg`
If there are no `edges`, a single node with `emptymsg` is created. If
`emptymsg` is `nothing` (default), no nodes are created, and the image
rendered from the DOT-string will be empty.

### `faded`
A function `(nodename) -> Bool` that determines whether this node -- and
its incoming and outgoing edges -- should be drawn in gray. If `nothing`
(default), no nodes are faded.

### `nodeinfo`
A mapping `nodeinfo => String`, or `nothing` (default).
For any node present in this mapping, its info is printed underneath its
name in the graph.

## Example:

```jldoctest
julia> edges = [:A => :B, "yes" => "no"];

julia> style = ["node [color=\"red\"]"];

julia> using PkgGraph

julia> PkgGraph.to_dot_str(edges; style, bg=:blue, indent=2) |> println
digraph {
  bgcolor = "blue"
  node [fillcolor="white", fontcolor="black", color="black"]
  edge [color="black"]
  node [color="red"]
  A -> B
  yes -> no
}

julia> emptymsg="(empty graph)";

julia> PkgGraph.to_dot_str([]; emptymsg, dark=true, style=[]) |> println
digraph {
    bgcolor = "transparent"
    node [fillcolor="black", fontcolor="white", color="white"]
    edge [color="white"]
    onlynode [label=" (empty graph) ", shape="plaintext"]
}
```
