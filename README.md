# README

This is a REST-API built with Ruby 3.0.3 and Rails 7.0.3. It can be used to schedule appointments with real estate agents (realtors). Tests are written with Rspec. JSON formatting is done with JBuilder. Calculating distance between locations is done with [Geocoder](https://github.com/alexreisner/geocoder).

## Installation
1. Make sure to have Ruby 3.0.3 installed on your machine.
2. Clone this repo.
3. Run `bundle install` to download gems and their dependencies. Then run `rake db:setup` to create the database, run migrations and seed the database.
4. Start the server with `rails s`

## Tests
Run `rspec` to run the test suite.

## Usage

This API features a single endpoint that accepts POST requests at ``/api/v1/appointments``.  The body of a request must be in JSON-format and should look like this:
```
{

"appointment": {

	"lat": 52.5019145,

	"lng": 13.4135005,

	"address": "Prinzessinnenstraße 26, 10969 Berlin",

	"time": "02/12/2021 10:00",

	"seller": {

		"name": "Alexander Schmitt",

		"phone": "+498005800550"

		}

	}

}
```
All fields are mandatory. In order for a request to be successful it needs to meet the following criteria:
- *time* must be a date in dd/mm/yyyy format followed by a time in 24h format
	- It must be at least 48 hours in the future.
	- It must represent a weekday.
	- Time must be between 8:00 and 18:00
- *lat* and *lon* must represent a location that is <= 20km distance from a realtor

A successful request will create an appointment with a realtor and has an http status of 201. The realtor's name and city will be included in the response.

## How to contribute
Don't. This was a coding challenge 😉
