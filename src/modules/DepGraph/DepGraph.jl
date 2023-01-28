module DepGraph

using Pkg
using TOML
using UUIDs
using ProgressMeter
using Base: active_project

include("stdlib.jl")
export STDLIB,
       STDLIB_NAMES

include("project.jl")
export packages_in_active_manifest

include("registry.jl")

include("main.jl")
export depgraph,
       should_be_included,
       is_jll,
       is_in_stdlib,
       STDLIB

include("graphsjl.jl")
export vertices,
       node_index,
       adjacency_matrix,
       as_graphsjl_input,
       as_int_pairs,
       EdgeList,
       Edge

end
