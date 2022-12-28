
if on_github
    page_ext = ""
else
    page_ext = ".html"
end

substitutions = [

    # Remove link to docs (the badge) from header
    " &nbsp; [![][docbadge]][docs]" => "",

    ("see the Reference section in the <sub>[![][docbadge]][docs]</sub>."
     => "see [`PkgGraphs.Internals`](ref/internal$page_ext)."),

    ("\n(see [Unreleased Changes](#unreleased-changes--) below)."
     =>"; see [Unreleased Changes](https://github.com/tfiers/PkgGraphs.jl#unreleased-changes--) on GitHub."),

    # Remove sections at the end
    r"### Versions.*$"s => "",
    # ↪ `s` flag to have `.` match newlines too
]

function apply_adhoc_preprocessing(src)
    for (old, new) in substitutions
        # Error detection -- for when the readme src is inadvertently
        # changed later.
        is_present(old, src) || @warn """
            Pattern to substitute not found in ReadMe!
            Pattern: $(repr(old))
            """
        src = replace(src, old=>new)
    end
    return src
end

is_present(pattern::AbstractString, s) = (findfirst(pattern, s) ≠ nothing)
is_present(pattern::Regex, s)          = (match(pattern, s)     ≠ nothing)
