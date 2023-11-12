# frozen_string_literal: true

Address.new(address1: '123 North Michigan Avenue', city: 'Chicago', state: 'IL', zip_code: '60601', country: 'United States', latitude: 41.885311, longitude: -87.624375).save
Address.new(address1: '456 W Randolph St', city: 'Chicago', state: 'IL', zip_code: '60661', country: 'United States', latitude: 41.884584, longitude: -87.641548).save
Address.new(address1: '789 North State Street', city: 'Chicago', state: 'IL', zip_code: '60654', country: 'United States', latitude: 41.895914, longitude: -87.629503).save
Address.new(address1: '101 East Erie Street', city: 'Chicago', state: 'IL', zip_code: '60611', country: 'United States', latitude: 41.894534, longitude: -87.623702).save
Address.new(address1: '222 Merchandise Mart Plaza', city: 'Chicago', state: 'IL', zip_code: '60654', country: 'United States', latitude: 41.888447, longitude: -87.635536).save
Address.new(address1: '333 South Wabash Avenue', city: 'Chicago', state: 'IL', zip_code: '60604', country: 'United States', latitude: 41.878984, longitude: -87.625664).save
Address.new(address1: '444 North Dearborn Street', city: 'Chicago', state: 'IL', zip_code: '60654', country: 'United States', latitude: 41.890098, longitude: -87.630571).save
Address.new(address1: '555 West Monroe Street', city: 'Chicago', state: 'IL', zip_code: '60661', country: 'United States', latitude: 41.880379, longitude: -87.638854).save
Address.new(address1: '666 North Lake Shore Drive', city: 'Chicago', state: 'IL', zip_code: '60611', country: 'United States', latitude: 41.894198, longitude: -87.613832).save
Address.new(address1: '777 West Chicago Avenue', city: 'Chicago', state: 'IL', zip_code: '60654', country: 'United States', latitude: 41.896109, longitude: -87.653412).save
Address.new(address1: '888 North LaSalle Drive', city: 'Chicago', state: 'IL', zip_code: '60610', country: 'United States', latitude: 41.898229, longitude: -87.632662).save
Address.new(address1: '999 West Adams Street', city: 'Chicago', state: 'IL', zip_code: '60607', country: 'United States', latitude: 41.878676, longitude: -87.655051).save

Address.new(address1: '1234 South Figueroa Street', city: 'Los Angeles', state: 'CA', zip_code: '90015', country: 'United States', latitude: 34.039673, longitude: -118.267420).save
Address.new(address1: '5678 Wilshire Boulevard', city: 'Los Angeles', state: 'CA', zip_code: '90036', country: 'United States', latitude: 34.063042, longitude: -118.360696).save
Address.new(address1: '9101 Sunset Boulevard', city: 'Los Angeles', state: 'CA', zip_code: '90069', country: 'United States', latitude: 34.090372, longitude: -118.383661).save
Address.new(address1: '2468 West 7th Street', city: 'Los Angeles', state: 'CA', zip_code: '90057', country: 'United States', latitude: 34.058945, longitude: -118.276170).save
Address.new(address1: '13579 Venice Boulevard', city: 'Los Angeles', state: 'CA', zip_code: '90066', country: 'United States', latitude: 34.003933, longitude: -118.448438).save
Address.new(address1: '1011 Broadway Street', city: 'Los Angeles', state: 'CA', zip_code: '90015', country: 'United States', latitude: 34.041436, longitude: -118.265675).save
Address.new(address1: '1213 S San Pedro Street', city: 'Los Angeles', state: 'CA', zip_code: '90015', country: 'United States', latitude: 34.030938, longitude: -118.259956).save
Address.new(address1: '1415 East 1st Street', city: 'Los Angeles', state: 'CA', zip_code: '90033', country: 'United States', latitude: 34.047195, longitude: -118.235249).save
Address.new(address1: '1617 West Pico Boulevard', city: 'Los Angeles', state: 'CA', zip_code: '90015', country: 'United States', latitude: 34.044633, longitude: -118.273853).save
Address.new(address1: '1819 Olympic Boulevard', city: 'Los Angeles', state: 'CA', zip_code: '90006', country: 'United States', latitude: 34.055891, longitude: -118.274245).save
Address.new(address1: '2021 South Grand Avenue', city: 'Los Angeles', state: 'CA', zip_code: '90007', country: 'United States', latitude: 34.033328, longitude: -118.266916).save
Address.new(address1: '2223 West Adams Boulevard', city: 'Los Angeles', state: 'CA', zip_code: '90018', country: 'United States', latitude: 34.032618, longitude: -118.331496).save

Address.all.in_groups_of(3).each do |addresses|
  Driver.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, home_address: addresses[0]).save
  Ride.new(start_address: addresses[1], destination_address: addresses[2]).save
end
