
println("Inserting repo ReadMe as docs Home page")

parentdir = dirname
readme = joinpath(parentdir(parentdir(@__DIR__)), "ReadMe.md")

@showtime using CommonMark
@showtime parser = Parser()
@showtime ast = open(parser, readme)
@showtime readme_html = CommonMark.html(ast)

homepage = joinpath(parentdir(@__DIR__), "build", "index.html")

# using EzXML
# doc = readhtml(homepage)
# main = findfirst("//article", doc)
# setnodecontent!(main, h)
# write(homepage, doc)
# Doesn't write valid html (almost; but not quite).

homepage_html = read(homepage, String)

article(fill) = """
<article class="content" id="documenter-page">$fill</article>"""

new = replace(homepage_html, Regex(article(".*"), "s") => article(readme_html))
# ↪ `s` flag: allow `.*` to continue matching over newlines.

write(homepage, new)

println("done")
