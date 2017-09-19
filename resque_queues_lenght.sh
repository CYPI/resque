#! /bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Returns resque queues length"
  exit 0
fi

REDIS_PORT=<redis_port>
REDIS_PERM=<redis_instance>
RESQUE_QUEUES=$(echo "SMEMBERS \"resque:queues\"" | redis-cli -h $REDIS_PERM -p $REDIS_PORT | awk '{print $1}')

for queue in $RESQUE_QUEUES; do
  QUEUE_LENGTH=$(echo "LLEN \"resque:queue:$queue\"" | redis-cli -h $REDIS_PERM -p $REDIS_PORT)
  echo $queue
  echo $QUEUE_LENGTH
done
