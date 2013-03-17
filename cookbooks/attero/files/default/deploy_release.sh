#!/bin/bash

if test "$#" -lt 1 ; then
    echo "usage: $0 <release-package>" >&2
    exit 1
fi

script_dir="$( cd "$( dirname "$0" )" && pwd )"
conf_dir=$(readlink -f $script_dir/../conf)
releases_dir=$(readlink -f $script_dir/../releases)
release_file=$1
release_dir=${release_file%%.*}

s3_path="s3://ops.idleplaythings.com/releases/attero"

main() {
    run download_release
    run extract_release
    run link_release
    run clean_downloads
    run restart_service
}

run() {
    $@ && return 0
    echo "failed to execute $@" >&2
    exit 1
}

download_release() {
    s3cmd --config $conf_dir/s3.conf --force get $s3_path/$release_file $releases_dir/$release_file
}

extract_release() {
    if test -d $releases_dir/$release_dir ; then
        rm -rf $releases_dir/$release_dir
    fi

    mkdir $releases_dir/$release_dir

    tar xzf $releases_dir/$release_file -C $releases_dir/$release_dir
}

link_release() {
    if test -f $releases_dir/current ; then
        rm $releases_dir/current
    fi

    ln -s $releases_dir/$release_dir $releases_dir/current
}

clean_downloads() {
    for file in $(find $releases_dir -name *.tar.gz); do
        rm $file;
        echo Removed $file
    done;
}

restart_service() {
    sudo $script_dir/restart_attero.sh
}

main
