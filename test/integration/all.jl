
using PkgGraph
using Test

@testset "integration" verbose=true begin
    include("deps-as-dot.jl")
    include("graphsjl_example.jl")
end
