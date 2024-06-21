#!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/
