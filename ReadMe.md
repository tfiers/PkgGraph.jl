
# PkgGraphs.jl &nbsp;[![][docbadge]][docs] [![][chlog-img]][chlog] [![][devimg]][#development]
<!-- add `[![][latestimg]][latest]` when 0.2 is out  -->

Small tool to visualize the dependency graph of a Julia package.


[latestimg]: https://img.shields.io/github/v/release/tfiers/PkgGraphs.jl?label=Latest%20release
[latest]:    https://github.com/tfiers/PkgGraphs.jl/releases/latest

[docbadge]: https://img.shields.io/badge/📕_Documentation-blue
[docs]: https://tfiers.github.io/PkgGraphs.jl/

[chlog-img]: https://img.shields.io/badge/🕑_Changelog-gray
[chlog]: Changelog.md

[devimg]: https://img.shields.io/badge/⚒️_dev-gray


### Example

```julia
julia> using PkgGraphs

julia> PkgGraphs.open(:Unitful)
```
This will open the browser to [this url][dotlink], which renders the following image:

<!-- Generated with `PkgGraphs.create("Unitful", "docs/img/")` -->
<!-- If updating this, update the link below too (`PkgGraphs.Internals.url`) -->
<img src="docs/img/Unitful-deps.svg"
     width=680
     alt="Dependency graph of Unitful, rendered with Graphviz dot">


