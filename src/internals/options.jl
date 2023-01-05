
"""
    Options(; kw...)

Used by `PkgGraph.open` and `PkgGraph.create`, as settings to tweak
their output.

The fields of this struct are keyword arguments to the above end-user
functions. I.e, no need to construct this object yourself.

## Keyword arguments

`jll`\\
    Whether to include binary 'JLL' dependencies in the graph
    (default: `true`)

`stdlib`\\
    Whether to include packages in the standard library
    (default: `true`)

`style`\\
    Custom Graphviz styling. See [`default_style`](@ref).

`base_url`\\
    See [`url`](@ref).
    By default, the first entry in [`webapps`](@ref).
"""
@kwdef struct Options
    jll       ::Bool            = true
    stdlib    ::Bool            = true
    style     ::Vector{String}  = default_style
    base_url  ::String          = first(webapps)
end


depgraph(pkg, o::Options) =
    depgraph(pkg; o.jll, o.stdlib)

to_dot_str(pkg, o::Options) =
    to_dot_str(
        depgraph(pkg, o);
        o.style,
        emptymsg = "($pkg has no dependencies)",
    )

url(pkg, o::Options) =
    url(o.base_url, to_dot_str(pkg, o))
