class Bullet < ActiveRecord::Base
  validates :title, :content, :presence => true

  scope :recent, -> { order("created_at DESC") }
end
