#!/bin/bash
/usr/local/bin/influx write --org $INFLUXDB_ORG --bucket $INFLUXDB_BUCKET "m,host=host1 field1=1.2,field2=5i 1640995200000000000"
