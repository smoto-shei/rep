class AddAvatarToUserBody < ActiveRecord::Migration[5.2]
  def change
    add_column :user_bodies, :avatar, :string
  end
end
