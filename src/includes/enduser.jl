
"""
    open(pkgname, base_url = first(webapps); kw...)

Open the browser to an image of `pkgname`'s dependency graph.

See [`url`](@ref) for more on `base_url`, and for possible keyword
arguments see [`depgraph`](@ref) and [`to_dot_str`](@ref) .
"""
function open(pkgname, base_url = first(webapps); dryrun = false, kw...)
    dotstr = depgraph_as_dotstr(pkgname; kw...)
    link = url(dotstr, base_url)
    if !dryrun
        DefaultApplication.open(link)
        # ↪ Passing a URL (and not a file) opens the browser on all
        #   platforms. (Even though that is undocumented behaviour:
        #   https://github.com/tpapp/DefaultApplication.jl/issues/12)
    end
    return nothing
end

"""
    create(pkgname, dir = tempdir(); fmt = :png, open = true, kw...)

Render the dependency graph of the given package as an image in `dir`,
and open it with your default image viewer. Uses the external program
'`dot`' (see [graphviz.org](https://graphviz.org)), which must be
available on `PATH`.

`fmt` is an output file format supported by dot, such as `:svg` or `:png`.\\
If `fmt` is `:svg`, the generated SVG file is post-processed, to add
light and dark-mode CSS.

To only create the image, without automatically opening it, pass
`open = false`.

See [`depgraph`](@ref) and [`to_dot_str`](@ref) for more keyword
arguments.
"""
function create(pkgname, dir=tempdir(); fmt=:png, bg=bg(fmt), open=true, dryrun=false, kw...)
    if !is_dot_available() && !dryrun
        error("`dot` program not found on `PATH`. Get it at https://graphviz.org/download/")
    end
    dotstr = depgraph_as_dotstr(pkgname; bg, kw...)
    imgpath = output_path(pkgname, dir, fmt)
    if !dryrun
        create_dot_image(dotstr, fmt, imgpath)
        if fmt == :svg
            SVG.add_darkmode(imgpath)
        end
        open && DefaultApplication.open(imgpath)
    end
    return nothing
end

bg(fmt) = (fmt == :png ? :white : :transparent)

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
