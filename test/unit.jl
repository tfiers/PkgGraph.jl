using PkgGraph
using PkgGraph.Internals
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

    @test !is_jll("TOML")
    @test is_in_stdlib("TOML")
    @test !is_jll("Graphs")
    @test !is_in_stdlib("Graphs")
    @test is_jll("LibUV_jll")
    @test is_in_stdlib("LibUV_jll")

    @test  should_be_included("LibUV_jll")
    @test !should_be_included("LibUV_jll", include_stdlib = false)
    @test !should_be_included("LibUV_jll", include_jll = false)
    @test !should_be_included("TOML", include_stdlib = false)
    @test  should_be_included("TOML", include_jll = false)

    @test depgraph("Graphs"; jll = false, stdlib = false) == [
               "Graphs" => "ArnoldiMethod"
        "ArnoldiMethod" => "StaticArrays"
         "StaticArrays" => "StaticArraysCore"
               "Graphs" => "Compat"
               "Graphs" => "DataStructures"
       "DataStructures" => "Compat"
       "DataStructures" => "OrderedCollections"
               "Graphs" => "Inflate"
               "Graphs" => "SimpleTraits"
         "SimpleTraits" => "MacroTools"
    ]
end



@testset "dot" begin

    edges = [:A => :B, "yes" => "no"];

    style = ["node [color=\"red\"]"];

    @test to_dot_str(edges; style, bg=:blue, indent = 2) ==
        """
        digraph {
          bgcolor = "blue"
          node [fillcolor="white", fontcolor="black", color="black"]
          edge [color="black"]
          node [color="red"]
          A -> B
          yes -> no
        }
        """

    @test to_dot_str([], mode=:dark, style=[], emptymsg="(empty graph)") ==
        """
        digraph {
            bgcolor = "transparent"
            node [fillcolor="black", fontcolor="white", color="white"]
            edge [color="white"]
            onlynode [label=\" (empty graph) \", shape=\"plaintext\"]
        }
        """
end


@testset "urls" begin

    base = PkgGraph.webapps[2]
    @test PkgGraph.url("digraph {Here->There}", base) ==
        "http://magjac.com/graphviz-visual-editor/?dot=digraph%20%7BHere-%3EThere%7D"
end


@testset "local" begin

    @test is_dot_available() isa Bool

    @test output_path(:Test, ".", :svg) == joinpath(".", "Test-deps.svg")
    @test dotcommand(:png, "infile", "outfile") == `dot -Tpng -ooutfile infile`
end
