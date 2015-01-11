class Course < ActiveRecord::Base
  mount_uploader :CourseData, CourseDataUploader
  
  validates :year, :name, :teacher, :grade, :category, :CourseData, :grade_id, :presence => true

  belongs_to :grade

  belongs_to :owner, class_name: "User", foreign_key: :user_id

  def editable_by?(user)
    user && user == owner
  end
end
