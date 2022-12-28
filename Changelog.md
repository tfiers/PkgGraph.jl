
# Changelog

This document summarizes the changes that were introduced in each new version of _PkgGraphs.jl_.

> With thanks to [Keep a Changelog](https://keepachangelog.com) for the format and inspiration.

The version numbers roughly follow [SemVer](https://semver.org/):
- <details>

  The version format is `major.minor.patch`,\
  with the latter two '`0`' if not specified.

  For versions ≥ 1.0, we try to guarantee the following:
    - `major` version increases are breaking
      - i.e. they can make existing code error;
    - `minor` version increases are not
      - i.e. they are backwards compatible.
    - `patch` versions are for e.g. bugfixes.
  
  <br>

  Before `v1` (so at `v0.x`), minor versions may be breaking too (and mostly are).
  </details>

-------------

<br>

## Unreleased

[Diff. w/ latest release][diff-unreleased]

<!--
Possible categories:
### Added
### Changed
### Fixed
### Deprecated  (for soon-to-be removed features)
### Removed
### Security
-->

- Rename package, from `PkgGraph.jl` to `PkgGraphs.jl`
- Removed `Pkg` dependency
- Transparent background for generated images (instead of solid white)
- When no deps: a single node with "no deps" is drawn (instead of nothing)
- Settings (`rendering_website`, `style`) are now set via kwargs and not mutating globals
- Add backwards support for Julia 1.6
- ⋮\
  `{to backfill}`


[diff-unreleased]: https://github.com/tfiers/PkgGraphs.jl/compare/v0.1...HEAD

<br>


## v0.1  &nbsp;<sub>[![][v01-date-badge]][v01-release]</sub>

The first automated tests were added.\
And they found bugs:

### Fixed

- `PkgGraphs.rendering_url = …` does not work.
    - So we go the RefValue way.\
      → new `set_rendering_url(…)` end-user function.

- When requested package is not in active project:\
  Error during creation of error message.
  - [Fix](https://github.com/tfiers/PkgGraphs.jl/commit/f70e5aa#r92719993)
    (scroll up a bit).

### Misc

- Pin down minimum supported Julia version (~~1.2~~ → 1.7)
  - 1.6 would be possible, but a bit of work (see [commit message](https://github.com/tfiers/PkgGraphs.jl/commit/2e39f84))

[v01-date-badge]: https://img.shields.io/badge/Released_on-2022--12--12-blue
[v01-release]: https://github.com/tfiers/PkgGraphs.jl/releases/tag/v0.1



<br>

## Pre-history

[Repo at code-import][@import] (2022-12-09)

PkgGraphs.jl started with code imported from [tfiers/julia-sketches][sketches]
(`pkg-deps-graphs`).\
That project was started on 2022-11-06 ([commit history][pre-hist]).

[@import]:  https://github.com/tfiers/PkgGraphs.jl/tree/sketch-import
[sketches]: https://github.com/tfiers/julia-sketches
[pre-hist]: https://github.com/tfiers/julia-sketches/commits/main/pkg-deps-graph
