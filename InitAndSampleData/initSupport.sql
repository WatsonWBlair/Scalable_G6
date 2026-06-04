CREATE EXTERNAL TABLE IF NOT EXISTS airports (iata STRING,airport STRING,city STRING,state STRING,country STRING,lat DECIMAL,long DECIMAL) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' tblproperties("skip.header.line.count"="1");
CREATE EXTERNAL TABLE IF NOT EXISTS carriers (Code STRING,Description STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' tblproperties("skip.header.line.count"="1");
CREATE EXTERNAL TABLE IF NOT EXISTS planes (tailnum STRING,type STRING,manufacturer STRING,issue_date STRING,model STRING,status STRING,aircraft_type STRING,engine_type STRING,year INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' tblproperties("skip.header.line.count"="1");

LOAD DATA LOCAL INPATH 'airports.csv' OVERWRITE INTO TABLE airports;
LOAD DATA LOCAL INPATH 'carriers.csv' OVERWRITE INTO TABLE carriers;
LOAD DATA LOCAL INPATH 'plane-data.csv' OVERWRITE INTO TABLE planes;