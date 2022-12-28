
# Graphviz & DAG visualization

PkgGraph.jl is a glue package: it gathers the package dependency graph, and converts it
to a text format that can be read by a [DAG](@ref) visualization program, which then
does the real work.

We choose to use [Graphviz] `dot` as DAG visualizer (i.e. to create the actual images).
`dot` is probably the most well known program for visualizing dependency graphs.

This page discusses Graphviz, and some possible alternatives.

[Graphviz]: https://graphviz.org



## Alternatives to Graphviz

### Mermaid

'[Mermaid diagrams]' are something more newfangled.

Mermaid uses the [Dagre.js] library for graph layout.
Dagre.js is in part based on `dot`. From their [wiki]:
> The general skeleton for Dagre comes from
> [Gansner, et al., "A Technique for Drawing Directed Graphs"](@ref Gansner1993), 
> which gives both an excellent high level overview of the phases
> involved in layered drawing as well as diving into the details and problems
> of each of the phases. Besides the basic skeleton, we specifically used
> the technique described in the paper to produce an acyclic graph, 
> and we use the network simplex algorithm for ranking. 
> If there is one paper to start with when learning about layered graph drawing,
> this is it!
(See also [mentions of the paper in Dagre's codebase][mentions]).

Mermaid has prettier default styling than Graphviz.\
But, I find that `dot` does a bit better at graph layout than Mermaid / Dagre.

By choosing Graphviz over Mermaid, we trade-off some styling and style-ability¹ 
for better default DAG layouts.

¹ The default Graphviz style is not awesome, and many effects are infeasible to achieve.
  (See also the critical note in [Styling Graphviz output](@ref) earlier).

[Mermaid diagrams]: https://mermaid-js.github.io/mermaid
[Dagre.js]:         https://github.com/dagrejs/dagre
[wiki]:             https://github.com/dagrejs/dagre/wiki#recommended-reading
[mentions]:         https://github.com/search?q=repo:dagrejs/dagre%20gansner&type=code


### Julia packages for DAG layout

For graph layout and visualization there are [NetworkLayout.jl] (outputs coordinates)
and [GraphPlot.jl] (outputs images).
Neither work well with long-ish text labels, nor do they have any specific layout algorithms for DAGs.

(See also, [The `dot` algorithm in Julia?](@ref))

[NetworkLayout.jl]: https://github.com/JuliaGraphs/NetworkLayout.jl
[GraphPlot.jl]: https://github.com/JuliaGraphs/GraphPlot.jl




## Graphviz today

My impressions from browsing through the [Graphviz Discourse forum] and [their GitLab]:
- Two of the original creators (Emden R. Gansner and Stephen C. North)
  are still engaged with the project (though they are not writing much code anymore)
- There are new maintainers, actively making edits to the codebase at the time of writing.
- The codebase – though working fantastically still in 2022 –
  seems a bit unwieldy to add new features to. See the following quote.

From a [2020 Hacker News comment] by one of Graphviz's creators (edited):
> We're reluctant to be exposed to too much anger about misfeatures in 20 year old code
> that was basically a prototype that escaped from the lab, [..]
>
> We've gotten a lot of help lately from Magnus Jacobsson, Matthew Fernandez and Mark
> Hansen on cleaning up the website and the code base, even some persistent bugs we
> could never find ourselves.
> 
> Improvements that would benefit the community the most?
> - better default styles that don't look like troff from 1985
> - more expressive graph language with classes or templates
> - better documentation to help people find useful tools or just know what they should be looking for
> - it would be a big effort, but move the core algorithms to a framework that supports interaction with layout generation

[Graphviz Discourse forum]: https://forum.graphviz.org/top?period=all
[their GitLab]:             https://gitlab.com/graphviz/graphviz
[2020 Hacker News comment]: https://news.ycombinator.com/item?id=23475225




## The `dot` algorithm in Julia?

A fun project would be to translate the four-step DAG layout algorithm,
described very well in [the original paper](@ref Gansner1993), to Julia.

The code would probably be shorter, and maybe more maintainable,
than [the current C implementation][1].

[1]: https://gitlab.com/graphviz/graphviz/-/tree/main/lib
<!-- most salient is the 'common/' src dir; contains e.g network simplex code -->




## [The original paper on dot's algorithm](@id Gansner1993)
<!-- Can't have `code format` (here: `dot`) when naming headers like this. boo. -->
<!-- (todo, file this bug in Documenter.jl) -->

> E. R. Gansner, E. Koutsofios, S. C. North and K.-P. Vo,
> "**A technique for drawing directed graphs**,"
> IEEE Transactions on Software Engineering, Mar. 1993.
> [doi: 10.1109/32.221135](https://doi.org/10.1109/32.221135)

An open version of this paper is available via the official Graphviz website:
- [graphviz.org/documentation/TSE93.pdf](https://graphviz.org/documentation/TSE93.pdf)

That version is alas not typeset as nicely as the IEEE-version.\
For those without institutional access, please see the following 
- [copy of the IEEE-typeset version](https://tomasfiers.net/content/Gansner1993IEEE.pdf)

For more publications on Graphviz, see [graphviz.org/theory](https://graphviz.org/theory).

---

For more on Graphviz, see
- The official [website](https://graphviz.org),
- This curated list of Graphviz-related resources: ['Awesome GraphViz'][1]

[1]: https://github.com/CodeFreezr/awesome-graphviz#readme
