# AWS Hive Analytics Package

This repository contains a collection of scripts for analyzing flight delay data using AWS EC2 and Hive. The package automates the process of transferring scripts to an EC2 instance, initializing the database, running queries, and retrieving results for visualization.

The presentation for this project can be found here: https://docs.google.com/presentation/d/1oqVRY2z6ms0ivcUo_MbyGE-W0ATb3TJsozcmwzHcXsw/edit?usp=sharing

## Files Overview

- Scripts (Run in this order)
- `runLocal.sh` - Transfers all necessary script files to an AWS EC2 instance (Run Locally)
- `sshRemote.sh` - Changes the user's execution context to the EC2 instance (Run Locally)
- `initRemote.sh` - Downloads, unzips, and cleans data on the EC2 instance, then initializes support and flight tables (Run on EC2)
- `initSupport.sql` - Creates and populates Hive tables with airports, carrier, and plane data. (Run on EC2)
- `initFlights.sql` - Creates and populates Hive tables with flight delay data for all years. (Run on EC2)
- `sampleFlights.sql` - Creates the sample table, and populates it with sampled records. (Run on EC2)
- `exeQueries.sh` - Exports sampled records to an output file. (Run on EC2)
- `fetchResults.sh` - Copies sample output file from EC2 back to your local machine. (Run Locally)

- Classifiers
- Classifier implementations are contained in the `classifiers` directory. See documentation on specific files for how to best run them.


## Prerequisites

- An AWS EC2 instance with:
  - Hadoop and Hive installed and configured
  - Sufficient storage for the flight delay dataset
  - Python (for the EC2 data preparation steps)
- Local machine with:
  - SSH access to your EC2 instance (key pair configured)
  - Python with Jupyter Notebook, pandas, matplotlib, and other visualization libraries

## Setup and Execution

### Step 1: Configure Environment Variables

Before running any scripts, update the `.env` file in the scripts directory with the following variables:

```
EC2_KEY_PATH='Scalable.pem'
EC2_USER='hadoop'
REMOTE_DIR='/home/hadoop'
EC2_HOST='ec2-34-231-180-243.compute-1.amazonaws.com'
YEARS=(1997 2002 2005 2006 2007)
SAMPLE_SIZE=40000
```
>- You will need to update the EC2_HOST to match your deployed cluster
>- It is expected that your permission key will be stored in the root directory of this project

### Step 2: Transfer Scripts to EC2

Run the `runLocal.sh` script from the root directory of this project on your local machine:

```bash
sh ./scripts/runLocal.sh
```

This script will:
- Create the necessary directory structure on your EC2 instance
- Transfer all script files to the EC2 instance

### Step 3: Initialize Data and Tables

Run the initialization script on your EC2 instance:

```bash
sh initRemote.sh
```

This script will:
- Download and unzip the flight delay dataset
- Clean the data as needed
- Execute `initTables.sql` to create and populate Hive tables

### Step 4: Sample Data

Run the initialization script on your EC2 instance:

```bash
hive -f sampleFlights.sql
```

This script will:
- Initalize a table in hive
- Populate the table with 40K flights from each year.

### Step 5: Execute Queries

Run the query execution script:

```bash
sh exeQueries.sh
```

This will:
- Export sample data to a `samples.csv` file

### Step 5: Fetch Results

Retrieve the query results to your local machine:

```bash
sh ./scripts/fetchResults.sh
```

This script copies sample data from your EC2 instance to your local machine.

### Step 6: Train and Evaluate Classifiers

Open and run the Jupyter notebooks found in the `classifiers` directory.

```bash
jupyter notebook ./classifiers/*.ipynb
```

These notebooks will:
- Load the sample data into a dataframe
- Preform some basic EDA and Data Preperation
- Train and Evaluate the classifier


## Classifier Results:

- Random Forest: [0, 0, 0, 1, 0, 0, 1, 0, 0, 1]
- K Nearest Neighbor: 
- SDG Classifier:
- XG Boost:
- Logistic Regressor: [1, 1, 1, 1, 0, 1, 1, 1, 0, 0]
- Logistic Regressor(2006_sample_only): [0, 0, 0, 0, 0, 0, 0, 0, 1, 1]


<!-- Actual = [0,0,0,0,0,0,1,1,1,1] -->
