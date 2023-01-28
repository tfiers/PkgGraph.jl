"""
Visualize the dependency graph of a Julia package.

Use [`depgraph_web`](@ref) to view the graph in the browser,
or [`depgraph_image`](@ref) to generate an image locally.
"""
module PkgGraph


include("DepGraphs/DepGraphs.jl")
using .DepGraphs

include("LoadTime.jl")
using .LoadTime

include("DotString/DotString.jl")
using .DotString

include("SVG.jl")
using .SVG


using DefaultApplication
using URIs: escapeuri
using Graphviz_jll: dot
include("deps-as-dot.jl")
include("dotcommand.jl")
include("webapps.jl")
include("enduser.jl")

export depgraph_web, depgraph_image

# using SnoopPrecompile
# @precompile_all_calls begin
#     depgraph_as_dotstr(:DefaultApplication)
# end
# Disabled for now:
# increases precompilation time by almost 2x (5.0 → 9.3 seconds)
# but TTFX wasn't really a problem (0.33 → 0.04 seconds)

end # module
