
# Step 3: Commit
# --------------

println("Will commit [$projectfile] and [$changelog_file]")
println("You can check the changes to be committed in e.g. VS Code")
confirm_or_quit("Stage and commit?")
!dryrun && add!(repo, projectfile)
!dryrun && add!(repo, changelog_file)
msg = "Set version to `$version_to_release`"
if dryrun
    short_sha = "abc1234"
else
    sha = commit(repo, msg)
    short_sha = string(sha)[1:7]
end
println("Made commit ", blue(short_sha), " (\"$msg\")")
confirm_or_quit("Push?")
!dryrun && push(repo)
commit_url = "https://github.com/$ghrepo/commits/$short_sha"
println("Commit pushed. Url: ", blue(commit_url))
magic_phrase = "@JuliaRegistrator register"
println("Magic phrase: \"$magic_phrase\"")
confirm_or_quit("Copy phrase to clipboard, and open browser to commit url?")
!dryrun && clipboard(magic_phrase)
!dryrun && DefaultApplication.open(commit_url)
println()
