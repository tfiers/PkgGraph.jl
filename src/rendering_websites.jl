
const rendering_websites = [
    "https://dreampuf.github.io/GraphvizOnline/#",     # Default
    "http://magjac.com/graphviz-visual-editor/?dot=",  # Linked from graphviz.org. Many features.
    "https://edotor.net/?engine=dot#",
]
@doc(
"""
A list of base URLs of websites that can render Graphviz dot-formatted
strings. Used by [`Internals.url`](@ref).

Default:
""" * join("1. [$r]($r)\n" for r in rendering_websites),
rendering_websites)
