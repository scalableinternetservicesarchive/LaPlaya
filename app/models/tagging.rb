class Tagging < ActiveRecord::Base
  belongs_to :project
  belongs_to :tag, counter_cache: true
end
