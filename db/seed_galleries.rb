# Galleries
@count = 0
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

puts "\tCreating galleries..."
users = User.all.to_a.each
(@count/5).times do
  def next_user(user_list)
    begin
      user_list.next
    rescue StopIteration => ex
      user_list.rewind
      next_user(user_list)
    end
  end
  g = FactoryGirl.create(:gallery, projects: Project.all.sample(5), author: next_user(users))
end
