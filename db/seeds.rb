# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
 	20.times do
 		user['email'] = Faker::Internet.email
 		user['first_name'] = Faker::Name.first_name
 		user['last_name'] = Faker::Name.last_name

 		User.create(user)
 	end
end

uid = []
User.all.each do |u|
	uid << u.id
end

listing = {}

ActiveRecord::Base.transaction do
	50.times do
		listing['title'] = Faker::TwinPeaks.location
		listing['description'] = Faker::TwinPeaks.quote
		listing['price'] = Faker::Number.decimal(3, 2)
		listing['address'] = Faker::Address.street_address + ', ' + Faker::Address.zip + ' ' +Faker::Address.city + ', ' + Faker::Address.country
		listing['home_type'] = ['House', 'Apartment', 'Villa', 'Condominium'].sample
		listing['room_type'] = ['shared', 'private', 'entire property'].sample
		listing['bedroom'] = rand(1..3)
		listing['bathroom'] = rand(1..3)
		listing['accommodate'] = rand(1..5)
		listing['user_id'] = uid.sample

		Listing.create(listing)
	end
end

tag_names = ['Smoker', 'Pool', 'Internet', 'Gym', 'TV', 'Kitchen', 'Air-conditioner', 'Pet friendly']

ActiveRecord::Base.transaction do
	tag_names.each do |elm|
		Tag.create(tag_name: elm)
	end
end

listing_ids = []
tag_ids = []

Listing.all.each do |elm|
	listing_ids << elm.id
end

Tag.all.each do |elm|
	tag_ids << elm.id
end

ActiveRecord::Base.transaction do
	listing_ids.each do |listing_id|
		available_tag_ids = tag_ids
		rand(1..6).times do
			selected_tag_id = available_tag_ids.sample
			available_tag_ids -= [selected_tag_id]
			ListingsTag.create(listing_id: listing_id, tag_id: selected_tag_id)
		end
	end
end