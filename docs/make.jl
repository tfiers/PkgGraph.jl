
t₀ = time()
println("\nRunning docs/make.jl")

repo = "tfiers/PkgGraph.jl"
ref = gitref = "main"

src = "src"
srcmod = "src-mod"

print("Pre-processing docs/src/ … ")
include("scripts/process_src.jl")
process_src(verbose = false)
println("done")

using PkgGraph
using Documenter

# Configure doctests to not need `using PkgGraph` in every example.
DocMeta.setdocmeta!(PkgGraph, :DocTestSetup, :(using PkgGraph); recursive=true, warn=false)

println("<makedocs>")  # ..including Documenter.HTML(…) construction call
makedocs(
    source = srcmod,
    # modules = [PkgGraph],
    # ↪ To get a warning if there are any docstrings not mentioned in the markdown.
    sitename = "PkgGraph.jl",
    # ↪ Displayed in page title and navbar.
    doctest = true,
    format = Documenter.HTML(;
        prettyurls = true,
        # ↪ No `.html` in URL
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
            "ref/internals.md",
        ],
        "Background" => [
            # This would go in index page ("If I had one!" :p):
            # > Background: Explanation of choices and tradeoffs,
            # > discussion of alternatives, and other PkgGraph-related
            # > trivia.
            "bg/usage-tips.md",
            "bg/related-work.md",
            "bg/graphviz.md",
            "bg/graphsjl.md",
            "bg/abbrevs.md",
        ],
        "devguide.md",
    ],
)
println("</makedocs>")

include("scripts/insert_readme_in_docs.jl")

# From `process_src`
correct_edit_links(verbose=false)

devurl = "dev"
on_github = (get(ENV, "GITHUB_ACTIONS", "") == "true")
if on_github
    deploydocs(;
        repo = "github.com/$repo",
        devbranch = "main",
        # ↪ What 'dev' in the version dropdown points to.
        devurl,
        # ↪ The text of that 'dev' in the version dropdown (and in url)
        versions = ["v#.#", "stable" => "v^", devurl => devurl],
        # ↪ (This is the default).
    )
end

Δt = round(time() - t₀, digits=1)
println("docs/make.jl completed ($Δt seconds)")
