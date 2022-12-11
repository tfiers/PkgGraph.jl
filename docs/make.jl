
using Pkg
Pkg.activate(@__DIR__)

on_github = (get(ENV, "GITHUB_ACTIONS", "") == "true")
build_dir_exists = isdir(joinpath(@__DIR__, "build"))

# For developers building docs locally, we don't want to always instantiate automatically
# (→ slower builds). The following is a heuristic for whether the docs env might not be
# instantiated yet. (If it is, no problem. If it's not, the imports will (might) error).
if !on_github && !build_dir_exists
    Pkg.instantiate()
end

using PkgGraph
using Documenter
# I want newest Documenter (gh logo repo link :))
# https://github.com/JuliaDocs/Documenter.jl/blob/master/CHANGELOG.md
# We ran
#
#   (docs) pkg> add https://github.com/JuliaDocs/Documenter.jl`
#
# manually one time; but that's fine, because docs/Manifest.toml is committed.

# Configure doctests to not need `using PkgGraph` in every example.
DocMeta.setdocmeta!(PkgGraph, :DocTestSetup, :(using PkgGraph); recursive=true)

println("Running mkdocs")
makedocs(
    modules = [PkgGraph],
    # ↪ To get a warning if there are any docstrings not mentioned in the markdown.
    sitename = "PkgGraph.jl",
    # ↪ Displayed in page title and navbar.
    doctest = true,
    format = Documenter.HTML(;
        prettyurls = on_github,
        # ↪ When local, generate `/pagename.html`s, not `/pagename`s (i.e. not
        #   `/pagename/index.html`s), so that you don't need a localhost server
        canonical = "https://tfiers.github.io/PkgGraph.jl/stable",
        # ↪ To not have search engines send users to old versions.
        edit_link = "main",
        # ↪ Instead of current commit hash. Let 'em edit main.
        footer = nothing,
        # ↪ Normally "Powered by …"
    ),
    pages=[
        "Home" => "index.md",
        "usage.md",
        "internals.md",
        "background.md",
    ],
)

if on_github
    deploydocs(;
        repo = "github.com/tfiers/PkgGraph.jl",
        devbranch = "main",
        # ↪ What 'Dev' in the version dropdown points to.
    )
end

if !isdefined(Main, :docs_already_opened)
    using DefaultApplication
    DefaultApplication.open(joinpath(@__DIR__, "build", "index.html"))
    docs_already_opened = true;
end
