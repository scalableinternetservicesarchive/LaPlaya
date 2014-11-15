# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clean out old test data
puts "Cleaning out old data."
User.delete_all
Project.delete_all
Comment.delete_all
Gallery.delete_all

Dir[Rails.root.join("db/seed_user*.rb")].each {|f| require f}
Dir[Rails.root.join("db/seed_comment*.rb")].each {|f| require f}
Dir[Rails.root.join("db/seed_galleries*.rb")].each {|f| require f}

puts "\n*** Summary ***"
puts "Created #{Project.count} projects."
puts "Created #{Comment.count} total comments."
puts "Created #{Gallery.count} galleries."
