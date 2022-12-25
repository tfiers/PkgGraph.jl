"""
Visualize the dependency graph of a Julia package.

Use [`PkgGraph.open`](@ref) to view the graph in the browser,
or [`PkgGraph.create`](@ref) to generate an image locally.
"""
module PkgGraph


module Internals

using DefaultApplication
using URIs: escapeuri
using TOML
using Base: active_project

include("depgraph.jl")
export depgraph,
       packages_in_active_manifest

include("dot.jl")
export deps_as_DOT,
       to_DOT_str,
       style

include("local.jl")
export is_dot_available,
       create_DOT_image

include("online.jl")
export url,
       base_urls

end # module

using .Internals


"""
    open(pkgname)

Open the browser to an image of `pkgname`'s dependency graph.\\
The given package must be installed in the currently active project.

To render the dependency graph using a local Graphviz `dot` installation (instead of an
online Graphviz renderer), use [`create`](@ref).

For more info, see [`url`](@ref).
"""
open(pkgname) = begin
    DefaultApplication.open(url(pkgname))
    # ↪ Passing a url opens the browser on all platforms. (Even though that is undocumented:
    #   https://github.com/tpapp/DefaultApplication.jl/issues/12)
    return nothing
end

"""
    set_base_url(new)

# Set the rendering website that will be used by [`open`](@ref) and [`url`](@ref).

See `PkgGraph.base_urls` for some options.
"""
set_base_url(new) = (Internals.base_url[] = new)


"""
    create(pkgname, dir = tempdir(); fmt = :png)

Render the dependency graph of the given package as an image in `dir`, and open it with your
default image viewer. Uses the external program '`dot`' (see [graphviz.org](https://graphviz.org)),
which must be available on `PATH`.

`fmt` is an output file format supported by dot, such as svg or png.
"""
create(pkgname, dir = tempdir(); fmt = :png) = begin
    if !is_dot_available()
        error("`dot` program not found on `PATH`. Get it at https://graphviz.org/download/")
    end
    dotstr = deps_as_DOT(pkgname)
    imgname = "$pkgname-deps.$fmt"
    imgpath = joinpath(dir, imgname)
    create_DOT_image(dotstr, fmt, imgpath)
    DefaultApplication.open(imgpath)
    return nothing
end

end # module
