# Testing `PkgGraphs`

To run tests locally, in the project root, do:
```julia
pkg> activate .
pkg> test
```

Doctests are not run here, but rather when building the docs.

For quick re-tests:
```julia
julia> using Revise

julia> include("test/main.jl")  # e.g.
```
