
# We temporarily activate the docs/ project to run the doctest, but restore the originally
# active project after. This is so you don't have to constantly change envs locally when
# you're running both `pkg> test` and doctest repeatedly.
active_proj = Base.active_project()

using Pkg
Pkg.activate(@__DIR__)

on_github = (get(ENV, "GITHUB_ACTIONS", "") == "true")
if on_github
    Pkg.instantiate()
end

using Documenter
using PkgGraph

# So we don't need to be `using PkgGraph` in every example:
DocMeta.setdocmeta!(PkgGraph, :DocTestSetup, :(using PkgGraph); recursive=true)

doctest(PkgGraph)

# Restore env
Pkg.activate(active_proj)
