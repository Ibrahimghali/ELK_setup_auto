# Elasticsearch Cluster Setup Automation

This repository provides an automated way to set up an Elasticsearch cluster across multiple nodes using obfuscated setup scripts. The project includes encoded scripts for node configuration and multiple trigger scripts to execute them.

## Project Structure

```plaintext
elasticsearch_setup_auto/
├── encoded/
│   ├── node1_setup.sh             # Encoded setup script for node-1
│   ├── node2_setup.sh             # Encoded setup script for node-2
│   ├── node3_setup.sh             # Encoded setup script for node-3
│   ├── trigger_setup1.sh          # Encoded trigger script for node-1
│   ├── trigger_setup2.sh          # Encoded trigger script for node-2
│   └── trigger_setup3.sh          # Encoded trigger script for node-3
├── LICENSE                         # License file
├── README.md                      # Project documentation
└── scripts/
    ├── key.sh                     # Script for handling keys (if applicable)
    ├── node1.sh                   # Original setup script for node-1
    ├── node2.sh                   # Original setup script for node-2
    ├── node3.sh                   # Original setup script for node-3
    ├── trigger1.sh                # Original trigger script for node-1
    ├── trigger2.sh                # Original trigger script for node-2
    └── trigger3.sh                # Original trigger script for node-3
```

## How to Use

Follow the steps below to set up your Elasticsearch cluster.

### 1. Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/Ibrahimghali/elasticsearch-setup.git
```

Navigate to the project directory:

```bash
cd elasticsearch-setup
```

### 2. Run the Decoder Script

Navigate to the `encoded/` directory, which contains the encoded setup scripts:

```bash
cd encoded
```

Run the decoder script to decode and execute the node setup scripts. Choose the appropriate trigger script based on the node you want to set up:

```bash
./trigger_setup1.sh  # For node-1
./trigger_setup2.sh  # For node-2
./trigger_setup3.sh  # For node-3
```

The selected script will automatically decode and set up the Elasticsearch cluster for the corresponding node based on the encoded files. Ensure the IP addresses of your nodes are properly configured during the process.

### 3. Verify the Cluster

Once the scripts have been executed, you can check the cluster status using the following command on any of the nodes:

```bash
curl -X GET "localhost:9200/_cluster/health?pretty"
```

This will give you details about the health and status of your Elasticsearch cluster.

## Additional Notes

- The original setup scripts are not included in the repository for security and simplicity reasons. They can be found in the `scripts/` directory.
- Make sure to review the [Elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/index.html) for detailed configuration options and best practices.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---
