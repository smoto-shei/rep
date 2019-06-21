class ChangeCloumnsOfImages < ActiveRecord::Migration[5.2]
  def change
    change_column :images, :user_image, :string, null: true
    add_column :images, :comment, :text
    add_column :images, :date, :date, null: false
  end
end
