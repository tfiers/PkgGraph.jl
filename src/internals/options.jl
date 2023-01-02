
"""
    Options(; kw...)

Settings to tweak the output of `PkgGraph.open` and `PkgGraph.create`.

The fields of this type are keyword arguments to the above end-user
functions. I.e, no need to construct this object yourself.

As a casual user, only the first two options (the 'include' flags) are
likely to be useful.


## Applicable to both `open` and `create`:

Options for [`depgraph`](@ref)
- `include_jll`: Whether to include binary 'JLL' dependencies in the graph (default: `true`)
- `include_stdlib`: Whether to include packages in the standard library (default: `true`)

Options for [`to_dot_str`](@ref)
- `style`: Custom Graphviz styling. See [`default_style`](@ref).

## Applicable to `open`:

- `base_url`: see [`url`](@ref). By default, the first entry in [`webapps`](@ref).

"""
@kwdef struct Options
    include_jll    ::Bool           = true
    include_stdlib ::Bool           = true
    style          ::Vector{String} = default_style
    base_url       ::String         = first(webapps)
end


depgraph(pkg, o::Options) =
    depgraph(pkg; o.include_jll, o.include_stdlib)

to_dot_str(pkg, o::Options) =
    to_dot_str(
        depgraph(pkg, o);
        o.style,
        emptymsg = "($pkg has no dependencies)",
    )

url(pkg, o::Options) =
    url(o.base_url, to_dot_str(pkg, o))
