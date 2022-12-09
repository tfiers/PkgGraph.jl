module PkgGraph

using Pkg
using TOML
using Base: active_project
using URIs: escapeuri
using DefaultApplication


"""
    depgraph(pkgname)

Open the browser to an image of `pkgname`'s dependency graph.\\
The given package must be installed in the currently active project.

To render the dependency graph using a local Graphviz `dot` installation (instead of an
online Graphviz renderer), use [`depgraph_local`](@ref).

For more info, see [`depgraph_url`](@ref).
"""
depgraph(pkgname) = begin
    DefaultApplication.open(depgraph_url(pkgname))
    # ↪ Passing a url opens the browser on all platforms. (Even though that is undocumented:
    #   https://github.com/tpapp/DefaultApplication.jl/issues/12)
    return nothing
end


"""
    depgraph_local(pkgname, dir = tempdir(); fmt = :png)

Render the dependency graph of the given package as an image in `dir`, and open it with your
default image viewer. Uses the external program '`dot`' (https://graphviz.org), which must
be available on `PATH`.

`fmt` is an output file format supported by dot, such as svg or png.
"""
depgraph_local(pkgname, dir = tempdir(); fmt = :png) = begin
    if !is_dot_available()
        error("`dot` program not found on `PATH`. Get it at https://graphviz.org/download/")
    end
    dotstr = deps_as_DOT(pkgname)
    imgname = "$pkgname-deps.$fmt"
    imgpath = joinpath(dir, imgname)
    create_DOT_image(dotstr, fmt, imgpath)
    DefaultApplication.open(imgpath)
    return nothing
end


const rendering_urls = [
    "https://dreampuf.github.io/GraphvizOnline/#",     # Default
    "http://magjac.com/graphviz-visual-editor/?dot=",  # Linked from graphviz.org. Many features.
    "https://edotor.net/?engine=dot#",
]
const rendering_url = Ref(first(rendering_urls))

"""
    depgraph_url(pkgname)

Create a URL at which the dependency graph of `pkgname` is rendered as an image, using an
online Graphviz rendering service.

## How it works
The dependency graph of `pkgname` is created locally, and converted to a string in the
Graphviz DOT format (see [`deps_as_DOT`](@ref)). This string is URL-encoded, and appended to
a partly-complete URL, which is by default the first entry in the `PkgGraph.rendering_urls`
list. To use a different rendering website, use [`set_rendering_url`](@ref).
"""
depgraph_url(pkgname) = begin
    dotstr = deps_as_DOT(pkgname)
    url = rendering_url[] * escapeuri(dotstr)
end

"""
    set_rendering_url(new)

Set the base url that will be used by [`depgraph`](@ref) and [`depgraph_url`](@ref) to the
given `new` url.

See `PkgGraph.rendering_urls` for some options.
"""
set_rendering_url(new) = (rendering_url[] = new)



"""
    deps_as_DOT(pkgname)

Create the dependency graph of `pkgname` and render it as a Graphviz DOT string.

Example output (truncated), for `"Unitful"`:
```
digraph {
    Unitful -> ConstructionBase
    ConstructionBase -> LinearAlgebra
    LinearAlgebra -> Libdl
    ⋮
    Unitful -> Random
    Random -> SHA
    Random -> Serialization
}
```
For more info, see [`create_depgraph`](@ref) and [`to_DOT_str`](@ref).
"""
deps_as_DOT(pkgname) = create_depgraph(pkgname) |> to_DOT_str


"""
    deps = create_depgraph(pkgname)

Build a graph of the dependencies of the given package, using the active project's Manifest
file.

The returned `deps` object is a flat list of `"PkgA" => "PkgB"` dependency pairs.
"""
create_depgraph(pkgname) = begin
    rootpkg = string(pkgname)
    packages = packages_in_active_manifest()
    if rootpkg ∉ keys(packages)
        error("""
        The given package ($pkgname) must be installed in the active project
        (which is currently `$(active_project())`)""")
    end
    deps = []
    add_deps_of(name) = begin
        pkg_info = only(packages[name])  # Two packages with same name not supported.
        direct_deps = get(pkg_info, "deps", [])
        for dep in direct_deps
            push!(deps, name => dep)
            add_deps_of(dep)
        end
    end
    add_deps_of(rootpkg)
    return unique!(deps)  # Could use a SortedSet instead; but this spares a pkg load.
end

manifest(proj_path) = replace(proj_path, "Project.toml" => "Manifest.toml")
packages_in(manifest) = TOML.parsefile(manifest)["deps"]
packages_in_active_manifest() = packages_in(manifest(active_project()))


"""
    to_DOT_str(edges)

Build a string that represents the given directed graph in the Graphviz DOT format
(https://graphviz.org/doc/info/lang.html).

## Example:

```jldoctest
julia> using PkgGraph: to_DOT_str

julia> edges = [:A => :B, "yes" => "no"];

julia> to_DOT_str(edges) |> println
digraph {
    A -> B
    yes -> no
}
```
"""
function to_DOT_str(edges)
    lines = ["digraph {"]  # DIrected graph
    for (m, n) in edges
        push!(lines, "    $m -> $n")
    end
    push!(lines, "}\n")
    return join(lines, "\n")
end

function is_dot_available()
    if Sys.iswindows()
        cmd = `where dot`
    else
        cmd = `which dot`
    end
    proc = run(cmd, wait = false)
    return success(proc)
end

function create_DOT_image(DOT_str, fmt, path)
    dotfile = tempname()
    write(dotfile, DOT_str)
    run(`dot -T$fmt -o$imgfile $dotfile`)
    println("Created ", relpath(path))
end

end
