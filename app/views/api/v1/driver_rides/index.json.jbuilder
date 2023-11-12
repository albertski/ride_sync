# frozen_string_literal: true

json.data @driver_rides do |ride|
  json.id ride.id
  json.start_address ride.start_address
  json.destination_address ride.destination_address
  json.driver_details do
    json.merge!(ride.driver_details.as_json.except('ride', 'driver'))
  end
end
json.count @driver_rides.count
json.total_pages @driver_rides.total_pages
json.current_page @driver_rides.current_page
json.links do
  json.self request.original_fullpath
  json.prev path_to_previous_page(@driver_rides)
  json.next path_to_next_page(@driver_rides)
end
