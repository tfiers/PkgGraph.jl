module DepGraph

using Pkg
using TOML
using UUIDs
using Base: active_project

include("DepGraph/stdlib.jl")
export STDLIB,
       STDLIB_NAMES

include("DepGraph/project.jl")

include("DepGraph/registry.jl")

include("DepGraph/main.jl")
export depgraph,
       should_be_included,
       is_jll,
       is_in_stdlib,
       STDLIB

include("DepGraph/graphsjl.jl")
export vertices,
       node_index,
       adjacency_matrix,
       as_graphsjl_input,
       as_int_pairs,
       EdgeList,
       Edge

end
