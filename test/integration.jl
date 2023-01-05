using PkgGraph
using PkgGraph.Internals
using Test


@testset "end-user" begin

    @test isnothing(PkgGraph.open("Test", dryrun = true))
    @test isnothing(PkgGraph.create("Test", dryrun = true))
end


@testset "dot" begin

    @test to_dot_str(:TOML, Options()) ==
        """
        digraph {
            bgcolor = "transparent"
            node [fontname = "sans-serif", style = "filled", fillcolor = "white"]
            edge [arrowsize = 0.88]
            TOML -> Dates
            Dates -> Printf
            Printf -> Unicode
        }
        """

    @test to_dot_str(:TOML, Options(style=[])) ==
        """
        digraph {
            TOML -> Dates
            Dates -> Printf
            Printf -> Unicode
        }
        """

    @test to_dot_str(:URIs, Options(style=[])) ==
        """
        digraph {
            onlynode [label = \" (URIs has no dependencies) \", shape = \"plaintext\"]
        }
        """
end


@testset "urls" begin

    urlencoded = "digraph%20%7B%0A%20%20%20%20bgcolor%20%3D%20%22transparent%22%0A%20%20%20%20node%20%5Bfontname%20%3D%20%22sans-serif%22%2C%20style%20%3D%20%22filled%22%2C%20fillcolor%20%3D%20%22white%22%5D%0A%20%20%20%20edge%20%5Barrowsize%20%3D%200.88%5D%0A%20%20%20%20TOML%20-%3E%20Dates%0A%20%20%20%20Dates%20-%3E%20Printf%0A%20%20%20%20Printf%20-%3E%20Unicode%0A%7D%0A"

    @test url("TOML", Options()) == "https://dreampuf.github.io/GraphvizOnline/#" * urlencoded

    @test url("TOML", Options(base_url=last(PkgGraph.webapps))) == "https://edotor.net/?engine=dot#" * urlencoded

    @test url("TOML", Options(style=[])) == "https://dreampuf.github.io/GraphvizOnline/#digraph%20%7B%0A%20%20%20%20TOML%20-%3E%20Dates%0A%20%20%20%20Dates%20-%3E%20Printf%0A%20%20%20%20Printf%20-%3E%20Unicode%0A%7D%0A"
end
