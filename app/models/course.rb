class Course < ActiveRecord::Base
  before_save :default_values

  mount_uploader :data, CourseDataUploader

  validates :year, :name, :grade, :category, :grade_id, :semester_id, :presence => true
  # validates :teacher, :presence => true
  validates :data, :presence => true

  belongs_to :grade
  belongs_to :semester
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  scope :recent, -> { order("year DESC") }

  # this should be put in ability.rb
  def editable_by?(user)
    user && user == owner || user.admin?
  end

  private

  def default_values
    self.teacher ||= "暫無"
    self.note ||= "暫無"
  end
end
