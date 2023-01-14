
substitutions = [

    # Remove badges from header
    r"^(# PkgGraph\.jl).*$"m => s"\1",

    ("see the Reference section in the <sub>[![][docbadge]][docs]</sub>."
     => "see [Internals](ref/internals)."),

    #  The below is only if no registered release yet :)
    # ("\n(see [Development](#development) below)."
    #  =>"; see [Development](https://github.com/tfiers/PkgGraph.jl#development) on GitHub."),

    # Remove sections at the end
    r"## Development.*$"s => "",
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
