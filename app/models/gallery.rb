class Gallery < ActiveRecord::Base
  has_and_belongs_to_many :projects
  belongs_to :user
  validates :title, uniqueness: true
  validates :title, length: { minimum: 4 }
  validates :user, presence: true
end
