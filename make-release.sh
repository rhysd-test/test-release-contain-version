#! /bin/bash

set -e

name=github-release-test
ver="v1.2.3"

rm -rf release
gox -verbose
mkdir -p release
mv ${name}_* release/
cd release
for bin in *; do
    if [[ "${bin}" == *windows* ]]; then
        cmd="${name}.exe"
        mv "$bin" "$cmd"
        release="${bin//$name/${name}_${ver}}"
        zip "${release}.zip" "$cmd"
    else
        cmd="$name"
        mv "$bin" "$cmd"
        release="${bin//$name/${name}_${ver}}"
        tar cf "${release}.tar" "$cmd"
        gzip "${release}.tar"
    fi
    rm "$cmd"
done
