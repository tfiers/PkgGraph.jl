# Documentation build

To build the documentation locally, run, in the project root:
```julia
julia> include("docs/make.jl")
```
The first time this is run, it will open the browser to the generated docs.\
(You can also manually open the generated `docs/build/index.html`).

## Revise

For faster rebuilds when editing docstrings, start a fresh Julia session,
and, before running the above, do:
```julia
julia> using Revise
```

## On project instantiation

The build script (`docs/make.jl`) will automatically instantiate the `docs` environment (i.e. will install the packages in `docs/Manifest.toml`), if it detects that the `docs/build/` dir is not present.

If this heuristic is incorrect, or if `docs/Manifest.toml` has changed since the last `instantiate`, run
```
(docs) pkg> instantiate
```
manually, before running the build script.
