#!/bin/bash
set -o nounset
set -o errexit

readonly instance_name="Ec2 driver server"
readonly ami_id="ami-4e16e023"
readonly instance_count=1
readonly instance_type="t2.micro"
readonly key_name="fe-shared"
# 'default' security group
readonly security_group_id="sg-78022a1c"
# private subnet
readonly subnet_id="subnet-ef88edb6"
readonly root_volume_size=8
readonly root_device="/dev/sda1"

readonly instance_id=$(aws ec2 run-instances --image-id $ami_id --count $instance_count --instance-type $instance_type --key-name $key_name --security-group-ids $security_group_id --subnet-id $subnet_id --block-device-mappings "[{\"DeviceName\":\"${root_device}\",\"Ebs\":{\"VolumeSize\":${root_volume_size},\"DeleteOnTermination\":true}}]" --query 'Instances[0].InstanceId' --output text)

echo "Ec2 instance has been run, instance id: ${instance_id}"

aws ec2 create-tags --resources ${instance_id} --tags Key=Name,Value="${instance_name}"