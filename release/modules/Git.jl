
module Git

using LibGit2: add!, commit

include("Common.jl")
using .Common

function add_commit_push(files, msg)
    println("Will commit ", join(blue.(files), ", ", " and "))
    println("You can check the changes to be committed in e.g. VS Code")
    confirm_or_quit("Stage and commit?")
    for f in files
        add!(repo, f)
    end
    sha = commit(repo, msg)
    short_sha = string(sha)[1:7]
    println("Made commit ", blue(short_sha), " (\"$msg\")")
    confirm_or_quit("Push?")
    run(`git push`)  # Not `LibGit2.push(repo)`: that needs auth
    commit_url = "https://github.com/$ghrepo/commits/$short_sha"
    println("Commit pushed. Url: ", blue(commit_url))
    return commit_url
end

end
