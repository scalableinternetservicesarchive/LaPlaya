# Galleries
users = User.all.to_a.each
5.times do
  puts "\tCreating gallery..."
  def next_user(user_list)
    begin
      user_list.next
    rescue StopIteration => ex
      user_list.rewind
      next_user(user_list)
    end
  end
  g = FactoryGirl.create(:gallery_with_projects, author: next_user(users))
end
