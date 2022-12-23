
println("Inserting repo ReadMe as docs Home page")

parentdir = dirname
readme = relpath(joinpath(parentdir(parentdir(@__DIR__)), "ReadMe.md"))

include("preprocess_readme.jl")
md = make_links_absolute(read(readme, String))

@showtime using CommonMark
@showtime parser = Parser()
@showtime ast = parser(md)
@showtime readme_html = CommonMark.html(ast)

homepage = relpath(joinpath(parentdir(@__DIR__), "build", "index.html"))
homepage_html = read(homepage, String)

article(fill) = """
<article class="content" id="documenter-page">$fill</article>"""

println("  Writing rendered [$readme] into [$homepage]")
new = replace(homepage_html, Regex(article(".*"), "s") => article(readme_html))
# ↪ `s` flag: allow `.*` to continue matching over newlines.

write(homepage, new)

println("done")
