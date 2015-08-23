#!/usr/bin/env python

import sys
import os

def run_plugin():
    w1_id = '28-0000053132a2'
    w1_slave = '/sys/bus/w1/devices/{}/w1_slave'.format(w1_id)

    if not os.path.exists(w1_slave):
        print('Cannot open {}'.format(w1_slave))
        sys.exit()

    with open(w1_slave, 'r') as fo:
        lines = fo.readlines()

    line_1 = lines[0].strip()
    if 'YES' in line_1:
        line_2 = lines[1].strip()
        index = line_2.find('t=')
        if index != -1:
            temp = int(line_2[index + 2:]) / 1000
            return temp
    else:
        sys.exit()


if __name__ == '__main__':
    num_args = len(sys.argv)

    if num_args == 1:
        print('temperature.value {}'.format(run_plugin()))
    elif num_args == 2 and sys.argv[1] == 'config':
        print('graph_args --base 1000')
        print('graph_category sensors')
        print('graph_info Raspberry Pi DS18B20 1-Wire Bus Temperature Sensor')
        print('graph_title DS18B20 Temperature')
        print('graph_vlabel Celsius')
        print('temperature.label ds18b20')
