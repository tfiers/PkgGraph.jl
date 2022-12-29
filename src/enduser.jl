
"""
    open(pkgname, base_url = first(webapps))

Open the browser to an image of `pkgname`'s dependency graph.

The given package must be installed in the currently active project.

See also [`webapps`](@ref) and [`Internals.url`](@ref).
"""
function open(pkgname, base_url = first(webapps); kw...)
    DefaultApplication.open(url(pkgname, base_url; kw...))
    #   Passing a URL (and not a file) opens the browser on all
    #   platforms. (Even though that is undocumented behaviour:
    #   https://github.com/tpapp/DefaultApplication.jl/issues/12)
    return nothing
end


"""
    create(pkgname, dir = tempdir(); fmt = :png)

Render the dependency graph of the given package as an image in `dir`,
and open it with your default image viewer. Uses the external program
'`dot`' (see [graphviz.org](https://graphviz.org)), which must be
available on `PATH`.

`fmt` is an output file format supported by dot, such as svg or png.

The given package must be installed in the currently active project.
"""
function create(pkgname, dir = tempdir(); fmt = :png)
    if !is_dot_available()
        error("`dot` program not found on `PATH`. Get it at https://graphviz.org/download/")
    end
    dotstr = deps_as_dot(pkgname)
    imgpath = output_path(pkgname, dir, fmt)
    create_dot_image(dotstr, fmt, imgpath)
    DefaultApplication.open(imgpath)
    return nothing
end
