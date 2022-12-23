
repo = "tfiers/PkgGraph.jl"
ref = "main"

link_patterns = [
    r"src *= *\"(\S+)\"",     # <img src="link">
    r"href *= *\"(\S+)\"",    # <a href="link">
    r"\[[^\]]+\]\((\S+)\)",   # [this](link)
    r"\[[^\]]+\]: +(\S+)",    # [this]: link
]
url = r"^https?://\S+"
is_url(s) = !isnothing(match(url, strip(s)))
is_anchor(s) = startswith(strip(s), "#")

captured_link(m::RegexMatch) = only(m.captures)

repo = strip(repo, '/')
text_base_url = "https://github.com/$repo/blob/$ref/"
nontext_base_url = "https://raw.githubusercontent.com/$repo/$ref/"

absolute(rellink) = (istext(rellink) ? text_base_url * rellink
                                     : nontext_base_url * rellink)

istext(link) = !endswith(lowercase(link), nontext)

nontext = r"\.svg|png|jpg|jpeg|gif|webp|mp4|mov|webm|zip|gz|tgz|pdf|pptx|docx|xlsx"
# From https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/attaching-files


replacement(substr, pattern) = begin
    link = captured_link(match(pattern, substr))
    if is_url(link) || is_anchor(link)
        return substr
    else
        println("  Making link [$link] absolute")
        return replace(substr, link => absolute(link))
    end
end

function make_links_absolute(src)
    for pat in link_patterns
        src = replace(src, pat => (s -> replacement(s, pat)))
    end
    return src
end
