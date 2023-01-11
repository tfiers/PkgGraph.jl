using PkgGraph
using PkgGraph.Internals
using Test


@testset "end-user" begin

    @test isnothing(PkgGraph.open("Test", dryrun = true))
    @test isnothing(PkgGraph.create("Test", dryrun = true))
    @test isnothing(PkgGraph.create("PyPlot", dryrun = true))
end


@testset "svg" begin

    contents(file) = read(file, String)

    infile = joinpath(@__DIR__, "simple-dot-output.svg")
    outfile = tempname()
    SVG.add_darkmode(infile, outfile)
    expected = joinpath(@__DIR__, "simple-dot-with-darkmode.svg")
    @test contents(outfile) == contents(expected)
end


@testset "graphsjl" begin

    edges = PkgGraph.depgraph("Test")
    nt = PkgGraph.as_graphsjl_input(edges)
    @test nt.vertices          == PkgGraph.vertices(edges)
    @test nt.indexof("Base64") == PkgGraph.node_index(edges)("Base64")
    @test nt.adjacency_matrix  == PkgGraph.adjacency_matrix(edges)
end


@testset "deps-as-dot" begin

    @test to_dot_str(:TOML, Options()) ==
        """
        digraph {
            bgcolor = "transparent"
            node [fillcolor="white", fontcolor="black", color="black"]
            edge [color="black"]
            node [fontname="sans-serif", style="filled"]
            edge [arrowsize=0.88]
            TOML -> Dates
            Dates -> Printf
            Printf -> Unicode
        }
        """

    @test to_dot_str(:TOML, Options(style=[], mode=:dark, bg=:white)) ==
        """
        digraph {
            bgcolor = "white"
            node [fillcolor="black", fontcolor="white", color="white"]
            edge [color="white"]
            TOML -> Dates
            Dates -> Printf
            Printf -> Unicode
        }
        """

    @test to_dot_str(:URIs, Options(style=[])) ==
        """
        digraph {
            bgcolor = "transparent"
            node [fillcolor="white", fontcolor="black", color="black"]
            edge [color="black"]
            onlynode [label=\" (URIs has no dependencies) \", shape=\"plaintext\"]
        }
        """
end
