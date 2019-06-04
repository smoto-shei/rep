class ChangeDatatypeOfUserboies < ActiveRecord::Migration[5.2]
  def change
    change_column :user_bodies, :height, :float
    change_column :user_bodies, :weight, :float
  end
end
