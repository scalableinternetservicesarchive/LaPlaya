# Galleries
puts "\tCreating galleries..."
users = User.all.to_a.each
15.times do
  def next_user(user_list)
    begin
      user_list.next
    rescue StopIteration => ex
      user_list.rewind
      next_user(user_list)
    end
  end
  g = FactoryGirl.create(:gallery, projects_count: 5, author: next_user(users))
end
