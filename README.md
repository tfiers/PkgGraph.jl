# PkgGraph.jl &nbsp; [![][docbadge]][docs]

<!-- The following part of this ReadMe will be re-used in the docs homepage (for DRY purposes) -->
<!-- for-inclusion-in-docs: -->

Tiny tool to visualize the dependency graph of a Julia package.

### Example

```julia
julia> using PkgGraph

julia> PkgGraph.open(:Unitful)
```
This will open the browser to [this url][dotlink], which renders the following image:

`{image, with sans-serif}`
<!-- also add dotlink, below  -->

<details>
  
  The given package (here: [Unitful][unitful]) must be installed in the currently active project for this to work.

  Note that `PkgGraph` does not have to be installed in the same project however:\
  you can switch projects _after_ `PkgGraph` has been imported (using `] activate`).

  Also see [Installation](#-installation) for an even easier way, without having to switch projects.

</details>

[dotlink]: …
[unitful]: https://github.com/PainterQubits/Unitful.jl


## 💻 Local rendering

If you are offline and have [Graphviz `dot`](https://graphviz.org) installed on your PATH, you can use
```julia
julia> PkgGraph.create(:Unitful, dir=".", fmt=:svg)
```
This will create an SVG image with `dot`, save it to the current directory, and open it with your default image viewer.

If the directory is not specified, a `tempdir()` is used.


## 📦 Installation

You might want to install `PkgGraph` in your base environment (e.g. `v1.8`).\
You can then use it in any project, without having to install it in that project.

One way to do this is to run – from any environment:
```
julia> using PkgGraph
```
If the package is not found, Julia will offer to install it.\
**Type '`o`' to choose** your base environment.

You can then call `using PkgGraph` from anywhere, without having to activate the base env.

<!-- /for-inclusion-in-docs -->


## ➕ More

See the [![][docbadge]][docs] for more info.

If you want to customize this package's functionality, there are some helper functions
(used by the above high-level commands) that you might find useful.

[docbadge]: https://img.shields.io/badge/📕_Documentation-blue
[docs]: https://tfiers.github.io/PkgGraph.jl/



<br>

## 👩‍💻 Development

For the latest commit on `main` (aka "dev", unstable):

[![][tests-badg]][tests-link]
[![][mkdoc-badg]][mkdoc-link]
[![][doctt-badg]][doctt-link]

<!-- must have empty line before these -->
[tests-link]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Tests.yml
[doctt-link]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Doctest.yml
[mkdoc-link]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Documentation.yml
[tests-badg]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Tests.yml/badge.svg
[doctt-badg]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Doctest.yml/badge.svg
[mkdoc-badg]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Documentation.yml/badge.svg


### Build docs locally

In the project root:
```julia
pkg> activate docs
julia> include("docs/make.jl")
```
