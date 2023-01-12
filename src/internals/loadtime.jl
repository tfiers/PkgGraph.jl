
# julia> @time_imports using UnicodePlots
output = """
      0.6 ms  SnoopPrecompile
      6.1 ms  StaticArraysCore
    910.7 ms  StaticArrays
     86.0 ms  FixedPointNumbers
    111.7 ms  ColorTypes 7.03% compilation time
     66.9 ms  Crayons
      1.3 ms  ConstructionBase
    593.1 ms  Unitful
      2.4 ms  DataAPI
      1.4 ms  Compat
     14.1 ms  OrderedCollections
    113.0 ms  DataStructures
      0.8 ms  SortingAlgorithms
     13.6 ms  Missings
      6.1 ms  DocStringExtensions 64.90% compilation time
    105.1 ms  ChainRulesCore
     25.8 ms  ChangesOfVariables
      3.1 ms  InverseFunctions
     12.8 ms  IrrationalConstants
      1.4 ms  LogExpFunctions
      0.6 ms  StatsAPI
     43.0 ms  StatsBase
    178.2 ms  MarchingCubes
      0.4 ms  Reexport
    534.3 ms  Colors
      0.3 ms  OpenLibm_jll
     34.0 ms  Preferences
      0.6 ms  JLLWrappers
     87.7 ms  CompilerSupportLibraries_jll
    456.5 ms  OpenSpecFun_jll 94.97% compilation time (99% recompilation)
     31.4 ms  SpecialFunctions
      0.5 ms  TensorCore
    280.2 ms  ColorVectorSpace 2.60% compilation time
     25.4 ms  ColorSchemes
      0.5 ms  Requires
      0.6 ms  NaNMath
      5.1 ms  Contour
    418.7 ms  FileIO 4.33% compilation time (15% recompilation)
     28.2 ms  Bzip2_jll
      0.4 ms  Zlib_jll
     30.4 ms  FreeType2_jll
      7.2 ms  CEnum
     11.1 ms  FreeType
   2348.7 ms  UnicodePlots 2.32% compilation time
"""

lines = split(strip(output), "\n")
parse_line(l) = begin
    parts = split(l, limit = 4)
    time_ms = parse(Float64, parts[1])
    @assert parts[2] == "ms"
    pkgname = parts[3]
    extra_info = (length(parts) > 3 ? last(parts) : nothing)
    (; pkgname, time_ms)
end
loadtimes = parse_line.(lines)

pkgname = "Revise"

proj = relpath(dirname(Base.active_project()))
code = "using InteractiveUtils; @time_imports using $pkgname"
# ↪ not using expr, as that's noisy (`begin` and LineNumberNodes)
cmd = `julia --startup-file=no --project=$proj -e $code`

# Relevant thread, on Tee:
# https://discourse.julialang.org/t/write-to-file-and-stdout/35042/2

begin
    buf = IOBuffer()
    pos = 0
    process = run(pipeline(cmd, buf), wait=false)
    while process_running(process)
        sleep(0.1)
        seek(buf, pos)
        new = read(buf, String)
        print(new)
        pos += sizeof(new)
    end
    println()
    output = String(take!(buf))
end
