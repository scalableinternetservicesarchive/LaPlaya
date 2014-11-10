class Project < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :galleries
  has_and_belongs_to_many :user_likes, class_name: 'User'

  validates :title, presence: true
  validates :thumbnail, presence: true

  #Project Likes
  has_many :project_likes, dependent: :destroy
  has_many :liking_users, through: :project_likes, source: :user
  alias_attribute :likes, :project_likes_count

  def root_comments
    comments.where parent_id: nil
  end

end
