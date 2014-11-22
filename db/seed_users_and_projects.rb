# Create a super user and some test users, then create projects with those users.
@count = 0
case ENV['SEED_SIZE']
  when 'mini'
    @count = 4
  when 'small'
    @count = 10
  when 'medium'
    @count = 30
  when 'large'
    @count = 100
  else
    puts "Defaulting to no seed data"
    @count = 0
end

User.create(username: 'superuser', email: 'super_user@example.com', password: 'helloworld', password_confirmation: 'helloworld', super_admin: true)
puts "\tCreating users and projects..."
@count.times do
  u = FactoryGirl.create(:user)
  (@count/2).times do
    p = FactoryGirl.create(:project, author: u)
    User.all.each do |user|
      p.add_like(user)
    end
  end
end

