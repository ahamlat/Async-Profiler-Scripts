#!/bin/bash

# Besu binaries home directory
BESU_HOME=/opt/besu

# Besu process id
pid=10741

# Async Profiler url
# Comment this line if you already executed this script on the current machine
async_profilier_url=https://github.com/jvm-profiling-tools/async-profiler/releases/download/v2.9/async-profiler-2.9-linux-x64.tar.gz

# set environment variables to capture kernel stacks using perf_events
# https://github.com/jvm-profiling-tools/async-profiler/wiki/Basic-Usage

# Comment these 2 lines if you already executed this script on the current machine

sysctl kernel.perf_event_paranoid=1
sysctl kernel.kptr_restrict=0

# set the duration for the profiler (in seconds)

duration=300

# set the output file for the profiling results

output_file=/tmp/async_profiler_results.html

# get the binaries from github, uncompress and copy it to $BESU_HOME

# Comment these 3 lines if you already executed this script on the current machine
wget $async_profilier_url
tar -xvf async-profiler-2.9-linux-x64.tar.gz
mv async-profiler-2.9-linux-x64 $BESU_HOME

# launch async profiler to profile CPU usage
cd $BESU_HOME/async-profiler-2.9-linux-x64
./profiler.sh -d $duration -e cpu -f $output_file $pid

# display a message indicating that profiling has completed
echo "Profiling completed. Results saved to $output_file."