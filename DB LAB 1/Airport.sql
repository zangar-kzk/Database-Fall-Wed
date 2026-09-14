CREATE TABLE airpots(
	a_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	a_name VARCHAR(255) NOT NULL,
	country VARCHAR(255) NOT NULL,
	a_state VARCHAR(255) NOT NULL,
	city VARCHAR(255) NOT NULL,
	created DATE DEFAULT CURRENT_TIMESTAMP,
	updated DATE DEFAULT CURRENT_TIMESTAMP
)
CREATE TABLE airlines(
	airl_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	airl_code INT UNIQUE NOT NULL,
	airl_name VARCHAR(255) NOT NULL,
	country VARCHAR(255),
	created DATE DEFAULT CURRENT_TIMESTAMP,
	updated DATE DEFAULT CURRENT_TIMESTAMP
)
 
CREATE TABLE flights(
	f_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	dep_gate VARCHAR(100),
	arr_gate VARCHAR(100),
	created DATE DEFAULT CURRENT_TIMESTAMP,
	updated DATE DEFAULT CURRENT_TIMESTAMP,
	airl_id INT REFERENCES airlines(airl_id),
	dep_a_id INT REFERENCES airpots(a_id),
	arr_a_id INT REFERENCES airpots(a_id),
	sch_dep_time TIMESTAMP ,
	sch_arr_time TIMESTAMP,
	actual_dep_time TIMESTAMP,
	actual_arr_time TIMESTAMP
)
CREATE TABLE passengers{
	p_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	f_name VARCHAR(255) NOT NULL,
	l_name VARCHAR(255) NOT NULL,
	gender VARCHAR(50),
	date_of_birth DATE NOT NULL,
	country_citizenship VARCHAR(255) NOT NULL,
	country_residence VARCHAR(255) NOT NULL,
	passport_id INT UNIQUE NOT NULL,
	created DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
	updated DATE DEFAULT CURRENT_TIMESTAMP NOT NULL
}
CREATE TABLE bookings (
    booking_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    f_id INT NOT NULL,
    p_id INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    booking_platform VARCHAR(50) NOT NULL,
    ticket_price NUMERIC(10, 2) NOT NULL,
    created TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
 
    CONSTRAINT bookings_flight FOREIGN KEY (f_id) REFERENCES flights(f_id),
    CONSTRAINT bookings_passenger FOREIGN KEY (p_id) REFERENCES passengers(p_id)
)
 
CREATE TABLE booking_changes (
    change_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id INT NOT NULL,
    change_details TEXT NOT NULL,
    created TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
 
    CONSTRAINT changes_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
)
CREATE TABLE boarding (
    boarding_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id INT UNIQUE NOT NULL,
    seat VARCHAR(10) NOT NULL,
    boarding_time TIMESTAMPTZ NOT NULL,
    created TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
 
    CONSTRAINT boarding_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
)
CREATE TABLE baggage (
    bag_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id INT NOT NULL,
    weight NUMERIC(5, 2) NOT NULL,
    created TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
 
    CONSTRAINT baggage_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
)
CREATE TABLE baggage_checks (
    bag_check_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id INT NOT NULL,
    p_id INT NOT NULL,
    check_results TEXT NOT NULL,
    created TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
 
    CONSTRAINT baggage_check_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    CONSTRAINT baggage_check_passenger FOREIGN KEY (p_id) REFERENCES passengers(p_id)
)
CREATE TABLE security_check (
    security_check_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    p_id INT NOT NULL,
    check_results TEXT NOT NULL,
    created TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
 
    CONSTRAINT security_passenger FOREIGN KEY (p_id) REFERENCES passengers(p_id)
)