
using Pkg
Pkg.activate(@__DIR__)

using Base: prompt
using Pkg
using Dates
using Crayons
using DefaultApplication
using Downloads
using JSON

ghrepo = "tfiers/PkgGraph.jl"
dryrun = false

dryrun && @info "Dry run"
println()

blue = Crayon(foreground=:blue)

reporoot = dirname(@__DIR__)
cd(reporoot)
println("Working directory: ", blue(pwd()))
println()

function confirm_or_quit(question)
    answer = prompt(question * " [Y/n]")
    lowercase(answer) in ["", "y"] || (println("Goodbye"); exit())
end

repo = GitRepo(".")
if isdirty(repo)
    println("There are uncommitted changes")
    # println("Please commit first, then run this script again")
    # exit()
    println()
end

include("projecttoml.jl")
include("changelog.jl")
include("commit.jl")
include("gh_release_draft.jl")

println("Done")
