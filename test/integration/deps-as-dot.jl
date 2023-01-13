
using PkgGraph: Options

@testset "deps-as-dot" begin

    @test PkgGraph.to_dot_str(:TOML, Options()) ==
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

    @test PkgGraph.to_dot_str(:TOML, Options(style=[], mode=:dark, bg=:white)) ==
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

    @test PkgGraph.to_dot_str(:URIs, Options(style=[])) ==
        """
        digraph {
            bgcolor = "transparent"
            node [fillcolor="white", fontcolor="black", color="black"]
            edge [color="black"]
            onlynode [label=\" (URIs has no dependencies) \", shape=\"plaintext\"]
        }
        """
end
