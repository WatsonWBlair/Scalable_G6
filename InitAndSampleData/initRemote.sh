# Source ENV Variables
source ./.env

mkdir queryResults

# Run this file in your Hadoop instance to download all relevant 
ROOT='https://dataverse.harvard.edu/api/access/datafile/:persistentId?persistentId=doi:10.7910/DVN/HG7NV7'

# Fetch and Clean Supplementary Data
wget -O airports.csv ${ROOT}/XTPZZY
sed -i 's/"//g' airports.csv
wget -O carriers.csv ${ROOT}/3NOQ6Q
sed -i 's/"//g' carriers.csv
wget -O plane-data.csv ${ROOT}/XXSL8A
sed -i 's/"//g' plane-data.csv

# Fetch data specified by YEARS env var
for year in "${YEARS[@]}"; do
    case "$year" in
        "1997")
            wget -O 1997.csv.bz2 ${ROOT}/RUGDRW
            bzip2 -d 1997.csv.bz2
            sed -i 's/"//g' 1997.csv
            ;;
        "2002")
            wget -O 2002.csv.bz2 ${ROOT}/OWJXH3
            bzip2 -d 2002.csv.bz2
            sed -i 's/"//g' 2002.csv
            ;;
        "2005")
            wget -O 2005.csv.bz2 ${ROOT}/JTFT25
            bzip2 -d 2005.csv.bz2
            sed -i 's/"//g' 2005.csv
            ;;
        "2006")
            wget -O 2006.csv.bz2 ${ROOT}/EPIFFT
            bzip2 -d 2006.csv.bz2
            sed -i 's/"//g' 2006.csv
            ;;
        "2007")
            wget -O 2007.csv.bz2 ${ROOT}/2BHLWK
            bzip2 -d 2007.csv.bz2
            sed -i 's/"//g' 2007.csv
            ;;
    esac
done

hive -f './initSupport.sql'
hive -f './initFlights.sql'

# for year in "${YEARS[@]}"; do
#     # Execute table initialization and data population script.
#     hive --hivevar YEAR=$year -f './initFlights.sql'
# done