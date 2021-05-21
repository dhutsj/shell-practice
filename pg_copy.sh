#! /bin/bash

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
date=$(date '+%Y%m%d%H%M%S')
psql postgresql://username:password@endpoint:port/db << EOF
CREATE TABLE test_$date
(
	region VARCHAR,
	country VARCHAR,
	item_type VARCHAR,
	sales_channel VARCHAR,
	order_priority CHAR,
	order_date DATE,
	order_id INT,
	ship_date DATE,
	unit_sold INT,
	unit_price FLOAT,
	unit_cost FLOAT,
	total_revenue FLOAT,
	total_cost FLOAT,
	total_profit FLOAT
);
set datestyle to MDY; 
\copy test_$date FROM '/root/2.csv' csv header;
EOF
done