<br>
<details>
  
  The given package (here: [Unitful][unitful]) must be installed in the currently active project for this to work.

  Note that `PkgGraphs` does not have to be installed in the same project however:\
  you can switch projects _after_ `PkgGraphs` has been imported (using `pkg> activate …`).

  Even easier is to install `PkgGraphs` in your base environment (see [Global Install](#global-install)),
  so you don't have to switch projects at all.

</details>

To filter out binary dependencies ([JLL packages]) or packages from the Julia standard library, provide the `ignore_jlls=true` and `ignore_stdlibs=true` keyword arguments.

[JLL packages]: https://docs.binarybuilder.org/stable/jll

[unitful]: https://github.com/PainterQubits/Unitful.jl
[dotlink]: https://dreampuf.github.io/GraphvizOnline/#digraph%20%7B%0A%20%20%20%20bgcolor%20%3D%20%22transparent%22%0A%20%20%20%20node%20%5Bfontname%20%3D%20%22sans-serif%22%2C%20style%20%3D%20%22filled%22%2C%20fillcolor%20%3D%20%22white%22%5D%0A%20%20%20%20edge%20%5Barrowsize%20%3D%200.88%5D%0A%20%20%20%20Unitful%20-%3E%20ConstructionBase%0A%20%20%20%20ConstructionBase%20-%3E%20LinearAlgebra%0A%20%20%20%20LinearAlgebra%20-%3E%20Libdl%0A%20%20%20%20LinearAlgebra%20-%3E%20libblastrampoline_jll%0A%20%20%20%20libblastrampoline_jll%20-%3E%20Artifacts%0A%20%20%20%20libblastrampoline_jll%20-%3E%20Libdl%0A%20%20%20%20libblastrampoline_jll%20-%3E%20OpenBLAS_jll%0A%20%20%20%20OpenBLAS_jll%20-%3E%20Artifacts%0A%20%20%20%20OpenBLAS_jll%20-%3E%20CompilerSupportLibraries_jll%0A%20%20%20%20CompilerSupportLibraries_jll%20-%3E%20Artifacts%0A%20%20%20%20CompilerSupportLibraries_jll%20-%3E%20Libdl%0A%20%20%20%20OpenBLAS_jll%20-%3E%20Libdl%0A%20%20%20%20Unitful%20-%3E%20Dates%0A%20%20%20%20Dates%20-%3E%20Printf%0A%20%20%20%20Printf%20-%3E%20Unicode%0A%20%20%20%20Unitful%20-%3E%20LinearAlgebra%0A%20%20%20%20Unitful%20-%3E%20Random%0A%20%20%20%20Random%20-%3E%20SHA%0A%20%20%20%20Random%20-%3E%20Serialization%0A%7D%0A


### Local rendering

If you are offline and have [Graphviz `dot`](https://graphviz.org) installed on your PATH, you can use something like
```julia
julia> PkgGraphs.create(:Unitful, ".", fmt=:svg)
```
This will call `dot` to create an SVG image in the current directory (`"."`), and will open it with your default image viewer.

If only the package-name is provided, a `tempdir()` and `fmt = :png` are used.


### Customization

The code tries to be modular. So if you want something a bit different than what the
above interface offers, you might be able to compose it from various internal
functions: see the Reference section in the <sub>[![][docbadge]][docs]</sub>.



<br>

## Installation

[The PR] to add `PkgGraphs` to the general registry is not merged yet at the time of
writing. When that is done, you'll be able to
```
pkg> add PkgGraphs
```
In the meantime, you can install by specifying a URL directly
(see [Development][#development] below).

[The PR]: https://github.com/JuliaRegistries/General/pull/74747


### Global Install

You might want to install `PkgGraphs` in your base environment (e.g. `v1.8`).\
You can then use it in any project, without having to install it in that project
or having to always switch projects.

<details>

You can activate your base environment using `] activate` (i.e. activate 'nothing'),
and then `add PkgGraphs` there.

Another way to obtain a global install is to run – from within _any_ environment:
```
julia> using PkgGraphs
```
If the package is not found, Julia will offer to install it.\
Type '`o`' to choose to install it in your base environment.
</details>



<br>

## Development

## Unreleased Changes &nbsp;<sub>[![][commitsimg]][latest] [![][devdocs-img]][devdocs]</sub>

For the latest commit on `main` (aka _dev_ and _unstable_):

| CI status | <sub>[![][testsimg]][tests]</sub> | <sub>[![][docbuildimg]][docbuild]</sub> |
|-----------|-----------------------------------|-----------------------------------------|

You can install `PkgGraphs` at this latest commit using
```
pkg> add https://github.com/tfiers/PkgGraphs.jl
```
It might be a good idea to install at a fixed revision instead.
Preferably at a [commit that passed tests][testhist].
For example:
```
pkg> add https://github.com/tfiers/PkgGraphs.jl#f6e83ca
```

[testhist]: https://github.com/tfiers/PkgGraphs.jl/actions/workflows/Tests.yml

[commitsimg]:  https://img.shields.io/github/commits-since/tfiers/PkgGraphs.jl/latest
<!-- The link, 'latest', is defined above (at header. See html comment at bottom of file). -->

[devdocs-img]: https://img.shields.io/badge/📕_Documentation-dev-blue.svg
[devdocs]:     https://tfiers.github.io/PkgGraphs.jl/dev

[docbuildimg]: https://github.com/tfiers/PkgGraphs.jl/actions/workflows/Docs.yml/badge.svg
[docbuild]:    https://github.com/tfiers/PkgGraphs.jl/actions/workflows/Docs.yml

[testsimg]:    https://github.com/tfiers/PkgGraphs.jl/actions/workflows/Tests.yml/badge.svg
[tests]:       https://github.com/tfiers/PkgGraphs.jl/actions/workflows/Tests.yml


### Roadmap

No progress guaranteed, _"Software provided 'as is'"_, etc.\
Ideas for improvement are currently managed with GitHub Issues.

For next release: <sub>[![][mile-img]][milestone]</sub>

[mile-img]: https://img.shields.io/github/milestones/progress/tfiers/PkgGraphs.jl/1?label=Milestone%20issues%20closed
[milestone]: https://github.com/tfiers/PkgGraphs.jl/milestone/1


### Contributions

Well-considered PRs, Issues, and Discussions are welcome.

Everyone is expected to adhere to the standards for constructive communication
described in [this Code of Conduct][CoC].

[CoC]: https://github.com/comob-project/snn-sound-localization/blob/17279f6/Code-of-Conduct.md


### How to

Check out the code for development using
```
pkg> dev PkgGraphs
```
See the readmes [in `test/`](test/ReadMe.md) and [in `docs/`](docs/ReadMe.md) for how to locally run the tests
and build the documentation.

**Releasing a new version**

1. Roll-over the [changelog](Changelog.md): rename the existing 'Unreleased'
   section to the new version. Add a new, empty Unreleased section.
   <!-- Could be automated prolly; add a step in Register.yml -->
2. Click the _Run workflow_ button [here][regCI], and bump the relevant version
   component. This will 1) create a commit that updates the version in `Project.toml`,
   and 2) create a comment on that commit that opens a PR in the General registry.

[regCI]: https://github.com/tfiers/PkgGraphs.jl/actions/workflows/Register.yml




<!-- 
On the "Commits since [latest release]" badge.

Currently the user has to click through on the release page
(on the gh-generated link "xx commits to main since this release").

We could add a `latest` tag (or branch?).
It can be automated: https://github.com/marketplace/actions/latest-tag

But moving a tag seems annoying, see https://pakstech.com/blog/move-git-tag/,
"Pulling after a tag has been edited" (you need to delete the local tag).

So, we rely on this click-through solution,
with the (undocumented?) `/releases/latest` url.

How does shields.io do this btw? → Via an API call
(https://github.com/badges/shields/blob/7a38cfe/services/github/github-commits-since.service.js#L138)
-->
