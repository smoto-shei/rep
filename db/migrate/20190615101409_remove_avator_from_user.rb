class RemoveAvatorFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :avator, :string
  end
end
