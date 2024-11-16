#!/bin/bash

# Clear the screen and start the setup
clear

# Ask for Elasticsearch node IP addresses
echo "Please enter the IP address for Elasticsearch Node 1 (e.g., 10.0.2.15):"
read node1_ip

echo "Please enter the IP address for Elasticsearch Node 2 (e.g., 10.0.2.4):"
read node2_ip

echo "Please enter the IP address for Elasticsearch Node 3 (e.g., 10.0.2.5):"
read node3_ip

echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting Logstash installation and configuration."

# Update package lists and install dependencies
echo "$(date '+%Y-%m-%d %H:%M:%S') - Updating package list and installing dependencies."
if sudo apt-get update && sudo apt-get install -y openjdk-11-jdk apt-transport-https; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Dependencies installed successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error installing dependencies."
    exit 1
fi

# Add the Elastic GPG key and repository
echo "$(date '+%Y-%m-%d %H:%M:%S') - Adding Elastic GPG key and repository."
if wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
   sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list'; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Elastic GPG key and repository added successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error adding GPG key or repository."
    exit 1
fi

# Install Logstash
echo "$(date '+%Y-%m-%d %H:%M:%S') - Installing Logstash."
if sudo apt-get update && sudo apt-get install logstash -y; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Logstash installed successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error installing Logstash."
    exit 1
fi



# Create Logstash pipeline configuration file
LOGSTASH_PIPELINE_CONF="/etc/logstash/conf.d/logstash_pipeline.conf"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Creating Logstash pipeline configuration."
sudo tee $LOGSTASH_PIPELINE_CONF > /dev/null <<EOF
input {
}

filter {
  # Apply any filtering if necessary (grok, mutate, etc.)
}

output {
  elasticsearch {
    hosts => ["http://$node1_ip:9200", "http://$node2_ip:9200", "http://$node3_ip:9200"]
    index => "logstash-index-%{+YYYY.MM.dd}"
    # Uncomment below if Elasticsearch has authentication enabled
    # user => "elastic"
    # password => "changeme"
  }
  
}
EOF

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Logstash pipeline configuration created successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error creating Logstash pipeline configuration."
    exit 1
fi

# Enable and start Logstash service
echo "$(date '+%Y-%m-%d %H:%M:%S') - Enabling and starting Logstash service."
if sudo systemctl enable logstash && sudo systemctl start logstash; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Logstash service started successfully."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error starting Logstash service."
    exit 1
fi

# Test the Logstash configuration
echo "$(date '+%Y-%m-%d %H:%M:%S') - Testing Logstash pipeline."
if sudo /usr/share/logstash/bin/logstash --config.test_and_exit -f $LOGSTASH_PIPELINE_CONF; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Logstash configuration test passed."
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error in Logstash configuration."
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Logstash setup completed successfully."
