
"""
    Options(; kw...)

Convenience object to gather all settings (kwargs) of different
functions in one place.

See [Settings](@ref) for available properties.
"""
@kwdef struct Options
    # ↪ i.e. see docs/src/ref/end-user.md for field documentation.
    jll       = true
    stdlib    = true
    style     = default_style()
    base_url  = first(webapps)
    mode      = :light
    bg        = "transparent"
end

depgraph(pkg, o::Options) =
    depgraph(pkg; o.jll, o.stdlib)

to_dot_str(pkg, o::Options) =
    to_dot_str(
        depgraph(pkg, o);
        o.style,
        o.mode,
        o.bg,
        emptymsg = "($pkg has no dependencies)",
    )

url(pkg, o::Options) =
    url(o.base_url, to_dot_str(pkg, o))
