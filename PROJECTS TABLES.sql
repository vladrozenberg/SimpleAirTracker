DROP TABLE AIRPORT;

CREATE TABLE AIRPORT(
	airport_id INT PRIMARY KEY,
	airport_name varchar(100),
	airport_IATA_code VARCHAR(3) UNIQUE NOT NULL,
	airport_ICAO_code varchar(4) UNIQUE NOT NULL,
	airport_city varchar(100),
	airport_country varchar(100),
	air_lon DECIMAL (10, 6) CONSTRAINT NN_air_lon NOT NULL,
	air_lat DECIMAL (9, 6) CONSTRAINT NN_air_lat NOT NULL,
	air_tz_time_zone varchar(50)  
	)