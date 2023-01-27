# Step 4: Draft gh release
# ------------------------

print("Creating gh release draft … ")

get_string(url) = String(take!(Downloads.download(url, IOBuffer())))
get_json(url) = JSON.parse(get_string(url))

baseurl = "https://api.github.com/repos/$ghrepo"
last_release_url = "$baseurl/releases/latest"
last_release_date = get_json(last_release_url)["published_at"]

issue_url = ("$baseurl/issues?state=closed"
    * "&since=$last_release_date&per_page=100"
    * "&sort=created&direction=asc"  # Oldest first
)
# ↪ Current limitation: no more than 100 closed issues (no multipage)
issues_list = get_json(issue_url)
closed_issues = []
merged_PRs = []
for issue_obj in issues_list
    title = issue_obj["title"]
    author = issue_obj["user"]["login"]
    nr = issue_obj["number"]
    if "pull_request" in keys(issue_obj)
        push!(merged_PRs, (; title, nr, author))
    else
        push!(closed_issues, (; title, nr))
    end
end
release_body = """
    Human-written changelog: [**Changelog @ $v_short**][cl]

    [cl]: https://github.com/$ghrepo/blob/main/$changelog_file#$v_short--

    """
if !isempty(merged_PRs)
    PR_line(; title, nr, author) = "  - $title (#$nr) ($author)"
    PR_lines = [PR_line(; PR...) for PR in merged_PRs]
    PR_list = join(PR_lines, "\n")
    release_body *= """
    Merged PRs:
    - <details><summary><sub>[Click to expand]</sub></summary>

    $PR_list
      </details>

    """
end
if !isempty(closed_issues)
    issue_line(; title, nr) = "  - $title (#$nr)"
    issue_lines = [issue_line(; iss...) for iss in closed_issues]
    issue_list = join(issue_lines, "\n")
    release_body *= """
    Closed issues:
    - <details><summary><sub>[Click to expand]</sub></summary>

    $issue_list
      </details>
    """
end

cmd = `gh api \
    --method POST \
    -H "Accept: application/vnd.github+json" \
    /repos/$ghrepo/releases \
    -f tag_name='$v_short' \
    -f body='$release_body' \
    -F draft=true`

println("done")
confirm_or_quit("Send release draft to GitHub and open in browser?")
!dryrun && run(cmd)
DefaultApplication.open("https://github.com/$ghrepo/releases")
