# frozen_string_literal: true

class DriverRidesService
  def self.fetch(driver, distance)
    rides = Ride.within_distance(driver.home_address.latitude, driver.home_address.longitude, distance)
    rides.each { |ride| ride.driver_details = driver }
    rides.sort_by { |ride| -(ride.driver_details.score || 0) }
  end
end
