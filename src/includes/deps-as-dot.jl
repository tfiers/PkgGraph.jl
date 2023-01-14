
depgraph_as_dotstr(pkgname; kw...) = begin
    edges = depgraph(pkgname; select(kw, depgraph)...)
    dotstr = to_dot_str(
        edges;
        select(kw, to_dot_str)...,
        emptymsg="($pkgname has no dependencies)",
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
