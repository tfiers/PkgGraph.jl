
```@meta
CurrentModule = PkgGraph
```

# End-user

```@docs
PkgGraph
PkgGraph.open
PkgGraph.create
```

## Settings

#### `jll`
Whether to include binary 'JLL' dependencies in the graph
(default: `true`)

#### `stdlib`
Whether to include packages in the standard library
(default: `true`)

#### `style`
Custom Graphviz styling. Default: [`default_style`](@ref).

#### `base_url`
See [`url`](@ref).
By default, the first entry in [`webapps`](@ref).
