on_github = (get(ENV, "CI", "") == "true")  # This is set by GitHub itself.

if on_github
    using Pkg
    Pkg.instantiate()
end

using Documenter
using PkgGraph

# So we don't need to be `using PkgGraph` in every example.
DocMeta.setdocmeta!(PkgGraph, :DocTestSetup, :(using PkgGraph); recursive=true)

doctest(PkgGraph)
