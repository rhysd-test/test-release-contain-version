#! /bin/bash

set -e

name=github-release-test

rm -rf release
gox -verbose
mkdir -p release
mv ${name}_* release/
cd release
for bin in *; do
    if [[ "${bin}" == *windows* ]]; then
        cmd="${name}.exe"
    else
        cmd="$name"
    fi
    mv "$bin" "$cmd"
    tar cf "${bin}.tar" "$cmd"
    xz "${bin}.tar"
done
