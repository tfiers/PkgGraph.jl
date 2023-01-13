
using PkgGraph
using Test

@testset "SVG" begin

    contents(file) = read(file, String)

    infile = joinpath(@__DIR__, "svg", "simple-dot-output.svg")
    expected = joinpath(@__DIR__, "svg", "simple-dot-with-darkmode.svg")
    outfile = tempname()

    PkgGraph.SVG.add_darkmode(infile, outfile)

    @test contents(outfile) == contents(expected)
end
