
@testset "deps-as-dot" begin

    @test PkgGraph.depgraph_as_dotstr(:TOML) ==
        """
        digraph {
            bgcolor = "transparent"
            node [fillcolor="white", fontcolor="black", color="black"]
            edge [color="black"]
            node [fontname="sans-serif", style="filled"]
            edge [arrowsize=0.88]
            TOML -> Dates [color=gray]
            Dates -> Printf [color=gray]
            Printf -> Unicode [color=gray]
            TOML [color=gray fontcolor=gray]
            Dates [color=gray fontcolor=gray]
            Printf [color=gray fontcolor=gray]
            Unicode [color=gray fontcolor=gray]
        }
        """

    @test PkgGraph.depgraph_as_dotstr(:TOML, style=[], dark=true, bg=:white, faded=nothing) ==
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
