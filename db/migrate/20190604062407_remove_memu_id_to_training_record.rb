class RemoveMemuIdToTrainingRecord < ActiveRecord::Migration[5.2]
  def change
    remove_column :training_records, :menu_id, :references
  end
end
