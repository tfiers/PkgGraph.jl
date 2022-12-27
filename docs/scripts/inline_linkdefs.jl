# Documenter can't do proper (CommonMark) markdown parsing yet.
# This is a hack so I can use the more modern feature in my src/ .md's anyway.

# Replace "Hello [blah].       \n\n[blah]: https://url"
#     (or "Hello [text][blah]. \n\n[blah]: https://url")
# with    "Hello [blah](https://url)."

orig = "src"
mod = "src-mod"

parentdir = dirname
docdir = parentdir(@__DIR__)
orig_dir = joinpath(docdir, orig)
moddir = joinpath(docdir, mod)
cp(orig_dir, moddir, force = true)


# Regex for substrings like "[blah]": an opening `[`,
# then anything that's not a closing `]`, and a closing `]`.
# Capture contents in a (group).
bracketed = r"\[([^\]]+)\]"

# "Hello [blah][1] more. \n\n[1]: …"
doublebracket = bracketed * bracketed

linkdef = r": +(http\S+).*\n"
# ↪ `\S`: _not_ a whitespace char
#   Note that this ignores footnotes (eg "[^1]: This is footnote text").

# "[blah]:   http://…   <!-- comment -->  \n"
linkdefline = bracketed * linkdef

singlebracket = bracketed * Regex("(?!$(linkdef.pattern))")
# Negative lookahead (See eg https://stackoverflow.com/a/406408/2611913)
# (A note: in the final regex the `:` does not mean 'non-capturing';
#  but is rather literally the ": " in linkdef strings).

first_couple(md) = begin
    linkdefs = collect(eachmatch(linkdefline, md))
    doublebraks = collect(eachmatch(doublebracket, md))
    singlebraks = collect(eachmatch(singlebracket, md))
    f(m) = !is_in_code_block(md, m)
    filter!(f, doublebraks)
    filter!(f, singlebraks)
    while !isempty(linkdefs)
        ld = popfirst!(linkdefs)
        linkdef_label = ld.captures[1]
        for db in doublebraks
            label = db.captures[2]
            (label == linkdef_label) && return (db, ld)
        end
        for sb in singlebraks
            label = sb.captures[1]
            (label == linkdef_label) && return (sb, ld)
        end
    end
    return nothing
end

is_in_code_block(md, m::RegexMatch) =
    any(m.offset in r for r in code_block_ranges(md))

code_block_ranges(md) = findall(r"```.*?```"s, md)
# - The `?` is to match as few characters as possible
#   ("non-greedy"). I.e. to stop at the first next ```.
# - `s` flag to have `.` match newlines too.

function inline_linkdef(md, couple)
    textbrak, linkd = couple
    text = textbrak.captures[1]
    url = linkd.captures[2]
    println("  Inlining linkdef of [$text]")
    replace_matches(
        md,
        textbrak => "[$text]($url)",
        linkd => "",
    )
end

replace_matches(
    s,
    old_new::Pair{RegexMatch, <:AbstractString}...
) =
    replace_ranges(s, (range_(old)=>new for (old,new) in old_new)...)

range_(m::RegexMatch) = start(m):end_(m)
start(m::RegexMatch) = m.offset
end_(m::RegexMatch) = m.offset + length(m.match) - 1
# ↪ Minus one: "abcd"[2:3] == "bc", of length 2. But 2→3 = +1

function replace_ranges(
    s,
    old_new::Pair{<:AbstractRange, <:AbstractString}...
)
    ranges = collect(first.(old_new))
    substitutions = last.(old_new)
    check_overlap(ranges)
    sort!(ranges)
    parts = []
    i = firstindex(s)
    for (r, subst) in zip(ranges, substitutions)
        before = prevind(s, r.start)
        after = nextind(s, r.stop)
        push!(parts, SubString(s, i:before))
        push!(parts, subst)
        i = after
    end
    push!(parts, SubString(s, i:lastindex(s)))
    join(parts)
end

function check_overlap(ranges)
    @assert allunique(ranges)
    for r1 in ranges, r2 in ranges
        r1 == r2 && continue
        if length(intersect(r1, r2)) > 0
            @error "Ranges $r1 and $r2 overlap"
        end
    end
end

function inline_linkdefs(md)
    while true
        couple = first_couple(md)
        if isnothing(couple)
            return md
        else
            md = inline_linkdef(md, couple)
        end
    end
end

for (root, _, files) in walkdir(moddir)
    for filename in files
        if filename |> endswith(".md")
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
        if filename |> endswith(".html")
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




# --comments--


# What happens when:
# [Text][1]
# [1]: link
# and later in the same file:
# [Blah][1]
# [1]: otherlink
# I.e. reuse of the same label.
# Well the first couple will get replaced first.
# So this'll work.
# What will _not_ work is multiple references to the same link.
# i.e.
# [Text][1] and another [reff][1].
# [1]: …
# The first will get replaced, and then the second
# won't have a match anymore.


# I should rewrite this whole thing:
# gather all `[single brackets]`, `[double][bracktes]`
# and `[linkdefs]: …` first.
# And only then start replacing.
