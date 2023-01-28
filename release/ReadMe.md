# Release script

To release a new version of PkgGraph.jl, run
```
julia release.jl
```
..and follow the steps shown.

This script will:
- In `Project.toml`, remove the `-dev` suffix from `version`
- Roll-over `Changelog.md` (replace the 'unreleased' badge with a
  released one)
- Commit and push the above, and have you comment on this commit on
  GitHub with `@JuliaRegistrator register`. (This opens a PR in the
  General registry)
- Draft a GitHub release, and have you check and publish it
  - GitHub will add a git tag on the release commit.\
    This tag will trigger a special run of the Documenter CI, which
    creates a new directory on the gh-pages branch for the newly
    released version.
- Update `Project.toml` and `Changelog.md` again, for the new dev
  version:
  - Prompt for the new dev version
  - Add it to `Project.toml`, with a `-dev` suffix
  - Add a new 'unreleased' section to the Changelog
  - Commit and push the above


## Requirements

- The [GitHub CLI] (`gh`) must be installed and available on your PATH,
  and `gh auth login` must have been run succesfully
- In this dir: `pkg> activate .` and `(release) pkg> instantiate`

[GitHub CLI]: https://github.com/cli/cli
