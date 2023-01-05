# Developer Guide


## Releasing a new version

#### The release commit:
- In [`Project.toml`], remove the `-dev` suffix from `version`.
- Roll-over [`Changelog.md`]:
    - Add a commented-out section above the new release, for the next
      version.
    - Move the 'unreleased' badge to the commented out section. Replace with a new
      'released' badge and link, in analogy with previously released versions.
- Commit the above, and comment on this commit on GitHub
  with `@JuliaRegistrator register`. (This opens a PR in the General registry)

#### In the next commit:
- In [`Project.toml`], bump the relevant version component, and add `-dev` again.
- In [`Changelog.md`], uncomment the next version's section. ("Changes: none yet")
- If this is the first release, update the 'Installation' section of the [ReadMe].
- Optionally add a temporary warning, that the newest release is not yet available for
  install from Genereal (but will be soon). Link to the PR.

#### When the PR is merged:
- The TagBot github action will automatically run, and create a git tag
  for the commented-on commit above.
- If this is the first release, update the 'Installation' section of the [ReadMe] again.
- Also in the ReadMe, update the git tag of the latest release in `[difflink]: …`.
- Remove the temporary warning and PR link.

[`Project.toml`]: https://github.com/tfiers/PkgGraph.jl/edit/main/Project.toml
[`Changelog.md`]: https://github.com/tfiers/PkgGraph.jl/edit/main/Changelog.md
[ReadMe]: https://github.com/tfiers/PkgGraph.jl/edit/main/ReadMe.md
