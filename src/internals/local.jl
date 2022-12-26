
function is_dot_available()
    if Sys.iswindows()
        cmd = `where dot`
    else
        cmd = `which dot`
    end
    proc = run(cmd, wait = false)
    return success(proc)
end

function create_DOT_image(DOT_str, fmt, path)
    dotfile = tempname()
    write(dotfile, DOT_str)
    run(`dot -T$fmt -o$path $dotfile`)
    println("Created ", nicepath(path))
end

nicepath(p) =
    if relpath(p) |> startswith("..")
        abspath(p)
    else
        relpath(p)
    end
