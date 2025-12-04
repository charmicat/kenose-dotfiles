#!/bin/bash

uwsm select
if true; then
#if uwsm check may-start -v; then
      exec systemd-cat -t uwsm_start uwsm start default
  else
      echo "uwsm check may-start returned bad status $?" 
fi

