class Course < ActiveRecord::Base
  mount_uploader :CourseData, CourseDataUploader
  
  validates :year, :name, :teacher, :grade, :category, :presence => true

  validates_presence_of :CourseData

  belongs_to :grade
end
