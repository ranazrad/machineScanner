import os
import boto3
import time

kms = boto3.client('kms', region_name='eu-west-1')

def get_online_machines():
    ec2 = boto3.resource('ec2')
    for instance in ec2.instances.all():
        for tag in instance.tags:
            if instance.state['Code'] == 16:
                if tag['Key'] == 'Name' and tag['Value'] == 'devops': #Replace Name with k8s.io/role/master and Value with 1
                    print("Name: {0}".format(tag['Value']))  # Do an operation
                    # Can be commented
                    print("Id: {0}\nPlatform: {1}\nType: {2}\nPublic IPv4: {3}\nAMI: {4}\nState: {5}\n".format(instance.id, instance.platform, instance.instance_type, instance.public_ip_address, instance.image.id, instance.state))

interval = os.environ.get('interval')
if interval == None:
    get_online_machines()
else:
    while True:
        get_online_machines()
        print("Sleep for {0} seconds".format(interval))
        time.sleep(int(interval))
