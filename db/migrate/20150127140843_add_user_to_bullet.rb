class AddUserToBullet < ActiveRecord::Migration
  def change
    add_reference :bullets, :user, index: true
  end
end
