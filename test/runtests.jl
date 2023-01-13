
using PkgGraph
using Test

@testset "PkgGraph.jl" verbose=true begin
    # `verbose`, so that timings are always shown
    include("unit/all.jl")
    include("integration/all.jl")
end

nothing  # To not print big "Test.DefaultTestSet(…)", when running manually
