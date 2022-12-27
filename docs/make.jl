
originally_active_proj = Base.active_project()

using Pkg
Pkg.activate(@__DIR__)

on_github = (get(ENV, "GITHUB_ACTIONS", "") == "true")
first_run = !isdefined(Main, :first_run_complete)

if !on_github
    first_run && print("Loading Revise … ")
    using Revise
    first_run && println("done")
    build_dir_exists = isdir(joinpath(@__DIR__, "build"))
    if !build_dir_exists
        println("Instantiating docs/Manifest.toml")
        Pkg.instantiate()  # See ReadMe
    end
end

repo = "tfiers/PkgGraph.jl"
ref = gitref = "main"

println("Pre-processing src/")
include("scripts/inline_linkdefs.jl")


@showtime using PkgGraph
@showtime using Documenter

if first_run
    # Configure doctests to not need `using PkgGraph` in every example.
    DocMeta.setdocmeta!(PkgGraph, :DocTestSetup, :(using PkgGraph); recursive=true)
end

println("Running makedocs")
makedocs(
    source = "src-mod",
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
        # ↪ To not have search engines send users to old versions
        edit_link = "main",
        # ↪ Instead of current commit hash. Let 'em edit main
        footer = nothing,
        # ↪ Normally "Powered by …"
        collapselevel = 3,
        # ↪ Default: 2. This is alas only for actual pages;
        #   can't auto-expand intra-page headers in other pages.
    ),
    pages=[
        "Home" => "index.md",
        "Reference" => [
            "ref/end-user.md",
            "ref/internal.md",
        ],
        "background.md",
    ],
)

include("scripts/insert_readme_in_docs.jl")


# From `inline_linkdefs.jl`
correct_edit_links()


if on_github
    devurl = "dev"
    deploydocs(;
        repo = "github.com/$repo",
        devbranch = "main",
        # ↪ What 'dev' in the version dropdown points to.
        devurl,
        # ↪ The text of that 'dev' in the version dropdown (and in url)
        versions = ["v#.#", devurl => devurl],
        # ↪ Default, but without the `"stable" => "v^"`.
    )
end

# Open browser to the generated docs the first time this script is run / included.
if first_run && !on_github
    if Base.prompt("Open results in browser? [y]/n") in ["y", ""]
        using DefaultApplication
        DefaultApplication.open(joinpath(@__DIR__, "build", "index.html"))
    end
end

if Base.active_project() ≠ originally_active_proj
    println("Re-activating originally active project")
    Pkg.activate(originally_active_proj)
end

first_run_complete = true

nothing  # To not print `true` when `include`ing.
