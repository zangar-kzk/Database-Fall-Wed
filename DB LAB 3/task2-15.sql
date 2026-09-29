--Task 2
INSERT INTO Airline (airline_code, airline_name, airline_country, created_at) 
VALUES ('AIR201', 'KazAir', 'Kazakhstan', NOW());

--Task 3
UPDATE Airline SET airline_country = 'Turkey', updated_at = NOW() 
WHERE airline_name = 'KazAir';

--Task 4
INSERT INTO Airline (airline_code, airline_name, airline_country, created_at) 
VALUES ('AIR202', 'AirEasy', 'France', NOW()), 
        ('AIR203', 'FlyHigh', 'Brazil', NOW()), 
        ('AIR204', 'FlyFly', 'Poland', NOW());

--Task 5
DELETE FROM Booking_flight WHERE flight_id IN (
    SELECT flight_id FROM Flights WHERE EXTRACT(YEAR FROM sch_arrival_time) = 2026 );
DELETE FROM Flights WHERE EXTRACT(YEAR FROM sch_arrival_time) = 2026;

--Task 6
UPDATE Booking SET ticket_price = ticket_price * 1.15, updated_at = NOW();

--Task 7
DELETE FROM Boarding_pass WHERE booking_id IN (SELECT booking_id FROM Booking WHERE ticket_price < 750);
DELETE FROM Baggage WHERE booking_id IN (SELECT booking_id FROM Booking WHERE ticket_price < 750);
DELETE FROM Baggage_check WHERE booking_id IN (SELECT booking_id FROM Booking WHERE ticket_price < 750);
DELETE FROM Booking_flight WHERE booking_id IN (SELECT booking_id FROM Booking WHERE ticket_price < 750); 
DELETE FROM Booking WHERE ticket_price < 750;

--Task 8
UPDATE Airline SET airline_code = 'UNK',
    updated_at = NOW()
WHERE airline_code IS NULL;

--Task 9
DELETE FROM Baggage_check
WHERE created_at < '2023-06-01'
  AND check_result = 'Not checked';

--Task 10
DELETE FROM Airport
WHERE a_state IS NULL 
  AND city IN ('Paris', 'Istanbul');

--Task 11
INSERT INTO Baggage_check (check_result, created_at, updated_at, booking_id, passenger_id)
VALUES (
    'Not checked', 
    NOW(), 
    NOW(), 
    1, 1
)RETURNING baggage_check_id, created_at;

--Task 12
UPDATE Airline
SET airline_country = UPPER(airline_country), 
    updated_at = NOW();

--Task 13
UPDATE Airline
SET airline_name = 'Global Airways',
    airline_country = 'United Kingdom',
    updated_at = NOW()
WHERE airline_id = 5;

--Task 14
UPDATE Airport
SET a_state = 'Capital District',
    updated_at = NOW()
WHERE city IN ('Astana', 'London', 'Tokyo');

--Task 15
UPDATE Baggage_check
SET check_result = 'Checked',
    updated_at = NOW()
WHERE created_at >= '2024-03-01' 
  AND created_at < '2024-04-01'
  AND check_result = 'Not checked';


