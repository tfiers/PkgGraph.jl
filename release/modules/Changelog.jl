

module Changelog

using Dates

include("Common.jl")
using .Common

const file = "Changelog.md"

function change_header_to_released(v_short)
    changelog = read_text()
    old_header = unreleased_header(v_short)
    println("Looking for 'unreleased header' of \"", blue(v_short), "\"")
    if findfirst(old_header, changelog) == nothing
        println("Header not found. We won't edit the Changelog")
    else
        println("Header found. Will update to a 'released' header")
        confirm_or_quit("Continue?")
        new_header = released_header(v_short)
        new_changelog = replace(changelog, old_header=>new_header)
        write(file, new_changelog)
        println("Updated [$file]")
    end
end

function add_unreleased_header(v_short)
    confirm_or_quit("Add unreleased header for $v_short?")
    changelog = read_text()
    newtext = dev_version_text(v_short)
    new_changelog = replace(changelog, hline => newtext)
    write(file, new_changelog)
    println("Updated [$file]")
end

read_text() = read(file, String)

unreleased_header(version) = """<br>

    ## $version  &nbsp;<sub>[![][unreleased-badge]][devlink]</sub>

    [unreleased-badge]: https://img.shields.io/badge/Unreleased-orange
    [devlink]: https://github.com/$ghrepo#development
    """

released_header(version, datestr = current_date_for_badge()) = """<br>

    ## $version  &nbsp;<sub>[![][$version-date-badge]][$version-release]</sub>

    [$version-date-badge]: https://img.shields.io/badge/Released_on-$datestr-blue
    [$version-release]: https://github.com/$ghrepo/releases/tag/$version
    """

current_date_for_badge() = Dates.format(now(), "yyyy--mm--dd")

const hline = "\n\n-------------\n\n"  # Separating preamble from versions

dev_version_text(version) = """
    $hline
    $(unreleased_header(version))
    _{no changes yet}_

    """

end
