
# Source Environment Variables
source ./.env

: '
Returns:
|Code                   | Name                    | Flight Count              |
|Sum Departure Delay    | Mean Departure Delay    | Median Departure Array    |
|Sum Arrival Delay      | Mean Arrival Delay      | Median Arrival Array      |
|Sum Carrier Delay      | Mean Carrier Delay      | Median Carrier Array      |
|Sum Weather Delay      | Mean Weather Delay      | Median Weather Array      |
|Sum NAS Delay          | Mean NAS Delay          | Median NAS Array          |
|Sum Security Delay     | Mean Security Delay     | Median Security Array     |
|Sum Late Aircraft Delay| Mean Late Aircraft Delay| Median Late Aircraft Array|
'
PORT_QUERY="select w.origin, a.airport, count(*),sum(w.depdelay)/60, avg(w.depdelay)/60, (percentile(cast(w.depdelay as BIGINT), 0.5))/60,sum(w.arrdelay)/60, avg(w.arrdelay)/60, (percentile(cast(w.arrdelay as BIGINT), 0.5))/60,sum(w.carrierdelay)/60, avg(w.carrierdelay)/60, (percentile(cast(w.carrierdelay as BIGINT), 0.5))/60,sum(w.weatherdelay)/60, avg(w.weatherdelay)/60, (percentile(cast(w.weatherdelay as BIGINT), 0.5))/60,sum(w.nasdelay)/60, avg(w.nasdelay)/60, (percentile(cast(w.nasdelay as BIGINT), 0.5))/60,sum(w.securitydelay)/60, avg(w.securitydelay)/60, (percentile(cast(w.securitydelay as BIGINT), 0.5))/60,sum(w.lateaircraftdelay)/60, avg(w.lateaircraftdelay)/60, (percentile(cast(w.lateaircraftdelay as BIGINT), 0.5))/60"
CARRIER_QUERY="select uniquecarrier, c.description, count(*),sum(w.depdelay)/60, avg(w.depdelay)/60, (percentile(cast(w.depdelay as BIGINT), 0.5))/60,sum(w.arrdelay)/60, avg(w.arrdelay)/60, (percentile(cast(w.arrdelay as BIGINT), 0.5))/60,sum(w.carrierdelay)/60, avg(w.carrierdelay)/60, (percentile(cast(w.carrierdelay as BIGINT), 0.5))/60,sum(w.weatherdelay)/60, avg(w.weatherdelay)/60, (percentile(cast(w.weatherdelay as BIGINT), 0.5))/60,sum(w.nasdelay)/60, avg(w.nasdelay)/60, (percentile(cast(w.nasdelay as BIGINT), 0.5))/60,sum(w.securitydelay)/60, avg(w.securitydelay)/60, (percentile(cast(w.securitydelay as BIGINT), 0.5))/60,sum(w.lateaircraftdelay)/60, avg(w.lateaircraftdelay)/60, (percentile(cast(w.lateaircraftdelay as BIGINT), 0.5))/60"

hive -f "sampleFlights.sql"
hive -e "set hive.cli.print.header=true; select * from samples;" | sed 's/[\t]/,/g' > ./queryResults/samples.csv

# for year in "${YEARS[@]}"; do
#     # echo "$year Ports Ranked By Sum"
#     # hive -e "set hive.cli.print.header=true; $PORT_QUERY from f_$year as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by sum(depdelay)+sum(arrdelay) DESC limit 3;" | sed 's/[\t]/,/g' > ./queryResults/${year}_port_sum_output.csv
#     # echo "$year Ports Ranked By Mean"
#     # hive -e "set hive.cli.print.header=true; $PORT_QUE from f_$year as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by avg(depdelay)+avg(arrdelay) DESC limit 3;" | sed 's/[\t]/,/g' > ./queryResults/${year}_port_mean_output.csv
#     # echo "$year Ports Ranked By Median"
#     # hive -e "set hive.cli.print.header=true; $PORT_QUE from f_$year as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by percentile(cast(w.depdelay as BIGINT), 0.5)+percentile(cast(w.arrdelay as BIGINT), 0.5) DESC limit 3;" | sed 's/[\t]/,/g' > ./queryResults/${year}_port_med_output.csv
#     # echo "$year Carriers Ranked By Sum"
#     # hive -e "set hive.cli.print.header=true; $CARRIER_QUERY from f_$year as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by sum(depdelay)+sum(arrdelay) DESC limit 3;" | sed 's/[\t]/,/g' > ./queryResults/${year}_carrier_sum_output.csv
#     # echo "$year Carriers Ranked By Mean"
#     # hive -e "set hive.cli.print.header=true; $CARRIER_QUERY from f_$year as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by avg(depdelay)+avg(arrdelay) DESC limit 3;" | sed 's/[\t]/,/g' > ./queryResults/${year}_carrier_mean_output.csv
#     # echo "$year Carriers Ranked By Median"
#     # hive -e "set hive.cli.print.header=true; $CARRIER_QUERY from f_$year as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by percentile(cast(w.depdelay as BIGINT), 0.5)+percentile(cast(w.arrdelay as BIGINT), 0.5) DESC limit 3;" | sed 's/[\t]/,/g' > ./queryResults/${year}_carrier_med_output.csv
#     echo "sample of $year"
#     hive -e "set hive.cli.print.header=true; select * from f_$year distribute by rand() sort by rand() limit $SAMPLE_SIZE;" | sed 's/[\t]/,/g' > ./queryResults/${year}_sample.csv
# done 



