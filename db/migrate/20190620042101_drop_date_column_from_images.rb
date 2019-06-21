class DropDateColumnFromImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :date, :date
  end
end
