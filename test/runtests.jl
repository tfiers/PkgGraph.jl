using Test

@testset "PkgGraph.jl" verbose=true begin
    # `verbose`, so that timings are always shown

    @testset "unit" verbose=true begin
        include("unit.jl")
    end
    @testset "integration" verbose=true begin
        include("integration.jl")
    end
    @testset "Graphs.jl example" verbose=true begin
        include("graphsjl_example.jl")
    end
end
