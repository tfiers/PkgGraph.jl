using PkgGraph
using Documenter
# I want newest Documenter (gh logo repo link :))
# https://github.com/JuliaDocs/Documenter.jl/blob/master/CHANGELOG.md
# Manifest is committed, so fine to add a dev version manually.

on_github = (get(ENV, "CI", "") == "true")  # This is set by GitHub itself.

makedocs(
    modules = [PkgGraph],
    # ↪ `makedocs` gives a warning if it finds any docstrings in these modules that aren't
    #    included in the markdown.
    sitename = "PkgGraph.jl",
    # ↪ Displayed in page title and navbar.
    doctest = false,
    # ↪ Done in runtests.jl (CI always builds docs and runs test together anyway).
    #   Plus, faster doc rebuilds when writing docs locally.
    format = Documenter.HTML(;
        prettyurls = on_github,
        # ↪ When local, no `/pagename/index.html`
        canonical = "https://tfiers.github.io/PkgGraph.jl/stable",
        # ↪ Hint for search engines that this version is where they should send users.
        edit_link = "main",
        # ↪ Instead of current commit hash. Let 'em edit main.
        footer = nothing,  # Normally "Powered by …"
    ),
    pages=[
        "Home" => "index.md",
    ],
)

if on_github
    deploydocs(;
        repo = "github.com/tfiers/PkgGraph.jl",
        devbranch = "main",
    )
end
