class ChangeColumnsDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :training_records, :user, null: false, foreign_key: true
  end
end
