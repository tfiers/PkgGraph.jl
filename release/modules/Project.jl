
module Project

include("Common.jl")
using .Common

const file = "Project.toml"

current_version() = extract_version(readtext()).current_version

readtext() = read(file, String)

extract_version(project_text) = begin
    m = match(version_line_pattern, project_text)
    (;
        matched_line = m.match,
        current_version = m.captures[1],
    )
end

# Matches a line like `version = "…"`, but w/ arbitrary whitespace.
const version_line_pattern = r"^\s*version\s*=\s*\"(.*)\"\s*$"m

function update_version(new_version)
    println("Reading [$file]")
    project_text = readtext()
    (; matched_line, current_version) = extract_version(project_text)
    println("Current version: ", blue(current_version))
    println("New version:     ", blue(new_version))
    if current_version == new_version
        println("These version are the same.")
        println("We won't edit $file")
    else
        confirm_or_quit("Update $file?")
        new_line = replace(matched_line, current_version=>new_version)
        new_text = replace(project_text, matched_line=>new_line)
        write(file, new_text)
        println("Updated [$file] to $new_version")
    end
end

end
