#!/bin/bash
mkdir /home/hima/.ssh
chown hima:hima /home/hima/.ssh
cd /home/hima/.ssh
touch authorized_keys
chmod 644 authorized_keys
chown hima:hima authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDK3VMMzhop+FWyZXzazaPs4RJ9uwwfOtw2inrpuFcriYXX97OgkrR6GWd79jtgfuSVXMQ2MDXgQSCwL1pXZ4CtvtHu7grKI24GRBDXbP1ESUwuCyEp+bTOVyG2OAk+Bw8vtv3EIesiJbktuncT1TtL+QXays+S3H/sZXCE90d52w+oXqjId1X3KQnUowwcCPbFsWrmSP7Etnkc+u1c9poTorbHLICCNo9ii1Hrbq4gcZbbf2YwWdD8GY//4v/09Y8EDk9gdiZOroXrctXXtVCc6k6Jif2ThQjPufkjE2BTSm6kLxjAzSlziT0uAC+XvFZQ/Uk6hHUiq6C5Mf50/MIb rsa-key-20211127' >> /home/hima/.ssh/authorized_keys

