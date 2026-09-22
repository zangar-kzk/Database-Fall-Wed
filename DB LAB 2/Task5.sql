CREATE TABLE Airport (
    Airport_name VARCHAR(100) PRIMARY KEY,
    Airport_city VARCHAR(50) NOT NULL
);

CREATE TABLE Airline (
    Airline_id INT PRIMARY KEY,
    Airline_name VARCHAR(100) NOT NULL
);

CREATE TABLE Flight (
    Flight_number VARCHAR(20) PRIMARY KEY,
    Airline_id INT NOT NULL,
    Dep_airport_name VARCHAR(100) NOT NULL,
    Arr_airport_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (Airline_id) REFERENCES Airline(Airline_id),
    FOREIGN KEY (Dep_airport_name) REFERENCES Airport(Airport_name),
    FOREIGN KEY (Arr_airport_name) REFERENCES Airport(Airport_name)
);

CREATE TABLE Passport (
    Passport VARCHAR(20) PRIMARY KEY,
    Full_name VARCHAR(100) NOT NULL
);

CREATE TABLE Booking (
    Booking_id INT PRIMARY KEY,
    Flight_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (Flight_number) REFERENCES Flight(Flight_number)
);

CREATE TABLE Ticket (
    Ticket_id INT PRIMARY KEY,
    Booking_id INT NOT NULL,
    Passport VARCHAR(20) NOT NULL,
    seat VARCHAR(10) NOT NULL,
    price VARCHAR(20) NOT NULL,
    FOREIGN KEY (Booking_id) REFERENCES Booking(Booking_id),
    FOREIGN KEY (Passport) REFERENCES Passport(Passport)
);

INSERT INTO Airport (Airport_name, Airport_city) VALUES
('AlmatyAir', 'Almaty'),
('AstanaAir', 'Astana'),
('LondonAir', 'London'),
('USAir', 'New York'),
('DubaiAir', 'Dubai');

INSERT INTO Airline (Airline_id, Airline_name) VALUES
(1, 'FlyArustan'),
(2, 'Air Astana'),
(3, 'SCAT'),
(4, 'Emirates'),
(5, 'British Airways');

INSERT INTO Flight (Flight_number, Airline_id, Dep_airport_name, Arr_airport_name) VALUES
('KZ1', 1, 'AlmatyAir', 'AstanaAir'),
('KU2', 2, 'AlmatyAir', 'LondonAir'),
('KD3', 3, 'AstanaAir', 'DubaiAir'),
('UU4', 4, 'LondonAir', 'USAir'),
('KZ5', 1, 'AstanaAir', 'AlmatyAir');

INSERT INTO Passport (Passport, Full_name) VALUES
('AB123', 'Ali'),
('CD456', 'Aruzhan'),
('EF789', 'Daniyar'),
('GH123', 'John'),
('IJ456', 'Elena');

INSERT INTO Booking (Booking_id, Flight_number) VALUES
(1, 'KZ1'),
(2, 'KZ1'),
(3, 'KD3'),
(4, 'UU4'),
(5, 'KZ5');

INSERT INTO Ticket (Ticket_id, Booking_id, Passport, seat, price) VALUES
(1, 1, 'AB123', '12A', '100$'),
(2, 2, 'AB123', '12B', '100$'),
(3, 3, 'EF789', '03F', '280$'),
(4, 4, 'GH123', '21C', '190$'),
(5, 5, 'IJ456', '08D', '310$');