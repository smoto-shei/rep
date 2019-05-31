class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|

      t.timestamps
    end
  end
end
