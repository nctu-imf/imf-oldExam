class Bullet < ActiveRecord::Base
  validates :title, :content, :presence => true

  scope :recent, -> { order("created_at DESC") }

  belongs_to :owner, class_name: "User", foreign_key: :user_id
end
