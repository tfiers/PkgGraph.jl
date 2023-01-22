
using PkgGraph
using Test

@testset "DotString" begin

    edges = [:A => :B, "yes" => "no"];

    style = ["node [color=\"red\"]"];

    @test PkgGraph.to_dot_str(edges; style, bg=:blue, indent = 2) ==
        """
        digraph {
          bgcolor = "blue"
          node [fontcolor="black"]
          edge [color="black"]
          node [color="red"]
          A -> B
          yes -> no
        }
        """

    @test PkgGraph.to_dot_str([], dark=true, style=[], emptymsg="(empty graph)") ==
        """
        digraph {
            bgcolor = "transparent"
            node [fontcolor="white"]
            edge [color="white"]
            onlynode [label=\" (empty graph) \", shape=plaintext]
        }
        """
end
