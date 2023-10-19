from subprocess import check_output
import re

def queue_utilsation():
    qstat_string = check_output(["qstat", "-Q", "-f", "-F", "dsv"]).decode()
    queues = {}
    for queue in qstat_string.split("\n"):
        m = re.search("Queue: (\w+).*Queued:([0-9]*).*Running:([0-9]*)", queue)
        if m:
            queues[m.group(1)] = {"queued": int(m.group(2)), "running": int(m.group(3))}
    return queues

