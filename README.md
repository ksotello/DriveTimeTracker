# The DriveTimeTracker Class Solution

## Reasoning behind my solution

I figured it would be easier to handle the process of converting and displayng drive time with their correspoding mph driven by creating a "DriveTimeTracker" class which would accept a file as it's input via the command line and then calling it's display_result
method in order to display the results of such conversions. The end result of the conversion is the creation of a hash which makes it easier to handle and display the information that has been processed.

What will need to be ran in order to display the drive time output?

```ruby
	ruby tracker.rb example_input.txt
```

Here is an example of the hash which gets created after processing a file

```ruby
{
	"Dan"=>{
		:TRIP_TIME_IN_MINUTES=>50,
		:TOTAL_MILES=>30.200000000000003
	}
	,"Alex"=>{
		:TRIP_TIME_IN_MINUTES=>75,
		:TOTAL_MILES=>42.0
	},
	"Bob"=>{
		:TRIP_TIME_IN_MINUTES=>0,
		:TOTAL_MILES=>0.0
	}
}
```

## DriveTimeTracker instance methods

### constructor

When call DriveTimeTracker.new and passing in a text file as an argument, two things will take place. One is making a call to the process_file_and_create_driver_hash method in order to create a driver_info_hash and the next step is to interate through the driver keys and setup up the TIME_IN_MINUTES and TOTAL_MILES keys with their appropriate data.

For the TIME_IN_MINUTES key the retrieve_total_trip_time_spent method is called which will return the the total value of all trips taken by the user and converts that result to minutes.

The TOTAL_MILES key calls the get_miles_traveled method which will then return the total miles for a drivers trip. By flattening the trip array that gets passed into this method it makes it easier to find and process the miles traveled in the trip info array that was initially created when the driver_info_has was first setup.

### process_file_and_create_driver_hash

This is used to setup the driver_info_hash by setting up keys defined by the individual driver name when the *Driver* command has been issued. If the *Trip* command has been issued then return the trip as an array which will then be processed at a later time. The idea behind this method is to
creat some structure in order to group drive times by their individual driver.

### retrieve_total_trip_time_spent

This is used in order to grab the total amount of time that a driver spent in a single trip. The final result is the total drive time speant in minutes. This method calls the convert_trip_times method in order to process each trip properly so that it could be consumed later.

### convert_trip_times

This converts a single trip array (for example: [07:15, 07:45, 17.3]) and returns the amount (in minutes) that it took for that driver to make their trip. So for example converting to two trips to minutes and then subtractng the result will give you to total trip time in minutes. This method also takes the trip milleage into account (the last item in the array) and make a check to see if the trip speed is greater than 5 and less than 100 and if so return the time spent else do not.

### get_miles_traveled

This methods job is to add the total number of miles travled and return it's result. By passing in the trip array and looking to the miles traveld (the value with a decimal point) which then returns an array of miles and then iterates through the result and returns the total amount of miles traveled for a driver.

### display_result

This method is responsible for displaying the converted miles and time to minutes to the console. Since the output needed to be sorted, the hash gets sorted by the :TOTAL_MILES key and a new hash is created in order to then display the results.