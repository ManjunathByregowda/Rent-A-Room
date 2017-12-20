30.times do 
	c = City.new
	c.name = Faker::Address.City
	c.save
end
	
10.times do
	c = Amenity.new
	c.name = Faker::Hobbit.character
	c.description = Faker::Hobbit.quote
	c.save
end