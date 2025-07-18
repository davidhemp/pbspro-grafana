#!/usr/bin/env python3
import os

import influxdb
import influxdb_client

import qstat
import qmgr

conn = influxdb.Connector()

queue_usage = qstat.queue_utilsation()
for cluster in ["cx", "hx"]:
    for queue in qmgr.routing_queues(cluster):
        queue_usage[cluster]["running"] += queue_usage[queue]["running"]
        queue_usage[cluster]["queued"] += queue_usage[queue]["queued"]
    
for queue, state in queue_usage.items():
        p = influxdb_client.Point("jobs").tag("queue", queue).field("Running", state["running"])
        conn.write(p)
        p = influxdb_client.Point("jobs").tag("queue", queue).field("Queued", state["queued"])
        conn.write(p)

hx_max_ncpus = qmgr.cluster_capacity("hx")
cx_max_ncpus = qmgr.cluster_capacity("cx")

p = influxdb_client.Point("jobs").tag("queue", "hx").field("max_ncpus", hx_max_ncpus)
conn.write(p) 
p = influxdb_client.Point("jobs").tag("queue", "cx").field("max_ncpus", cx_max_ncpus)
conn.write(p) 
    
