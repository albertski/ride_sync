# frozen_string_literal: true

class RideDriverDetails
  attr_accessor :ride, :driver, :driving_distance, :driving_duration, :commute_distance, :commute_duration,
                :ride_distance, :ride_duration, :ride_earnings, :score

  def initialize(ride, driver)
    @ride = ride
    @driver = driver

    calculate_driving
    calculate_commute
    caclulate_ride
    calculate_earnings
    calculate_score
  end

  private

  def calculate_driving
    driving_directions = google_direction(@ride.destination_address, @ride.start_address)
    @driving_distance = convert_meters_to_miles(driving_directions[:distance])
    @driving_duration = convert_seconds_to_hours(driving_directions[:duration])
  end

  def calculate_commute
    commute_directions = google_direction(@ride.start_address, @driver.home_address)
    @commute_distance = convert_meters_to_miles(commute_directions[:distance])
    @commute_duration = convert_seconds_to_hours(commute_directions[:duration])
  end

  def caclulate_ride
    ride_directions = google_direction(@ride.destination_address, @driver.home_address)
    @ride_distance = convert_meters_to_miles(ride_directions[:distance])
    @ride_duration = convert_seconds_to_hours(ride_directions[:duration])
  end

  def google_direction(destination, origin)
    Google::DirectionService.lookup(destination: destination.full_address, origin: origin.full_address)
  end

  def convert_meters_to_miles(value)
    value * 0.000621371
  end

  def convert_seconds_to_hours(value)
    value.to_f / 3600
  end

  def convert_hours_to_minute(value)
    value.to_f * 60
  end

  def calculate_earnings
    @ride_earnings = 12 + earnings_per_mile + earnings_per_minute
  end

  def earnings_per_mile
    return 0 if ride_distance <= 5

    1.50 * (ride_distance - 5)
  end

  def earnings_per_minute
    minutes = convert_hours_to_minute(ride_duration)
    return 0 if minutes <= 15

    (minutes - 15) * 0.70
  end

  def calculate_score
    @score = ride_earnings / (commute_duration + ride_duration)
  end
end
