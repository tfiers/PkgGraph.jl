using PkgDepGraph
using Documenter

DocMeta.setdocmeta!(PkgDepGraph, :DocTestSetup, :(using PkgDepGraph); recursive=true)

makedocs(;
    modules=[PkgDepGraph],
    authors="Tomas Fiers <tomas.fiers@gmail.com> and contributors",
    repo="https://github.com/tfiers/PkgDepGraph.jl/blob/{commit}{path}#{line}",
    sitename="PkgDepGraph.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://tfiers.github.io/PkgDepGraph.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/tfiers/PkgDepGraph.jl",
    devbranch="main",
)
