#!/bin/bash

while read line
do
        mv $line _self_vendor_certs/vd004/
done < list_hima


