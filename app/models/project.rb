class Project < ActiveRecord::Base
  # Belongs_to :user
  # has_many :comments
  validates :title, presence: true
  validates :thumbnail, presence: true
end
