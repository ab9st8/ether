# Package

version       = "0.1.0"
author        = "c1m5j"
description   = "A Serve-esque static file-serving command line utility."
srcDir        = "src"
bin           = @["ether"]
binDir        = "build"


# Dependencies

requires "nim >= 1.4.0"
requires "prologue"
requires "rainbow"
requires "argparse"