
"""
Post-processing of the SVG generated by Graphviz.

We remove repeated styling on each individual element,
and replace it by a global stylesheet, with both
light and dark modes.
"""

using EzXML

doc = readxml("docs/img/Unitful-deps orig.svg")
svg = root(doc)
ns = namespaces(svg)

# XPath quirk: it cannot work with a mix of empty and non-empty namespaces.
#   (Which we have:
#       <svg … xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
#   )
# So we give the first namespace an artificial prefix.
# (Re https://github.com/JuliaIO/EzXML.jl/issues/137
#  and the 'caveat' in the docs, https://juliaio.github.io/EzXML.jl/latest/manual/#XPath-1)
ns[1] = "x" => namespace(svg)

xpath(name; parent_class) = "//x:[@class='$parent_class']/x:$name"

attrs_to_remove = [
    xpath("ellipse", parent_class="node") => ["stroke", "fill"],
    xpath("text",    parent_class="node") => ["text-anchor", "font-family"],
    xpath("path",    parent_class="edge") => ["stroke"],
    xpath("polygon", parent_class="edge") => ["stroke", "fill"],
]
for (xpath, attrs) in attrs_to_remove
    for node in findall(xpath, svg, ns),
        for attr in attrs
            delete!(node, attr)
        end
    end
end

common_style =
"""
svg { color-scheme: light dark }
text {
    text-anchor: middle;
    font-family: sans-serif;
}
"""
colouring(; ink, paper) =
"""
.node ellipse { stroke: $ink; fill: $paper }
.node text    { fill: $ink }
.edge path    { stroke: $ink }
.edge polygon { stroke: $ink; fill: $ink }
"""
lightmode = colouring(ink="black", paper="white")
darkmode = colouring(paper="black", ink="white")

prefers(scheme, css) = "\n@media (prefers-color-scheme: $scheme) {$css}\n"

styles = [
    common_style,
    lightmode,
    prefers("dark", darkmode),
]
css = join(styles, "\n")
style = ElementNode("style")
setnodecontent!(style, css)

# Possible confusion here: we have xml nodes (tags); and we have
# graphviz nodes (vertices).

firstel = firstnode(svg)
linkprev!(firstel, style)
# ↪ Better than `addelement!(svg, …)`: now stylesheet is at top
#   (like in html), instead of at end.

write("docs/img/Unitful-deps.svg", doc)
