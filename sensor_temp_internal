#!/usr/bin/env python

import sys
import os


def run_plugin():
    sys_temp = '/sys/devices/virtual/thermal/thermal_zone0/temp'

    if not os.path.exists(sys_temp):
        print('Cannot open {}'.format(sys_temp))
        sys.exit()

    with open(sys_temp, 'r') as fo:
        temperature = fo.read()

    temperature = temperature.strip()
    temperature = int(temperature) / 1000
    return temperature

if __name__ == '__main__':
    num_args = len(sys.argv)

    if num_args == 1:
        print('temperature.value {}'.format(run_plugin()))
    elif num_args == 2 and sys.argv[1] == 'config':
        print('graph_args --base 1000')
        print('graph_category sensors')
        print('graph_info In-Built Temperature Sensor')
        print('graph_title Internal Temperature')
        print('graph_vlabel Celsius')
        print('temperature.label internal')
