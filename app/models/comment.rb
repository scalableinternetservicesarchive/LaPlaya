class Comment < ActiveRecord::Base
  belongs_to :project
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :parent, class_name: 'Comment'
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'

  validates :project, presence: true
  validates_presence_of :parent, allow_blank: true
  validates_presence_of :author
  validates :text, length: { minimum: 1 }
  validates_presence_of :parent, if: 'parent_id.present?'

  validate :parent_in_same_project


  private
  def parent_in_same_project
    unless parent.nil? || (parent.project == project)
      errors.add(:parent, 'Must belong to the same project')
      false
    end
  end

end
