"""
Visualize the dependency graph of a Julia package.

Use [`PkgGraph.open`](@ref) to view the graph in the browser,
or [`PkgGraph.create`](@ref) to generate an image locally.

(Note that these functions are not exported).

See [`PkgGraph.Internals`](@ref) for more functions.
"""
module PkgGraph

using TOML
using EzXML
using URIs: escapeuri
include("internals/Internals.jl")

using DefaultApplication
using .Internals
include("enduser.jl")

# No package exports (no namespace pollution)

end # module
