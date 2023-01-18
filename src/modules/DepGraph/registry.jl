using Pkg.Registry: reachable_registries,
                    uuids_from_name,
                    init_package_info!,
                    initialize_uncompressed!,
                    JULIA_UUID

regs = reachable_registries()
const reg = regs[findfirst(reg.name == "General" for reg in regs)]
@assert reg.name == "General"

name(uuid::UUID) =
    if uuid in STDLIB_UUIDS
        STDLIB[uuid]
    elseif uuid in keys(reg.pkgs)
        reg.pkgs[uuid].name
    else
        error()
    end

uuid(name::AbstractString) =
    if name in STDLIB_NAMES
        findfirst(==(name), STDLIB)
    else
        uuids = uuids_from_name(reg, name)
        if isempty(uuids)
            error("Package `$name` not found")
        elseif length(uuids) > 1
            error("Multiple packages with the same name (`$name`) not supported")
        else
            return only(uuids)
        end
    end

direct_deps_from_registry(pkg) = begin
    if pkg in STDLIB_NAMES
        return direct_deps_of_stdlib_pkg(pkg)
    end
    pkgentry = reg.pkgs[uuid(pkg)]
    p = init_package_info!(pkgentry)
    versions = keys(p.version_info)
    v = maximum(versions)
    initialize_uncompressed!(p, [v])
    vinfo = p.version_info[v]
    compat_info = vinfo.uncompressed_compat
    # ↪ All direct deps will be here, even if author didn't them
    #   [compat] (their versionspec will just be "*").
    direct_dep_uuids = collect(keys(compat_info))
    filter!(!=(JULIA_UUID), direct_dep_uuids)
    return name.(direct_dep_uuids)
end
