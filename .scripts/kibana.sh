#!/bin/bash

# Log function to add timestamps
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Clear the screen and start the setup
clear
log "Starting Kibana setup script."

# Ask for the Elasticsearch node IP addresses
read -p "Please enter the IP address for Elasticsearch Node 1 (e.g., 10.0.2.15): " node1_ip
log "Node 1 IP entered: $node1_ip"

read -p "Please enter the IP address for Elasticsearch Node 2 (e.g., 10.0.2.4): " node2_ip
log "Node 2 IP entered: $node2_ip"

read -p "Please enter the IP address for Elasticsearch Node 3 (e.g., 10.0.2.5): " node3_ip
log "Node 3 IP entered: $node3_ip"

# Update package list and install required dependencies
log "Updating package list and installing dependencies."
if sudo apt-get update && sudo apt install curl openjdk-11-jdk gnupg gpg -y; then
    log "Dependencies installed successfully."
else
    log "Error installing dependencies."
    exit 1
fi

# Add Elasticsearch GPG key
log "Adding Elasticsearch GPG key."
if wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg; then
    log "Elasticsearch GPG key added successfully."
else
    log "Error adding Elasticsearch GPG key."
    exit 1
fi

# Install apt transport for https
log "Installing apt-transport-https."
if sudo apt-get install apt-transport-https -y; then
    log "apt-transport-https installed successfully."
else
    log "Error installing apt-transport-https."
    exit 1
fi

# Add Elasticsearch APT repository
log "Adding Elasticsearch APT repository."
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
if sudo apt-get update; then
    log "Elasticsearch APT repository added successfully."
else
    log "Error adding Elasticsearch APT repository."
    exit 1
fi

# Install Kibana
log "Installing Kibana."
if sudo apt-get install kibana -y; then
    log "Kibana installed successfully."
else
    log "Error installing Kibana."
    exit 1
fi

# Configure Kibana settings in kibana.yml
KIBANA_YML="/etc/kibana/kibana.yml"

# Backup the original configuration file
log "Backing up original kibana.yml."
sudo cp $KIBANA_YML ${KIBANA_YML}.bak

# Update server settings
log "Configuring Kibana server settings."
sudo sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/' $KIBANA_YML
sudo sed -i 's/#server.port: 5601/server.port: 5601/' $KIBANA_YML

# Configure Elasticsearch hosts in Kibana
log "Configuring Elasticsearch hosts in kibana.yml."
sudo sed -i "s|#elasticsearch.hosts: \[\"http://localhost:9200\"\]|elasticsearch.hosts: [\"http://$node1_ip:9200\", \"http://$node2_ip:9200\", \"http://$node3_ip:9200\"]|" $KIBANA_YML

# Set monitoring.ui.ccs.enabled to false
log "Disabling monitoring.ui.ccs.enabled."
echo "monitoring.ui.ccs.enabled: false" | sudo tee -a $KIBANA_YML

# Optional: Configure Elasticsearch authentication if needed
# Uncomment and modify the following lines if you have authentication
# sudo sed -i 's|#elasticsearch.username: "kibana_system"|elasticsearch.username: "your_username"|' $KIBANA_YML
# sudo sed -i 's|#elasticsearch.password: "pass"|elasticsearch.password: "your_password"|' $KIBANA_YML

# Reload systemd manager and restart Kibana service
log "Reloading systemd and restarting Kibana."
sudo systemctl daemon-reload
sudo systemctl enable kibana
if sudo systemctl restart kibana; then
    log "Kibana restarted successfully."
else
    log "Error restarting Kibana."
    exit 1
fi

# Check the status of Kibana
log "Checking Kibana service status."
if sudo systemctl status kibana | grep -q 'active (running)'; then
    log "Kibana is running."
else
    log "Kibana is not running."
    exit 1
fi

log "Kibana setup script completed successfully."
