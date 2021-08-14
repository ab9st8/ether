## Ether

Ether is small utility that serves directories statically on localhost, similar to the tool `serve` made by Vercel.

Hopefully I'll also implement API middleware for this (like `serve` does).

### Installing and using
```sh
git clone https://github.com/c1m5j/ether.git && cd ether
mkdir build && nimble build
./build/ether <dirname> [--port port]
```
where `dirname` is the name of the directory you want to serve and `port` is the desired port to listen on (8080 by default).

Keep in mind that routes will be adjusted to the directory from which the directory is passed, for example `ether dir` will serve all files from the `dir` directory on the `/` route, but `ether ./dir` will serve all files from the `dir` directory on the `/dir/` route. This is probably unwanted and could lead to bugs, but no one has time or desire to test for that.

Acknowledgements: thank you to [flywind](https://github.com/xflywind) for making [Prologue](https://github.com/planety/prologue), the definitive Nim networking library, and for helping me find a closure-related bug!

---
Licensed under the [Unlicense](https://unlicense.org/) + [HAD](https://github.com/c1m5j/have-an-awesome-day).