: ' 
Query Graveyard - Discarded Queries

# CARRIERS="('WN', 'AA', 'MQ', 'EV', 'B6')"

hive -e "set hive.cli.print.header=true; select * from samples;" | sed 's/[\t]/,/g' > ./queryResults/samples.csv

hive -e "set hive.cli.print.header=true; select * from f_1997 distribute by rand() sort by rand() limit 40000;" | sed 's/[\t]/,/g' > ./queryResults/1997_sample.csv
hive -e "set hive.cli.print.header=true; select * from f_2002 distribute by rand() sort by rand() limit 40000;" | sed 's/[\t]/,/g' > ./queryResults/2002_sample.csv
hive -e "set hive.cli.print.header=true; select * from f_2005 distribute by rand() sort by rand() limit 40000;" | sed 's/[\t]/,/g' > ./queryResults/2005_sample.csv
hive -e "set hive.cli.print.header=true; select * from f_2006 distribute by rand() sort by rand() limit 40000;" | sed 's/[\t]/,/g' > ./queryResults/2006_sample.csv
hive -e "set hive.cli.print.header=true; select * from f_2007 distribute by rand() sort by rand() limit 40000;" | sed 's/[\t]/,/g' > ./queryResults/2007_sample.csv


# Mean Values
hive -e "select w.origin, a.airport, count(*), (avg(w.depdelay)/60), count(*), avg(w.cancelled), avg(w.carrierdelay)/60, avg(w.weatherdelay)/60, avg(w.nasdelay)/60, avg(w.securitydelay)/60, avg(w.lateaircraftdelay)/60 from flights_07 as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by avg(depdelay) DESC limit 3;" > port_mean_output.csv


# Median Values
hive -e "select uniquecarrier, count(*), sum(cancelled)/60, sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60 from flights_07 where uniquecarrier in $CARRIERS group by uniquecarrier;" > carrier_delay_output.csv
hive -e "select w.origin, a.airport, (percentile(cast(w.depdelay as BIGINT), 0.5))/60, count(*) from flights_07 as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by percentile(cast(arrdelay as BIGINT), 0.5) DESC limit 3;" > port_median_output_arr.csv
hive -e "select w.origin, a.airport, (percentile(cast(w.depdelay as BIGINT), 0.5))/60, count(*) from flights_07 as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by percentile(cast(depdelay as BIGINT), 0.5) DESC limit 3;" > port_median_output.csv

hive -e "select origin, count(*), sum(cancelled), sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60 from flights_07 where origin in $AIRPORTS group by origin;" > port_delay_output.csv

hive -e "select uniquecarrier, c.description, (avg(depdelay)/60),(avg(arrdelay)/60), count(*), sum(cancelled), sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60 from flights_07 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by avg(w.depdelay) desc limit 3;" > carrier_mean_output.csv
hive -e "select uniquecarrier, c.description, (avg(depdelay)/60),(avg(arrdelay)/60), count(*), sum(cancelled), sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60 from flights_07 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by avg(w.arrdelay) desc limit 3;" > carrier_mean_output.csv
hive -e "select uniquecarrier, c.description, (percentile(cast(depdelay as BIGINT), 0.5)/60),(percentile(cast(arrdelay as BIGINT), 0.5)/60), count(*) from flights_07 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by avg(w.depdelay) desc limit 3;" > carrier_median_output.csv
hive -e "select uniquecarrier, c.description, (percentile(cast(depdelay as BIGINT), 0.5)/60),(percentile(cast(arrdelay as BIGINT), 0.5)/60), count(*) from flights_07 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by avg(w.arrdelay) desc limit 3;" > carrier_median_output_arr.csv

