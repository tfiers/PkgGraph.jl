# Step 1: Project.toml: remove `-dev` from version
# ------------------------------------------------

projectfile = "Project.toml"
text = read(projectfile, String)
# Matches a line like `version = "…"`, but w/ arbitrary whitespace.
version_line_pattern = r"^\s*version\s*=\s*\"(.*)\"\s*$"m
m = match(version_line_pattern, text)
matched_line = m.match
current_version = m.captures[1]  # `v0.6.0-dev`, eg
version_to_release = first(split(current_version, "-"))
# ↪ Could instead do `VersionNumber(current_version)`, and use its
#   `.prerelease` field, which for the above example is `("dev",)`.
#   https://docs.julialang.org/en/v1/manual/strings/#man-version-number-literals

println("Reading [$projectfile]")
println("Current version:    ", blue(current_version))
println("Version to release: ", blue(version_to_release))
if current_version == version_to_release
    println("These version are the same. (No '-dev' suffix found)")
    println("We won't edit Project.toml")
else
    confirm_or_quit("Update Project.toml?")
    new_line = replace(matched_line, current_version=>version_to_release)
    new_text = replace(text, matched_line=>new_line)
    !dryrun && write(projectfile, new_text)
    println("Updated [$projectfile] to $version_to_release")
end
println()
