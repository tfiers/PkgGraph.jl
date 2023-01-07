
module SVG

using EzXML

"""
    add_darkmode(path, out = path)

Edit an SVG file generated by Graphviz.

Remove repeated styling on individual elements,
and replace it by a global stylesheet, with both light and dark modes.
(This is achieved through a CSS `@media` query for `prefers-color-scheme`).
"""
function add_darkmode(path, out = path)
    print("Adding darkmode to [$path] … ")
    doc = readxml(path)
    svg = root(doc)
    remove_nonDRY_attrs!(svg)
    add_css!(svg)
    write(out, doc)
    println("done")
    if out != path
        println("Written to [$out]")
    end
end

function remove_nonDRY_attrs!(svg)
    ns = namespaces_patched_for_xpath(svg)
    for (xpath, attrs) in attrs_to_remove()
        for node in findall(xpath, svg, ns)
            for attr in attrs
                delete!(node, attr)
            end
        end
    end
end
attrs_to_remove() = [
    xpath("ellipse", parent_class="node") => ["stroke", "fill"],
    xpath("text",    parent_class="node") => ["text-anchor", "font-family"],
    xpath("path",    parent_class="edge") => ["stroke"],
    xpath("polygon", parent_class="edge") => ["stroke", "fill"],
]
xpath(name; parent_class) = "//x:g[@class='$parent_class']/x:$name"

namespaces_patched_for_xpath(svg) = begin
    # XPath quirk: it cannot work with a mix of empty and non-empty namespaces.
    #   (Which we have:
    #       <svg … xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    #   )
    # So we give the first namespace an artificial prefix.
    # (Re https://github.com/JuliaIO/EzXML.jl/issues/137
    #  and the 'caveat' in the docs, https://juliaio.github.io/EzXML.jl/latest/manual/#XPath-1)
    ns = namespaces(svg)
    ns[1] = "x" => namespace(svg)  # `namespace` returns first URL
    ns
end

function add_css!(svg)
    node = create_css_node()
    add_as_first_child!(svg, node)
end

function create_css_node()
    node = ElementNode("style")
    setnodecontent!(node, css())
    return node
end

css() = "\n" * join(styles(), "\n")

styles() = [
    common_style(),
    lightmode(),
    prefers("dark", darkmode()),
]

common_style() =
    """
    svg { color-scheme: light dark }
    text {
        text-anchor: middle;
        font-family: sans-serif;
    }
    """

lightmode() = colouring(ink="black", paper="white")
darkmode() = colouring(paper="black", ink="white")

colouring(; ink, paper) =
    """
    .node ellipse { stroke: $ink; fill: $paper }
    .node text    { fill: $ink }
    .edge path    { stroke: $ink }
    .edge polygon { stroke: $ink; fill: $ink }
    """

prefers(scheme, css) = "@media (prefers-color-scheme: $scheme) {\n$css}\n"

function add_as_first_child!(svg, node)
    first_child = firstnode(svg)
    linkprev!(first_child, node)
end
# ↪ Better than `addelement!(svg, …)`: now stylesheet is at top
#   (like in html), instead of at end.

end
