class AddExperienceToUserBody < ActiveRecord::Migration[5.2]
  def change
    add_column :user_bodies, :experience, :date
  end
end