# Select by Arrival Delay - Deprecated due to selecting by SUM of Arrival and Departure
hive -e "select w.origin, a.airport, count(*), (sum(w.depdelay)/60), sum(w.cancelled), sum(w.carrierdelay)/60, sum(w.weatherdelay)/60, sum(w.nasdelay)/60, sum(w.securitydelay)/60, sum(w.lateaircraftdelay)/60, sum(w.arrdelay)/60 from flights_97 as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by sum(arrdelay) DESC limit 3;" > 97_port_output_arr.csv
hive -e "select w.origin, a.airport, count(*), (sum(w.depdelay)/60), sum(w.cancelled), sum(w.carrierdelay)/60, sum(w.weatherdelay)/60, sum(w.nasdelay)/60, sum(w.securitydelay)/60, sum(w.lateaircraftdelay)/60, sum(w.arrdelay)/60 from flights_02 as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by sum(arrdelay) DESC limit 3;" > 02_port_output_arr.csv
hive -e "select w.origin, a.airport, count(*), (sum(w.depdelay)/60), sum(w.cancelled), sum(w.carrierdelay)/60, sum(w.weatherdelay)/60, sum(w.nasdelay)/60, sum(w.securitydelay)/60, sum(w.lateaircraftdelay)/60, sum(w.arrdelay)/60 from flights_05 as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by sum(arrdelay) DESC limit 3;" > 05_port_output_arr.csv
hive -e "select w.origin, a.airport, count(*), (sum(w.depdelay)/60), sum(w.cancelled), sum(w.carrierdelay)/60, sum(w.weatherdelay)/60, sum(w.nasdelay)/60, sum(w.securitydelay)/60, sum(w.lateaircraftdelay)/60, sum(w.arrdelay)/60 from flights_06 as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by sum(arrdelay) DESC limit 3;" > 06_port_output_arr.csv
hive -e "select w.origin, a.airport, count(*), (sum(w.depdelay)/60), sum(w.cancelled), sum(w.carrierdelay)/60, sum(w.weatherdelay)/60, sum(w.nasdelay)/60, sum(w.securitydelay)/60, sum(w.lateaircraftdelay)/60, sum(w.arrdelay)/60 from flights_07 as w inner join airports as a on w.origin = a.iata where cancelled = 0 group by w.origin, a.airport order by sum(arrdelay) DESC limit 3;" > 07_port_output_arr.csv
hive -e "select uniquecarrier, c.description, (sum(depdelay)/60), count(*), sum(cancelled), sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60, sum(arrdelay)/60 from flights_97 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by sum(w.arrdelay) desc limit 3;" > 97_carrier_output_arr.csv
hive -e "select uniquecarrier, c.description, (sum(depdelay)/60), count(*), sum(cancelled), sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60, sum(arrdelay)/60 from flights_02 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by sum(w.arrdelay) desc limit 3;" > 02_carrier_output_arr.csv
hive -e "select uniquecarrier, c.description, (sum(depdelay)/60), count(*), sum(cancelled), sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60, sum(arrdelay)/60 from flights_05 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by sum(w.arrdelay) desc limit 3;" > 05_carrier_output_arr.csv
hive -e "select uniquecarrier, c.description, (sum(depdelay)/60), count(*), sum(cancelled), sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60, sum(arrdelay)/60 from flights_06 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by sum(w.arrdelay) desc limit 3;" > 06_carrier_output_arr.csv
hive -e "select uniquecarrier, c.description, (sum(depdelay)/60), count(*), sum(cancelled), sum(carrierdelay)/60, sum(weatherdelay)/60, sum(nasdelay)/60, sum(securitydelay)/60, sum(lateaircraftdelay)/60, sum(arrdelay)/60 from flights_07 as w inner join carriers as c on w.uniquecarrier = c.code where cancelled = 0 group by w.uniquecarrier, c.description order by sum(w.arrdelay) desc limit 3;" > 07_carrier_output_arr.csv

'
