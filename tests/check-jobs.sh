#!/bin/bash

EXIT_CODE=0
for line in $(qstat | grep runner); do 
  job_target=$(echo "line" | awk '{ print $2}' | cut -d"-" -f1)
  final_queue=$(echo "line" | awk '{ $6 }')
  if [[ "${job_target}" != "${final_qeueu}" ]]; then
    echo "Error found in: ${line}"
    EXIT_CODE=1
  fi
exit ${EXIT_CODE}

