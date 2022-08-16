#!/bin/sh
docker build -t aws .
#docker run -itd --name aws aws
docker run -itd --name aws -v /home/ec2-user/.aws:/home/boto/.aws aws
docker logs --follow aws
echo done
