#!/bin/bash
export INFLUXDB_VERSION="2.7.1"
export INFLUXDB_DOWNLOAD_PATH="https://dl.influxdata.com/influxdb/releases"
wget -q $INFLUXDB_DOWNLOAD_PATH/influxdb2-$INFLUXDB_VERSION-linux-amd64.tar.gz
tar xvfz influxdb2-$INFLUXDB_VERSION-linux-amd64.tar.gz
sudo cp influxdb2_linux_amd64/influxd /usr/local/bin/

wget -q $INFLUXDB_DOWNLOAD_PATH/influxdb2-client-$INFLUXDB_VERSION-linux-amd64.tar.gz
tar xvfz influxdb2-client-$INFLUXDB_VERSION-linux-amd64.tar.gz
sudo cp influx /usr/local/bin/
export PATH:/usr/local/bin/:$PATH

if [ "$INFLUXDB_START" = "true" ]
then
    /usr/local/bin/influxd --http-bind-address :8086  &
    sleep 5
    influx setup --host http://localhost:8086 -f \
        -o $INFLUXDB_ORG \
        -u $INFLUXDB_USER \
        -p $INFLUXDB_PASSWORD \
        -b $INFLUXDB_BUCKET
    influx auth create --user $INFLUXDB_USER --org $INFLUXDB_BUCKET --read-buckets --write-buckets
fi

