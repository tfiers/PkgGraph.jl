"""
Visualize the dependency graph of a Julia package.

Use [`PkgGraph.open`](@ref) to view the graph in the browser,
or [`PkgGraph.create`](@ref) to generate an image locally.

Internal functions can be accessed via `PkgGraph.Internals`
"""
module PkgGraph

module Internals

    using TOML
    using Base: active_project
    include("internals/depgraph.jl")
    export depgraph,
           packages_in_active_manifest

    include("internals/dot.jl")
    export deps_as_DOT,
           to_DOT_str,
           style

    include("internals/local.jl")
    export is_dot_available,
           create_DOT_image

    using URIs: escapeuri
    include("internals/online.jl")
    export url,
           base_urls
end


using .Internals
using DefaultApplication

include("enduser.jl")

# No package exports (no namespace pollution)

end # module
