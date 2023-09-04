#!/bin/bash
influx write --bucket $INFLUXDB_BUCKET "m,host=host1 field1=1.2,field2=5i 1640995200000000000"
