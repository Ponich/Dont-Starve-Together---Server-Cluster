#!/usr/bin/env bash

steamcmd_dir="$HOME/steamcmd"
install_dir="$HOME/steamapps/DST"
#cluster_name=${1:-Cluster_1}
cluster_name=${PWD##*/}
dontstarve_dir="$HOME/.klei/DoNotStarveTogether"

function fail()
{
        echo Error: "$@" >&2
        exit 1
}

function check_for_file()
{
    if [ ! -e "$1" ]; then
            fail "Missing file: $1"
    fi
}

cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"

check_for_file "steamcmd.sh"
check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"
check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 +quit

check_for_file "$install_dir/bin"

cd "$install_dir/bin" || fail 

./dontstarve_dedicated_server_nullrenderer -cluster ${cluster_name} -console
