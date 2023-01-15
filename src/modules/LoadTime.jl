
module LoadTime

export time_imports

"""
    time_imports(pkg)

Measure load times of the given package and its dependencies, by running
`@time_imports` in a new julia process, and parsing its output.

`@time_imports` is new in Julia 1.8. If called with a lower Julia
version, this method prints a warning and returns an empty list.

## Example:

```
julia> using PkgGraph.LoadTime

julia> loadtimes = time_imports("EzXML");
┌ Info: Running command:
│ `julia --startup-file=no --project=. -e 'using InteractiveUtils; @time_imports using EzXML'`
└ Live output:
    423.5 ms  Preferences
      0.7 ms  JLLWrappers
      0.3 ms  Zlib_jll
      9.3 ms  Libiconv_jll 40.60% compilation time
      4.4 ms  XML2_jll
     54.1 ms  EzXML 53.25% compilation time

julia> last(loadtimes)
(pkgname = "EzXML", time_ms = 54.1)
```
"""
function time_imports(pkg)
    # On the docstring: note that we don't jldoctest this.
    # Locally, on my Windows laptop, the doctest works (with `; filter = r"\\d.*\$"m`)
    # But on CI, it does not (re https://github.com/tfiers/PkgGraph.jl/issues/81)
    # Hence, no doctest.
    if VERSION < v"1.8"
        @warn "`@time_imports` requires Julia 1.8 or higher"
        return []
    end
    code = timeimports_code(pkg)
    proj = activeproject_short()
    cmd = julia_cmd(code, proj)
    output = run_verbose(cmd)
    loadtimes = parse_timeimports(output)
    return loadtimes
end


timeimports_code(pkgname) =
    "using InteractiveUtils; @time_imports using $pkgname"
    # ↪ str, not expr, as that's noisy (`begin` and LineNumberNodes)

activeproject_short() = relpath(dirname(Base.active_project()))

julia_cmd(code, proj) =
    `julia --startup-file=no --project=$proj -e $code`

"""
Run the given command, capturing and returning its stdout as a String;
but also live-printing that stdout to the current process's stdout.
"""
run_verbose(cmd) = begin
    buf = IOBuffer()
    pos = 0
    @info "Running command:\n$cmd\nLive output:"
    p = run(pipeline(cmd, buf), wait=false)
    while process_running(p)
        sleep(0.1)
        seek(buf, pos)
        new = read(buf, String)
        print(new)
        pos += sizeof(new)
    end
    return output = String(take!(buf))
end

parse_timeimports(output) = begin
    lines = split(strip(output), "\n")
    return [parse_line(l) for l in lines]
end


# Some example output lines of a `@time_import` call:
#
#     456.5 ms  OpenSpecFun_jll 94.97% compilation time (99% recompilation)
#      31.4 ms  SpecialFunctions
#       0.5 ms  TensorCore
#     280.2 ms  ColorVectorSpace 2.60% compilation time
parse_line(l) = begin
    parts = split(l, limit = 4)
    time_ms = parse(Float64, parts[1])
    @assert parts[2] == "ms"
    pkgname = parts[3]
    extra_info = (length(parts) > 3 ? last(parts) : nothing)
    (; pkgname, time_ms)
end

end
