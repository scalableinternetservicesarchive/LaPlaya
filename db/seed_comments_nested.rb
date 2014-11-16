# Given the existing projects,

users = User.all.to_a.each
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

  #  multiple levels of nested comments
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