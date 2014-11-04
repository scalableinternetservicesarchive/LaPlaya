class Project < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :galleries

  validates :title, presence: true
  validates :thumbnail, presence: true

  def root_comments
    comments.where parent_id: nil
  end

end
