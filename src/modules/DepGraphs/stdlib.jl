using UUIDs
using TOML

stdlib() = begin
    packages = Dict{UUID,String}()
    for path in readdir(Sys.STDLIB; join = true)
        # ↪ `join` gets us complete paths
        if isdir(path)
            toml = proj_dict(path)
            push!(packages, UUID(toml["uuid"]) => toml["name"])
        end
    end
    packages
end
proj_dict(pkgdir) = TOML.parsefile(proj_file(pkgdir))
proj_file(pkgdir) = joinpath(pkgdir, "Project.toml")

const STDLIB = stdlib()
const STDLIB_UUIDS = keys(STDLIB)
const STDLIB_NAMES = values(STDLIB)

direct_deps_of_stdlib_pkg(name) = begin
    pkgdir = joinpath(Sys.STDLIB, name)
    d = proj_dict(pkgdir)
    keys(get(d, "deps", []))
end
