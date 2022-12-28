using Test

@testset "PkgGraph.jl" verbose=true begin

    @testset "main" begin
        include("main.jl")
    end
    @testset "JuliaGraphs_interop" begin
        include("JuliaGraphs_interop.jl")
    end
end
