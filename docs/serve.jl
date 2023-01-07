
using Pkg

cd(@__DIR__)

Pkg.activate("localdev")
isfile("localdev/Manifest.toml") || Pkg.instantiate()
@showtime using LiveServer
@showtime using Revise
# ↪ Docstring changes don't seem to work
#   (even if triggering rebuild by touching docs/src/, or
#    if importing Revise & PkgGraph before LiveServer).

Pkg.activate(".")
isdir("build") || Pkg.instantiate()  # Heuristic, see ReadMe
@showtime using PkgGraph
@showtime using Documenter

reporoot = dirname(@__DIR__)
cd(reporoot)

servedocs(
    # include_dirs = ["src"],  # Watch for docstring changes too
    launch_browser = true,
)
