
using TOML
using Base: active_project

is_in_project(pkg, proj = active_project()) =
    isfile(proj) && (name(proj) == pkg || pkg in keys(all_deps(proj)))

name(proj_path) = name(dict(proj_path))
dict(proj_path) = TOML.parsefile(proj_path)
name(toml::Dict) = get(toml, "name", nothing)

all_deps(project) = begin
    mani = manifest(project)
    if !isfile(mani)
        return Dict()
    end
    @static if VERSION ≥ v"1.7"
        deps = TOML.parsefile(mani)["deps"]
    else
        deps = TOML.parsefile(mani)
    end
end
manifest(project) = replace(project, "Project.toml" => "Manifest.toml")

direct_deps_from_project(proj = active_project()) = begin
    proj_dict = dict(proj)
    proj_name = name(proj_dict)
    all_deps_ = all_deps(proj)
    direct_deps(pkgname) =
        if pkgname == proj_name
            get(proj_dict, "deps", []) |> keys
        else
            deps_with_name = all_deps_[pkgname]
            check_only(deps_with_name)
            dep_dict = only(deps_with_name)
            get(dep_dict, "deps", [])
        end
    direct_deps
end
check_only(packages_with_same_name) = @assert(
    length(packages_with_same_name) == 1,
    """
    Different packages with same name not supported
    (The offending packages:)
    $packages_with_same_name
    """
)

# The above is poop: we want dep tree of entire thing, also if no top specified
# no name. then there's multiple roots, sure (or take as name, the directory)
#


"""
    packages_in_active_manifest()

Read and parse the `Manifest.toml` of the given project, and return its
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
packages_in_active_manifest() = all_deps(active_project())
