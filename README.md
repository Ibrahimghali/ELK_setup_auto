# Elasticsearch Cluster Setup Automation

This repository provides an automated way to set up an Elasticsearch cluster across multiple nodes using obfuscated setup scripts. The project includes encoded scripts for node configuration and multiple trigger scripts to execute them.

## Project Structure

```plaintext
elasticsearch_setup_auto/
├── LICENSE
├── README.md
├── src
│   ├── kibana_setup.py
│   ├── logstash_setup.py
│   ├── node1_setup.py
│   ├── node2_setup.py
│   └── node3_setup.py
└── trigger
    ├── kibana_runner.sh
    ├── logstash_runner.sh
    ├── node1_runner.sh
    ├── node2_runner.sh
    └── node3_runner.sh
```

## How to Use

Follow the steps below to set up your Elasticsearch cluster.

### 1. Clone the Repository

First, clone the repository to your local machines (3 nodes):

```bash
git clone https://github.com/Ibrahimghali/elasticsearch_setup_auto.git
```

Navigate to the project directory:

```bash
cd elasticsearch-setup
```

### 2. Know Your Node IP Addresses

Before running the setup scripts, ensure you know the IP addresses of the three nodes you will be configuring. This is crucial for the proper setup and communication between the nodes.

```bash
ip a
```

### 3. Run the Trigger Script

Navigate to the `trigger/` directory, which contains the encoded setup scripts:

```bash
cd trigger
```

Run the trigger script to decode and execute the node setup scripts. Choose the appropriate trigger script based on the node you want to set up:

```bash
bash node1_runner.sh  # For node-1 (elasticsearch)
bash node2_runner.sh # For node-2 (elasticsearch)
bash node3_runner.sh # For node-3 (elasticsearch)
bash kibana_runner.sh # For Kibana node
```

The selected script will automatically decode and set up the Elasticsearch cluster for the corresponding node based on the encoded files. Ensure the IP addresses of your nodes are properly configured during the process.

### 4. Verify the Cluster

#### 4.1. Check the Cluster Health

After executing the setup scripts, verify the cluster's health by running the following command on any node:

```bash
curl -X GET "localhost:9200/_cluster/health?pretty"
```

This command provides details about the health and status of your Elasticsearch cluster.

#### 4.2. Check Node Information

To get detailed information about the nodes in your Elasticsearch cluster, use the following command:

```bash
curl -X GET "localhost:9200/_cat/nodes?v"
```

This command displays a tabular view of the nodes, including their IP addresses, roles, and other relevant details.

### 5. Restart Elasticsearch if Nodes Are Not Running

If you find that not all nodes are running, restart the Elasticsearch service on the affected nodes using the following command:

```bash
sudo systemctl restart elasticsearch.service
```

If you find that not all three nodes are running, you can restart the Elasticsearch service on the affected nodes using the following command:

```bash
sudo systemctl restart elasticsearch.service
```

If you find that not all three nodes are running, you can restart the Elasticsearch service on the affected nodes using the following command:

```bash
sudo systemctl restart elasticsearch.service
```

To check the status and verify Kibana is properly running, you can add the following note to the README file:

### 6. Verify Kibana

After setting up Kibana and Elasticsearch, you can verify Kibana's status by checking if the Kibana service is running and then accessing its web interface.

#### 6.1. Check Kibana Service Status

Run the following command on the machine where Kibana is installed to check if the service is active:

```bash
sudo systemctl status kibana
```

If Kibana is running, you should see output indicating that the service is active (running).

#### 6.2. Access Kibana Web Interface

Kibana provides a web-based interface that you can access using a web browser. By default, Kibana runs on port 5601. Open a browser and go to the following URL:

```bash
http://<KIBANA_NODE_IP>:5601
```

Replace `<KIBANA_NODE_IP>` with the IP address of the node where Kibana is installed. You should be able to see the Kibana dashboard.

#### 6.3. Verify Kibana's Connection to Elasticsearch

Once you're in the Kibana web interface, you can check if Kibana is properly connected to Elasticsearch by navigating to **Stack Monitoring** or **Dev Tools**. In **Dev Tools**, run the following command:

```bash
GET _cat/health?v
```

This will return the health of your Elasticsearch cluster, and if Kibana is properly connected, it should display the cluster's health status.

## Logs

The setup scripts generate logs for each step of the process, providing details about success or failure. These logs help track the progress and troubleshoot any issues during setup.

## Additional Notes

- Make sure to review the [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/index.html) for detailed configuration options and best practices.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
