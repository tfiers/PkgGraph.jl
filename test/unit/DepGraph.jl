
using PkgGraph.DepGraph
using Test

@testset "DepGraph" begin

    @test depgraph("TOML") == [
        "TOML" => "Dates",
        "Dates" => "Printf",
        "Printf" => "Unicode"
    ]

    if VERSION ≥ v"1.8"  # Julia v1.7 does not support error string matching
        @test_throws(
            "Package `DinnaeExist` not found",
            depgraph("DinnaeExist")
        )
    end

    @testset "jll & stdlib exclusion" begin

        using PkgGraph: is_jll, is_in_stdlib, should_be_included

        @test !is_jll("TOML")
        @test  is_in_stdlib("TOML")
        @test !is_jll("Graphs")
        @test !is_in_stdlib("Graphs")
        @test  is_jll("LibUV_jll")
        @test  is_in_stdlib("LibUV_jll")

        @test  should_be_included("LibUV_jll")
        @test !should_be_included("LibUV_jll", include_stdlib = false)
        @test !should_be_included("LibUV_jll", include_jll = false)
        @test !should_be_included("TOML", include_stdlib = false)
        @test  should_be_included("TOML", include_jll = false)

        # User might run with proj `test` active (`] test`), or project `PkgGraph` (`include("..")`)
        # The latter does not have Graphs in its manifest; so it comes from registry, and there
        # deps have different order (also on julia 1.6 there's no registry querying).
        # Heeence, why `../standalone` exists.

        using Pkg
        deps = Pkg.dependencies()
        @assert "Graphs" in [dep.name for dep in values(deps)] "Please use [activate_standalone.jl]"
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


    @testset "Graphs.jl export" begin

        edges = depgraph("Test")
        nt = as_graphsjl_input(edges)
        @test nt.vertices          == vertices(edges)
        @test nt.indexof("Base64") == node_index(edges)("Base64")
        @test nt.adjacency_matrix  == adjacency_matrix(edges)
    end
end
