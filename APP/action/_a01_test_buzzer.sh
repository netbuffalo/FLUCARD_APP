#!/bin/sh

for pattern in 1 2 3 4 6
do
  # test buzzer
  buzzer -t $pattern
  sleep 3

  # stop buzzer
  buzzer -t 5
  sleep 1
done
