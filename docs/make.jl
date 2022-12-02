using PkgDepGraph
using Documenter
# I want newest Documenter (gh logo repo link :))
# https://github.com/JuliaDocs/Documenter.jl/blob/master/CHANGELOG.md
# Manifest is committed so fine to do once.


DocMeta.setdocmeta!(PkgDepGraph, :DocTestSetup, :(using PkgDepGraph); recursive=true)
# This is from here: https://github.com/JuliaCI/PkgTemplates.jl/issues/232
# But I didn't have any trouble with running doctests before?

makedocs(;
    modules=[PkgDepGraph],
    authors="Tomas Fiers <tomas.fiers@gmail.com> and contributors",
    # Is this needed? Where?
    repo="https://github.com/tfiers/PkgDepGraph.jl/blob/{commit}{path}#{line}",
    # ↪ makedocs does this automatically for a gh remote
    sitename="PkgDepGraph.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        # ↪ when local, no /pagename/index.html. ok ig.
        canonical="https://tfiers.github.io/PkgDepGraph.jl",
        edit_link="main",
        footer=nothing,  # yee
    ),
    pages=[
        "Home" => "index.md",
    ],
    # doctest is true by default
    # Is doctest not better in test. For fast doc build feedback loop.
)

deploydocs(;
    repo="github.com/tfiers/PkgDepGraph.jl",
    devbranch="main",
)
# Shouldn't this only be done in CI.
