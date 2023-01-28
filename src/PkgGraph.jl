"""
Visualize the dependency graph of a Julia package.

Use [`depgraph_web`](@ref) to view the graph in the browser,
or [`depgraph_image`](@ref) to generate an image locally.
"""
module PkgGraph


include("modules/DepGraph/DepGraph.jl")
using .DepGraph

include("modules/LoadTime.jl")
using .LoadTime

include("modules/DotString.jl")
using .DotString

include("modules/SVG.jl")
using .SVG


using DefaultApplication
using URIs: escapeuri
include("includes/deps-as-dot.jl")
include("includes/dotcommand.jl")
include("includes/webapps.jl")
include("includes/enduser.jl")

export depgraph_web, depgraph_image

# using SnoopPrecompile
# @precompile_all_calls begin
#     depgraph_as_dotstr(:DefaultApplication)
# end
# Disabled for now:
# increases precompilation time by almost 2x (5.0 → 9.3 seconds)
# but TTFX wasn't really a problem (0.33 → 0.04 seconds)

end # module
