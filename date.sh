#!/bin/bash

function wonderful_date()
{
	local now_time=$(date)
	echo ""
        echo "Now time is: $now_time"
	echo ""
	echo "date +%Y%m%d: $(date +%Y%m%d)"
	echo ""
	echo "date +%Y/%m/%d %H:%M:%S %Z: $(date +'%Y/%m/%d %H:%M:%S %Z')"
}

wonderful_date
