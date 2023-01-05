
"""
    Options(; kw...)

Convenience object to gather all settings (kwargs) of different
functions in one place

See [Settings](@ref) for available properties.
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
