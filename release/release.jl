
using Pkg
Pkg.activate(@__DIR__)

using DefaultApplication

include("modules/Common.jl")
using .Common

include("modules/Project.jl")
using .Project

include("modules/Changelog.jl")
using .Changelog

include("modules/Git.jl")
using .Git

include("modules/GitHubRelease.jl")
using .GitHubRelease

cd_reporoot() = begin
    reporoot = dirname(@__DIR__)
    cd(reporoot)
    println("Working directory: ", blue(pwd()))
    println()
    if isdirty(repo)
        @info "There are uncommitted changes"
        println()
    end
end

update_project_rm_dev() = begin
    @info "Step 1: Project.toml: remove `-dev` from version"
    current_version = Project.current_version()  # `v0.6.0-dev`, eg
    v_to_release = split(current_version, "-")[1]
    # ↪ Could instead do `VersionNumber(current_version)`, and nullify its
    #   `.prerelease` field, which for the above example is `("dev",)`.
    #   https://docs.julialang.org/en/v1/manual/strings/#man-version-number-literals
    Project.update_version(v_to_release)
    println()
    return v_to_release
end

rollover_changelog(git_tag) = begin
    @info "Step 2: Rollover Changelog.md"
    Changelog.change_header_to_released(git_tag)
    println()
end

commit_and_register(v_to_release) = begin
    @info "Step 3: Commit & Register in General"
    msg = set_version_to__str(v_to_release)
    commit_url = Git.add_commit_push([Project.file, Changelog.file], msg)
    commit_url = "https://github.com/tfiers/PkgGraph.jl/commit/0c0709d"
    phrase = "@JuliaRegistrator register"
    println("Magic phrase: \"", blue(phrase), "\"")
    confirm_or_quit("Copy phrase to clipboard, and open browser to commit url?")
    is_WSL = "WSL_DISTRO_NAME" in keys(ENV)
    if is_WSL
        run(pipeline(`echo $phrase`, `clip.exe`))
    else
        clipboard(phrase)
    end
    DefaultApplication.open(commit_url)
    println()
end

set_version_to__str(v) = "Set version to `$v`"

gh_release(v_to_release, git_tag) = begin
    @info "Step 4: Draft GitHub release"
    GitHubRelease.create_and_send_draft(git_tag)
    println("Check and publish the release draft")
    prompt("When done, press <enter> to continue")
    println("Congrats on the new release")
    println("Newly released version: ", blue(v_to_release))
    println("New git tag:            ", blue(gittag))
    println()
end

new_dev_version(released_v) = begin
    @info "Step 5: New dev version"
    released_v = VersionNumber(released_v)
    proposed_new_v = VersionNumber(released_v.major, released_v.minor+1, 0)
    default = string(proposed_new_v)
    answer = prompt("What is the new dev version?"; default)
    future_release_v = VersionNumber(answer)
    new_dev_version = string(future_release_v) * "-dev"
    Project.update_version(new_dev_version)
    Changelog.add_unreleased_header(shorthand(future_release_v))
    msg = set_version_to__str(new_dev_version)
    Git.add_commit_push([Project.file, Changelog.file], msg)
    println()
end

cd_reporoot()
v = update_project_rm_dev()
git_tag = shorthand(v)
rollover_changelog(v)
commit_and_register(v)
gh_release(v, git_tag)
new_dev_version(v)
println("Done")
