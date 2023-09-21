#!/bin/bash

current_pid=$$
pid_file=/home/user/vlock.pid

if [ -f "$pid_file" ];then
        echo "[$(date) $current_pid] Previous task did not stop properly"
        pid=$(cat "$pid_file")
        if ps -p "$pid" > /dev/null; then
                echo "[$(date) $current_pid] Previous Task is still running with pid=$pid, Exiting..."
                exit 1
        fi
fi

echo $current_pid > "$pid_file"
echo "[$(date) $current_pid] Start Main Execution"

# sleep for 30~90 seconds
sleep  $((RANDOM % 60 + 30))

echo "[$(date) $current_pid] Execution Completed"
rm -f "$pid_file"
