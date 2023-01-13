
```@meta
CurrentModule = PkgGraph
```

# End-user

```@docs
PkgGraph
```

## Online
```@docs
PkgGraph.open
```

## Local
```@docs
PkgGraph.create
```

## Settings

These are keyword arguments that can be used with [`PkgGraph.open`](@ref) and
[`PkgGraph.create`](@ref).\
(They are also fields to [`PkgGraph.Options`](@ref)).

#### `jll`
Whether to include binary 'JLL' dependencies in the graph
(default: `true`)

#### `stdlib`
Whether to include packages from the standard library in the graph
(default: `true`)

#### `mode`
Either `:light` (default) or `:dark`.\
Whether to use black lines and black text on a white background, or vice versa.\
Note that locally-generated SVGs get both colour-schemes simultaneously (through [`SVG.add_darkmode`](@ref)), so this option is irrelevant for them.

#### `bg`
Background colour for the image.\
Default is `"transparent"`.\
`"white"` (in combination with `mode = :light`) might be a sensible value when you are
creating a PNG but do not know on what background it will be seen. (A light-mode PNG with transparent background looks bad on a dark background).

#### `style`
Custom Graphviz styling. See [`default_style`](@ref).

#### `base_url`
See [`url`](@ref).
By default, the first entry in [`webapps`](@ref).
