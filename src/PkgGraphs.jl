"""
Visualize the dependency graph of a Julia package.

Use [`PkgGraphs.open`](@ref) to view the graph in the browser,
or [`PkgGraphs.create`](@ref) to generate an image locally.

(Note that these functions are not exported).

See [`PkgGraphs.Internals`](@ref) for more functions.
"""
module PkgGraphs

include("webapps.jl")


"""
Namespace for the non-end-user functions in PkgGraphs.

For ease of experimentation, you can import these with
```
using PkgGraphs.Internals
```
(They are also imported in the main module, so they
can be accessed as `PkgGraphs.depgraph`, e.g).
"""
module Internals

    using TOML
    using Base: active_project
    include("internals/depgraph.jl")
    export depgraph,
           vertices,
           packages_in_active_manifest

    include("internals/dot.jl")
    export deps_as_dot,
           to_dot_str,
           default_style

    include("internals/local.jl")
    export is_dot_available,
           create_dot_image,
           dotcommand,
           output_path

    using URIs: escapeuri
    using ..PkgGraphs: webapps
    include("internals/online.jl")
    export url
end

using DefaultApplication
using .Internals

include("enduser.jl")

# No package exports (no namespace pollution)

end # module
