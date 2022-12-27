
const rendering_websites = [
    "https://dreampuf.github.io/GraphvizOnline/#",     # Default
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
""" * join("1. [$r]($r)\n" for r in rendering_websites),
rendering_websites)
