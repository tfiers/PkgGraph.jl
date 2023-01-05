"""
Visualize the dependency graph of a Julia package.

Use [`PkgGraph.open`](@ref) to view the graph in the browser,
or [`PkgGraph.create`](@ref) to generate an image locally.

(Note that these functions are not exported).

See [`PkgGraph.Internals`](@ref) for more functions.
"""
module PkgGraph


"""
Namespace for the non-end-user functions in PkgGraph.

For ease of experimentation, you can import these with
```
using PkgGraph.Internals
```
They are also imported in the main module, so they
can be accessed as `PkgGraph.depgraph`, e.g.
"""
module Internals

    using TOML
    using Base: active_project
    include("internals/depgraph.jl")
    export depgraph,
           packages_in_active_manifest,
           should_be_included,
           is_jll,
           is_in_stdlib,
           STDLIB,
           vertices

    include("internals/dot.jl")
    export to_dot_str,
           default_style

    using EzXML
    include("internals/svg.jl")
    export add_darkmode

    include("internals/local.jl")
    export is_dot_available,
           create_dot_image,
           dotcommand,
           output_path

    using URIs: escapeuri
    include("internals/online.jl")
    export url,
           webapps

    using Base: @kwdef
    include("internals/options.jl")
    export Options
end

using .Internals
using DefaultApplication
include("enduser.jl")

# No package exports (no namespace pollution)

end # module
