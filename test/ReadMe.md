# Testing `PkgGraph`

## Full suite

To run all tests locally, in the project root, do:
```julia
pkg> activate .
pkg> test
```


## Selected tests

To run only a subset of the tests, run
```julia
julia> include("test/activate_standalone.jl")
```
and then, e.g,
```julia
julia> include("test/unit/all.jl")
```
The `activate_standalone.jl` script loads Revise, so you can do quick
re-tests by running `include("test/unit/all.jl")` again after you've
edited the code in `src/`.


## Doctests

Doctests are not run here, but rather when building the docs.
