
# PkgGraph.jl &nbsp;[![][latestimg]][latest] [![][docbadge]][docs] [![][chlog-img]][chlog] [![][devimg]](#development)

Visualize the dependency graph of a Julia package


[latestimg]: https://img.shields.io/github/v/release/tfiers/PkgGraph.jl?label=Latest%20release
[latest]:    https://github.com/tfiers/PkgGraph.jl/releases/latest

[docbadge]: https://img.shields.io/badge/📕_Documentation-blue
[docs]: https://tfiers.github.io/PkgGraph.jl/

[chlog-img]: https://img.shields.io/badge/🕑_Changelog-gray
[chlog]: Changelog.md

[devimg]: https://img.shields.io/badge/⚒️_Development-gray


### Example

```julia
using PkgGraph
```
```julia
depgraph_web(:Unitful)
```
This will open the browser to [this url][dotlink], which renders something like the following:

<!-- See docs/script/update_imgs_and_url.jl -->
<img src="docs/img/Unitful-deps.svg"
     width=680
     alt="Dependency graph of Unitful, rendered with Graphviz dot">

<br>

Packages in the Julia standard library are by default faded-out.
To remove them entirely from the graph, set the keyword argument
`stdlib = false`.

Similarly, you can filter out binary dependencies ([JLL packages])
by setting `jll = false`.

[JLL packages]: https://docs.binarybuilder.org/stable/jll

[unitful]: https://github.com/PainterQubits/Unitful.jl
[dotlink]: https://dreampuf.github.io/GraphvizOnline/#digraph%20%7B%0A%20%20%20%20bgcolor%20%3D%20%22transparent%22%0A%20%20%20%20node%20%5Bfillcolor%3D%22white%22%2C%20fontcolor%3D%22black%22%2C%20color%3D%22black%22%5D%0A%20%20%20%20edge%20%5Bcolor%3D%22black%22%5D%0A%20%20%20%20node%20%5Bfontname%3D%22sans-serif%22%2C%20style%3D%22filled%22%5D%0A%20%20%20%20edge%20%5Barrowsize%3D0.88%5D%0A%20%20%20%20Unitful%20-%3E%20ConstructionBase%0A%20%20%20%20ConstructionBase%20-%3E%20LinearAlgebra%20%5Bcolor%3Dgray%5D%0A%20%20%20%20LinearAlgebra%20-%3E%20Libdl%20%5Bcolor%3Dgray%5D%0A%20%20%20%20LinearAlgebra%20-%3E%20libblastrampoline_jll%20%5Bcolor%3Dgray%5D%0A%20%20%20%20libblastrampoline_jll%20-%3E%20Artifacts%20%5Bcolor%3Dgray%5D%0A%20%20%20%20libblastrampoline_jll%20-%3E%20Libdl%20%5Bcolor%3Dgray%5D%0A%20%20%20%20libblastrampoline_jll%20-%3E%20OpenBLAS_jll%20%5Bcolor%3Dgray%5D%0A%20%20%20%20OpenBLAS_jll%20-%3E%20Artifacts%20%5Bcolor%3Dgray%5D%0A%20%20%20%20OpenBLAS_jll%20-%3E%20CompilerSupportLibraries_jll%20%5Bcolor%3Dgray%5D%0A%20%20%20%20CompilerSupportLibraries_jll%20-%3E%20Artifacts%20%5Bcolor%3Dgray%5D%0A%20%20%20%20CompilerSupportLibraries_jll%20-%3E%20Libdl%20%5Bcolor%3Dgray%5D%0A%20%20%20%20OpenBLAS_jll%20-%3E%20Libdl%20%5Bcolor%3Dgray%5D%0A%20%20%20%20Unitful%20-%3E%20Dates%20%5Bcolor%3Dgray%5D%0A%20%20%20%20Dates%20-%3E%20Printf%20%5Bcolor%3Dgray%5D%0A%20%20%20%20Printf%20-%3E%20Unicode%20%5Bcolor%3Dgray%5D%0A%20%20%20%20Unitful%20-%3E%20LinearAlgebra%20%5Bcolor%3Dgray%5D%0A%20%20%20%20Unitful%20-%3E%20Random%20%5Bcolor%3Dgray%5D%0A%20%20%20%20Random%20-%3E%20SHA%20%5Bcolor%3Dgray%5D%0A%20%20%20%20Random%20-%3E%20Serialization%20%5Bcolor%3Dgray%5D%0A%20%20%20%20LinearAlgebra%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20libblastrampoline_jll%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20OpenBLAS_jll%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20CompilerSupportLibraries_jll%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20Dates%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20Printf%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20Random%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20Libdl%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20Artifacts%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20Unicode%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20SHA%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%20%20%20%20Serialization%20%5Bcolor%3Dgray%20fontcolor%3Dgray%5D%0A%7D%0A


### Local rendering

