
"""
    depgraph_as_dotstr(
        pkgname;
        emptymsg = "(\$pkgname has no dependencies)",
        faded    = is_in_stdlib,
        time     = false,
        kw...
    )

Render the dependency graph of `pkgname` as a Dot-string.

First calls [`depgraph(pkgname)`](@ref), and then calls [`to_dot_str`](@ref)
on the result. Keyword arguments are passed on to whichever of those two
functions accepts them.

By default, packages in the Julia standard library are drawn in gray. To
disable this, pass `faded = nothing`.\
Note that standard library packages can be filtered out entirely by
passing `stdlib = false` (see [`depgraph`](@ref)).

When `time` is `true`, calls [`time_imports`](@ref) and displays the
results in the graph. (Julia 1.8 and higher only).
"""
depgraph_as_dotstr(
    pkgname;
    emptymsg = "($pkgname has no dependencies)",
    faded    = is_in_stdlib,
    time     = false,
    kw...
) = begin
    edges = depgraph(pkgname; select(kw, depgraph)...)
    if time
        loadtimes = time_imports(pkgname)
        nodeinfo = Dict(
            pkgname => "[$time ms]"
            for (pkgname, time) in loadtimes
        )
    else
        nodeinfo = nothing
    end
    dotstr = to_dot_str(
        edges;
        select(kw, to_dot_str)...,
        emptymsg,
        faded,
        nodeinfo,
    )
end

"""
Extract the keyword arguments from `kw` that are applicable to the
single-method function `f`.
"""
select(kw, f) = begin
    m = only(methods(f))
    kwargnames_f = Base.kwarg_decl(m)
    selected_kw = [
        name => val for (name, val) in kw
        if name in kwargnames_f
    ]
end
