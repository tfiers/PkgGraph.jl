
"""
    url(pkgname, base_url = first(rendering_websites); kw...)

Create a URL at which the dependency graph of `pkgname` is rendered as an image, using an
online Graphviz rendering service.

Keyword arguments are passed on to [`deps_as_dot`](@ref) and [`to_dot_str`](@ref).

## How it works
The dependency graph of `pkgname` is created locally, and converted to a
string in the Graphviz DOT format. This string is URL-encoded, and
appended to a partly-complete `base_url`.

## Example:

```jldoctest
julia> base_url = PkgGraph.rendering_websites[2]
"http://magjac.com/graphviz-visual-editor/?dot="

julia> PkgGraph.url(:TOML, base_url, style=[], indent=0)
"http://magjac.com/graphviz-visual-editor/?dot=digraph%20%7B%0ATOML%20-%3E%20Dates%0ADates%20-%3E%20Printf%0APrintf%20-%3E%20Unicode%0A%7D%0A"
```
"""
url(
    pkgname,
    base_url = first(rendering_websites);
    kw...
) =
    base_url * escapeuri(deps_as_dot(pkgname; kw...))
