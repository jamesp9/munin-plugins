#!/bin/bash

output_config() {
    echo "graph_title Chrony Tracking"
    echo "graph_category ntp"
    echo "graph_vlabel seconds"

    echo "system_time.label system_time"
    echo "system_time.type GAUGE"

    echo "last_offset.label last_offset"
    echo "last_offset.type GAUGE"

    echo "rms_offset.label rms_offset"
    echo "rms_offset.type GAUGE"

    echo "root_delay.label root_delay"
    echo "root_delay.type GAUGE"

    echo "root_dispersion.label root_dispersion"
    echo "root_dispersion.type GAUGE"
}

output_values() {
    chrony_output=$(chronyc tracking)
    system_time=$(echo "${chrony_output}" | grep "System\ time" | cut -d":" -f2 | awk '{print $1}')
    last_offset=$(echo "${chrony_output}" | grep "Last\ offset" | cut -d":" -f2 | awk '{print $1}')
    rms_offset=$(echo "${chrony_output}" | grep "RMS\ offset" | cut -d":" -f2 | awk '{print $1}')
    root_delay=$(echo "${chrony_output}" | grep "Root\ delay" | cut -d":" -f2 | awk '{print $1}')
    root_dispersion=$(echo "${chrony_output}" | grep "Root\ dispersion" | cut -d":" -f2 | awk '{print $1}')
    printf "system_time.value %f\n" ${system_time}
    printf "last_offset.value %f\n" ${last_offset}
    printf "rms_offset.value %f\n" ${rms_offset}
    printf "root_delay.value %f\n" ${root_delay}
    printf "root_dispersion.value %f\n" ${root_dispersion}
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
