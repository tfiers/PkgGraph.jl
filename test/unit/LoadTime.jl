
using PkgGraph.LoadTime: parse_timeimports
using Test

@testset "LoadTime" begin

    example_output = """
      99456.5 ms  OpenSpecFun_jll 94.97% compilation time (99% recompilation)
        423.5 ms  Preferences
          0.7 ms  JLLWrappers
          0.3 ms  Zlib_jll
          9.3 ms  Libiconv_jll 40.60% compilation time
          4.4 ms  XML2_jll
         54.1 ms  EzXML 53.25% compilation time
    """

    @test parse_timeimports(example_output) == [
        (pkgname = "OpenSpecFun_jll", time_ms = 99456.5),
        (pkgname = "Preferences",     time_ms = 423.5),
        (pkgname = "JLLWrappers",     time_ms = 0.7),
        (pkgname = "Zlib_jll",        time_ms = 0.3),
        (pkgname = "Libiconv_jll",    time_ms = 9.3),
        (pkgname = "XML2_jll",        time_ms = 4.4),
        (pkgname = "EzXML",           time_ms = 54.1),
    ]
end



# NamedTuple{(:pkgname,:time_ms),Tuple{SubString{String},Float64}}[(pkgname = "OpenSpecFun_jll",
# time_ms = 99456.5),
# (pkgname = "Preferences",
# time_ms = 423.5),
# (pkgname = "JLLWrappers",
# time_ms = 0.7),
# (pkgname = "Zlib_jll",
# time_ms = 0.3),
# (pkgname = "Libiconv_jll",
# time_ms = 9.3),
# (pkgname = "XML2_jll",
# time_ms = 4.4),
# (pkgname = "EzXML",
# time_ms = 54.1)]
#  ==
# NamedTuple{(:pkgname,:time_ms),Tuple{String,Float64}}[(pkgname = "OpenSpecFun_jll",
# time_ms = 99456.5),
# (pkgname = "Preference",
# time_ms = 423.5),
# (pkgname = "JLLWrapper",
# time_ms = 0.7),
# (pkgname = "Zlib_jl",
# time_ms = 0.3),
# (pkgname = "Libiconv_jll",
# time_ms = 9.3),
# (pkgname = "XML2_jl",
# time_ms = 4.4),
# (pkgname = "EzXML",
# time_ms = 54.1)]
