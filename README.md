# RideSync

RideSync is a scheduled ride service. Drivers get the freedom to choose from a list of upcoming rides that align with their schedule and preferences.

## Setup

- Copy `example.env` to `.env`
- Create Google Platform API Key and add it to  `GOOGLE_API_KEY` inside .env file
- Setup Database
```
rails db:create
rails db:migrate
rails db:seed
```

## Google Integrations

- DirectionService: Used to fetch driving information between addresses (each lookup is cached for 1 hour)
- GeocodeService: Use to fetch the longitude and latitude values of the address. In order for the Address to get geocoded, you need set `geocode_address` to true.  For example:
```
Address.new(address1: '123 North Broadway', city: 'Chicago', state: 'IL', zip_code: '60613', country: 'United States', geocode_address: true).save
```

## API

### DriverRides

#### Parameters
---
- driver (integer) REQUIRED:  Driver id
- page (integer) OPTIONAL: Default to the current page
- distance (integer) OPTIONAL: Defaults to rides within 100 miles

#### Attributes
---
- total_count (Integer): The total count of records that will be displayed accross all pages.
- links (object)
  - self (string): Current page path
  - prev (string): Previous page path
-  next (string): Next page path
- data (array):
  - id (integer): Unique identifier for Ride
  - start_address (object):
    - id (integer): Unique identifier for Address
    - address1 (string): Address 1
    - address2 (string): Address 2
    - city (string): City
    - zip_code (string) Zip Code
    - country (string) Country
    - latitude (float) Latitude
    - longitude (float) Longitude
    - created_at (date) Created at date
    - updated_at (date) Updated at date
  - destination_address (object): Same as start_address
  - driver_details (object):
    - driving_distance (float): The driving distance between two addresses is the distance in miles that it would take
to drive a reasonably efficient route between them.
    - driving_duration (float): The driving duration between two addresses is the amount of time in hours it would
take to drive the driving distance under realistic driving conditions.
    - commute_distance (float): The commute distance for a ride is the driving distance from the driver’s home address
to the start of the ride, in miles
    - commute_duration (float): The commute duration for a ride is the amount of time it is expected to take to drive the
commute distance, in hours.
    - ride_distance (float): The ride distance for a ride is the driving distance from the start address of the ride to
the destination address, in miles
    - ride_duration (float): The ride duration for a ride is the amount of time it is expected to take to drive the ride
distance, in hours
    - ride_earnings (float): The ride earnings is how much the driver earns by driving the ride
    - score (float): score of a ride in $ per hour


#### Example
---

```
http://127.0.0.1:3000/api/v1/driver_rides.json?driver=1&distance=20
```

```
json
{
  "data": [
    {
      "id": 1,
      "start_address": {
        "id": 2,
        "address1": "456 W Randolph St",
        "address2": null,
        "city": "Chicago",
        "state": "IL",
        "zip_code": "60661",
        "country": "United States",
        "latitude": 41.884584,
        "longitude": -87.641548,
        "created_at": "2023-11-12T04:47:23.978Z",
        "updated_at": "2023-11-12T04:47:23.978Z"
      },
      "destination_address": {
        "id": 3,
        "address1": "789 North State Street",
        "address2": null,
        "city": "Chicago",
        "state": "IL",
        "zip_code": "60654",
        "country": "United States",
        "latitude": 41.895914,
        "longitude": -87.629503,
        "created_at": "2023-11-12T04:47:23.982Z",
        "updated_at": "2023-11-12T04:47:23.982Z"
      },
      "driver_details": {
        "driving_distance": 1.420454106,
        "driving_duration": 0.16583333333333333,
        "commute_distance": 1.391249669,
        "commute_duration": 0.08666666666666667,
        "ride_distance": 1.029611747,
        "ride_duration": 0.12472222222222222,
        "ride_earnings": 12,
        "score": 56.76741130091984
      }
    }
  ],
  "total_count": 1,
  "current_page": 1,
  "links": {
    "self": "/api/v1/driver_rides.json?driver=1&distance=20",
    "prev": null,
    "next": null
  }
}
```
