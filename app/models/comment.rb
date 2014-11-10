class Comment < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :parent, class_name: "Comment"
  has_many :children, class_name: "Comment", foreign_key: "parent_id"

  validates :project, presence: true
  validates_presence_of :parent, allow_blank: true
  validates_presence_of :user
  validates :text, length: { minimum: 1 }
  validates_presence_of :parent, if: 'parent_id.present?'

end
