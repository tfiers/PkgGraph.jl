
println("Inserting repo ReadMe as docs Home page")

parentdir = dirname
readme = relpath(joinpath(parentdir(parentdir(@__DIR__)), "ReadMe.md"))

md_orig = read(readme, String)
md = deepcopy(md_orig)

include("preprocess_readme/make_links_absolute.jl")
md = make_links_absolute(md)

include("preprocess_readme/ad-hoc_preprocessing.jl")
md = apply_adhoc_preprocessing(md)

@showtime using CommonMark
@showtime parser = Parser()
@showtime ast = parser(md)

readme_html = CommonMark.html(ast)

homepage = relpath(joinpath(parentdir(@__DIR__), "build", "index.html"))
homepage_html = read(homepage, String)

article(fill) = """
<article class="content" id="documenter-page">$fill</article>"""

println("  Writing rendered [$readme] into [$homepage]")
new = replace(homepage_html, Regex(article(".*"), "s") => article(readme_html))
# ↪ `s` flag: allow `.*` to continue matching over newlines.

write(homepage, new)

println("done")
