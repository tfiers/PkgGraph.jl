
function apply_adhoc_preprocessing(src)

    # Remove link to docs (the badge) from header
    src = replace(src, " &nbsp; [![][docbadge]][docs]" => "")

    page_ext = on_github ? "" : ".html"
    src = replace(src,
        ("see the Reference section in the <sub>[![][docbadge]][docs]</sub>."
         => "see [`PkgGraph.Internals`](ref/internal$page_ext).")
    )

    gh = "https://github.com/tfiers/PkgGraph.jl#unreleased-changes--"
    src = replace(src,
        ("\n(see [Unreleased Changes](#unreleased-changes--) below)."
        =>"; see [Unreleased Changes]($gh) on GitHub.")
    )

    # Remove sections at the end
    src = replace(src, r"### Versions.*$"s => "")
    # ↪ `s` flag to have `.` match newlines too
end
