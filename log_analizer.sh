#!/bin/bash

# Script should be started with one argument - path to log.file
LOG_TO_PARSE=$1

echo "parsing $LOG_TO_PARSE"

echo "########################################"  > out.txt
echo "   hour  - % of successful requests/hour" >> out.txt
echo "########################################" >> out.txt

awk -F[:\ ] '{total[$5]++; if ($(NF-2)==200) success[$5]++} 
		END {for (i in total) print i, "hour - ", success[i]/total[i]*100, "%"}' $LOG_TO_PARSE >> out.txt

# 5th field  - hour
# $(NF-2) - status code, is always at second position from the end. 
#           12 position doesn't fit as there are difference in log line.
# total[]  - amount of lines in the  array
# success[] - and the successful ones in  array.
echo "########################################" >> out.txt
echo "saved result -> out.txt"
echo ""
cat out.txt



