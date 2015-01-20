class RenameCourseData < ActiveRecord::Migration
  def change
    rename_column :courses, :CourseData, :data
  end
end
