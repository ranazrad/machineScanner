#!/bin/sh
sudo docker kill aws 2> errors.txt
sudo docker rm aws 2> errors.txt
sudo docker rmi -f aws 2> errors.txt
echo done
