# Building the docs

To build the documentation locally, run
```bash
$ julia docs/serve.jl
```
The first time this is run in a fresh repo clone, this will install the necessary
packages.

Then, it will load [Revise] (to watch for docstring changes),
[LiveServer], and PkgGraph. Next, it will:

1. Run `docs/make.jl`
    - This takes a while the first time
2. Start a local web server, using LiveServer's `serve` to show the
   results (which will be in `docs/build/`)
    - Each page is also injected with a script that makes the page auto-reload if the
      underlying file changes.
        - This seems to not always work: sometimes a manual page reload
          is necessary.
    - The home page is automatically opened in the browser.
3. Watch `src/` and `docs/src/` for any changes, and if so, re-run `make.jl`

This is the same as what LiveServer's [`servedocs`] does; however in my
testing it failed to update on doc-string changes; so we do it
ourselves.

In principle you can quit with `Ctrl-C`; but this doesn't seem to work
well, so you'll have to kill the terminal 🤷

[Revise]: https://timholy.github.io/Revise.jl
[LiveServer]: https://github.com/tlienart/LiveServer.jl
[`servedocs`]: https://tlienart.github.io/LiveServer.jl/stable/man/functionalities/#servedocs


## Updating static images

To update
1. The images in `img/` (used in the docs and in the main readme); and
2. the long example URL in `../ReadMe.md`,

run:
```
julia docs/scripts/update_imgs_and_url.jl
```

This is not yet run automatically (i.e. in `make.jl`),
as that would require a `dot` installation on GH Actions.
(re https://github.com/tfiers/PkgGraph.jl/issues/52)


## Project instantiation

`serve.jl` will automatically instantiate the `docs` environment (i.e. it will install
the packages in `docs/Manifest.toml`), if it detects that the `docs/build/` dir is not
present. (This is a heuristic to detect a fresh repo clone).

If the build dir is already present, it will not `instantiate`, to save time.

If the build-dir heuristic is not correct, or if `docs/Manifest.toml` has changed since
the last `instantiate`, run
```
(docs) pkg> instantiate
```
manually, before running `serve.jl`.


## Documenter version

We use an unreleased version of Documenter, to get the newest features (see its [changelog]). (Most importantly, we want the link to the gh repo in the header, so you don't have to go through an "Edit" page every time).

We added the latest commit (which passed CI), on 2023-01-05:

    (docs) pkg> add https://github.com/JuliaDocs/Documenter.jl#dd1e334

(Diff of this commit w/ latest release: https://github.com/JuliaDocs/Documenter.jl/compare/v0.27.23...dd1e334)

[changelog]: https://github.com/JuliaDocs/Documenter.jl/blob/master/CHANGELOG.md
