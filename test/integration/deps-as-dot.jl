
@testset "deps-as-dot" begin

    @test PkgGraph.depgraph_as_dotstr(:TOML) ==
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

    @test PkgGraph.depgraph_as_dotstr(:TOML, style=[], mode=:dark, bg=:white) ==
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

    @test PkgGraph.depgraph_as_dotstr(:URIs, style=[]) ==
        """
        digraph {
            bgcolor = "transparent"
            node [fillcolor="white", fontcolor="black", color="black"]
            edge [color="black"]
            onlynode [label=\" (URIs has no dependencies) \", shape=\"plaintext\"]
        }
        """
end
