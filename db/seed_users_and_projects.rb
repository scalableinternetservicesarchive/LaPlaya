# Create a super user and some test users, then create projects with those users.
@count = 0
t1 = Time.now
case ENV['SEED_SIZE']
  when 'mini'
    @count = 4
  when 'small'
    @count = 10
  when 'medium'
    @count = 30
  when 'large'
    @count = 10000
  when 'xlarge'
    @count = 100000
  else
    puts "Defaulting to no seed data"
    @count = 0
end

# Create users
User.create(username: 'superuser', email: 'super_user@example.com', password: 'helloworld', password_confirmation: 'helloworld', super_admin: true)
puts "\tCreating users and projects..."
@num_users =  @count > 30 ? 1000 : @count
@num_users.times do
  u = FactoryGirl.create(:user)
end

# helper function
@users = User.all.to_a.each
def next_user(user_list)
  begin
    user_list.next
  rescue StopIteration => ex
    user_list.rewind
    next_user(user_list)
  end
end

# Create Projects
@count.times do
  p = FactoryGirl.create(:project, author: next_user(@users))
end

# Create likes
# Each user will like 100 projects
User.all.each do |user|
  user.liked_projects = Project.all.sample(100)
end
t2 = Time.now
puts "Users + Projects + Likes seeding time #{t2 - t1} s"
