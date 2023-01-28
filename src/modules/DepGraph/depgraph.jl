
"""
    depgraph(pkgname; jll = true, stdlib = true)

Build a directed graph of the dependencies of the given package, using
the active project's Manifest file.

The returned `deps` object is a flat list of `"PkgA" => "PkgB"`
dependency pairs.

Binary JLL dependencies and packages in the standard library can be
filtered out from the result by setting `jll` and `stdlib` to `false`.

## Example:

```jldoctest
julia> using PkgGraph.DepGraph

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
depgraph(pkgname; jll = true, stdlib = true, verbose = false) = begin
    rootpkg = string(pkgname)
    if is_in_project(rootpkg)
        verbose && @info "Package `$rootpkg` found in active project. Using Manifest.toml"
        direct_deps = direct_deps_from_project()
        spin = false
    else
        @info "Package \"$rootpkg\" not found in active project. Using General registry"
        direct_deps = direct_deps_from_registry
        spin = true
        spinner = "🌑🌒🌓🌔🌕🌖🌗🌘"
    end
    spin && (p = ProgressUnknown("Crawling registry", spinner=true))
    deps = Vector{Pair{String, String}}()
    add_deps_of(pkg) = begin
        for dep in direct_deps(pkg)
            spin && ProgressMeter.next!(p; spinner)
            if should_be_included(dep, include_jll=jll, include_stdlib=stdlib)
                push!(deps, pkg => dep)
                add_deps_of(dep)
            end
        end
    end
    add_deps_of(rootpkg)
    spin && ProgressMeter.finish!(p)
    return unique!(deps)  # Could use a SortedSet instead; but this spares a pkg load.
end


should_be_included(pkg; include_jll = true, include_stdlib = true) =
    if !include_jll && is_jll(pkg)
        false
    elseif !include_stdlib && is_in_stdlib(pkg)
        false
    else
        true
    end

"""
    is_jll(pkg)::Bool
"""
is_jll(pkg) = endswith(string(pkg), "_jll")

"""
    is_in_stdlib(pkg)::Bool
"""
is_in_stdlib(pkg) = string(pkg) in STDLIB_NAMES
