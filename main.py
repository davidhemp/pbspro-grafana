#!/usr/bin/env python3
import yaml

import influxdb
import influxdb_client

import qstat
import qmgr

# Local config file
with open("config.yaml", 'r') as file:
        config = yaml.safe_load(file)
conn = influxdb.Connector(config["influx"])

queue_usage = qstat.queue_utilsation()
for queue in qmgr.routing_queues(config["cluster"]):
    queue_usage[config["cluster"]]["running"] += queue_usage[queue]["running"]
    queue_usage[config["cluster"]]["queued"] += queue_usage[queue]["queued"]
    
for queue, state in queue_usage.items():
    p = influxdb_client.Point("jobs").tag("queue", queue).field("Running", state["running"])
    conn.write(p)
    p = influxdb_client.Point("jobs").tag("queue", queue).field("Queued", state["queued"])
    conn.write(p)

max_ncpus = qmgr.cluster_capacity(config["cluster"])

p = influxdb_client.Point("jobs").tag("queue", config["cluster"]).field("max_ncpus", max_ncpus)
conn.write(p) 
    
