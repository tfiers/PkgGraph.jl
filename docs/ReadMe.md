# Building the docs

To build the documentation locally, run, in the project root:
```julia
julia> include("docs/make.jl")
```
The first time this is run, it will open the browser to the generated docs.\
(You can also manually open the generated `docs/build/index.html`).

For faster rebuilds when editing docstrings, [Revise] is loaded by `make.jl`.

[Revise]: https://timholy.github.io/Revise.jl


## Updating static images

To update
1. The images in `img/` (used in the docs and in the main readme), and
2. The long example URL in `../ReadMe.md`,

run:
```
julia docs/scripts/update_imgs_and_url.jl
```

This is not (yet) run automatically (in docs/make.jl),
as that would require a `dot` installation on GH Actions.
(re https://github.com/tfiers/PkgGraph.jl/issues/52)


## On project instantiation

The build script (`make.jl`) will automatically instantiate the `docs` environment (i.e. will install the packages in `docs/Manifest.toml`), if it detects that the `docs/build/` dir is not present.

If the build dir is already present, it will not `instantiate`, so as to speed up docs building time.

If that heuristic is incorrect, or if `docs/Manifest.toml` has changed since the last `instantiate`, run
```
(docs) pkg> instantiate
```
manually, before running the build script.

## Documenter.jl

We use an unreleased version of Documenter, to get the newest features (see its [changelog]). (Most importantly, we want the link to the gh repo in the header, so you don't have to go through an "Edit" page every time).

We added the latest commit (which passed CI), on 2023-01-05:

    (docs) pkg> add https://github.com/JuliaDocs/Documenter.jl#dd1e334

(Diff of this commit w/ latest release: https://github.com/JuliaDocs/Documenter.jl/compare/v0.27.23...dd1e334)

[changelog]: https://github.com/JuliaDocs/Documenter.jl/blob/master/CHANGELOG.md
