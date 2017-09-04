#!/usr/bin/env python
"""
"""

from os import listdir, path
from sys import argv, exit

def get_thermals():
    """
    """
    thermals = listdir('/sys/devices/virtual/thermal')
    thermal_zones = [x for x in thermals if 'thermal_zone' in x]
    if len(thermal_zones) == 0:
        print('No thermal_zone devices.')
        exit()
    thermal_zones.sort()
    tz_nums = [x.replace('thermal_zone', '') for x in thermal_zones]
    return tz_nums



def run_plugin(tz_num):
    sys_temp = '/sys/devices/virtual/thermal/thermal_zone{}/temp'.format(tz_num)

    if not path.exists(sys_temp):
        print('Cannot open {}'.format(sys_temp))
        exit()

    with open(sys_temp, 'r') as fo:
        temperature = fo.read()

    temperature = temperature.strip()
    temperature = int(temperature) / 1000
    return temperature


if __name__ == '__main__':
    num_args = len(argv)
    tz_nums = get_thermals()

    if num_args == 1:
        for tz in tz_nums:
            print('temperature{}.value {}'.format(tz, run_plugin(tz)))
    elif num_args == 2 and argv[1] == 'config':
        print('graph_args --base 1000')
        print('graph_category sensors')
        print('graph_info In-Built Temperature Sensor')
        print('graph_title Internal Temperature')
        print('graph_vlabel Celsius')
        for tz in tz_nums:
            print('temperature{0}.label internal {0}'.format(tz))
