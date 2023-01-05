
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

for node in findall("//x:g[@class='node']", svg, ns)
    ellipse = findfirst("x:ellipse", node, ns)
    delete!(ellipse, "fill")
    delete!(ellipse, "stroke")
    text = findfirst("x:text", node, ns)
    delete!(text, "text-anchor")
    delete!(text, "font-family")
end
for edge in findall("//x:g[@class='edge']", svg, ns)
    path = findfirst("x:path", edge, ns)
    delete!(path, "stroke")
    polygon = findfirst("x:polygon", edge, ns)
    delete!(polygon, "fill")
    delete!(polygon, "stroke")
end

common_style = """

svg {
    color-scheme: light dark;
}

text {
    text-anchor: middle;
    font-family: sans-serif;
}
"""

lightmode = """

.node ellipse {
    fill: white;
    stroke: black;
}
.node text {
    fill: black;
}
.edge path {
    stroke: black;
}
.edge polygon {
    fill: black;
    stroke: black;
}
"""

darkmode = """

.node ellipse {
    fill: black;
    stroke: white;
}
.node text {
    fill: white;
}
.edge path {
    stroke: white;
}
.edge polygon {
    fill: white;
    stroke: white;
}
"""

prefers(scheme, css) = "\n@media (prefers-color-scheme: $scheme) {$css}\n"

css = common_style * lightmode * prefers("dark", darkmode)

style = ElementNode("style")
setnodecontent!(style, css)
# - Note (node) the confusion here: we have xml nodes (tags);
#   and we have graphviz nodes (vertices).
# - `lightmode` last, so that if the color scheme mechanism doesn't work,
#   light mode wins.

firstnode = findfirst("//x:g[@class='graph']", svg, ns)
linkprev!(firstnode, style)
# Better than `addelement!(svg, …)`: now stylesheet is at top (like in html),
# instead of at end.

write("docs/img/Unitful-deps.svg", doc)
