module Common

using Base: prompt
using Crayons
using LibGit2: GitRepo, isdirty

export blue, confirm_or_quit, prompt, shorthand, ghrepo, repo, isdirty

const ghrepo = "tfiers/PkgGraph.jl"

const repo = GitRepo(".")

const blue = Crayon(foreground=:blue)

confirm_or_quit(question) = begin
    answer = prompt(question * " [Y/n]")
    lowercase(answer) in ["", "y"] || (println("Goodbye"); exit())
end

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

end
