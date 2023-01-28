
output_path(pkgname, dir, fmt) = joinpath(dir, "$pkgname-deps.$fmt")

function create_dot_image(dot_str, fmt, path)
    dotfile = tempname()
    write(dotfile, dot_str)
    run(dotcommand(fmt, dotfile, path))
    println("Created ", nicepath(path))
end

dotcommand(fmt, infile, outfile) = `$(dot()) -T$fmt -o$outfile $infile`

nicepath(p) =
    if relpath(p) |> startswith("..")
        abspath(p)
    else
        relpath(p)
    end
