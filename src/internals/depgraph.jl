
"""
    depgraph(pkgname)

Build a directed graph of the dependencies of the given package, using
the active project's Manifest file.

The returned `deps` object is a flat list of `"PkgA" => "PkgB"` dependency pairs.

## Example:

```jldoctest
julia> using PkgGraph.Internals

julia> depgraph(:Test)
8-element Vector{Pair{String, String}}:
             "Test" => "InteractiveUtils"
 "InteractiveUtils" => "Markdown"
         "Markdown" => "Base64"
             "Test" => "Logging"
             "Test" => "Random"
           "Random" => "SHA"
           "Random" => "Serialization"
             "Test" => "Serialization"
```
"""
depgraph(pkgname) = begin
    rootpkg = string(pkgname)
    packages = packages_in_active_manifest()
    if rootpkg ∉ keys(packages)
        error("""
        The given package ($pkgname) must be installed in the active project
        (which is currently `$(active_project())`)""")
    end
    deps = Vector{Pair{String, String}}()
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

if VERSION ≥ v"1.7"
    packages_in(manifest) = TOML.parsefile(manifest)["deps"]
else
    packages_in(manifest) = TOML.parsefile(manifest)
end

"""
    packages_in_active_manifest()

Read and parse the `Manifest.toml` of the active project, and return its
'deps' table (as a dictionary indexed by package names).

Every entry in this dictionary is a list. This is for when multiple
packages would share the same name.

## Example:

```jldoctest; filter = r" => .*\$"m
julia> using PkgGraph.Internals

julia> packages = packages_in_active_manifest();

julia> only(packages["PkgGraph"])
Dict{String, Any} with 4 entries:
  "deps"    => ["DefaultApplication", "TOML", "URIs"]
  "uuid"    => "f9c1b9e4-72e8-4a14-ade5-14f45fc35f11"
  "version" => "0.1.0"
  "path"    => "C:\\Users\\tfiers\\.julia\\dev\\PkgGraph"
```
"""
packages_in_active_manifest() = packages_in(manifest(active_project()))


"""
    vertices(edges)

Extract the unique nodes from the given list of edges.

Useful when converting the output of [`depgraph`](@ref) to a `Graphs.jl`
graph. (See the example script in [The Graphs.jl ecosystem](@ref)).

## Example:

```jldoctest
julia> using PkgGraph.Internals

julia> edges = depgraph(:Test);

julia> vertices(edges)
8-element Vector{String}:
 "Test"
 "InteractiveUtils"
 "Markdown"
 "Random"
 "Base64"
 "Logging"
 "SHA"
 "Serialization"
```
"""
vertices(edges) = [first.(edges); last.(edges)] |> unique!
