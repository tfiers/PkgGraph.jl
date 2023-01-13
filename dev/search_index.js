var documenterSearchIndex = {"docs":
[{"location":"bg/abbrevs/#Abbreviations","page":"Abbreviations","title":"Abbreviations","text":"","category":"section"},{"location":"bg/abbrevs/#DAG","page":"Abbreviations","title":"DAG","text":"","category":"section"},{"location":"bg/abbrevs/","page":"Abbreviations","title":"Abbreviations","text":"Directed acyclic graph","category":"page"},{"location":"bg/abbrevs/","page":"Abbreviations","title":"Abbreviations","text":"Package dependencies are a DAG.","category":"page"},{"location":"bg/abbrevs/#DOT","page":"Abbreviations","title":"DOT","text":"","category":"section"},{"location":"bg/abbrevs/","page":"Abbreviations","title":"Abbreviations","text":"The DAG layout algorithm of Graphviz.","category":"page"},{"location":"bg/abbrevs/","page":"Abbreviations","title":"Abbreviations","text":"Originally stands for 'Dag-of-Tomorrow' and Dot (as in Dorothy) {source}.","category":"page"},{"location":"bg/abbrevs/","page":"Abbreviations","title":"Abbreviations","text":"Now used as a noun. Variably encountered as dot, DOT, and Dot.","category":"page"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"CurrentModule = PkgGraph","category":"page"},{"location":"ref/end-user/#End-user","page":"End-user","title":"End-user","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"PkgGraph","category":"page"},{"location":"ref/end-user/#PkgGraph.PkgGraph","page":"End-user","title":"PkgGraph.PkgGraph","text":"Visualize the dependency graph of a Julia package.\n\nUse PkgGraph.open to view the graph in the browser, or PkgGraph.create to generate an image locally.\n\n(Note that these functions are not exported).\n\n\n\n\n\n","category":"module"},{"location":"ref/end-user/#Online","page":"End-user","title":"Online","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"PkgGraph.open","category":"page"},{"location":"ref/end-user/#PkgGraph.open","page":"End-user","title":"PkgGraph.open","text":"open(pkgname; kw...)\n\nOpen the browser to an image of pkgname's dependency graph.\n\nSee Settings for possible keyword arguments.\n\n\n\n\n\n","category":"function"},{"location":"ref/end-user/#Local","page":"End-user","title":"Local","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"PkgGraph.create","category":"page"},{"location":"ref/end-user/#PkgGraph.create","page":"End-user","title":"PkgGraph.create","text":"create(pkgname, dir = tempdir(); fmt = :png, open = true, kw...)\n\nRender the dependency graph of the given package as an image in dir, and open it with your default image viewer. Uses the external program 'dot' (see graphviz.org), which must be available on PATH.\n\nfmt is an output file format supported by dot, such as :svg or :png.\nIf fmt is :svg, the generated SVG file is post-processed, to add light and dark-mode CSS.\n\nTo only create the image, without automatically opening it, pass open = false.\n\nSee Settings for more keyword arguments.\n\n\n\n\n\n","category":"function"},{"location":"ref/end-user/#Settings","page":"End-user","title":"Settings","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"These are keyword arguments that can be used with PkgGraph.open and PkgGraph.create.\n(They are also fields to PkgGraph.Options).","category":"page"},{"location":"ref/end-user/#jll","page":"End-user","title":"jll","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"Whether to include binary 'JLL' dependencies in the graph (default: true)","category":"page"},{"location":"ref/end-user/#stdlib","page":"End-user","title":"stdlib","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"Whether to include packages from the standard library in the graph (default: true)","category":"page"},{"location":"ref/end-user/#mode","page":"End-user","title":"mode","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"Either :light (default) or :dark.\nWhether to use black lines and black text on a white background, or vice versa.\nNote that locally-generated SVGs get both colour-schemes simultaneously (through SVG.add_darkmode), so this option is irrelevant for them.","category":"page"},{"location":"ref/end-user/#bg","page":"End-user","title":"bg","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"Background colour for the image.\nDefault is \"transparent\".\n\"white\" (in combination with mode = :light) might be a sensible value when you are creating a PNG but do not know on what background it will be seen. (A light-mode PNG with transparent background looks bad on a dark background).","category":"page"},{"location":"ref/end-user/#style","page":"End-user","title":"style","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"Custom Graphviz styling. See default_style.","category":"page"},{"location":"ref/end-user/#base_url","page":"End-user","title":"base_url","text":"","category":"section"},{"location":"ref/end-user/","page":"End-user","title":"End-user","text":"See url. By default, the first entry in webapps.","category":"page"},{"location":"devguide/#Developer-Guide","page":"Developer Guide","title":"Developer Guide","text":"","category":"section"},{"location":"devguide/#Releasing-a-new-version","page":"Developer Guide","title":"Releasing a new version","text":"","category":"section"},{"location":"devguide/#The-release-commit:","page":"Developer Guide","title":"The release commit:","text":"","category":"section"},{"location":"devguide/","page":"Developer Guide","title":"Developer Guide","text":"In Project.toml, remove the -dev suffix from version.\nRoll-over Changelog.md:\nAdd a commented-out section above the new release, for the next version.\nMove the 'unreleased' badge to the commented out section. Replace with a new 'released' badge and link, in analogy with previously released versions.\nCommit the above, and comment on this commit on GitHub with @JuliaRegistrator register. (This opens a PR in the General registry)","category":"page"},{"location":"devguide/#In-the-next-commit:","page":"Developer Guide","title":"In the next commit:","text":"","category":"section"},{"location":"devguide/","page":"Developer Guide","title":"Developer Guide","text":"In [Project.toml], bump the relevant version component, and add -dev again.\nIn [Changelog.md], uncomment the next version's section. (\"Changes: none yet\")\nIf this is the first release, update the 'Installation' section of the ReadMe.\nOptionally add a temporary warning, that the newest release is not yet available for install from Genereal (but will be soon). Link to the PR.","category":"page"},{"location":"devguide/#When-the-PR-is-merged:","page":"Developer Guide","title":"When the PR is merged:","text":"","category":"section"},{"location":"devguide/","page":"Developer Guide","title":"Developer Guide","text":"The TagBot github action will automatically run, and create a git tag for the commented-on commit above.\nThis will also trigger a DocBuild run, creating a new directory for the tagged version on the gh-pages branch.\nIf this is the first release, update the 'Installation' section of the [ReadMe] again.\nAlso in the ReadMe, update the git tag of the latest release in [difflink]: ….\nRemove the temporary warning and PR link.","category":"page"},{"location":"bg/graphviz/#Graphviz-and-DAG-visualization","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"","category":"section"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"PkgGraph.jl is a glue package: it gathers the package dependency graph, and converts it to a text format that can be read by a DAG visualization program, which then does the real work.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"We choose to use Graphviz's dot as DAG visualizer (i.e. to create the actual images). dot is probably the most well known program for visualizing dependency graphs.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"This page discusses Graphviz, and some possible alternatives.","category":"page"},{"location":"bg/graphviz/#Alternatives-to-Graphviz","page":"Graphviz & DAG visualization","title":"Alternatives to Graphviz","text":"","category":"section"},{"location":"bg/graphviz/#Mermaid","page":"Graphviz & DAG visualization","title":"Mermaid","text":"","category":"section"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"'Mermaid diagrams' are something more newfangled than Graphviz. Mermaid uses the Dagre.js library for graph layout.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"Dagre.js is in part based on dot. From their wiki:","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"The general skeleton for Dagre comes from Gansner, et al., \"A Technique for Drawing Directed Graphs\",  which gives both an excellent high level overview of the phases involved in layered drawing as well as diving into the details and problems of each of the phases. Besides the basic skeleton, we specifically used the technique described in the paper to produce an acyclic graph,  and we use the network simplex algorithm for ranking.  If there is one paper to start with when learning about layered graph drawing, this is it!","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"(See also mentions of the Gansner paper in Dagre's codebase).","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"Mermaid has prettier default styling than Graphviz.\nBut, I find that dot does a bit better at graph layout than Mermaid / Dagre.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"By choosing Graphviz over Mermaid, we trade-off some styling and style-ability¹  for better default DAG layouts.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"¹ The default Graphviz style is not awesome, and many effects are infeasible to achieve.   (See also the critical note in Styling Graphviz output earlier).","category":"page"},{"location":"bg/graphviz/#Julia-packages-for-DAG-layout","page":"Graphviz & DAG visualization","title":"Julia packages for DAG layout","text":"","category":"section"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"For graph layout and visualization there are NetworkLayout.jl (which outputs coordinates) and GraphPlot.jl (which outputs images). Neither work well with long-ish text labels, nor do they have any specific layout algorithms for DAGs.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"(See also, The dot algorithm in Julia?)","category":"page"},{"location":"bg/graphviz/#Graphviz-today","page":"Graphviz & DAG visualization","title":"Graphviz today","text":"","category":"section"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"My impressions from browsing through the Graphviz Discourse forum and their GitLab:","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"Two of the original creators (Emden R. Gansner and Stephen C. North) are still engaged with the project (though they are not writing much code anymore)\nThere are new maintainers, actively making edits to the codebase at the time of writing.\nThe codebase – though working fantastically still in 2022 – seems a bit unwieldy to add new features to. See the following quote.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"From a 2020 Hacker News comment by one of the creators (edited):","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"We're reluctant to be exposed to too much anger about misfeatures in 20 year old code that was basically a prototype that escaped from the lab, [..]We've gotten a lot of help lately from Magnus Jacobsson, Matthew Fernandez and Mark Hansen on cleaning up the website and the code base, even some persistent bugs we could never find ourselves.Improvements that would benefit the community the most?better default styles that don't look like troff from 1985\nmore expressive graph language with classes or templates\nbetter documentation to help people find useful tools or just know what they should be looking for\nit would be a big effort, but move the core algorithms to a framework that supports interaction with layout generation","category":"page"},{"location":"bg/graphviz/#The-dot-algorithm-in-Julia?","page":"Graphviz & DAG visualization","title":"The dot algorithm in Julia?","text":"","category":"section"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"A fun project would be to translate the four-step DAG layout algorithm, described very well in the original paper, to Julia.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"The code would probably be shorter, and maybe more maintainable, than the current C implementation.","category":"page"},{"location":"bg/graphviz/#Gansner1993","page":"Graphviz & DAG visualization","title":"The original paper on dot's algorithm","text":"","category":"section"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"E. R. Gansner, E. Koutsofios, S. C. North and K.-P. Vo, \"A technique for drawing directed graphs,\" IEEE Transactions on Software Engineering, Mar. 1993. doi: 10.1109/32.221135","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"An open version of this paper is available via the official Graphviz website:","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"graphviz.org/documentation/TSE93.pdf","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"That version is alas not typeset as nicely as the IEEE-version.\nFor those without institutional access, please see the following ","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"copy of the IEEE-typeset version","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"For more publications on Graphviz, see graphviz.org/theory.","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"For more on Graphviz, see","category":"page"},{"location":"bg/graphviz/","page":"Graphviz & DAG visualization","title":"Graphviz & DAG visualization","text":"The official website,\nThis curated list of Graphviz-related resources: 'Awesome GraphViz'","category":"page"},{"location":"bg/usage-tips/#Usage-tips","page":"Usage tips","title":"Usage tips","text":"","category":"section"},{"location":"bg/usage-tips/#Local-vs-'online'-rendering","page":"Usage tips","title":"Local vs 'online' rendering","text":"","category":"section"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"(See footnote[1] for why 'online' is in scare-quotes).","category":"page"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"[1]: The websites in PkgGraph.webapps use Wasm-compiled versions of Graphviz   (see e.g. dreampuf/GraphvizOnline, which uses mdaines/viz.js). I.e. in the   end, even for the 'online' option, Graphviz does run on your local computer.   (Though, alas, you do need an active internet connection to access these   web-apps).","category":"page"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"The advantage of the web-apps over local rendering is that they provide a nice interactive editor, for if you want to tweak your output.","category":"page"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"Magnus Jacobsson's Graphviz Visual Editor is especially good for this, as it provides a GUI interface for adding new nodes and changing styles. (It is also the renderer linked from the official graphviz.org website, and its repository is receiving active updates at the time of writing).","category":"page"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"You can use Magnus's app by providing the following as keyword argument to PkgGraph.open:","category":"page"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"julia> base_url = PkgGraph.webapps[2]\n\"http://magjac.com/graphviz-visual-editor/?dot=\"\n\njulia> # PkgGraph.open(:Test; base_url)","category":"page"},{"location":"bg/usage-tips/#Styling-Graphviz-output","page":"Usage tips","title":"Styling Graphviz output","text":"","category":"section"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"The fastest way to find how to do something with the Graphviz DOT language, is probably to look at graphviz.org/gallery, and find an example that does something similar to what you are looking for. Every example comes with the DOT source that produced it.","category":"page"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"You could also take a look at the Attributes documentation.","category":"page"},{"location":"bg/usage-tips/","page":"Usage tips","title":"Usage tips","text":"Note that it is often hard or not feasible to achieve a particular graphic effect with Graphviz. (See the quote by one of Graphviz's authors in Graphviz today). The better option, if you want a particular style, is probably to import the generated SVG image into a design program, and then edit that manually; or even to copy and re-create the graph from scratch.","category":"page"},{"location":"bg/related-work/#Related-work","page":"Related work","title":"Related work","text":"","category":"section"},{"location":"bg/related-work/#Julia-packages","page":"Related work","title":"Julia packages","text":"","category":"section"},{"location":"bg/related-work/#[PkgDependency.jl](https://github.com/peng1999/PkgDependency.jl)","page":"Related work","title":"PkgDependency.jl","text":"","category":"section"},{"location":"bg/related-work/","page":"Related work","title":"Related work","text":"Nice and actively maintained package that does a very similar thing to PkgGraph, and has no non-Julia dependencies. Prints package dependencies as a tree in the REPL. Because package dependencies are a DAG and not a tree, there are repeated names in the printout (those are marked with a (*)).","category":"page"},{"location":"bg/related-work/#[PkgDeps.jl](https://github.com/JuliaEcosystem/PkgDeps.jl)","page":"Related work","title":"PkgDeps.jl","text":"","category":"section"},{"location":"bg/related-work/","page":"Related work","title":"Related work","text":"Provides a very useful users(pkg) function, to see downstream dependents of a package (instead of upstream like here). Also has dependencies(pkg) and direct_dependencies(pkg) functions.","category":"page"},{"location":"bg/related-work/#[Graphviz.jl](https://github.com/JuliaGraphs/GraphViz.jl)","page":"Related work","title":"Graphviz.jl","text":"","category":"section"},{"location":"bg/related-work/","page":"Related work","title":"Related work","text":"Bundles the graphviz binaries (including dot) (via JuliaBinaryWrappers/Graphviz_jll), and provides access in Julia to graphviz's C API. Provides the @dot_str macro to render dot strings in a notebook.","category":"page"},{"location":"bg/related-work/#[GraphvizDotLang.jl](https://github.com/jhidding/GraphvizDotLang.jl)","page":"Related work","title":"GraphvizDotLang.jl","text":"","category":"section"},{"location":"bg/related-work/","page":"Related work","title":"Related work","text":"Recent package, under active development at the time of writing. A beautiful package to generate and render dot-strings. Uses Julia's piping syntax. Had I discovered this package before writing PkgGraph, I might have used it as a dependency. (Replacing things like PkgGraph.to_dot_str).","category":"page"},{"location":"bg/related-work/#Júlio-Hoffimann's-work","page":"Related work","title":"Júlio Hoffimann's work","text":"","category":"section"},{"location":"bg/related-work/","page":"Related work","title":"Related work","text":"There is a notebook in JuliaGraphsTutorials, by Júlio Hoffimann, that analyzes the complete graph of Julia package dependencies: {nbviewer link}.","category":"page"},{"location":"bg/related-work/","page":"Related work","title":"Related work","text":"Note that this is older code (Julia 0.6), from back when only 1500 packages were registered (circa 2017).","category":"page"},{"location":"bg/related-work/","page":"Related work","title":"Related work","text":"Júlio also made interactive D3.js visualizations of the dependency graph, and of a world map of Julians (See the links at the top of the notebook).","category":"page"},{"location":"","page":"Home","title":"Home","text":"{this is overwritten by a version of the ReadMe in make.jl}","category":"page"},{"location":"ref/internals/","page":"Internals","title":"Internals","text":"CurrentModule = PkgGraph","category":"page"},{"location":"ref/internals/#Internals","page":"Internals","title":"Internals","text":"","category":"section"},{"location":"ref/internals/#Creating-a-dependency-graph","page":"Internals","title":"Creating a dependency graph","text":"","category":"section"},{"location":"ref/internals/","page":"Internals","title":"Internals","text":"depgraph\nis_jll\nis_in_stdlib","category":"page"},{"location":"ref/internals/#PkgGraph.DepGraph.depgraph","page":"Internals","title":"PkgGraph.DepGraph.depgraph","text":"depgraph(pkgname; jll = true, stdlib = true)\n\nBuild a directed graph of the dependencies of the given package, using the active project's Manifest file.\n\nThe returned deps object is a flat list of \"PkgA\" => \"PkgB\" dependency pairs.\n\nBinary JLL dependencies and packages in the standard library can be filtered out from the result by setting jll and stdlib to false.\n\nExample:\n\njulia> using PkgGraph\n\njulia> PkgGraph.depgraph(:Test)\n8-element Vector{Pair{String, String}}:\n             \"Test\" => \"InteractiveUtils\"\n \"InteractiveUtils\" => \"Markdown\"\n         \"Markdown\" => \"Base64\"\n             \"Test\" => \"Logging\"\n             \"Test\" => \"Random\"\n           \"Random\" => \"SHA\"\n           \"Random\" => \"Serialization\"\n             \"Test\" => \"Serialization\"\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#PkgGraph.DepGraph.is_jll","page":"Internals","title":"PkgGraph.DepGraph.is_jll","text":"is_jll(pkg)::Bool\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#PkgGraph.DepGraph.is_in_stdlib","page":"Internals","title":"PkgGraph.DepGraph.is_in_stdlib","text":"is_in_stdlib(pkg)::Bool\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#DOT-strings","page":"Internals","title":"DOT strings","text":"","category":"section"},{"location":"ref/internals/","page":"Internals","title":"Internals","text":"to_dot_str\ndefault_style","category":"page"},{"location":"ref/internals/#PkgGraph.DotString.to_dot_str","page":"Internals","title":"PkgGraph.DotString.to_dot_str","text":"to_dot_str(\n    edges;\n    mode     = :light,\n    bg       = \"transparent\",\n    style    = default_style(),\n    indent   = 4,\n    emptymsg = nothing,\n)\n\nBuild a string that represents the given directed graph in the Graphviz DOT format ↗.\n\nmode and bg specify the colour scheme and background colour for the graph (see Settings).\n\nstyle is a list of strings, inserted as lines in the output (after the lines generated for mode and bg, and just before the graph edge lines). To use Graphviz's default style, pass style = []. For the default see default_style. For more on how dot-graphs can be styled, see Styling Graphviz output.\n\nindent is the number of spaces to indent each line in the \"digraph\" block with.\n\nIf there are no edges, a single node with emptymsg is created. If emptymsg is nothing (default), no nodes are created, and the image rendered from the DOT-string will be empty.\n\nExample:\n\njulia> edges = [:A => :B, \"yes\" => \"no\"];\n\njulia> style = [\"node [color=\\\"red\\\"]\"];\n\njulia> using PkgGraph\n\njulia> PkgGraph.to_dot_str(edges; style, bg=:blue, indent=2) |> println\ndigraph {\n  bgcolor = \"blue\"\n  node [fillcolor=\"white\", fontcolor=\"black\", color=\"black\"]\n  edge [color=\"black\"]\n  node [color=\"red\"]\n  A -> B\n  yes -> no\n}\n\njulia> emptymsg=\"(empty graph)\";\n\njulia> PkgGraph.to_dot_str([]; emptymsg, mode=:dark, style=[]) |> println\ndigraph {\n    bgcolor = \"transparent\"\n    node [fillcolor=\"black\", fontcolor=\"white\", color=\"white\"]\n    edge [color=\"white\"]\n    onlynode [label=\" (empty graph) \", shape=\"plaintext\"]\n}\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#PkgGraph.DotString.default_style","page":"Internals","title":"PkgGraph.DotString.default_style","text":"default_style()\n\nThe default style used by to_dot_str:\n\nnode [fontname=\"sans-serif\", style=\"filled\"]\nedge [arrowsize=0.88]\n\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#Post-processing-of-SVG-files","page":"Internals","title":"Post-processing of SVG files","text":"","category":"section"},{"location":"ref/internals/","page":"Internals","title":"Internals","text":"SVG.add_darkmode","category":"page"},{"location":"ref/internals/#PkgGraph.SVG.add_darkmode","page":"Internals","title":"PkgGraph.SVG.add_darkmode","text":"add_darkmode(path, out = path)\n\nEdit an SVG file generated by Graphviz.\n\nRemove repeated styling on individual elements, and replace it by a global stylesheet, with both light and dark modes. (This is achieved through a CSS @media query for prefers-color-scheme).\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#Online-rendering","page":"Internals","title":"Online rendering","text":"","category":"section"},{"location":"ref/internals/","page":"Internals","title":"Internals","text":"url\nwebapps","category":"page"},{"location":"ref/internals/#PkgGraph.url","page":"Internals","title":"PkgGraph.url","text":"url(dotstr, base = first(webapps))\n\nCreate a URL at which the given dot-string is rendered as an image, using an online Graphviz rendering service.\n\nThe dot-string is URL-encoded, and appended to a partly complete base URL (see webapps)\n\nExample:\n\njulia> base = PkgGraph.webapps[2];\n\njulia> PkgGraph.url(\"digraph {Here->There}\", base)\n\"http://magjac.com/graphviz-visual-editor/?dot=digraph%20%7BHere-%3EThere%7D\"\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#PkgGraph.webapps","page":"Internals","title":"PkgGraph.webapps","text":"A list of websites that can render Graphviz dot-formatted strings. Used by url.\n\nNote that these are 'base URLs', to which url-encoded dot-strings can be directly appended.\n\nDefault contents:\n\nhttps://dreampuf.github.io/GraphvizOnline/#\nhttp://magjac.com/graphviz-visual-editor/?dot=\nhttps://edotor.net/?engine=dot#\n\n\n\n\n\n","category":"constant"},{"location":"ref/internals/#Settings-object","page":"Internals","title":"Settings object","text":"","category":"section"},{"location":"ref/internals/","page":"Internals","title":"Internals","text":"Options","category":"page"},{"location":"ref/internals/#PkgGraph.Options","page":"Internals","title":"PkgGraph.Options","text":"Options(; kw...)\n\nConvenience object to gather all settings (kwargs) of different functions in one place.\n\nSee Settings for available properties.\n\n\n\n\n\n","category":"type"},{"location":"ref/internals/#Graphs.jl-conversion","page":"Internals","title":"Graphs.jl conversion","text":"","category":"section"},{"location":"ref/internals/","page":"Internals","title":"Internals","text":"as_graphsjl_input\nvertices\nnode_index\nadjacency_matrix","category":"page"},{"location":"ref/internals/#PkgGraph.DepGraph.as_graphsjl_input","page":"Internals","title":"PkgGraph.DepGraph.as_graphsjl_input","text":"as_graphsjl_input(edges)\n\nObtain the outputs of, respectively\n\nvertices(edges)\nnode_index(edges)\nadjacency_matrix(edges)\n\n..but without unnecessary repeat computation.\n\nUseful when converting the output of depgraph to a Graphs.jl graph;\nSee the example script in Working with Graphs.jl.\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#PkgGraph.DepGraph.vertices","page":"Internals","title":"PkgGraph.DepGraph.vertices","text":"vertices(edges)\n\nExtract the unique nodes from the given list of edges.\n\nExample:\n\njulia> using PkgGraph\n\njulia> edges = PkgGraph.depgraph(:Test);\n\njulia> PkgGraph.vertices(edges)\n8-element Vector{String}:\n \"Test\"\n \"InteractiveUtils\"\n \"Markdown\"\n \"Random\"\n \"Base64\"\n \"Logging\"\n \"SHA\"\n \"Serialization\"\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#PkgGraph.DepGraph.node_index","page":"Internals","title":"PkgGraph.DepGraph.node_index","text":"node_index(edges)\nnode_index(vertices)\n\nCreate a function that returns the index of a given vertex.\n\nThis is useful because Graphs.jl requires vertices to be integers.\n\nExample:\n\njulia> using PkgGraph\n\njulia> edges = [\"A\"=>\"B\", \"B\"=>\"C\"];\n\njulia> node = PkgGraph.node_index(edges);\n\njulia> node(\"C\")\n3\n\n\n\n\n\n","category":"function"},{"location":"ref/internals/#PkgGraph.DepGraph.adjacency_matrix","page":"Internals","title":"PkgGraph.DepGraph.adjacency_matrix","text":"adjacency_matrix(edges)\n\nA square bitmatrix A that is 0 everywhere except at A[i,j] when there is a connection from the node with index i to the node with index j.\n\n\n\n\n\n","category":"function"},{"location":"bg/graphsjl/#Working-with-Graphs.jl","page":"Working with Graphs.jl","title":"Working with Graphs.jl","text":"","category":"section"},{"location":"bg/graphsjl/","page":"Working with Graphs.jl","title":"Working with Graphs.jl","text":"PkgGraph does not depend on any of the packages from JuliaGraphs.","category":"page"},{"location":"bg/graphsjl/","page":"Working with Graphs.jl","title":"Working with Graphs.jl","text":"However, you can easily convert the list of package dependencies to a type that supports the Graphs.jl interface. You are then able to use the ecosystem's powerful set of graph analysis tools. See PkgGraph.as_graphsjl_input.","category":"page"},{"location":"bg/graphsjl/#Example","page":"Working with Graphs.jl","title":"Example","text":"","category":"section"},{"location":"bg/graphsjl/","page":"Working with Graphs.jl","title":"Working with Graphs.jl","text":"For an example of using Graphs.jl functions on a package dependency DAG, see test/graphsjl_interop.jl, where we analyze the dependency graph of Tests:","category":"page"},{"location":"bg/graphsjl/","page":"Working with Graphs.jl","title":"Working with Graphs.jl","text":"<img width=400\n     src=\"https://raw.githubusercontent.com/tfiers/PkgGraph.jl/main/docs/img/Test-deps.svg\">","category":"page"},{"location":"bg/graphsjl/","page":"Working with Graphs.jl","title":"Working with Graphs.jl","text":"This is a summary of that file:","category":"page"},{"location":"bg/graphsjl/","page":"Working with Graphs.jl","title":"Working with Graphs.jl","text":"using Graphs\n\nedges = PkgGraph.depgraph(\"Test\")\n\npackages = PkgGraph.vertices(edges)\nnode     = PkgGraph.node_index(edges)\nA        = PkgGraph.adjacency_matrix(edges)\n\n# Or, more efficiently:\npackages, node, A = PkgGraph.as_graphsjl_input(edges)\n\ng = DiGraph(A)\n\n@test outdegree(g, node(\"Test\")) == 4\n@test indegree(g, node(\"Test\")) == 0\n\nds = dijkstra_shortest_paths(g, node(\"Test\"))\n# ..plus some wrangling & formatting, and we get:\n\"\"\"\nDistance from Test to …\n              Test: 0\n  InteractiveUtils: 1\n          Markdown: 2\n            Random: 1\n            Base64: 3\n           Logging: 1\n               SHA: 2\n     Serialization: 1\n\"\"\"","category":"page"}]
}
