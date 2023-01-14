
using Pkg

cd(@__DIR__)

Pkg.activate("localdev")

isfile("localdev/Manifest.toml") || Pkg.instantiate()

@showtime using Revise

Pkg.activate(".")

isdir("build") || Pkg.instantiate()  # Heuristic, see ReadMe

@showtime using PkgGraph
@showtime using Documenter

# `servedocs` (with `cd(reporoot)` and `include_dirs = ["src"]`) does
# not seem to track doc string changes, alas. So we do it ourselves.

include("make.jl")

@info "Starting LiveServer in subprocess"
code = "using LiveServer; serve(dir=\"build\", launch_browser=true)"
cmd = `julia --project=localdev -e $code`
server_process = run(cmd, wait = false)

@info "Watching for changes to PkgGraph and [docs/src/]"
entr(["src"], [PkgGraph], postpone = true) do
    include("make.jl")
end
# entr blocks, until Ctrl-C

@info "Killing server process …"
kill(server_process)
@info "Done. Goodbye"
