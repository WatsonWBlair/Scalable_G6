source .env
# # YEARS=(07)

# for year in "${YEARS[@]}"; do
#     # scp -i $EC2_KEY_PATH ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/queryResults/${year}_carrier_sum_output.csv ./queryResults
#     # scp -i $EC2_KEY_PATH ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/queryResults/${year}_port_mean_output.csv ./queryResults
#     # scp -i $EC2_KEY_PATH ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/queryResults/${year}_carrier_mean_output.csv ./queryResults
#     # scp -i $EC2_KEY_PATH ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/queryResults/${year}_port_med_output.csv ./queryResults
#     # scp -i $EC2_KEY_PATH ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/queryResults/${year}_carrier_med_output.csv ./queryResults
#     # scp -i $EC2_KEY_PATH ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/queryResults/${year}_sample.csv ./queryResults
#     scp -i $EC2_KEY_PATH ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/queryResults/samples.csv ./queryResults
# done


scp -i $EC2_KEY_PATH ${EC2_USER}@${EC2_HOST}:${REMOTE_DIR}/queryResults/samples.csv ./classifiers/queryResults


    
