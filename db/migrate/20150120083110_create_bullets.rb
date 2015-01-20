class CreateBullets < ActiveRecord::Migration
  def change
    create_table :bullets do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
