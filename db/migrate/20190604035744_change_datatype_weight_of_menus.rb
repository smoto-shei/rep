class ChangeDatatypeWeightOfMenus < ActiveRecord::Migration[5.2]
  def change
    changecolumn :menus, :weight, :float, null: false
  end
end
