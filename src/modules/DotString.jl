
module DotString

export to_dot_str,
       default_style

@doc readchomp(joinpath(@__DIR__, "to_dot_string.md"))
function to_dot_str(
    edges;
    mode     = :light,
    bg       = "transparent",
    style    = default_style(),
    indent   = 4,
    emptymsg = nothing,
)
    lines = ["digraph {"]  # DIrected graph
    tab = " "^indent
    colourscheme = colourschemes()[mode]
    bgcolor = "bgcolor = \"$bg\""
    for line in [bgcolor; colourscheme; style]
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

colourschemes() = Dict(
    :light => colouring(paper="white", ink="black"),
    :dark  => colouring(paper="black", ink="white"),
)

end
