# Documenter can't do proper (CommonMark) markdown parsing yet.
# This is a hack so I can use the more modern feature in my src/ .md's anyway.

parentdir = dirname
orig_dir = joinpath(parentdir(@__DIR__), "src")
moddir = joinpath(parentdir(@__DIR__), "src-mod")
cp(orig_dir, moddir, force = true)


# Replace "Hello [blah] more. \n\n[blah]: https://url"
# with    "Hello [blah](https://url) more."
#
# We don't do anything for "[^1]" (footnotes) atm.

# Regex for substrings like "[blah]": an opening `[`,
# then anything that's not a closing `]`, and a closing `]`.
# Capture contents in a (group).
bracketed = r"\[([^\]]*)\]"

# "Hello [blah][1] more. \n\n[1]: …"
aliased = bracketed * bracketed

linkdef = r": +(http\S*).*\n"
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

for (root, dirs, files) in walkdir(moddir)
    for filename in files
        if endswith(filename, ".md")
            f = relpath(joinpath(root, filename))
            println("Reading [$f]")
            src = read(f, String)
            mod = inline_linkdefs(src)
            write(f, mod)
        end
    end
end
