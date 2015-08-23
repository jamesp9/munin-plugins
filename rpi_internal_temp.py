#!/usr/bin/env python

import sys
import os

def run_plugin():
    pi_temp = '/sys/class/thermal/thermal_zone0/temp'

    if not os.path.exists(pi_temp):
        print('Cannot open {}'.format(pi_temp))
        sys.exit()

    with open(pi_temp, 'r') as fo:
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
        print('graph_info Raspberry Pi In-Built Temperature Sensor')
        print('graph_title Internal Temperature')
        print('graph_vlabel Celsius')
        print('temperature.label internal')
