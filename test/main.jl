using PkgGraphs
using PkgGraphs.Internals
using Test


@testset "depgraph" begin

    @test depgraph("TOML") == [
        "TOML" => "Dates",
        "Dates" => "Printf",
        "Printf" => "Unicode"
    ]

    if VERSION ≥ v"1.8"  # Julia v1.7 does not support error string matching
        @test_throws(
            "The given package (DinnaeExist) must be installed in the active project",
            depgraph("DinnaeExist")
        )
    end

    @test sort(depgraph("Graphs"; ignore_stdlibs=true, ignore_jlls=true)) == [
        "ArnoldiMethod" => "StaticArrays"
        "DataStructures" => "Compat"
        "DataStructures" => "OrderedCollections"
                "Graphs" => "ArnoldiMethod"
                "Graphs" => "Compat"
                "Graphs" => "DataStructures"
                "Graphs" => "Inflate"
                "Graphs" => "SimpleTraits"
          "SimpleTraits" => "MacroTools"
          "StaticArrays" => "StaticArraysCore"
    ]
end


@testset "dot" begin

    @test deps_as_dot(:TOML) ==
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

    @test deps_as_dot(:TOML, style=[]) ==
        """
        digraph {
            TOML -> Dates
            Dates -> Printf
            Printf -> Unicode
        }
        """

    @test deps_as_dot(:URIs, style=[]) ==
        """
        digraph {
            onlynode [label = \" (URIs has no dependencies) \", shape = \"plaintext\"]
        }
        """
end


@testset "urls" begin

    urlencoded = "digraph%20%7B%0A%20%20%20%20bgcolor%20%3D%20%22transparent%22%0A%20%20%20%20node%20%5Bfontname%20%3D%20%22sans-serif%22%2C%20style%20%3D%20%22filled%22%2C%20fillcolor%20%3D%20%22white%22%5D%0A%20%20%20%20edge%20%5Barrowsize%20%3D%200.88%5D%0A%20%20%20%20TOML%20-%3E%20Dates%0A%20%20%20%20Dates%20-%3E%20Printf%0A%20%20%20%20Printf%20-%3E%20Unicode%0A%7D%0A"

    @test url("TOML") == "https://dreampuf.github.io/GraphvizOnline/#" * urlencoded

    @test url("TOML", last(PkgGraphs.webapps)) == "https://edotor.net/?engine=dot#" * urlencoded

    @test url("TOML", style=[]) == "https://dreampuf.github.io/GraphvizOnline/#digraph%20%7B%0A%20%20%20%20TOML%20-%3E%20Dates%0A%20%20%20%20Dates%20-%3E%20Printf%0A%20%20%20%20Printf%20-%3E%20Unicode%0A%7D%0A"
end


@testset "local" begin

    @test is_dot_available() isa Bool

    @test output_path(:Test, ".", :svg) == joinpath(".", "Test-deps.svg")
    @test dotcommand(:png, "infile", "outfile") == `dot -Tpng -ooutfile infile`
end
