
"""
    create(pkgname; dir = tempdir(), fmt = :png)

Render the dependency graph of the given package as an image in `dir`, and open it with your
default image viewer. Uses the external program '`dot`' ([graphviz.org](https://graphviz.org)),
which must be available on `PATH`.

`fmt` is an output file format supported by dot, such as svg or png.
"""
create(pkgname; dir = tempdir(), fmt = :png) = begin
    if !is_dot_available()
        error("`dot` program not found on `PATH`. Get it at https://graphviz.org/download/")
    end
    dotstr = deps_as_DOT(pkgname)
    imgname = "$pkgname-deps.$fmt"
    imgpath = joinpath(dir, imgname)
    create_DOT_image(dotstr, fmt, imgpath)
    DefaultApplication.open(imgpath)
    return nothing
end

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
    println("Created ", relpath(path))
end
