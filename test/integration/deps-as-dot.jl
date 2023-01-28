
@testset "deps-as-dot" begin

    @test PkgGraph.depgraph_as_dotstr(:TOML) ==
        """
        digraph {
            bgcolor = "transparent"
            node [fontcolor="black"]
            edge [color="black"]
            node [fontname="sans-serif", fontsize=14]
            node [color=none, width=1, height=0.3]
            edge [arrowsize=0.8]
            TOML -> Dates
            Dates -> Printf
            Printf -> Unicode
        }
        """

    @test PkgGraph.depgraph_as_dotstr(:URIs, style=[]) ==
        """
        digraph {
            bgcolor = "transparent"
            node [fontcolor="black"]
            edge [color="black"]
            onlynode [label=\" (URIs has no dependencies) \", shape=plaintext]
        }
        """
end
