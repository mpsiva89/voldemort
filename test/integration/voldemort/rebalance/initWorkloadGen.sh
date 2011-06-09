#!/bin/bash

vldm_dir=/Users/lgao/Projects/voldemort
work_dir=/Users/lgao/work/rebalance

EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage:  $0 [NUM_OF_KEYS] [MAX_VALUE_SIZE]"
  exit -1 
fi

gen.sh $1 $2 | awk '{print $0 "\""}' > $work_dir/workload.txt
echo "exit" >> $work_dir/workload.txt
cd $vldm_dir
bin/voldemort-shell.sh test tcp://localhost:6667 $work_dir/workload.txt
