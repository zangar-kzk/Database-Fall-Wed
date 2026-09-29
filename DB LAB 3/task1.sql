INSERT INTO Airline (airline_code, airline_name, airline_country, created_at, updated_at)
SELECT 
    'AIR' || i,
    'Airline ' || i,
    (ARRAY['Kazakhstan', 'USA', 'UK', 'UAE', 'Germany', 'France', 'Turkey'])[floor(random() * 7 + 1)],
    NOW(),
    NOW()
FROM generate_series(1, 200) AS i;

INSERT INTO Airport (airport_name, country, a_state, city, created_at, updated_at)
SELECT 
    'Airport ' || i,
    CASE city
        WHEN 'Almaty'   THEN 'Kazakhstan'
        WHEN 'Astana'   THEN 'Kazakhstan'
        WHEN 'London'   THEN 'UK'
        WHEN 'New York' THEN 'USA'
        WHEN 'Dubai'    THEN 'UAE'
        WHEN 'Paris'    THEN 'France'
        WHEN 'Istanbul' THEN 'Turkey'
    END,
    'State ' || i,
    city,
    NOW(),
    NOW()
FROM (
    SELECT 
        i, (ARRAY['Almaty', 'Astana', 'London', 'New York', 'Dubai', 'Paris', 'Istanbul'])[floor(random() * 7 + 1)] AS city
    FROM generate_series(1, 200) AS i
) AS airport;

INSERT INTO Passengers (first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at)
SELECT 
    first_name_val,
    (ARRAY['Smith', 'Kim', 'Kyrgyzbai', 'Kyuandyk', 'Saparova', 'Akhmetov', 'Taylor'])[floor(random() * 7 + 1)],
    '1990-01-01'::DATE + (random() * 13000)::INT,
    CASE WHEN first_name_val IN ('Elena', 'Aruzhan', 'Sophia') 
    THEN 'Female' 
    ELSE 'Male' 
    END,
    (ARRAY['Kazakhstan', 'USA', 'UK', 'UAE', 'Germany', 'France', 'Turkey'])[floor(random() * 7 + 1)],
    (ARRAY['Kazakhstan', 'USA', 'UK', 'UAE', 'Germany', 'France', 'Turkey'])[floor(random() * 7 + 1)], 
    'N' || (10000000 + i),
    NOW(),
    NOW()
FROM (
    SELECT 
        i,
        (ARRAY['Alex', 'John', 'Elena', 'Ali', 'Aruzhan', 'Daniyar', 'Sophia', 'Zangar'])[floor(random() * 8 + 1)] AS first_name_val
    FROM generate_series(1, 200) AS i
) AS passengers;

INSERT INTO Flights (sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at)
SELECT 
    dep_time,
    dep_time + INTERVAL '3 hours',
    dep_app,
    CASE WHEN dep_app = arr_app THEN (dep_app % 200) + 1 -- Если совпали, смещаем на следующий ID
        ELSE arr_app
    END,
    'Gate-' || (floor(random() * 30) + 1),
    'Gate-' || (floor(random() * 30) + 1),
    (floor(random() * 200) + 1)::INT,
    dep_time,
    dep_time + INTERVAL '3 hours',
    NOW(),
    NOW()
FROM (
    SELECT 
        i,
        NOW() + (i || ' hours')::INTERVAL AS dep_time,
        (floor(random() * 200) + 1)::INT AS dep_app,
        (floor(random() * 200) + 1)::INT AS arr_app
    FROM generate_series(1, 200) AS i
) AS flights;

INSERT INTO Booking (flight_id, passenger_id, booking_platform, created_at, updated_at, status, ticket_price)
SELECT 
    (floor(random() * 200) + 1)::INT,
    i,
    (ARRAY['Website', 'Mobile App', 'Agency', 'Kaspi Travel'])[floor(random() * 4 + 1)],
    NOW(),
    NOW(),
    (ARRAY['Confirmed', 'Pending', 'Cancelled'])[floor(random() * 3 + 1)],
    (100 + (random() * 800))::DECIMAL(7,2)
FROM generate_series(1, 200) AS i;

INSERT INTO Security_check (check_result, created_at, updated_at, passenger_id)
SELECT 
    (ARRAY['Passed', 'Failed', 'Secondary Check'])[floor(random() * 3 + 1)],
    NOW(),
    NOW(),
    i
FROM generate_series(1, 200) AS i;

INSERT INTO Baggage_check (check_result, created_at, updated_at, booking_id, passenger_id)
SELECT 
    (ARRAY['Passed', 'Flagged', 'Cleared'])[floor(random() * 3 + 1)],
    NOW(),
    NOW(),
    i,
    i
FROM generate_series(1, 200) AS i;

INSERT INTO Baggage (weight_in_kg, created_at, updated_at, booking_id)
SELECT 
    (10 + (random() * 22))::DECIMAL(4,2),
    NOW(),
    NOW(),
    i
FROM generate_series(1, 200) AS i;

INSERT INTO Boarding_pass (booking_id, seat, boarding_time, created_at, updated_at)
SELECT 
    i,
    (floor(random() * 30) + 1) || (ARRAY['A', 'B', 'C', 'D', 'E', 'F'])[floor(random() * 6 + 1)],
    NOW() + (i || ' hours')::INTERVAL,
    NOW(),
    NOW()
FROM generate_series(1, 200) AS i;

INSERT INTO Booking_flight (booking_id, flight_id, created_at, updated_at)
SELECT 
    i,
    (floor(random() * 200) + 1)::INT,
    NOW(),
    NOW()
FROM generate_series(1, 200) AS i;