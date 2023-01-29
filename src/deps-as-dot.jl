
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
disable this, pass `faded = nothing`.\\
Note that standard library packages can be filtered out entirely by
passing `stdlib = false` (see [`depgraph`](@ref)).

When `time` is `true`, calls [`time_imports`](@ref) and displays the
results in the graph. (Julia 1.8 and higher only).
"""
depgraph_as_dotstr(
    pkgname;
    emptymsg  = "($pkgname has no dependencies)",
    faded     = is_in_stdlib(pkgname) ? nothing : is_in_stdlib,
    time      = false,
    loadtimes = nothing,  # For if precalculated (quick iteration in dev)
    kw...
) = begin
    edges = depgraph(pkgname; select(kw, depgraph)...)
    if time
        loadtimes = time_imports(pkgname)
    end
    if !isnothing(loadtimes)
        nodeinfo = Dict(
            pkgname => "[$time ms]"
            for (pkgname, time) in loadtimes
        )
        fontsize, relsize = time_to_size(loadtimes)
    else
        nodeinfo = nothing
        fontsize = 14
        relsize  = nothing
    end
    dotstr = to_dot_str(
        edges;
        select(kw, to_dot_str)...,
        emptymsg,
        faded,
        nodeinfo,
        fontsize,
        relsize,
    )
end

"""
    print_dotstr(pkgname; kw...)

Like [`depgraph_as_dotstr`](@ref) but prints the result instead of
returning a string.
"""
print_dotstr(pkg; kw...) = depgraph_as_dotstr(pkg; kw...) |> println

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

function time_to_size(loadtimes)
    min_fontsize = 7
    max_fontsize = 24
    max_rel = max_fontsize / min_fontsize
    max_time = maximum(x.time_ms for x in loadtimes)
    input_range = 0:max_time
    output_range = 1:max_rel
    f = sqrt
    relsize = Dict(
        pkgname => remap(time, input_range, output_range, f)
        for (pkgname, time) in loadtimes
    )
    (; fontsize = min_fontsize, relsize)
end

function remap(x, input_range, output_range, f=identity)
    # 24 and (20,30) becomes 0.4
    y = fraction(x, input_range)
    # `f` is a function mapping [0, 1] to [0, 1]
    z = f(y)
    # 0.2 and (100,200) becomes 120
    w = lerp(z, output_range)
end

"Linearly interpolate ('lerp') between `a` (`t = 0`) and `b` (`t = 1`)"
lerp(t, a, b) = a + t * (b - a)
lerp(t, range) = lerp(t, first(range), last(range))

"Map `v` ∈ [`a`, `b`] to a a fraction ∈ [0, 1]"
fraction(v, a, b) = (v - a) / (b - a)
fraction(v, range) = fraction(v, first(range), last(range))
# aka 'inverse lerp'
