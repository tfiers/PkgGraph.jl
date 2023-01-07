
verbose = false
if !isdefined(Main, :first_run)
    first_run = true
end

print("Inserting repo ReadMe as docs Home page … ")
first_run && println()

parentdir = dirname
readme = relpath(joinpath(parentdir(parentdir(@__DIR__)), "ReadMe.md"))

md_orig = read(readme, String)
md = deepcopy(md_orig)

include("preprocess_readme/make_links_absolute.jl")
md = make_links_absolute(md; verbose)

include("preprocess_readme/ad-hoc_preprocessing.jl")
md = apply_adhoc_preprocessing(md)

if first_run
    @showtime using CommonMark
    @showtime parser = Parser()
    @showtime ast = parser(md)
else
    parser = Parser()
    ast = parser(md)
end

readme_html = CommonMark.html(ast)

homepage = relpath(joinpath(parentdir(@__DIR__), "build", "index.html"))
homepage_html = read(homepage, String)

article(fill) = """
    <article class="content" id="documenter-page">$fill</article>"""

verbose && println("  Writing rendered [$readme] into [$homepage]")
new = replace(homepage_html, Regex(article(".*"), "s") => article(readme_html))
# ↪ `s` flag: allow `.*` to continue matching over newlines.

write(homepage, new)

first_run && print(" … ")
println("done")
first_run = false
