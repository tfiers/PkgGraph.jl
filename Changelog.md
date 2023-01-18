
# Changelog

A summary of the changes introduced in each new version of `PkgGraph`.

<details><summary>
The version numbers roughly follow <a href="https://semver.org">SemVer</a>
<sub>(expand for details)</sub>
</summary>

  The version format is `major.minor.patch`,\
  with the latter two '`0`' if not specified.

  For versions ≥ `v1`, we try to guarantee that `minor` version increases 
  are not breaking, i.e. that they are backwards compatible.
  
  Before `v1` (so at `v0.x`), minor versions may be (and mostly are) breaking.
  
  `major` version increases are breaking, i.e. they can make existing
  code error.
  
  `patch` versions are for e.g. bugfixes.
</details>

<sub>With thanks to [Keep a Changelog](https://keepachangelog.com) for the format and inspiration.</sub>

<!--
Keep a Changelog recommends these categories for organizing changes
per version: [Added, Changed, Fixed, Removed, Security,
              Deprecated (for soon-to-be removed features)]
-->

-------------


<!-- <br>

## v0.7  &nbsp;<sub>[![][unreleased-badge]][devlink]</sub>

[unreleased-badge]: https://img.shields.io/badge/Unreleased-orange
[devlink]: https://github.com/tfiers/PkgGraph.jl#development

_{no changes yet}_ -->


<br>

## v0.6  &nbsp;<sub>[![][unreleased-badge]][devlink]</sub>

[unreleased-badge]: https://img.shields.io/badge/Unreleased-orange
[devlink]: https://github.com/tfiers/PkgGraph.jl#development

- New keyword argument **`time`**, to measure import times of dependencies,
  and display them in the graph
  - Example: `depgraph_web(:MyPkg, time = true)`
  - `time` is passed on to the new internal function [`depgraph_as_dotstr`]
  - Uses the `@time_imports` macro, [introduced] in Julia 1.8
      - Hence, `time` is not supported for Julia 1.6 and 1.7
  - Makes use of the new internal function [`time_imports`], which runs
    `@time_imports using MyPkg` in a new process, and parses the output.
- New keyword argument **`faded`** (see [`depgraph_as_dotstr`] and [`to_dot_str`])
  - Packages in the standard library are now faded out, by default.\
    To get the old behaviour back, pass `faded = false` to the end-user
    functions.
- `depgraph_image`:
  - The output directory is now a keyword (**`dir`**), instead of a
    positional argument
  - New keyword argument **`post`**, to allow disabling of the SVG
    post-processing. By default, `post = true`, and the SVG is still
    post-processed like before, to add automatic dark & light mode
    switching (see [`SVG.add_darkmode`])
- A bug preventing the package from precompiling when more than one registry
  is registered has been fixed.

[introduced]: https://github.com/tfiers/PkgGraph.jl/issues/64#issuecomment-1380193445
[`depgraph_as_dotstr`]: https://tfiers.github.io/PkgGraph.jl/dev/ref/internals/#PkgGraph.depgraph_as_dotstr
[`time_imports`]:       https://tfiers.github.io/PkgGraph.jl/dev/ref/internals/#PkgGraph.LoadTime.time_imports
[`to_dot_str`]:         https://tfiers.github.io/PkgGraph.jl/dev/ref/internals/#PkgGraph.DotString.to_dot_str
[`SVG.add_darkmode`]:   https://tfiers.github.io/PkgGraph.jl/dev/ref/internals/#PkgGraph.SVG.add_darkmode
<!-- Update the '/dev/' part in the url here to '/v0.6/' on release -->


<br>

## v0.5  &nbsp;<sub>[![][v0.5-date-badge]][v0.5-release]</sub>

[v0.5-date-badge]: https://img.shields.io/badge/Released_on-2023--01--14-blue
[v0.5-release]: https://github.com/tfiers/PkgGraph.jl/releases/tag/v0.5

- Rename and export the end-user API functions:
  - `PkgGraph.open` → `depgraph_web`
  - `PkgGraph.create` → `depgraph_image`
- Keyword `mode=:dark` renamed to `dark=true` (default is still
  light-mode i.e. `dark=false`)
- `depgraph_image`: default background colour is now `:white` if 
  `fmt=:png` (which is the default format)
  - Why?\
    (1). PNG is default, because the default Windows image viewer allows
    you to pan zoom PNGs. Not so with SVGs (which open in
    Firefox, which has no image panning)\
    (2). See note on white bg and darkmode in docs>Settings>`bg`
  - Default background colour is still `:transparent` for `fmt=:svg`
- `Internals` module removed and split up into different submodules
  (`DotString`, `DepGraph`, …)
- `Options` struct removed (→ no more duplication of documentation for
  kwargs; we now refer to `depgraph` and `to_dot_str`'s docstrings
  directly).


<br>

## v0.4.1  &nbsp;<sub>[![][v0.4.1-date-badge]][v0.4.1-release]</sub>

[v0.4.1-date-badge]: https://img.shields.io/badge/Released_on-2023--01--11-blue
[v0.4.1-release]: https://github.com/tfiers/PkgGraph.jl/releases/tag/v0.4.1

- Remove support for Julia 1.6.\
  (Due to registry crawling feature in 0.4; registry API is too
  different in 1.6)


<br>

## v0.4  &nbsp;<sub>[![][v04-date-badge]][v04-release]</sub>

[v04-date-badge]: https://img.shields.io/badge/Released_on-2023--01--11-blue
[v04-release]: https://github.com/tfiers/PkgGraph.jl/releases/tag/v0.4.0

- Remove limitation "package must be installed in active project".
  Any package in the General registry (and standard library) can now be
  queried from anywhere.
  - This (re)introduced dependencies: Pkg (a big one; but stdlib), and UUIDS.
- Dark-mode option for _all_ generated images\
  <sup>(not just local SVGs; also PNGs and webapp URLs)</sup>
  - Pass the `mode=:dark` keyword argument to `open` and `create` for this.
  - There is also a new `bg` option to configure the background color
    (default is transparent. But white is sometimes a good idea; see docs).
  - Locally-generated SVGs still get both a light and a dark theme, using a CSS media
    query (`prefers-color-scheme`).

<details>
<summary><em>Infra changes</em></summary>

- Add LiveServer.jl, `docs/serve.jl`, 
  and `docs/localdev/Project.toml`, for local doc-builds
  - When editing docstrings, you might still want to use Revise and do
    `include("docs/make.jl")` manually; it seems to not work well with LiveServer.
- `docs/scripts/` in `make.jl` are less verbose now
</details>


<br>

## v0.3  &nbsp;<sub>[![][v03-date-badge]][v03-release]</sub>

[v03-date-badge]: https://img.shields.io/badge/Released_on-2023--01--05-blue
[v03-release]: https://github.com/tfiers/PkgGraph.jl/releases/tag/v0.3.0

- Add light & dark mode CSS to generated SVGs
  - This introduced a new dependency, [EzXML](https://github.com/JuliaIO/EzXML.jl)
- `PkgGraph.create`:
  - Allow passing `open=false` to only create the image, and not automatically
    open it with the default image viewer too.
  - The file format, `fmt`, is a keyword argument again (not positional)
- Shorten keyword arguments for excluding JLLs and standard library packages:
  - ~~`include_jll`~~ → `jll`
  - ~~`include_stdlib`~~ → `stdlib`
- New functions `adjacency_matrix`, `node_index`, and `as_graphsjl_input`
  (→ easier Graphs.jl interop).



<br>

## v0.2  &nbsp;<sub>[![][v02-date-badge]][v02-release]</sub>

[v02-date-badge]: https://img.shields.io/badge/Released_on-2023--01--02-blue
[v02-release]: https://github.com/tfiers/PkgGraph.jl/releases/tag/v0.2.0

- Rename the end-user API functions:
  - `depgraph` → `PkgGraph.open`
  - `depgraph_local` → `PkgGraph.create`
- Organize API, with new `PkgGraph.Internals` module
- New options `include_jll` and `include_stdlib`, to be able to filter
  binary 'JLL' dependencies and packages from the standard library. This can
  significantly declutter the graphs for packages with many such dependencies.
  Thanks @KristofferC
- Add backwards support for Julia 1.6
- Removed `Pkg` dependency
- Transparent background for generated images (instead of solid white)
- When no deps: a single node with "no deps" is drawn (instead of nothing)
- User settings (`base_url`, `style`) are now set via kwargs and not mutating globals
- _{Docs & infra}_
  - Actual example in ReadMe
  - Lots (lots) of doc writing
    - Plus custom markdown (pre)processing scripts :)
  - Add this changelog



<br>

## v0.1  &nbsp;<sub>[![][v01-date-badge]][v01-release]</sub>

[v01-date-badge]: https://img.shields.io/badge/Released_on-2022--12--12-blue
[v01-release]: https://github.com/tfiers/PkgGraph.jl/releases/tag/v0.1.0

- The first automated tests were added.\
  And they found bugs:
  - `PkgGraph.rendering_url = …` does not work.
      - So we go the RefValue way.\
        → new `set_rendering_url(…)` end-user function.
  - When requested package is not in active project:\
    Error during creation of error message.
    - [Fix](https://github.com/tfiers/PkgGraph.jl/commit/f70e5aa#r92719993)
      (scroll up a bit).
- Pin down minimum supported Julia version (~~1.2~~ → 1.7)
  - 1.6 would be possible, but a bit of work (see [commit message](https://github.com/tfiers/PkgGraph.jl/commit/2e39f84))



<br>

## Pre-history

[Repo at code-import][@import] (2022-12-09)

PkgGraph.jl started with code imported from [tfiers/julia-sketches][sketches]
(`pkg-deps-graphs`).\
That project was started on 2022-11-06 ([commit history][pre-hist]).

[@import]:  https://github.com/tfiers/PkgGraph.jl/tree/sketch-import
[sketches]: https://github.com/tfiers/julia-sketches
[pre-hist]: https://github.com/tfiers/julia-sketches/commits/main/pkg-deps-graph
