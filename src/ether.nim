import prologue, tables, os, rainbow, sugar, argparse, options

var routes = newTable[string, HandlerAsync]()

proc filepathToRoute(filepath: string): string =
    var i = 0
    for idx, ch in filepath:
        if ch in {DirSep, AltSep}:
            i = idx
            break
    while filepath[i] in {DirSep, AltSep}: inc i
    return filepath[i-1..^1]

proc collect(dirname: string) =
    for kind, name in walkDir(dirname):
        case kind
        of pcFile:
            capture name:
                let (directory, filename) = name.expandFilename().splitPath()
                let route = filepathToRoute(dirname & "/" & filename)
                routes[route] = proc (ctx: Context) {.async.} =
                    await ctx.staticFileResponse(filename, directory)
        of pcDir: collect(name)

        else: discard

when isMainModule:
    let parser = newParser("ether"):
        help("Ether is small utility that serves directories statically on localhost, similar to the tool `serve` made by Vercel.")
        option("--port", "-p", default=some("8080"), help="Port to listen on")
        arg("dirname", help="Name of directory to serve")

    try:
        let res = parser.parse()
        let dirname = res.dirname
        let port = res.port
        if parseInt(port) > 9999: raise new(ValueError)

        var settings = newSettings()
        settings.port = Port(parseInt(res.port))

        echo dirname
        echo res.port
        collect(dirname)
        var app = newApp(settings=settings)
        for route, routeProc in routes:
            app.addRoute(route, routeProc)
        app.run()

    except ValueError:
        echo "Error! Invalid port.".rfRed

    except ShortCircuit:
        echo parser.help
        quit(1)