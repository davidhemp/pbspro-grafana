export INFLUXDB_VERSION="2.7.1"
export INFLUXDB_DOWNLOAD_PATH="https://dl.influxdata.com/influxdb/releases"
wget -q $INFLUXDB_DOWNLOAD_PATH/influxdb2-$INFLUXDB_VERSION-linux-amd64.tar.gz
tar xvfz influxdb2-$INFLUXDB_VERSION-linux-amd64.tar.gz
sudo cp influxdb2_linux_amd64/influxd /usr/local/bin/
rm -r influxdb2_linux_amd64/

wget -q $INFLUXDB_DOWNLOAD_PATH/influxdb2-client-$INFLUXDB_VERSION-linux-amd64.tar.gz
tar xvfz influxdb2-client-$INFLUXDB_VERSION-linux-amd64.tar.gz
sudo cp influx /usr/local/bin/
rm *.tar.gz
