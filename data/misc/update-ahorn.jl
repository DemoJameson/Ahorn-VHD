env = ENV["AHORN_ENV"]

logfilePath = joinpath(dirname(env), "log-install-ahorn.txt")
println("Logging to " * logfilePath)
logfile = open(logfilePath, "w")

flush(stdout)
flush(stderr)

stdoutReal = stdout
(rd, wr) = redirect_stdout()
redirect_stderr(stdout)

@async while !eof(rd)
    data = String(readavailable(rd))
    print(stdoutReal, data)
    flush(stdoutReal)
    print(logfile, data)
    flush(logfile)
end


using Pkg
Pkg.activate(env)

install_or_update(url::String, pkg::String) = if "Ahorn" ∈ keys(Pkg.Types.Context().env.project.deps)
    println("Updating $pkg...")
    Pkg.update(pkg)
else
    println("Adding $pkg...")
    Pkg.add(PackageSpec(url = url))
end

Pkg.instantiate()

Pkg.add(name="Gtk", version="1.2.2")
Pkg.pin("Gtk")

install_or_update("https://gitee.com/demojameson_personal/Maple.git", "Maple")
install_or_update("https://gitee.com/demojameson_personal/Ahorn.git", "Ahorn")

Pkg.instantiate()
Pkg.API.precompile()

import Ahorn