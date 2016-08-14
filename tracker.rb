class DriveTimeTracker

	def initialize(file)
		@driver_info_hash = Hash.new
		process_file_and_create_driver_hash(open(file))

		@driver_info_hash.each_pair do |key, value|
			@driver_info_hash[key] = {
				:TRIP_TIME_IN_MINUTES => retrieve_total_trip_time_spent(value),
				:TOTAL_MILES => get_miles_traveled(value.flatten)
			}
		end
	end

	def process_file_and_create_driver_hash(file)
		file.readlines.map do |file_line|
			file_line_arr = file_line.split

			command		= file_line_arr.first
			driver_name	= file_line_arr[1]

			@driver_info_hash[driver_name] = [] if command.eql?("Driver") && !@driver_info_hash.has_key?(driver_name)
			@driver_info_hash[driver_name].push(file_line_arr.slice(2, file_line_arr.length)) if command.eql? "Trip"
		end
	end

	def retrieve_total_trip_time_spent(trip_time_and_miles_array)
		trip_times_array = []
		total_time_spent = 0

		trip_times_array = trip_time_and_miles_array.map do |trip_time_and_miles|
			convert_trip_times(trip_time_and_miles)
		end

		trip_times_array.each { |trip_time| total_time_spent += trip_time }
		return total_time_spent
	end

	def convert_trip_times(trip)
		trip_1_arr 	= trip[0].split(":")
		trip_2_arr 	= trip[1].split(":")
		trip_miles 	= trip[2].to_f
		trip_time 	= 0.0
		trip_speed 	= 0.0

		trip_time 	= (((trip_2_arr[0].to_i * 60) + trip_2_arr[1].to_i) - ((trip_1_arr[0].to_i * 60) + trip_1_arr[1].to_i))
		trip_speed 	= (trip_miles / trip_time) * 60

		return trip_time if (trip_speed > 5.0 && trip_speed < 100.0)
	end

	def get_miles_traveled(trip_time_and_miles_array)
		total_miles_traveled	= 0.0
		miles_traveled_array	= []

		miles_traveled_array = trip_time_and_miles_array.map do |times_and_miles|
			times_and_miles if times_and_miles.include?(".")
		end

		miles_traveled_array.compact.each do |mile_traveled|
			total_miles_traveled += mile_traveled.to_f
		end

		return total_miles_traveled
	end

	def display_result
		results_to_display = Hash[*@driver_info_hash.sort_by { |key, value| value[:TRIP_TIME_IN_MINUTES] }.reverse.flatten]
		results_to_display.each_pair do |key, value|
			mph = ((value[:TOTAL_MILES] / value[:TRIP_TIME_IN_MINUTES]) * 60)
			puts "#{key}: #{value[:TOTAL_MILES].to_i} miles @ #{mph.round} mph" if value[:TOTAL_MILES] > 0
			puts "#{key}: #{value[:TOTAL_MILES].to_i} miles" if value[:TOTAL_MILES] == 0
		end
	end

end

file = ARGV.first
dtt = DriveTimeTracker.new(file)
dtt.display_result