from subprocess import check_output
import re

def routing_queues(target_queue="hx"):
    qmgr_data = check_output(["qmgr", "-c", f"print queue {target_queue}"]).decode()
    route_destinations = []
    for line in qmgr_data.split("\n"):
        if "route_destinations" in line:
            queue = line.split(" ")[5]
            route_destinations.append(queue)
    return route_destinations

def cluster_capacity(cluster="hx"):
    qmgr_data = check_output(["qmgr", "-c", "print nodes @default"]).decode()
    total_ncpus = 0
    for line in qmgr_data.split("\n"):
        if cluster in line: 
            if "ncpus" in line:
                total_ncpus += int(line.split(" ")[5])
    return total_ncpus
