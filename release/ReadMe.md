# Release script

To release a new version of PkgGraph.jl, run
```
julia release.jl
```
..and follow the steps shown.

This script will:
- In `Project.toml`, remove the `-dev` suffix from `version`
- Roll-over `Changelog.md`:
    - Add a commented-out section above the new release, for the next
      version
    - Move the 'unreleased' badge to the commented out section. Replace
      with a new 'released' badge and link
- Commit the above, and have you comment on this commit on GitHub with
  `@JuliaRegistrator register`. (This opens a PR in the General
  registry)
- Draft a GitHub release

## Requirements

- The [GitHub CLI] (`gh`) must be installed and available on your path,
  and you've run `gh auth login`
- `]activate release` and `]instantiate`

[GitHub CLI]: https://github.com/cli/cli
