# Documenter can't do proper (CommonMark) markdown parsing yet.
# This is a hack so I can use the more modern feature in my src/ .md's anyway.

orig = "src"
mod = "src-mod"

parentdir = dirname
docdir = parentdir(@__DIR__)
orig_dir = joinpath(docdir, orig)
moddir = joinpath(docdir, mod)
cp(orig_dir, moddir, force = true)


# Replace "Hello [blah] more. \n\n[blah]: https://url"
# with    "Hello [blah](https://url) more."
#
# We don't do anything for "[^1]" (footnotes) atm.

# Regex for substrings like "[blah]": an opening `[`,
# then anything that's not a closing `]`, and a closing `]`.
# Capture contents in a (group).
bracketed = r"\[([^\]]+)\]"

# "Hello [blah][1] more. \n\n[1]: …"
aliased = bracketed * bracketed

linkdef = r": +(http\S+).*\n"
# ↪ `\S`: _not_ a whitespace char
#   Note that this ignores footnotes (eg "[^1]: This is footnote text").

# "[blah]:   http://…   <!-- comment -->  \n"
linkdefline = bracketed * linkdef

textbracket = bracketed * Regex("(?!$(linkdef.pattern))")
# Negative lookahead (See eg https://stackoverflow.com/a/406408/2611913)
# (A note: in the final regex the `:` does not mean 'non-capturing';
#  but is rather literally the ": " in linkdef strings).

first_long_distance_relationship(md) = begin
    linkdefs = collect(eachmatch(linkdefline, md))
    textbraks = collect(eachmatch(textbracket, md))
    while !isempty(linkdefs)
        l = popfirst!(linkdefs)
        for tb in textbraks
            if tb.captures[1] == l.captures[1]
                return (tb, l)
            end
        end
    end
    return nothing
end

function inline_linkdef(md, linked_pair)
    textbrak, linkd = linked_pair
    tb = textbrak.captures[1]
    url = linkd.captures[2]
    println("  Inlining linkdef of [$tb]")
    md = replace(md, textbrak.match => "[$tb]($url)"; count = 1)
    md = replace(md, linkd.match => ""; count = 1)
end

function inline_linkdefs(md)
    while true
        p = first_long_distance_relationship(md)
        if isnothing(p)
            return md
        else
            md = inline_linkdef(md, p)
        end
    end
end

for (root, _, files) in walkdir(moddir)
    for filename in files
        if endswith(filename, ".md")
            f = relpath(joinpath(root, filename))
            println("Reading [$f]")
            src = read(f, String)
            srcmod = inline_linkdefs(src)
            write(f, srcmod)
        end
    end
end

# After `makedocs` has ran, the 'Edit on GitHub' links
# point to `src-mod`. So we need to change that back to `src`.
function correct_edit_links()
    for (root, _, files) in walkdir(builddir), filename in files
        if endswith(filename, ".html")
            f = relpath(joinpath(root, filename))
            println("Correcting edit link in [$f]")
            html = read(f, String)
            corrected = correct_edit_link(html)
            write(f, corrected)
        end
    end
end
builddir = joinpath(docdir, "build")

correct_edit_link(html) = replace(html, editlink => substit)

editlink = Regex("(href *= *\"https://github.com/$repo/blob/$ref/docs)/$mod/")
substit = SubstitutionString("\1/$orig/")
