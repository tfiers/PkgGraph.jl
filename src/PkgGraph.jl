"""
Visualize the dependency graph of a Julia package.

Use [`PkgGraph.open`](@ref) to view the graph in the browser,
or [`PkgGraph.create`](@ref) to generate an image locally.
"""
module PkgGraph

using Pkg
using TOML
using Base: active_project
using URIs: escapeuri
using DefaultApplication

include("depgraph.jl")
include("dot.jl")
include("local.jl")
include("online.jl")

end
