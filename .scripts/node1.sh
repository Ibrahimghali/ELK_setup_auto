#!/bin/bash

# Clear the screen and start the setup
clear
echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting Elasticsearch node-1 setup script."

# Prompt for IP input for node-2
read -p "Enter IP address for node-2: " NODE2_IP
echo "You entered: $NODE2_IP"

# Prompt for IP input for node-3
read -p "Enter IP address for node-3: " NODE3_IP
echo "You entered: $NODE3_IP"

# Update package list and install required dependencies (curl and Java)
echo "$(date '+%Y-%m-%d %H:%M:%S') - Updating package list and installing dependencies."
if sudo apt update && sudo apt install curl openjdk-11-jdk -y; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Dependencies installed successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error installing dependencies."
    exit 1
fi

# Check Java version
if java -version; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Java installed successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error checking Java version."
    exit 1
fi

# Add Elasticsearch GPG key and repository
echo "$(date '+%Y-%m-%d %H:%M:%S') - Adding Elasticsearch GPG key and repository."
if wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
   sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list' && \
   sudo apt update; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Elasticsearch repository added successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error adding Elasticsearch repository."
    exit 1
fi

# Install Elasticsearch
echo "$(date '+%Y-%m-%d %H:%M:%S') - Installing Elasticsearch."
if sudo apt install elasticsearch -y; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Elasticsearch installed successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error installing Elasticsearch."
    exit 1
fi

# Get the IP address of the current machine
CURRENT_IP=$(hostname -I | awk '{print $1}')
echo "$(date '+%Y-%m-%d %H:%M:%S') - Current machine IP address: $CURRENT_IP"

# Create and configure elasticsearch.yml with user-provided IP addresses
echo "$(date '+%Y-%m-%d %H:%M:%S') - Configuring elasticsearch.yml."
if sudo tee /etc/elasticsearch/elasticsearch.yml > /dev/null << EOF
# ======================== Elasticsearch Configuration =========================
# Cluster name
cluster.name: elastic

# Node name
node.name: node-1

# Path to directory where to store the data
path.data: /var/lib/elasticsearch

# Path to log files
path.logs: /var/log/elasticsearch

# Network settings (make Elasticsearch accessible from any IP address)
network.host: 0.0.0.0

# HTTP port for Elasticsearch
http.port: 9200

# Discovery settings (seed hosts for other nodes)
discovery.seed_hosts: ["$CURRENT_IP", "$NODE2_IP", "$NODE3_IP"]

# Bootstrap the cluster using initial master nodes
cluster.initial_master_nodes: ["node-1", "node-2", "node-3"]

EOF
then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - elasticsearch.yml configured successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error configuring elasticsearch.yml."
    exit 1
fi

# Enable and start Elasticsearch
echo "$(date '+%Y-%m-%d %H:%M:%S') - Enabling and starting Elasticsearch."
if sudo systemctl enable elasticsearch && sudo systemctl daemon-reload && sudo systemctl start elasticsearch; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Elasticsearch enabled and started successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error enabling or starting Elasticsearch."
    exit 1
fi

# Test Elasticsearch by sending a request to localhost
echo "$(date '+%Y-%m-%d %H:%M:%S') - Testing Elasticsearch."
if curl -X GET "localhost:9200/" && curl -X GET "localhost:9200/_cat/nodes?v"; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Elasticsearch test requests were successful."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error during Elasticsearch test requests."
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Elasticsearch node-1 setup script completed successfully."
