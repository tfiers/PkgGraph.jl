
"""
    open(pkgname)

Open the browser to an image of `pkgname`'s dependency graph.\\
The given package must be installed in the currently active project.

To render the dependency graph using a local Graphviz `dot` installation (instead of an
online Graphviz renderer), use [`create`](@ref).

For more info, see [`depgraph_url`](@ref).
"""
open(pkgname) = begin
    DefaultApplication.open(depgraph_url(pkgname))
    # ↪ Passing a url opens the browser on all platforms. (Even though that is undocumented:
    #   https://github.com/tpapp/DefaultApplication.jl/issues/12)
    return nothing
end

const rendering_urls = [
    "https://dreampuf.github.io/GraphvizOnline/#",     # Default
    "http://magjac.com/graphviz-visual-editor/?dot=",  # Linked from graphviz.org. Many features.
    "https://edotor.net/?engine=dot#",
]
const rendering_url = Ref(first(rendering_urls))

"""
    set_rendering_url(new)

Set the base url that will be used by [`open`](@ref) and [`depgraph_url`](@ref) to the
given `new` url.

See `PkgGraph.rendering_urls` for some options.
"""
set_rendering_url(new) = (rendering_url[] = new)


"""
    depgraph_url(pkgname)

Create a URL at which the dependency graph of `pkgname` is rendered as an image, using an
online Graphviz rendering service.

## How it works
The dependency graph of `pkgname` is created locally, and converted to a string in the
Graphviz DOT format (see [`deps_as_DOT`](@ref)). This string is URL-encoded, and appended to
a partly-complete URL, which is by default the first entry in the `PkgGraph.rendering_urls`
list. To use a different rendering website, use [`set_rendering_url`](@ref).
"""
depgraph_url(pkgname) = begin
    dotstr = deps_as_DOT(pkgname)
    url = rendering_url[] * escapeuri(dotstr)
end
