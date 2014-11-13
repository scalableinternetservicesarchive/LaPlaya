class Gallery < ActiveRecord::Base
  has_and_belongs_to_many :projects
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  validates :title, uniqueness: true
  validates :title, length: { minimum: 4 }
  validates :author, presence: true
end
