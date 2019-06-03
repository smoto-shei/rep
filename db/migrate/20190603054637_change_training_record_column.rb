class ChangeTrainingRecordColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :training_records, :date, :date, null: false
    remove_column :training_records, :exercise_id, :int
    add_column :training_records, :exercise, :string, null: false
  end
end
