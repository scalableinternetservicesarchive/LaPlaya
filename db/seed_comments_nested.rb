# Given the existing projects,
puts "\tCreating comments for projects..."
users = User.all.to_a.each
Project.all.each do |project|
  current_comments = []
  def next_user(users)
    begin
      users.next
    rescue StopIteration => ex
      users.rewind
      next_user(users)
    end
  end

  #  multiple levels of nested comments
  2.times do
    current_comments.append(FactoryGirl.create(:comment, author: next_user(users), project: project, parent: nil))
  end
  tmp = current_comments
  current_comments = []
  tmp.each do |comment|
    3.times do
      current_comments.append(FactoryGirl.create(:comment, author: next_user(users), project: project, parent: comment))
    end
  end
  tmp = current_comments
  current_comments = []
  tmp.each do |comment|
    2.times do
      current_comments.append(FactoryGirl.create(:comment, author: next_user(users), project: project, parent: comment))
    end
  end
end