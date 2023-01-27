# Developer Guide


## Releasing a new version

#### The release commit:
See the readme in [`release/`].

[`release`]: https://github.com/tfiers/PkgGraph.jl/tree/main/release#readme

#### In the next commit:
- In [`Project.toml`], bump the relevant version component, and add `-dev` again.
- In [`Changelog.md`], uncomment the next version's section. ("Changes: none yet")
- If this is the first release, update the 'Installation' section of the [ReadMe].
- Optionally add a temporary warning, that the newest release is not yet available for
  install from Genereal (but will be soon). Link to the PR.

#### When the PR is merged:
- The TagBot github action will automatically run, and create a git tag
  for the commented-on commit above.
  - This will also trigger a DocBuild run, creating a new directory for the tagged
    version on the gh-pages branch.
- If this is the first release, update the 'Installation' section of the [ReadMe] again.
- Remove the temporary warning and PR link.

[`Project.toml`]: https://github.com/tfiers/PkgGraph.jl/edit/main/Project.toml
[`Changelog.md`]: https://github.com/tfiers/PkgGraph.jl/edit/main/Changelog.md
[ReadMe]: https://github.com/tfiers/PkgGraph.jl/edit/main/ReadMe.md
