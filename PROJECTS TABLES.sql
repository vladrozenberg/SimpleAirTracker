DROP TABLE IF EXISTS Flight_position;
DROP TABLE IF EXISTS Flight_Schedule;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS PLANE;

CREATE TABLE Airport(
	airport_id INT PRIMARY KEY,
	airport_name varchar(100),
	airport_IATA_code VARCHAR(3) UNIQUE NOT NULL,
	airport_ICAO_code varchar(4) UNIQUE NOT NULL,
	airport_city varchar(100),
	airport_country varchar(100),
	airport_lon DECIMAL (10, 6) CONSTRAINT NN_air_lon NOT NULL,
	airport_lat DECIMAL (9, 6) CONSTRAINT NN_air_lat NOT NULL,
	airport_tz_time_zone varchar(50)  
);

CREATE TABLE Plane(
	ICAO24 varchar(6) PRIMARY KEY,
	pla_model varchar(50),
	pla_airline varchar(50),
	pla_capacity int
	
);
	CREATE TABLE Flight_Schedule(
	schedule_id INT PRIMARY KEY,
	schedule_callsign VARCHAR(8),
	schedule_day_week INT,
	schedule_arv_time TIME,
	schedule_dept_time TIME,
	airport_id_arv INT,
	airport_id_dept INT,
	CONSTRAINT fk_airport_arv
	FOREIGN KEY (airport_id_arv)
	REFERENCES Airport(airport_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT fk_airport_dest
	FOREIGN KEY (airport_id_dept)
	REFERENCES Airport(airport_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
		
		
);

CREATE TABLE Flight(
	flight_id INT PRIMARY KEY,
	flight_callsign VARCHAR(8),
	flight_dept_time_actual time,
	flight_arrival_time_actual time,
	flight_status varchar(25),
	airport_id_arrival INT,
	airport_id_departure INT,
	schedule_id int,
	icao24 varchar(6),
	CONSTRAINT fk_airport_arival
	FOREIGN KEY (airport_id_arrival)
	REFERENCES AIRPORT (airport_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT fk_airport_departure
	FOREIGN KEY (airport_id_departure)
	REFERENCES AIRPORT (airport_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT fk_flight_schedule
	FOREIGN KEY (schedule_id)
	REFERENCES Flight_Schedule(schedule_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	CONSTRAINT fk_plane
	FOREIGN KEY (icao24)
	REFERENCES Plane (ICAO24)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
	);

CREATE TABLE Flight_position(
	pos_id INT PRIMARY KEY,
	pos_time TIMESTAMP NOT NULL,
	pos_time_position TIMESTAMP,
	pos_lon DECIMAL (10, 6),
	pos_lat DECIMAL (9,6),
	pos_ground_status BOOL,
	pos_velocity DECIMAL (8,3),
	pos_heading DECIMAL (8,2),
	flight_id INT NOT NULL,
	CONSTRAINT fk_flight_position
	FOREIGN KEY (flight_id)
	REFERENCES Flight(flight_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);