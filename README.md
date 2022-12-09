# PkgGraph.jl &nbsp; [![](https://img.shields.io/badge/📕_Documentation-blue)][docs]

<!-- The following part of this ReadMe will be re-used in the docs homepage (for DRY purposes) -->
<!-- for-inclusion-in-docs: -->

Visualize the dependency graph of a Julia package.

## Example

```julia
julia> using PkgGraph

julia> PkgGraph.open("Unitful")
```
This will open the browser to [this url][dotlink], which renders the following image:

`{image, with sans-serif}`
<!-- also add dotlink, below  -->

The given package (here: [Unitful][unitful]) must be installed in the currently activated project for this to work.[^1]

[^1]: Note that `PkgGraph` does not have to be installed in the same project as the one whose packages
you want to visualize: you can switch projects (using `] activate`)
_after_ `PkgGraph` has been imported. Also see [Installation](#installation).

[dotlink]: …
[unitful]: https://github.com/PainterQubits/Unitful.jl


## Local rendering

If you are offline, and you have [Graphviz `dot`](https://graphviz.org) installed and available on your PATH, you can use
```julia
julia> PkgGraph.create("Unitful")
```
This will call `dot` to visualize the dependency graph, and then open the created image with your default image viewer.


## Installation

It might be useful to have `PkgGraph` installed in your base environment (e.g. `v1.8`).
You can then use it in any project, without having to install it in that project.

One way to do this is to type
```
julia> using PkgGraph
```
It will warn that the package is not found, and offer to install it.
**Type `o`** and choose your base environment (e.g. `v1.8`).

You can then call `using PkgGraph` from anywhere, without having to activate the base environment.

<!-- /for-inclusion-in-docs -->


## More

See the [documentation][docs] for more.

There are some utility functions (used by the above high-level commands)
which you might find useful if you want to hack on this package's functionality.

[docs]: https://tfiers.github.io/PkgGraph.jl/


<br>

---

## For contributors

Does the latest commit on main ("dev", unstable) pass all tests, and do the dev docs build succesfully?

[![Build Status][CI-badge]][CI-link]

<!-- must have empty line before these -->
[CI-badge]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/CI.yml/badge.svg?branch=main
[CI-link]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/CI.yml?query=branch%3Amain


### Build docs locally
In the project root:
```julia
pkg> activate docs
julia> include("docs/make.jl")
```
