using Test


@testset "PkgGraph.jl" verbose=true begin
    # `verbose`, so that timings are always shown

    @testset "unit" verbose=true begin
        include("unit.jl")
    end
    @testset "integration" verbose=true begin
        include("integration.jl")
    end
    @testset "JuliaGraphs_interop" verbose=true begin
        include("JuliaGraphs_interop.jl")
    end
end
