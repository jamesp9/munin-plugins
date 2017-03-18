# munin-rpi-sensors
Graph assorted sensors attached to the Raspberry Pi

## Internal Temperature Sensor

## DS18B20 - Temperature
To use the Dallas 1-Wire Temperature sensor plugin, you will first need to find out the unique 64bit rom code of your device.
```
ls -l /sys/bus/w1/devices/
```
You will see something like this:
```
lrwxrwxrwx 1 root root 0 Oct 10 08:31 28-000008299930 -> ../../../devices/w1_bus_master1/28-000008299930
lrwxrwxrwx 1 root root 0 Oct 10 10:37 w1_bus_master1 -> ../../../devices/w1_bus_master1
```
For this plugin we only need the unique code `000008299930` as the family id `28` is presumed.

Copy the `sensor_temp_ds18b20.py` script to your system plugins directory:
On Archlinux:
```
# cp sensor_temp_ds18b20.py /usr/lib/munin/plugins/sensor_temp_ds18b20_
```
On Debian family:
```
# cp sensor_temp_ds18b20.py /usr/share/munin/plugins/sensor_temp_ds18b20_
```

Now link the plugin using the unique code from your device
```
# ln -s /usr/lib/munin/plugins/sensor_temp_ds18b20_ /etc/munin/plugins/sensor_temp_ds18b20_000008299930
```

NOTE: when linking the file the `28-` is left out and just uses the 1wire ID.

Restart the Munin Node service

## RHT03 - Temperature and Humidity
