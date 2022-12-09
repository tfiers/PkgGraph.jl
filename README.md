# PkgGraph.jl &nbsp; [![](https://img.shields.io/badge/📕_Documentation-blue)][docs]

Visualize the dependency graph of a Julia package.


## Usage

```julia
julia> using PkgGraph

julia> PkgGraph.open("Unitful")
```
If  the given package (here: [Unitful][uful]) is installed in the active project, this will open the browser [to here][dotlink], which renders the following image:

[uful]: https://github.com/PainterQubits/Unitful.jl
[dotlink]: …

[dotlink & image, with sans-serif]


If you are offline, and you have [Graphviz `dot`](graphviz.org) installed and available on your PATH, you can use
```julia
julia> PkgGraph.create("Unitful")
```
This will call `dot` to visualize the dependency graph, and then open the new image with your default image viewer.

See the [documentation][docs] for more info.\
There are some lower level functions that might be useful if you want to hack on this package's functionality.

[docs]: https://tfiers.github.io/PkgGraph.jl/

<br>

---

## For contributors

Does the latest commit on main ("dev", unstable) pass all tests, and do the dev docs build succesfully?

[![Build Status][CI-badge]]([CI-link])

[CI-badge]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/CI.yml/badge.svg?branch=main
[CI-link]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/CI.yml?query=branch%3Amain

### Build docs locally
```julia
pkg> activate docs
julia> include("docs/make.jl")
```
