
"""
    base_urls

A list of websites that can render Graphviz dot-formatted strings. See [`url`](@ref).

```@eval
@show base_urls
```
"""
const base_urls = [
    "https://dreampuf.github.io/GraphvizOnline/#",     # Default
    "http://magjac.com/graphviz-visual-editor/?dot=",  # Linked from graphviz.org. Many features.
    "https://edotor.net/?engine=dot#",
]
const base_url = Ref(first(base_urls))


"""
    url(pkgname)

Create a URL at which the dependency graph of `pkgname` is rendered as an image, using an
online Graphviz rendering service.

## How it works
The dependency graph of `pkgname` is created locally, and converted to a string in the
Graphviz DOT format (see [`deps_as_DOT`](@ref)). This string is URL-encoded, and appended to
a partly-complete URL, which is by default the first entry in the `PkgGraph.base_urls`
list. To use a different rendering website, use [`set_base_url`](@ref).
"""
url(pkgname) = base_url[] * escapeuri(deps_as_DOT(pkgname))
