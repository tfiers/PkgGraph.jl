
module DotString

using ..DepGraph: vertices, is_in_stdlib, depgraph
# The latter two are imported for reference in the docstring

export to_dot_str,
       default_style

docstr = joinpath(@__DIR__, "to_dot_string.md")
include_dependency(docstr)

@doc readchomp(docstr)
function to_dot_str(
    edges;
    dark      = false,
    bg        = "transparent",
    style     = default_style(),
    indent    = 4,
    emptymsg  = nothing,
    faded     = nothing,
    nodeinfo  = nothing,
)
    lines = ["digraph {"]  # DIrected graph
    tab = " "^indent
    addline(l) = push!(lines, tab * l)
    bgcolor = "bgcolor = \"$bg\""
    colourscheme = dark ? darkmode : lightmode
    for str in [bgcolor; colourscheme; style]
        addline(str)
    end
    for (m, n) in edges
        if !isnothing(faded) && any(faded, [m, n])
            addline("$m -> $n [color=gray]")
        else
            addline("$m -> $n")
        end
    end
    isnothing(faded) || for node in vertices(edges)
        if faded(node)
            addline("$node [fontcolor=gray]")
        end
    end
    isnothing(nodeinfo) || for node in vertices(edges)
        if node in keys(nodeinfo)
            info = nodeinfo[node]
            addline("$node [label=\"$node\\n$info\"]")
        end
    end
    if !isnothing(emptymsg) && isempty(edges)
        addline(single_node(emptymsg))
    end
    push!(lines, "}")
    return join(lines, "\n") * "\n"
end

single_node(text) = "onlynode [label=\" $text \", shape=plaintext]"
# ↪ the extra spaces around the text are for some padding in the output png (eg)

default_style() = [
    "node [fontname=\"sans-serif\", fontsize=14]",  # 14 is default
    "node [color=none, shape=box, width=1, height=0.5]",
    # Default width is 0.75 (but expands for label), height 0.5
    # Larger width spaces nodes out more
    "edge [arrowsize=0.8]",
]
@doc(
"""
    default_style()

The default style used by [`to_dot_str`](@ref):

""" * join("`$l`\\\n" for l in default_style()),
default_style)

colouring(; ink) = [
    """node [fontcolor="$ink"]""",
    """edge [color="$ink"]""",
]
const lightmode = colouring(ink="black")
const darkmode  = colouring(ink="white")

end
