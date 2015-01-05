class AddCourseDataToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :CourseData, :string
  end
end
