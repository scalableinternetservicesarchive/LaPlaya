class Project < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :galleries

  #Project Likes
  has_many :project_likes, dependent: :destroy
  has_many :liking_users, through: :project_likes, source: :user
  alias_attribute :likes, :project_likes_count

  #Project Tags
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates_presence_of :title
  validates_length_of :title, minimum: 5
  validates_presence_of :thumbnail
  validates_presence_of :author


  def root_comments
    comments.where parent_id: nil
  end

  def add_like(current_user)
    if liking_users.include? current_user
      false
    else
      liking_users << current_user
      true
    end
  end

  def remove_like(current_user)
    if liking_users.include? current_user
      liking_users.delete current_user
      true
    else
      false
    end
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).projects
  end

end
