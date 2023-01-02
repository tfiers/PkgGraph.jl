"""
    url(base, dotstr)

Create a URL at which the given dot-string is rendered as an image,
using an online Graphviz rendering service.

The dot-string is URL-encoded, and appended to a partly complete
`base` URL (see [`webapps`](@ref))

## Example:

```jldoctest
julia> base = PkgGraph.webapps[2];

julia> PkgGraph.url(base, "digraph {Here->There}")
"http://magjac.com/graphviz-visual-editor/?dot=digraph%20%7BHere-%3EThere%7D"
```
"""
url(base, dotstr) = base * escapeuri(dotstr)

const webapps = [
    "https://dreampuf.github.io/GraphvizOnline/#",
    "http://magjac.com/graphviz-visual-editor/?dot=",
    "https://edotor.net/?engine=dot#",
]
@doc(
"""
A list of websites that can render Graphviz dot-formatted
strings. Used by [`Internals.url`](@ref).

Note that these are 'base URLs', to which url-encoded
dot-strings can be directly appended.

Default contents:
""" * join("1. [`$r`]($r)\n" for r in webapps),
webapps)
