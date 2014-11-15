# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'superuser', email: 'super_user@example.com', password: 'helloworld', password_confirmation: 'helloworld', super_admin: true)
projects = []
puts 'Starting seeding.'
(1..30).each do
  u = FactoryGirl.create(:user)
  puts "\tCreating user..."
  (1..10).each do
    p = FactoryGirl.create(:project, author: u)
  end
end


users = User.all.to_a.each
puts "\t Created #{Project.count} projects."
Project.all.each do |project|
  puts "\tCreating comments for project id: #{project.id}..."
  current_comments = []
  def next_user(users)
    begin
      users.next
    rescue StopIteration => ex
      users.rewind
      next_user(users)
    end
  end

  (1..2).each do
    current_comments.append(FactoryGirl.create(:comment, author: next_user(users), project: project, parent: nil))
  end
  tmp = current_comments
  current_comments = []
  tmp.each do |comment|
    (1..3).each do
      current_comments.append(FactoryGirl.create(:comment, author: next_user(users), project: project, parent: comment))
    end
  end
  tmp = current_comments
  current_comments = []
  tmp.each do |comment|
    (1..2).each do
      current_comments.append(FactoryGirl.create(:comment, author: next_user(users), project: project, parent: comment))
    end
  end
end
