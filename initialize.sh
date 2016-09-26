#!/bin/bash
apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
wget -q -O - http://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
echo "deb http://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
apt-get update
echo y | apt-get install jenkins
echo y | apt-get install git
echo y | apt-get install apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
touch /etc/apt/sources.list.d/docker.list
echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' | tee --append /etc/apt/sources.list.d/docker.list
apt-get update
echo y | apt-get install docker-engine
gpasswd -a jenkins docker
rm -R /var/lib/jenkins/*
cp -R ./* /var/lib/jenkins/
chown -R jenkins:jenkins /var/lib/jenkins/*
service docker restart
service jenkins restart