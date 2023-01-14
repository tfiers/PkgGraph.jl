
module DotString

using ..DepGraph: vertices, is_in_stdlib, depgraph

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
)
    lines = ["digraph {"]  # DIrected graph
    tab = " "^indent
    colourscheme = dark ? darkmode : lightmode
    bgcolor = "bgcolor = \"$bg\""
    for line in [bgcolor; colourscheme; style]
        push!(lines, tab * line)
    end
    for (m, n) in edges
        if !isnothing(faded) && any(faded, [m, n])
            push!(lines, tab * "$m -> $n [color=gray]")
        else
            push!(lines, tab * "$m -> $n")
        end
    end
    if !isnothing(faded)
        for node in vertices(edges)
            if faded(node)
                push!(lines, tab * "$node [color=gray fontcolor=gray]")
            end
        end
    end
    if !isnothing(emptymsg) && isempty(edges)
        push!(lines, tab * single_node(emptymsg))
    end
    push!(lines, "}")
    return join(lines, "\n") * "\n"
end

single_node(text) = "onlynode [label=\" $text \", shape=\"plaintext\"]"
# ↪ the extra spaces around the text are for some padding in the output png (eg)

default_style() = [
    "node [fontname=\"sans-serif\", style=\"filled\"]",
    "edge [arrowsize=0.88]",
]
@doc(
"""
    default_style()

The default style used by [`to_dot_str`](@ref):

""" * join("`$l`\\\n" for l in default_style()),
default_style)

colouring(; paper, ink) = [
    """node [fillcolor="$paper", fontcolor="$ink", color="$ink"]""",
    """edge [color="$ink"]""",
]

const lightmode = colouring(paper="white", ink="black")
const darkmode  = colouring(paper="black", ink="white")

end
