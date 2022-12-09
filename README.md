# PkgGraph.jl &nbsp; [![](https://img.shields.io/badge/📕_Documentation-blue)][docs]

Visualize the dependency graph of a Julia package.


## Usage

<!-- This part of the ReadMe will be re-used in the docs homepage (DRY) -->
<!-- for-inclusion-in-docs: -->

```julia
julia> using PkgGraph

julia> PkgGraph.open("Unitful")
```
This will open the browser to [this url][dotlink], which renders the following image:

[dotlink & image, both with sans-serif]

The given package (here: [Unitful][unitful]) must be installed in the currently activated project for this to work.

[dotlink]: …
[unitful]: https://github.com/PainterQubits/Unitful.jl


### Local rendering

If you are offline, and you have [Graphviz `dot`](https://graphviz.org) installed and available on your PATH, you can use
```julia
julia> PkgGraph.create("Unitful")
```
This will call `dot` to visualize the dependency graph, and then open the new image with your default image viewer.

<!-- /for-inclusion-in-docs -->


See the [documentation][docs] for more info.\
There are some utility functions (used by the above high-level commands)
which you might find useful if you want to hack on this package's functionality.

[docs]: https://tfiers.github.io/PkgGraph.jl/

<br>

---

## For contributors

Does the latest commit on main ("dev", unstable) pass all tests, and do the dev docs build succesfully?

[![Build Status][CI-badge][CI-link]
[CI-badge]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/CI.yml/badge.svg?branch=main
[CI-link]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/CI.yml?query=branch%3Amain

### Build docs locally
In the project root:
```julia
pkg> activate docs
julia> include("docs/make.jl")
```
