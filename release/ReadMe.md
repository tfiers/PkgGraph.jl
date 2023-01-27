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
- Commit the above, and have you comment on this commit on GitHub with
  `@JuliaRegistrator register`. (This opens a PR in the General
  registry)
- Draft a GitHub release, and have you check and publish it
  - GitHub will make a new tag for this release.\
    This tag will trigger a special run of the Documenter CI, creating a
    new directory for the newly released version on the gh-pages branch.
- Update `Project.toml` and `Changelog.md` again, for the new dev
  version


## Requirements

- The [GitHub CLI] (`gh`) must be installed and available on your PATH,
  and `gh auth login` must have been run succesfully
- In this dir: `pkg> activate .` and `(release) pkg> instantiate`

[GitHub CLI]: https://github.com/cli/cli
