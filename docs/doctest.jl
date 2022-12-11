on_github = (get(ENV, "GITHUB_ACTIONS", "") == "true")

if on_github
    using Pkg
    Pkg.instantiate()
end

using Documenter
using PkgGraph

# So we don't need to be `using PkgGraph` in every example.
DocMeta.setdocmeta!(PkgGraph, :DocTestSetup, :(using PkgGraph); recursive=true)

doctest(PkgGraph)
