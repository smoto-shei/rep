class ChangeColumnMenus < ActiveRecord::Migration[5.2]
  def change
    remove_column :training_records, :time, :int
    add_column :menus, :time, :int
    change_column :menus, :weight, :float, null: true
    change_column :menus, :rep, :int, null: true
  end
end
