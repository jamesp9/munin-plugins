#!/bin/bash

output_config() {
    echo "graph_title Chrony Activity"
    echo "graph_category ntp"
    echo "graph_vlabel Source Count"

    echo "online.label online"
    echo "online.type GAUGE"

    echo "offline.label offline"
    echo "offline.type GAUGE"

    echo "burst_online.label burst_online"
    echo "burst_online.type GAUGE"

    echo "burst_offline.label burst_offline"
    echo "burst_offline.type GAUGE"

    echo "unknown.label unknown_address"
    echo "unknown.type GAUGE"
}

output_values() {
    chrony_output=$(chronyc activity)
    sources_online=$(echo "${chrony_output}" | grep "sources\ online" | cut -d" " -f1)
    sources_offline=$(echo "${chrony_output}" | grep "sources\ offline" | cut -d" " -f1)
    sources_burst_online=$(echo "${chrony_output}" | grep "return\ to\ online" | cut -d" " -f1)
    sources_burst_offline=$(echo "${chrony_output}" | grep "return\ to\ offline" | cut -d" " -f1)
    sources_unknown=$(echo "${chrony_output}" | grep "unknown\ address" | cut -d" " -f1)
    printf "online.value %d\n" ${sources_online}
    printf "offline.value %d\n" ${sources_offline}
    printf "burst_online.value %d\n" ${sources_burst_online}
    printf "burst_offline.value %d\n" ${sources_burst_offline}
    printf "unknown.value %d\n" ${sources_unknown}
}

output_usage() {
    printf >&2 "%s - munin plugin to graph an example value\n" ${0##*/}
    printf >&2 "Usage: %s [config]\n" ${0##*/}
}

check_chronyd_is_running() {
    chronyc activity > /dev/null 2>&1 || { echo "chronyd is not running"; exit 1; };
}

case $# in
    0)
        check_chronyd_is_running
        output_values
        ;;
    1)
        case $1 in
            config)
                output_config
                ;;
            *)
                output_usage
                exit 1
                ;;
        esac
        ;;
    *)
        output_usage
        exit 1
        ;;
esac
