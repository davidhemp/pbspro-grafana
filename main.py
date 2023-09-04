#!/usr/bin/env python
import os

import influxdb
import influxdb_client

conn = influxdb.Connector()
p = influxdb_client.Point("nodes").field("failed", 10)
conn.write(p)
