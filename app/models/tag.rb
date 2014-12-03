class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :projects, through: :taggings
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.counts
    self.select('name, taggings_count as count')
  end

end
