# Create a super user and some test users, then create projects with those users.

User.create(username: 'superuser', email: 'super_user@example.com', password: 'helloworld', password_confirmation: 'helloworld', super_admin: true)
puts "\tCreating users and projects..."
30.times do
  u = FactoryGirl.create(:user)
  10.times do
    p = FactoryGirl.create(:project, author: u)
    User.all.each do |user|
      p.add_like(user)
    end
  end
end

