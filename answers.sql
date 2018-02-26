/*
1) Select a distinct list of ordered airports codes.
*/

select distinct arriveAirport Airports
from flight
where (arriveAirport <> 'BNA' and arriveAirport <> 'CHS' and arriveAirport <> 'STL');

/*
2) Provide a list of delayed flights departing from San Francisco (SFO).
*/

select airline.name, flight.flightNumber, flight.scheduledDepartDateTime, arriveAirport, status
from airline
inner join flight
on airline.id = flight.airlineid
where (status = 'delayed' and name = 'Delta');

/*
3) Provide a distinct list of cities that American airlines departs from.
*/

select distinct flight.departairport Cities
from airline
inner join flight
on airline.id = flight.airlineid
where name = 'American';

/*
4) Provide a distinct list of airlines that conducts flights departing from ATL.
*/

select distinct airline.name Airline
from airline
inner join flight
on airline.id = flight.airlineid
where flight.departairport = 'ATL';

/*
5)Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
*/

select airline.name, flight.flightNumber, departAirport, arriveAirport
from airline
inner join flight
on airline.id = flight.airlineid
where flight.scheduleddepartdatetime = flight.actualdepartdatetime;

/*
6)Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. Order your results by the arrival time.
*/

select airline.name Airline, flight.flightnumber Flight, flight.gate Gate,
time(scheduledArriveDateTime) Arrival, flight.status Status
from airline
inner join flight
on airline.id = flight.airlineid
where (arriveairport = 'CLT' and status = 'scheduled')
order by arrival asc;

/*
7) List the number of reservations by flight number. Order by reservations in descending order.
*/

select flightnumber flight, count(reservation.id) reservations
from reservation
inner join flight
on reservation.flightid = flight.id
group by flightnumber desc
order by reservations desc;

/*
8) List the average ticket cost for coach by airline and route. Order by AverageCost in descending order.
*/

select airline.name Airline, flight.departAirport, flight.arriveAirport, avg(reservation.cost) AverageCost
from airline
inner join flight
on airline.id = flight.airlineid
inner join reservation
on flight.id = reservation.flightid
where reservation.class = 'coach'
group by reservation.flightid
order by AverageCost desc;

/*
9) Which route is the longest?
*/

select departAirport, arriveAirport, max(miles) miles
from flight
group by id
order by miles
desc limit 1;

/*
10) List the top 5 passengers that have flown the most miles. Order by miles.
*/

select passenger.firstName, passenger.lastName, sum(miles) miles
from flight
inner join reservation
on reservation.flightid = flight.id
inner join passenger
on passenger.id = reservation.passengerid
group by reservation.passengerid
order by miles
desc limit 5;

/*
11) Provide a list of American airline flights ordered by route and arrival date and time.
*/

select name Name, concat(flight.departairport, ' --> ', arriveairport) Route,
date(scheduledarrivedatetime) 'Arrive Date',
time(scheduledarrivedatetime) 'Arrive Time'
from airline
inner join flight
on flight.airlineid = airline.id
where name = 'American'
order by Route, 'Arrive Date', 'Arrive Time';

/*
12 ) Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) by Airline, flight, and route. Order the report by total revenue in descending order.
*/

select name Airline, flight.flightnumber Flight, concat(flight.departairport, ' --> ', arriveairport) Route, count(reservation.id) 'Reservation Count', sum(cost) Revenue
from airline
inner join flight
on airline.id = flight.airlineid
inner join reservation
on flight.id = reservation.flightid
group by Flight
order by Revenue desc;

/*
13) List the average cost per reservation by route. Round results down to the dollar.
*/

select concat(flight.departairport, ' --> ', arriveairport) Route, round(avg(reservation.cost)) 'Avg Revenue'
from flight
inner join reservation
on reservation.flightid = flight.id
group by Route
order by round(avg(reservation.cost)) desc;

/*
14) List the average miles per flight by airline.
*/

select airline.name Name, avg(flight.miles) 'Avg Miles Per Flight'
from airline
inner join flight
on flight.airlineid = airline.id
group by airline.name
order by airline.name;