If you are offline and have [Graphviz `dot`](https://graphviz.org) installed on your PATH, you can use something like
```julia
depgraph_image(:Unitful, dir=".", fmt=:svg)
```
This will call `dot` to create an SVG image in the current directory (`"."`), and will open it with your default image viewer.

If only the package-name is provided, `dir = tempdir()` and `fmt = :png` are used.


### Customization

The code tries to be modular. So if you want something a bit different than what the
above interface offers, you might be able to compose it from various internal
functions: see the Reference section in the <sub>[![][docbadge]][docs]</sub>.


### Limitations

- See [**Known limitations & Bugs**][limbugs] in the issue tracker
- Also see [Roadmap]

[limbugs]: https://github.com/tfiers/PkgGraph.jl/issues?q=is%3Aissue+sort%3Aupdated-desc+label%3A%22known+limitation%22%2Cbug+is%3Aopen
[Roadmap]: https://github.com/tfiers/PkgGraph.jl#roadmap--



<br>

## Installation

PkgGraph is available in the Julia general registry and can be installed [as usual] with
```
pkg> add PkgGraph
```
[as usual]: https://pkgdocs.julialang.org/v1/getting-started

### Global Install

You might want to install `PkgGraph` in your base environment (e.g. `v1.8`).\
You can then use it in any project, without having to install it in that project
or having to switch projects.

<details>

You can activate your base environment using `] activate` (i.e. activate 'nothing'),
and then `add PkgGraph` there.

Another way to obtain a global install is to run – from within _any_ environment:
```
julia> using PkgGraph
```
If the package is not found, Julia will offer to install it.\
Type '`o`' to choose to install it in your base environment.
</details>



<br>

## Development

([back to top](#start-of-content))

### Unreleased Changes &nbsp;<sub>[![][commitsimg]][difflink] [![][devdocs-img]][devdocs]</sub>

For the latest commit on `main` (aka _dev_ and _unstable_):

| CI status | <sub>[![][testsimg]][tests]</sub> | <sub>[![][docbuildimg]][docbuild]</sub> |
|-----------|-----------------------------------|-----------------------------------------|

You can install `PkgGraph` at this latest commit using
```
pkg> add https://github.com/tfiers/PkgGraph.jl
```
It might be a good idea to install at a fixed revision instead.
Preferably at one that [passed tests][testhist].
For example:
```
pkg> add https://github.com/tfiers/PkgGraph.jl#50bc308 
```

[testhist]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Tests.yml

[commitsimg]:  https://img.shields.io/github/commits-since/tfiers/PkgGraph.jl/latest
[difflink]:    https://github.com/tfiers/PkgGraph.jl/releases/latest

[devdocs-img]: https://img.shields.io/badge/📕_Documentation-dev-blue.svg
[devdocs]:     https://tfiers.github.io/PkgGraph.jl/dev

[docbuildimg]: https://github.com/tfiers/PkgGraph.jl/actions/workflows/Docs.yml/badge.svg
[docbuild]:    https://github.com/tfiers/PkgGraph.jl/actions/workflows/Docs.yml

[testsimg]:    https://github.com/tfiers/PkgGraph.jl/actions/workflows/Tests.yml/badge.svg
[tests]:       https://github.com/tfiers/PkgGraph.jl/actions/workflows/Tests.yml


### Roadmap &nbsp;<sub>[![][open-img]][open-url] [![][close-img]][close-url]</sub>

Ideas for improvement are currently managed with GitHub issues.\
User-visible enhancements to [`src/`](src) are labelled with <sub>[![][feat-img]][feat-url]</sub>.

For `v1`: <sub>[![][mile-img]][milestone]</sub>

No progress guaranteed, _Software provided 'as is'_, etc.

[open-img]: https://img.shields.io/github/issues-raw/tfiers/PkgGraph.jl?label=issues%20open&color=blue
[close-img]: https://img.shields.io/github/issues-closed-raw/tfiers/PkgGraph.jl?label=closed&color=blue
[open-url]: https://github.com/tfiers/PkgGraph.jl/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc
[close-url]: https://github.com/tfiers/PkgGraph.jl/issues?q=is%3Aissue+is%3Aclosed+sort%3Aupdated-desc
[mile-img]: https://img.shields.io/github/milestones/progress/tfiers/PkgGraph.jl/1?label=Milestone%20issues%20closed
[milestone]: https://github.com/tfiers/PkgGraph.jl/milestone/1
[feat-img]: https://img.shields.io/badge/-feature-%23215B25
[feat-url]: https://github.com/tfiers/PkgGraph.jl/issues?q=is%3Aissue+sort%3Aupdated-desc+label%3Afeature+


### Contributions

Well-considered PRs, Issues, and Discussions are welcome.

Participants are expected to adhere to the standards for constructive communication
as e.g. described in [this Code of Conduct][CoC].

[CoC]: https://github.com/comob-project/snn-sound-localization/blob/17279f6/Code-of-Conduct.md


### How to hack on the code

Check out the code for development using
```
pkg> dev PkgGraph
```
One fun way to hack on the code is to open one of the source files
in VS Code, and execute individual lines in the [integrated Julia REPL][1],
maybe copying over some dummy input data from [`test/`].

See the readmes [in `test/`](test/ReadMe.md) and [in `docs/`](docs/ReadMe.md)
for how to locally run the tests and build the documentation.

See the [Developer Guide][2] in the documentation for more.

[1]: https://www.julia-vscode.org/docs/stable/userguide/runningcode/#The-Julia-REPL
[2]: https://tfiers.github.io/PkgGraph.jl/dev/devguide



<br>

## Alternatives

Julia packages similar to PkgGraph.jl:
- [PkgDependency.jl]
- [PkgDeps.jl]

See **[Related work]** in the documentation for more info.

[PkgDependency.jl]: https://github.com/peng1999/PkgDependency.jl
[PkgDeps.jl]: https://github.com/JuliaEcosystem/PkgDeps.jl
[Related work]: https://tfiers.github.io/PkgGraph.jl/dev/bg/related-work/
