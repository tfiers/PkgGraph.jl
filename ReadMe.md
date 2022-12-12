
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

<!-- Generated with `PkgGraph.create("Unitful", dir="docs", fmt=:png)` -->
<img src="docs/img/Unitful-deps.svg"
     width=680
     alt="Dependency graph of Unitful, rendered with Graphviz dot">


<details>
  
  The given package (here: [Unitful][unitful]) must be installed in the currently active project for this to work.

  Note that `PkgGraph` does not have to be installed in the same project however:\
  you can switch projects _after_ `PkgGraph` has been imported (using `pkg> activate …`).

  Even easier is to install `PkgGraph` in your base environment (see [Global install](#global-install)),
  so you don't have to switch projects at all.

</details>

[unitful]: https://github.com/PainterQubits/Unitful.jl
[dotlink]: https://dreampuf.github.io/GraphvizOnline/#digraph%20%7B%0A%20%20%20%20node%20%5Bfontname%20%3D%20%22sans-serif%22%5D%0A%20%20%20%20edge%20%5Barrowsize%20%3D%200.88%5D%0A%20%20%20%20Unitful%20-%3E%20ConstructionBase%0A%20%20%20%20ConstructionBase%20-%3E%20LinearAlgebra%0A%20%20%20%20LinearAlgebra%20-%3E%20Libdl%0A%20%20%20%20LinearAlgebra%20-%3E%20libblastrampoline_jll%0A%20%20%20%20libblastrampoline_jll%20-%3E%20Artifacts%0A%20%20%20%20libblastrampoline_jll%20-%3E%20Libdl%0A%20%20%20%20libblastrampoline_jll%20-%3E%20OpenBLAS_jll%0A%20%20%20%20OpenBLAS_jll%20-%3E%20Artifacts%0A%20%20%20%20OpenBLAS_jll%20-%3E%20CompilerSupportLibraries_jll%0A%20%20%20%20CompilerSupportLibraries_jll%20-%3E%20Artifacts%0A%20%20%20%20CompilerSupportLibraries_jll%20-%3E%20Libdl%0A%20%20%20%20OpenBLAS_jll%20-%3E%20Libdl%0A%20%20%20%20Unitful%20-%3E%20Dates%0A%20%20%20%20Dates%20-%3E%20Printf%0A%20%20%20%20Printf%20-%3E%20Unicode%0A%20%20%20%20Unitful%20-%3E%20LinearAlgebra%0A%20%20%20%20Unitful%20-%3E%20Random%0A%20%20%20%20Random%20-%3E%20SHA%0A%20%20%20%20Random%20-%3E%20Serialization%0A%7D%0A
<!-- link shortener? -->


## Local rendering

If you are offline and have [Graphviz `dot`](https://graphviz.org) installed on your PATH, you can use
```julia
julia> PkgGraph.create(:Unitful, dir=".", fmt=:svg)
```
This will create an SVG image with `dot`, save it to the current directory, and open it with your default image viewer.

If the directory is not specified, a `tempdir()` is used.


## Customization

The code tries to be modular. So if you want something a bit different from what the above interface offers, you might be able to compose it from different internal functions: see the Reference section in the <sub>[![][docbadge]][docs]</sub>.


[docbadge]: https://img.shields.io/badge/📕_Documentation-blue
[docs]: https://tfiers.github.io/PkgGraph.jl/



<br>

## 📦 Installation

`PkgGraph` is available in the General registry and can be installed with
```
pkg> add PkgGraph
```
This gives you `v0.1`, which is [kinda broken](https://github.com/tfiers/PkgGraph.jl/releases/tag/v0.1).

While waiting for `v0.2` to be released, you can install a more up-to-date version using git:
```
pkg> add https://github.com/tfiers/PkgGraph.jl
```
If you do not want a moving `main` revision in your Manifest,
you can use e.g. the following commit, to get a fixed dependency:
```
pkg> add https://github.com/tfiers/PkgGraph.jl#fe17ba2
```

### Global install

You might want to install `PkgGraph` in your base environment (e.g. `v1.8`).\
You can then use it in any project, without having to install it in that project or always having to switch projects.

<!-- One way to do this is to run – from any environment:
```
julia> using PkgGraph
```
If the package is not found, Julia will offer to install it.\
**Type '`o`' to choose** your base environment.

You can then call `using PkgGraph` from anywhere, without having to activate the base env. -->

### Versions

See [`Changelog.md`](Changelog.md) for a list of package versions, and the changes introduced in each.

<!-- ![Latest release](https://img.shields.io/github/v/release/tfiers/PkgGraph?label=Latest%20release) -->




<br>

## 👩‍💻 Development

<!-- For after first release: -->
<!-- ![Commits since latest release](https://img.shields.io/github/commits-since/tfiers/PkgGraph.jl/latest) -->

For the latest commit on `main` (aka "dev", unstable, and unreleased):

| [![][tests-CI-badge]][tests-CI] | [![docs-CI-badge][]][docs-CI] |
|---------------------------------|-------------------------------|

<!-- Must have empty line before linkdefs. -->
[docs-CI]:        https://github.com/tfiers/PkgGraph.jl/actions/workflows/Docs.yml
[tests-CI]:       https://github.com/tfiers/PkgGraph.jl/actions/workflows/Tests.yml
[docs-CI-badge]:  https://github.com/tfiers/PkgGraph.jl/actions/workflows/Docs.yml/badge.svg
[tests-CI-badge]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Tests.yml/badge.svg

See the readmes in [`test/`](test) and [`docs/`](docs) for how to locally run the tests
and build the documentation.

### Releasing a new version

1. In [`Changelog.md`](Changelog.md), rename the existing "Unreleased" section to be
   the new version's, and add a new, empty "Unreleased" section above.
   <!-- Could be automated prolly; add a step in Register.yml -->
2. Click the _Run workflow_ button [here][regCI], and bump the relevant version
   component. This will create a commit that updates the version in `Project.toml`, and
   add a comment on that commit that opens a PR in the General registry.

[regCI]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Register.yml
