source .env

scp -i ${EC2_KEY_PATH} ./.env ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}
scp -i ${EC2_KEY_PATH} ./exeQueries.sh ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}
scp -i ${EC2_KEY_PATH} ./initRemote.sh ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}
scp -i ${EC2_KEY_PATH} ./initFlights.sql ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}
scp -i ${EC2_KEY_PATH} ./initSupport.sql ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}
scp -i ${EC2_KEY_PATH} ./sampleFlights.sql ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}

