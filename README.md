# WolfFly_Airline

## Airline Booking System using Ruby on Rails

## Requirement
 - Ruby on Rails

## Application Overview

The main components of the system are:
1. Flight (Creating Flights with details like Source, Destination and Manufacturer  )\
2. Reservation (Making Reservations to flights defining the number of passengers and additional baggage could be included)\
3. User (User information to login and make reservations )\
4. Admin (A special case of user with permission to Delete/Edit/Update Flights, reservations and user)\
5. Baggage (Additional baggage to include along with the reservations)\

## Edge-Case Scenarios
->Admin can see reservations by searching with User ID\
->Admin can create/view/delete bags for users\
->Flights availability is automatically updated with respect to the reservations made.\
-> If you choose to add the baggage feature, you should first create a reservation, and then add bags to an existing reservation.\

## Testing

The application is tested using the RSpec library of the rails. 

## Deployment 

The application is deployed using NCSU VCL Remote System.\

Deployed Server Link: http://152.7.98.88:8080/

## Credentials for Admin and Users
 - ADMIN :\
        - username: admin@ncsu.edu\
        - password: admin\
 - Sample User 1:\
        - username: pm@ncsu.edu\
        - password: pm\
 - Sample User 2: \
        - username: sg@ncsu.edu\
        - password: sg\
