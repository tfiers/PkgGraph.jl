
repo = "tfiers/PkgGraph.jl"
gitref = "main"

function make_links_absolute(src)
    for pat in link_patterns
        r(matched_substr) = replacement(matched_substr, pat)
        src = replace(src, pat=>r)
        # In `replace(str, pat=>r)`, the replacement `r`
        # can be a:
        #   - function `r(s)::AbstractString`
        #   - regex's `SubstitutionString`
        # ..but not yet a
        #   - function `r(s)::SubstitutionString`
        # (Maybe julia PR?)
        # We hack it now by closing over the regex pattern.
    end
    src
end

link_patterns = [
    r"src *= *\"(\S+)\"",     # <img src="link">
    r"href *= *\"(\S+)\"",    # <a href="link">
    r"\[[^\]]+\]\((\S+)\)",   # [this](link)
    r"\[[^\]]+\]: *(\S+)",    # [this]: link
]
#                ↪ \S: non-space character

captured_link(m::RegexMatch) = only(m.captures)

replacement(substr, pattern) = begin
    link = captured_link(match(pattern, substr))
    if is_url(link) || is_anchor(link)
        substr
    else
        println("  Making link [$link] absolute")
        replace(substr, link => absolute(link))
    end
end

is_url(s) = !isnothing(match(r"^https?://\S+", strip(s)))

is_anchor(s) = startswith(strip(s), "#")

absolute(rellink) = (isbinary(rellink) ? binary_url(rellink)
                                       : text_url(rellink))

isbinary(link) = endswith(lowercase(link), binary_ext)
binary_ext = r"\.svg|png|jpg|jpeg|gif|webp|mp4|mov|webm|zip|gz|tgz|pdf|pptx|docx|xlsx"
# From https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/attaching-files

binary_url(p) = (path=stripp(p); "https://raw.githubusercontent.com/$repo/$ref/$path")
text_url(p) = (path=stripp(p); "https://github.com/$repo/blob/$ref/$path")
stripp(s) = strip(s, '/')
repo = stripp(repo)
ref = gitref
