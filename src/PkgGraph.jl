"""
Visualize the dependency graph of a Julia package.

Use [`PkgGraph.open`](@ref) to view the graph in the browser,
or [`PkgGraph.create`](@ref) to generate an image locally.

(Note that these functions are not exported).
"""
module PkgGraph


include("modules/DepGraph.jl")
using .DepGraph

include("modules/LoadTime.jl")
using .LoadTime

include("modules/DotString.jl")
using .DotString

include("modules/SVG.jl")
using .SVG


using DefaultApplication
using URIs: escapeuri
using Base: @kwdef
include("includes/dotcommand.jl")
include("includes/webapps.jl")
include("includes/options.jl")
include("includes/enduser.jl")

# No package exports (no namespace pollution)


end # module
