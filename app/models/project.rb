class Project < ActiveRecord::Base
  # Belongs_to :user
  has_many :comments
  validates :title, presence: true
  validates :thumbnail, presence: true

  def root_comments
    comments.where parent_id: nil
  end

end
