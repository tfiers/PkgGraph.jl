
is_in_code_block(md, m::RegexMatch) =
    any(
        m.offset in block
        for block in code_block_ranges(md)
    )

code_block_ranges(md) = findall(r"```.*?```"s, md)
# - The `?` is to match as few characters as possible
#   ("non-greedy"). I.e. to stop at the first next ```.
# - `s` flag is to have `.` match newlines too.
