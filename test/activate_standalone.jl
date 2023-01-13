
"""
Activate the test/ project, _but_ with PkgGraph (and Revise)
loaded too. Useful when running a test file on its own
(and not as part of `(PkgGraph) pkg> test`).

(Note that PkgGraph can't be part of test/Project.toml,
for some Julia reason).
"""

using Pkg
using Test

testdir = @__DIR__
reporoot = dirname(testdir)

Pkg.activate(joinpath(testdir, "standalone"))
Pkg.develop(path=reporoot)

if isdefined(Main, :PkgGraph)
    @warn """
    PkgGraph is already loaded; loading Revise now will have no effect.
    Fix by restarting Julia."""
end

using Revise
using PkgGraph

Pkg.activate(testdir)
