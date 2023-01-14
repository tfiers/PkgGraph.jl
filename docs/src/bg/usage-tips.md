
# Usage tips

## Local vs 'online' rendering

(See footnote[^1] for why 'online' is in scare-quotes).


[^1]: The websites in [`PkgGraph.webapps`](@ref) use Wasm-compiled versions of Graphviz
      (see e.g. [dreampuf/GraphvizOnline], which uses [mdaines/viz.js]). I.e. in the
      end, even for the 'online' option, Graphviz _does_ run on your local computer.
      (Though, alas, you do need an active internet connection to access these
      web-apps).

The advantage of the web-apps over local rendering is that they provide a nice
interactive editor, for if you want to tweak your output.

Magnus Jacobsson's [Graphviz Visual Editor][mj] is especially good for
this, as it provides a GUI interface for adding new nodes and changing styles.
(It is also the renderer linked from the official [graphviz.org] website,
and [its repository][gh] is receiving active updates at the time of writing).

You can use Magnus's app by providing the following as keyword argument to
[`depgraph_web`](@ref):

```jldoctest; setup=:( using PkgGraph )
julia> base_url = PkgGraph.webapps[2]
"http://magjac.com/graphviz-visual-editor/?dot="

julia> # depgraph_web(:Test; base_url)
```

[mj]: http://magjac.com/graphviz-visual-editor
[gh]: https://github.com/magjac/graphviz-visual-editor
[graphviz.org]: https://graphviz.org
[mdaines/viz.js]: https://github.com/mdaines/viz.js
[dreampuf/GraphvizOnline]: https://github.com/dreampuf/GraphvizOnline



## Styling Graphviz output

The fastest way to find how to do something with the Graphviz DOT language, is probably to look at [graphviz.org/gallery][1], and find an example that does something similar to what you are looking for. Every example comes with the DOT source that produced it.

You could also take a look at the [Attributes documentation][2].

Note that it is often hard or not feasible to achieve a particular graphic effect with
Graphviz. (See the quote by one of Graphviz's authors in [Graphviz today](@ref)). The
better option, if you want a particular style, is probably to import the generated SVG
image into a design program, and then edit that manually; or even to copy and re-create
the graph from scratch.

[1]: https://graphviz.org/gallery
[2]: https://graphviz.org/doc/info/attrs.html
