using Test

@testset "PkgGraphs.jl" verbose=true begin
    # `verbose`, so that timings are always shown

    @testset "main" begin
        include("main.jl")
    end
    @testset "JuliaGraphs_interop" begin
        include("JuliaGraphs_interop.jl")
    end
end
