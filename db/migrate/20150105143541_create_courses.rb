class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :category
      t.integer :year
      t.integer :grade_id
      t.string :teacher
      t.text :note

      t.timestamps
    end
  end
end
