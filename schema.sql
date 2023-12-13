drop database `cs336db`;

CREATE DATABASE  IF NOT EXISTS `cs336db`;
USE `cs336db`;

create table airport(airportId char(3) primary key);
insert into airport (airportId) values ('LAX'), ('JFK'), ('DEL'), ('FRA'), ('HND'), ('SIN');

create table airline(airlineId char(2) primary key);
insert into airline (airlineId) values ('DL'),('AA'), ('UA');

create table aircraft(aircraftId varchar(20), airlineId char(2), numSeats integer not null,
primary key(aircraftId, airlineId), foreign key(airlineId) references airline(airlineId) on update cascade);
insert into aircraft (aircraftId, airlineId, numSeats) values ('dl1', 'DL', 3), ('dl2', 'DL', 3), ('aa1', 'AA', 2), ('aa2', 'AA', 2), ('ua1', 'UA', 1), ('ua2', 'UA', 2);


create table flight(flightNumber integer auto_increment, airline char(2), flownBy varchar(20) not null, departureAirport char(3) not null, departureTime timestamp not null, arrivalAirport char(3) not null, arrivalTime timestamp not null, price float not null,
primary key(flightNumber, airline), foreign key(departureAirport) references airport(airportId) on update cascade, foreign key(arrivalAirport) references airport(airportId) on update cascade, foreign key(airline) references airline(airlineId) on update cascade, foreign key(flownBy) references aircraft(aircraftId) on update cascade);
insert into flight (airline, flownBy, departureAirport, departureTime, arrivalAirport, arrivalTime, price) values ('UA', 'ua1', 'JFK', '2023-12-25 12:00:00', 'LAX', '2023-12-25 13:00:00', 400.00);
insert into flight (airline, flownBy, departureAirport, departureTime, arrivalAirport, arrivalTime, price) values ('UA', 'ua2', 'LAX', '2023-12-26 12:00:00', 'JFK', '2023-12-26 13:00:00', 400.00);
insert into flight (airline, flownBy, departureAirport, departureTime, arrivalAirport, arrivalTime, price) values ('UA', 'ua1', 'JFK', '2023-12-26 16:00:00', 'DEL', '2023-12-26 19:00:00', 300.00);
insert into flight (airline, flownBy, departureAirport, departureTime, arrivalAirport, arrivalTime, price) values ('AA', 'ua1', 'DEL', '2023-12-26 20:00:00', 'LAX', '2023-12-26 23:00:00', 100.00);
insert into flight (airline, flownBy, departureAirport, departureTime, arrivalAirport, arrivalTime, price) values ('AA', 'ua1', 'DEL', '2023-12-27 20:00:00', 'HND', '2023-12-28 23:00:00', 100.00);
insert into flight (airline, flownBy, departureAirport, departureTime, arrivalAirport, arrivalTime, price) values ('DL', 'ua1', 'HND', '2023-12-29 02:00:00', 'LAX', '2023-12-30 19:00:00', 500.00);

create table account(username varchar(64) primary key, password varchar(64) not null, firstName varchar(50) not null, lastName varchar(50) not null, accountType varchar(20) not null);
insert into account(username, password, firstName, lastName, accountType) values ('admin', 'admin', 'Jesus','Christ', 'admin');
insert into account(username, password, firstName, lastName, accountType) values ('cust', 'cust', 'Test', 'Customer', 'customer');
insert into account(username, password, firstName, lastName, accountType) values ('cust2', 'cust2', 'Test', 'Customer2', 'customer');
insert into account(username, password, firstName, lastName, accountType) values ('binguy', 'binguy', 'IAm', 'aGuy', 'representative');

create table flightTicket(ticketID integer primary key auto_increment, totalFare float not null, class varchar(20) not null, changeFee float not null, bookingFee float not null, passenger varchar(64) not null, purchaseDateTime timestamp not null, 
foreign key(passenger) references account(username) on update cascade);
insert into flightTicket (totalFare, class, changeFee, bookingFee, passenger, purchaseDateTime) values (630, 'economy', 80, 30, 'cust', NOW());
insert into flightTicket (totalFare, class, changeFee, bookingFee, passenger, purchaseDateTime) values (630, 'economy', 80, 30, 'cust', NOW());

insert into flightTicket (totalFare, class, changeFee, bookingFee, passenger, purchaseDateTime) values (1000, 'business', 0, 30, 'cust2', NOW());

create table uses(flightNumber integer, airline char(2), ticketId integer, seatNumber varchar(3) not null, 
primary key (flightNumber, ticketId), foreign key(flightNumber, airline) references flight(flightNumber, airline) on update cascade, foreign key(ticketID) references flightTicket(ticketId) on update cascade);
insert into uses (flightNumber, airline, ticketId, seatNumber) values (1, 'UA', 1, 'A01');
insert into uses (flightNumber, airline, ticketId, seatNumber) values (2, 'UA', 1, 'A12');
insert into uses (flightNumber, airline, ticketId, seatNumber) values (1, 'UA', 2, 'G13');


create table inWaitingList(flightNumber integer, airlineId char(2), customer varchar(64), 
primary key (flightNumber, airlineId, customer), foreign key(flightNumber) references flight(flightNumber) on update cascade, foreign key(airlineId) references airline(airlineId) on update cascade, foreign key(customer) references account(username) on update cascade);
insert into inWaitingList(flightNumber, airlineId, customer) values (2, 'UA', 'cust');

create table question(QID integer auto_increment primary key, questionText text not null, reply text, customer varchar(64) not null, customerRep varchar(64),
foreign key(customer) references account(username) on update cascade, foreign key(customerRep) references account(username) on update cascade);
