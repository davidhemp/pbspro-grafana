#!/bin/bash

sudo /opt/pbs/bin/pbsnodes -a
/opt/pbs/bin/qstat -q
/opt/pbs/bin/qsub tests/simple-job.pbs
/opt/pbs/bin/qstat -f
