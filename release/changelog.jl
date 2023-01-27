
# Step 2: Rollover Changelog.md
# -----------------------------

changelog_file = "Changelog.md"
changelog = read(changelog_file, String)

shorthand(version) = begin
    (; major, minor, patch) = VersionNumber(version)
    if minor == 0 && patch == 0
        "v$major"
    elseif patch == 0
        "v$major.$minor"
    else
        "v$major.$minor.$patch"
    end
end
v_short = shorthand(version_to_release)

unreleased_header(version) = """
    <br>

    ## $version  &nbsp;<sub>[![][unreleased-badge]][devlink]</sub>

    [unreleased-badge]: https://img.shields.io/badge/Unreleased-orange
    [devlink]: https://github.com/$ghrepo#development
    """

released_header(version, datestr = date_for_badge()) = """
    <br>

    ## $version  &nbsp;<sub>[![][$version-date-badge]][$version-release]</sub>

    [$version-date-badge]: https://img.shields.io/badge/Released_on-$datestr-blue
    [$version-release]: https://github.com/$ghrepo/releases/tag/$version
    """
date_for_badge() = Dates.format(now(), "yyyy--mm--dd")

# (Could prompt for new dev version here)
# prompt("""What is the new dev version number? (eg: "v0.9", "v1.2.1")""")
# (Then parse, w/ VersionNumber, which handles both "1" and "v1";
#  and display back to user (shorthand :)).

old_header = unreleased_header(v_short)
new_headers = """
    <!--
    $(unreleased_header("v…"))

    _{no changes yet}_
    -->


    $(released_header(v_short))
    """
println("Reading [$changelog_file]")
println("Looking for 'unreleased header' for \"", blue(v_short), "\"")
if findfirst(old_header, changelog) == nothing
    println("Header not found. We won't edit the Changelog")
else
    println("Header found. Will update to a 'released' header, and add a"
            * " commented-out section above it for the future dev version.")
    confirm_or_quit("Continue?")
    new_changelog = replace(changelog, old_header=>new_headers)
    !dryrun && write(changelog_file, new_changelog)
    println("Updated [$changelog_file]")
end
println()
