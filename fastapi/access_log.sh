#!/bin/bash
docker ps | grep fastapi | awk '{print $1}'|xargs docker logs -f


