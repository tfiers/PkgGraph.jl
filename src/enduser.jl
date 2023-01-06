
"""
    open(pkgname; kw...)

Open the browser to an image of `pkgname`'s dependency graph.

The given package must be installed in the currently active project.

See [Settings](@ref) for possible keyword arguments.
"""
function open(pkgname; dryrun = false, kw...)
    link = url(pkgname, Options(; kw...))
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

The given package must be installed in the currently active project.

`fmt` is an output file format supported by dot, such as `:svg` or `:png`.\\
If `fmt` is `:svg`, the generated SVG file is post-processed, to add
light and dark-mode CSS.

To only create the image, without automatically opening it, pass
`open = false`.

See [Settings](@ref) for more keyword arguments.
"""
function create(pkgname, dir = tempdir(); fmt = :png, open = true, dryrun = false, kw...)
    if !is_dot_available() && !dryrun
        error("`dot` program not found on `PATH`. Get it at https://graphviz.org/download/")
    end
    dotstr = to_dot_str(pkgname, Options(; kw...))
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
