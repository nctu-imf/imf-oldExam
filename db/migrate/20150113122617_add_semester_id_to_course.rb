class AddSemesterIdToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :semester_id, :integer
  end
end
