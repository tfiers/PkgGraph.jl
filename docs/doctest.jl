on_github = (get(ENV, "CI", "") == "true")  # This is set by GitHub itself.

if on_github
    using Pkg
    Pkg.instantiate()
end

using Documenter
using PkgGraph

doctest(PkgGraph)
