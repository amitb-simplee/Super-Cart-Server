# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cart.create!(date: Time.zone.now, name: "test cart 1", items: [
	Item.new(name: "test item 1", quantity: "1", note: "test item 1 note"),
	Item.new(name: "test item 2", quantity: "2"),
	Item.new(name: "test item 3")
	])