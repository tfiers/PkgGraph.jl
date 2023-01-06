
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

#### `jll`
Whether to include binary 'JLL' dependencies in the graph
(default: `true`)

#### `stdlib`
Whether to include packages from the standard library in the graph
(default: `true`)

#### `mode`
Either `:light` (default) or `:dark`.\
Note that locally-generated SVGs get both colour-schemes simultaneously (through a CSS
`@media` query for `prefers-color-scheme`), so this option is irrelevant for them.

#### `bg`
Background colour for the image. Default is `transparent`.\
`white` (in combination with `mode = :light`) might be a sensible value when you are
creating a PNG but do not know on what background it will be seen. (A light-mode PNG on
a dark background looks bad. Same for a dark-mode PNG on a white background).

#### `style`
Custom Graphviz styling. Default: [`default_style`](@ref).

#### `base_url`
See [`url`](@ref).
By default, the first entry in [`webapps`](@ref).
