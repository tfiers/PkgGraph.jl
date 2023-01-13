
using PkgGraph
using Test

@testset "integration" begin
    include("deps-as-dot.jl")
    include("graphsjl_example.jl")
end
