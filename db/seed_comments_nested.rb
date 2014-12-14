# Given the existing projects,
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

  # Do "super" nesting on everything except mini size
  if @count > 4 then
    @users = User.all

    comment = FactoryGirl.create(:comment, author: @users.sample, project: project)
    100.times do
      comment = FactoryGirl.create(:comment, author: @users.sample, project: project, parent: comment)
    end
  else
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

end