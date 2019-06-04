class AddTimeToTrainingRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :training_records, :time, :integer
  end
end
