#!/bin/bash

mkdir -p /opt/observium/{rrd,logs,mibs}
cd /opt && wget http://www.observium.org/observium-community-latest.tar.gz && tar zxvf observium-community-latest.tar.gz && rm -f observium-community-latest.tar.gz
mv /opt/observium/config.php.default /opt/observium/config.php
cp /opt/observium/scripts/distro /usr/bin/distro
mkdir -p /tmp/observium/{scripts,mibs} && mv /opt/observium/scripts/* /tmp/observium/scripts/ && mv /opt/observium/mibs/* /tmp/observium/mibs/

echo "33  */6   * * *   root    /opt/observium/discovery.php -h all >> /dev/null 2>&1" >> /etc/crontab
echo "*/5 *     * * *   root    /opt/observium/discovery.php -h new >> /dev/null 2>&1" >> /etc/crontab
echo "*/5 *     * * *   root    /opt/observium/poller-wrapper.py 8 >> /dev/null 2>&1" >> /etc/crontab
echo "13 5 * * * root /opt/observium/housekeeping.php -ysel" >> /etc/crontab
echo "47 4 * * * root /opt/observium/housekeeping.php -yrptb" >> /etc/crontab
echo "" >> /etc/crontab