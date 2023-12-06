CREATE DATABASE  IF NOT EXISTS `cs336db`;
USE `cs336db`;

create table airport(airportId char(3) primary key);
insert into airport (airportId) values ('LAX'), ('JFK'), ('DEL'), ('FRA'), ('HND'), ('SIN');

create table airline(airlineId char(2) primary key);
insert into airline (airlineId) values ('DL'),('AA'), ('UA');

create table aircraft(aircraftId varchar(20), airlineId char(2), numSeats integer not null,
primary key(aircraftId, airlineId), foreign key(airlineId) references airline(airlineId));
insert into aircraft (aircraftId, airlineId, numSeats) values ('dl1', 'DL', 3), ('dl2', 'DL', 3), ('aa1', 'AA', 2), ('aa2', 'AA', 2), ('ua1', 'UA', 1), ('ua2', 'UA', 1);


create table flight(flightNumber integer auto_increment, airline char(2), flownBy varchar(20) not null, departureAirport char(3) not null, departureTime timestamp not null, arrivalAirport char(3) not null, arrivalTime timestamp not null, price float not null,
primary key(flightNumber, airline), foreign key(departureAirport) references airport(airportId), foreign key(arrivalAirport) references airport(airportId), foreign key(airline) references airline(airlineId), foreign key(flownBy) references aircraft(aircraftId));
insert into flight (airline, flownBy, departureAirport, departureTime, arrivalAirport, arrivalTime, price) values ('UA', 'ua1', 'JFK', '2023-12-25 12:00:00', 'LAX', '2023-12-25 19:00:00', 300.00);
insert into flight (airline, flownBy, departureAirport, departureTime, arrivalAirport, arrivalTime, price) values ('UA', 'ua1', 'LAX', '2023-12-26 12:00:00', 'JFK', '2023-12-26 19:00:00', 300.00);

create table account(username varchar(64) primary key, password varchar(64) not null, firstName varchar(50) not null, lastName varchar(50) not null, accountType varchar(20) not null);
insert into account(username, password, firstName, lastName, accountType) values ('admin', 'admin', 'Jesus','Christ', 'admin');
insert into account(username, password, firstName, lastName, accountType) values ('cust', 'cust', 'Test', 'Customer', 'customer');
insert into account(username, password, firstName, lastName, accountType) values ('cust2', 'cust2', 'Test', 'Customer2', 'customer');

create table flightTicket(ticketID integer primary key auto_increment, totalFare float not null, class varchar(20) not null, changeFee float not null, bookingFee float not null, passenger varchar(64) not null, purchaseDateTime timestamp not null, 
foreign key(passenger) references account(username));
insert into flightTicket (totalFare, class, changeFee, bookingFee, passenger, purchaseDateTime) values (630, 'economy', 80, 30, 'cust', NOW());
insert into flightTicket (totalFare, class, changeFee, bookingFee, passenger, purchaseDateTime) values (630, 'economy', 80, 30, 'cust', NOW());

insert into flightTicket (totalFare, class, changeFee, bookingFee, passenger, purchaseDateTime) values (1000, 'business', 0, 30, 'cust2', NOW());

create table uses(flightNumber integer, ticketId integer, seatNumber varchar(3) not null, 
primary key (flightNumber, ticketId), foreign key(flightNumber) references flight(flightNumber), foreign key(ticketID) references flightTicket(ticketId));
insert into uses (flightNumber, ticketId, seatNumber) values (1, 1, 'A01');
insert into uses (flightNumber, ticketId, seatNumber) values (2, 1, 'A12');

create table inWaitingList(flightNumber integer, airlineId char(2), customer varchar(64), 
primary key (flightNumber, airlineId, customer), foreign key(flightNumber) references flight(flightNumber), foreign key(airlineId) references airline(airlineId), foreign key(customer) references account(username));

create table question(QID integer auto_increment primary key, questionText text not null, reply text, customer varchar(64) not null, customerRep varchar(64),
foreign key(customer) references account(username), foreign key(customerRep) references account(username));
