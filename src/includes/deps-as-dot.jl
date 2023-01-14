
"""
    depgraph_as_dotstr(
        pkgname;
        emptymsg = "(\$pkgname has no dependencies)",
        faded = is_in_stdlib,
        kw...
    )

Render the dependency graph of `pkgname` as a Dot string.

First calls [`depgraph(pkgname)`](@ref), and then calls [`to_dot_str`](@ref)
on the result. Keyword arguments are passed on to whichever of those two
functions accepts them.

By default, packages in the Julia standard library are drawn in gray. To
disable this, pass `faded = nothing`. Note that packages in the standard
library can be filtered out entirely by passing `stdlib = false`.
"""
depgraph_as_dotstr(
    pkgname;
    emptymsg = "($pkgname has no dependencies)",
    faded = is_in_stdlib,
    kw...
) = begin
    edges = depgraph(pkgname; select(kw, depgraph)...)
    dotstr = to_dot_str(
        edges;
        select(kw, to_dot_str)...,
        emptymsg,
        faded,
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
