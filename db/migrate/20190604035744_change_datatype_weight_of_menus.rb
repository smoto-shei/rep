class ChangeDatatypeWeightOfMenus < ActiveRecord::Migration[5.2]
  def change
    change_column :menus, :weight, :float, null: false
  end
end
