using PkgGraph
using PkgGraph: depgraph, deps_as_DOT, url, is_dot_available
using Test

@testset "PkgGraph.jl" begin

    @test depgraph("TOML") == [
        "TOML" => "Dates",
        "Dates" => "Printf",
        "Printf" => "Unicode"
    ]

    @test deps_as_DOT(:TOML) ==
        """
        digraph {
            node [fontname = "sans-serif"]
            edge [arrowsize = 0.88]
            TOML -> Dates
            Dates -> Printf
            Printf -> Unicode
        }
        """

    urlencoded = "digraph%20%7B%0A%20%20%20%20node%20%5Bfontname%20%3D%20%22sans-serif%22%5D%0A%20%20%20%20edge%20%5Barrowsize%20%3D%200.88%5D%0A%20%20%20%20TOML%20-%3E%20Dates%0A%20%20%20%20Dates%20-%3E%20Printf%0A%20%20%20%20Printf%20-%3E%20Unicode%0A%7D%0A"

    @test url("TOML") == "https://dreampuf.github.io/GraphvizOnline/#" * urlencoded

    PkgGraph.set_base_url(last(PkgGraph.base_urls))

    @test url("TOML") == "https://edotor.net/?engine=dot#" * urlencoded

    PkgGraph.set_base_url(first(PkgGraph.base_urls))

    empty!(PkgGraph.style)

    @test deps_as_DOT(:TOML) ==
        """
        digraph {
            TOML -> Dates
            Dates -> Printf
            Printf -> Unicode
        }
        """

    @test url("TOML") == "https://dreampuf.github.io/GraphvizOnline/#digraph%20%7B%0A%20%20%20%20TOML%20-%3E%20Dates%0A%20%20%20%20Dates%20-%3E%20Printf%0A%20%20%20%20Printf%20-%3E%20Unicode%0A%7D%0A"

    if VERSION ≥ v"1.8"  # Julia v1.7 does not support error string matching
        @test_throws(
            "The given package (DinnaeExist) must be installed in the active project",
            depgraph("DinnaeExist")
        )
    end

    @test is_dot_available() isa Bool
end
