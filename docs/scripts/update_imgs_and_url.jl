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

depgraph_image("Unitful", "docs/img/", fmt=:png, open=false)
depgraph_image("Unitful", "docs/img/", fmt=:svg, open=false)
depgraph_image("Test", "docs/img/", fmt=:svg, open=false)

f = "ReadMe.md"
md = read(f, String)
current = r"^\[dotlink\]: (.*$)"m
m = match(current, md)
isnothing(m) && error("[$current] not found in [$f]")
current_url = m.captures[1]

new = PkgGraph.url("Unitful")

if current_url == new
    @info "Current url in [$f] still up to date"
else
    replacement = "[dotlink]: " * new
    md = replace(md, current => replacement)
    write(f, md)
    println("Replaced URL in [$f]")
end
