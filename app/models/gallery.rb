class Gallery < ActiveRecord::Base
  has_and_belongs_to_many :projects
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  validates :title, length: { minimum: 4 }, presence: true, uniqueness: true
  validates_presence_of :author
  # validates_presence_of :thumbnail # Leave this commented out till we update views / provide default / load from projects
end
