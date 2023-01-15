"""
Generate the images in [root]/docs/img/,
and the long URL in [root]/ReadMe.md
"""

using Pkg
using PkgGraph

cd(@__DIR__)
cd("../..")
@show pwd()

Pkg.activate("test")

depgraph_image("Unitful", dir="docs/img/", fmt=:png, open=false)
depgraph_image("Unitful", dir="docs/img/", fmt=:svg, open=false)
depgraph_image("Test", dir="docs/img/", fmt=:svg, faded=nothing, open=false)

readme = "ReadMe.md"
md = read(readme, String)
current = r"^\[dotlink\]: (.*$)"m
m = match(current, md)
isnothing(m) && error("[$current] not found in [$readme]")
current_url = m.captures[1]

dotstr = PkgGraph.depgraph_as_dotstr("Unitful")
new = PkgGraph.url(dotstr)

if current_url == new
    @info "Current url in [$readme] still up to date"
else
    replacement = "[dotlink]: " * new
    md = replace(md, current => replacement)
    write(readme, md)
    println("Replaced URL in [$readme]")
end
