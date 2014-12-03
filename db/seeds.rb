# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clean out old test data
puts "Cleaning out old data."
t1 = Time.now
User.delete_all
Project.delete_all
Comment.delete_all
Gallery.delete_all
Tag.delete_all

puts 'Starting seeding.'
Dir[Rails.root.join("db/seed_user*.rb")].each {|f| require f}
Dir[Rails.root.join("db/seed_comment*.rb")].each {|f| require f}
Dir[Rails.root.join("db/seed_galleries*.rb")].each {|f| require f}

t2 = Time.now
puts "\n*** Summary ***"
puts "Created #{User.count} users."
puts "Created #{Project.count} projects."
puts "Created #{Comment.count} total comments."
puts "Created #{Gallery.count} galleries."
puts "Total seeding time #{t2 - t1} s"